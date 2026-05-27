# AltEditor II — 64-Object Limit Fix

## Issue

When a project map contained more than 64 objects, reopening the project would fail to load
textures and object lists — the loaded project appeared broken/missing data.

## Root Cause

The bug is in the project file loader function `FUN_0040d3a0` at address `0x0040d98b`:

```
0040d986  MOV  [0x01537640], EAX    ; total_objects = atoi(Total_objects line)
0040d98b  CMP  EAX, 0x40            ; if (total_objects > 64)
0040d98e  JG   LAB_0040fc05         ;   goto cleanup (skip ALL object loading)
```

When `Total_objects` exceeded 64, execution jumped to `LAB_0040fc05` (cleanup/exit path),
bypassing the entire object-loading section — no object names, no textures, no object data.

### Why projects could exceed 64 in the first place

The add-object functions (`FUN_004052d0` and `FUN_0040618f`) have **no size limit**.
They increment the object counter `DAT_01537640` without any bounds check, so projects
could be saved with 70+ objects. The limit only existed on the load path.

### Static buffer capacity

| Buffer | Size (bytes) | Per-object stride | Max objects |
|--------|-------------|-------------------|-------------|
| `DAT_00b513c0` | 0x4000 (16384) | 0x40 (64 bytes) | **256** |
| `DAT_008c7b20` | heap-allocated | 0x20 (32 bytes) | unlimited |
| `DAT_008c7b38` | heap-allocated | pointer | unlimited |
| `DAT_008c7b3c` | heap-allocated | pointer | unlimited |
| `DAT_013ac2b8` | heap-allocated | pointer | unlimited |

The limiting factor is the static array `DAT_00b513c0` at **256 objects**.

## Fix Applied

**Patch address:** `0x0040d98d`
**Original byte:** `0x40`  
**New byte:** `0x7F`

### Instruction encoding constraint

The instruction `CMP EAX, 0x40` encodes as `83 F8 40` — the 3-byte compact form (`CMP r32, imm8`).
This encoding uses a **sign-extended** immediate, so valid positive values are limited to `0x00–0x7F`.
Values `0x80+` become negative numbers (`-128, -127, ...`) and break the `JG` jump logic.

Using `0x7F` (127) is the maximum positive value that fits the 3-byte encoding without
overwriting adjacent instructions.

### Before

```
0040d98b  83 F8 40        CMP  EAX, 0x40      ; max 64 objects
0040d98e  0F 8F 71220000  JG   LAB_0040fc05
```

### After

```
0040d98b  83 F8 7F        CMP  EAX, 0x7F      ; max 127 objects
0040d98e  0F 8F 71220000  JG   LAB_0040fc05
```

## How to reproduce the patch (Ghidra)

1. Go to address `0x0040d98d` in the Bytes view
2. Change byte `40` → `7F`
3. Press `D` at `0x0040d98b` to re-disassemble
4. File → Export Program → save patched `ae2.exe`

## Verification

- The instruction should read: `CMP EAX, 0x7f`
- The `JG` instruction at `0x0040d98e` should remain intact
- Projects with up to 127 objects should now load correctly
- The static buffer can safely hold up to 256 objects, so 127 leaves ample headroom
