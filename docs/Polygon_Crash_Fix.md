# AltEditor 2 — Define Polygon Crash Fix

## Summary

The "Define Polygon" tool crashes at exactly **113 points** because the polygon vertex array overflows into the adjacent framebuffer pointer.

## Key Symbols

| Symbol | Type | Address | Description |
|--------|------|---------|-------------|
| `Polygon_HandleClick` | `int(X,Y)` | `0x00448710` | Handles mouse clicks in polygon mode: adds points or detects double-click to close/fill |
| `Polygon_Rasterize` | `BOOL()` | `0x004496A0` | Rasterizes polygon outline + fill onto terrain grid. Called on double-click close |
| `RenderFrame` | `void()` | `0x0041D770` | Renders the game field framebuffer to screen |
| `GameField_HandleRightClick` | `BOOL()` | `0x00449350` | Right-click handler: closes/cancels polygon (sets `g_nPolygonPointCount` = 0) |
| `g_nPolygonPointCount` | `int` | `0x013AE994` | Number of polygon vertices placed. Reset to 0 on close/cancel |
| `g_dwPolygonVerts` | `uint[224]` | `0x00F77698` | Polygon vertex array (112 entries × 2 DWORDs: X, Y). 8 bytes per vertex |
| `g_pFramebuffer` | `void*` | `0x00F77A1C` | Framebuffer pointer. Sits immediately after the vertex array |
| `g_dwToolFlags` | `uint` | `0x00665564` | Bitmask of active tools. Bit `0x10` = Define Polygon mode |

## Root Cause

### Data Layout in BSS

```
g_dwPolygonVerts  →  0x00F77698  [112 vertices × 8 bytes = 0x380 bytes]
                                  Point  0: X at +0x000, Y at +0x004
                                  Point  1: X at +0x008, Y at +0x00C
                                  ...
                                  Point 111: X at +0x378, Y at +0x37C
                    0x00F77A18  ← 4 bytes of unrelated globals
g_pFramebuffer    →  0x00F77A1C  ← framebuffer bitmap pointer
```

### The Overflow

`Polygon_HandleClick` increments `g_nPolygonPointCount` and stores each vertex at `g_dwPolygonVerts[count * 2]` (X) and `g_dwPolygonVerts[count * 2 + 1]` (Y) with **no bounds check**.

| Point # | Index | Y stored at | Result |
|---------|-------|-------------|--------|
| 113th   | 112   | `0x00F77A1C` | **Overwrites `g_pFramebuffer`** |

The Y-coordinate pixel value (e.g. ~142 = `0x8E`) replaces the framebuffer pointer. On the next `RenderFrame` call:

```asm
; RenderFrame at 0x41D785
rep stosd [edi]    ; edi = 0x8E, ecx = 0x100000 (4MB)
                   ; → access violation
```

### How Polygon Close Works

Closing ("filling") the polygon is triggered by **double-clicking the last placed point**. In `Polygon_HandleClick`, the new click coordinates are compared against the previous vertex. When both match, the code at `0x448797` calls `Polygon_Rasterize` instead of adding a new vertex.

```
0x448775:  TEST ESI,ESI               ; first point? → skip comparison
           MOV EAX,[ESP+0x14]          ; new X
           MOV ECX,[ESI*8+0xF77690]    ; previous vertex X
           CMP ECX,EAX                 ; same X?
           JNZ add_point               ; no → add new vertex
           MOV EAX,[ESP+0x10]          ; new Y
           MOV ECX,[ESI*8+0xF77694]    ; previous vertex Y
           CMP ECX,EAX                 ; same Y?
           JNZ add_point               ; no → add new vertex
0x448797:  CALL Polygon_Rasterize      ; yes → CLOSE AND FILL
```

## The Fix

**Two changes, 21 bytes total** in `ae2.exe`.

### Change 1: Intercept at `0x004487E9`

Replaced the address-calculation instruction right before the vertex store with a jump to a code cave in unused INT3 padding.

| | Original | Patched |
|---|----------|---------|
| Instruction | `LEA ECX,[ESI*8]` (7 bytes) | `JMP 0x448D1C` (5 bytes) + `NOP; NOP` (2 bytes) |
| Bytes | `8D 0C F5 00 00 00 00` | `E9 2E 05 00 00 90 90` |

### Change 2: Code cave at `0x00448D1C`

```asm
0x448D1C:  CMP ESI, 0x70       ; count >= 112?
           JAE 0x448765         ;   yes → return 0 (reject silently)
           LEA ECX, [ESI*8]     ; no → perform original address calc
           JMP 0x4487F0         ;   → continue vertex store
```

The threshold is **112** (`0x70`), allowing indices 0–111 (112 total vertices).

**Byte dump:** `83 FE 70 0F 83 40 FA FF FF 8D 0C F5 00 00 00 00 E9 BF FA FF FF`

### What Was NOT Changed

The **comparison and fill logic at `0x448775–0x448797` is completely untouched**. The double-click close path never enters the code cave — it falls through to `0x448797` and calls `Polygon_Rasterize` directly.

### Execution Flow After Fix

```
Mouse click in polygon mode
    │
    ▼
Polygon_HandleClick()
    │
    ▼
[0x448775] Compare with previous vertex
    │
    ├── Different coords ──► [0x4487E9] JMP cave
    │                            │
    │                        [Cave] count >= 112?
    │                            │
    │                        YES ─► return 0 (reject)
    │                        NO  ─► store vertex
    │
    └── Same coords (double-click) ──► [0x448797] Polygon_Rasterize()
                                          (always allowed, never blocked)
```

## Behavior After Fix

| Action | Result |
|--------|--------|
| Place points 1–112 | Stored normally |
| Double-click last point | Polygon closes and fills — **always works** |
| Attempt 113th+ point | Silently rejected (returns 0) |
| Right-click cancel | Works as before (sets count to 0) |
| All other tools (ambient, water, fog, objects) | Completely unaffected |

## Files

| File | Purpose |
|------|---------|
| `ae2.exe.bak` | Original unpatched binary |
| `ae2.exe` | Patched binary with crash fix |
| `Polygon_Crash_Fix.md` | This documentation |
| Ghidra project | Analysis with named symbols |
