# DxWnd Configuration

The tool ships with a pre-configured `dxwnd.ini` that applies the following
compatibility settings to make AltEditor II work correctly on modern Windows.

## Active Compatibility Flags

| Flag | Purpose |
|------|---------|
| `SINGLEPROCAFFINITY` | Forces single CPU core — prevents timing issues on multi-core systems |
| `SLOWDOWN` | Slows the main timing loop — prevents the editor from running too fast |
| `NOPERFCOUNTER` | Disables high-resolution performance counter — uses legacy timer instead |
| `EMULATEWIN9XHEAP` | Emulates Windows 9x heap behavior via `9xheap.dll` — fixes memory allocation crashes |
| `VIRTUALHEAP` | Works around broken heap assumptions in the original code |
| `LEGACYALLOC` | Uses legacy memory allocation strategies for compatibility |
| `USERGB565` | Forces 16-bit RGB565 color mode for correct color rendering |
| `GDISTRETCHED` | Fixes GDI stretching artifacts |
| `FONTBYPASS` | Bypasses broken font enumeration that could cause missing text |
| `WINAUTOREPAINT` | Forces automatic window repainting |
| `FAKEVERSION` | Reports Windows 95 to the application — satisfies old version checks |
| `LOCKWINPOS` | Locks window position to prevent it from moving off-screen |
| `MODIFYMOUSE` | Fixes mouse coordinate clamping in windowed mode |
| `HANDLEEXCEPTIONS` | Catches crashes and prevents Windows error dialogs |

## Window Settings

| Setting | Value | Description |
|---------|-------|-------------|
| Window size | 800×600 | Initial window dimensions |
| Window position | (50, 50) | Initial position on screen |
| Slowdown ratio | 2 | Halves the timing speed for correct behavior |

## CD Audio & Multimedia

| Setting | Description |
|---------|-------------|
| CD drive | Auto-detected (`?:`) |
| Fake HDD | `C:` |
| Fake CD drive | `D:` |

## How to Customize

1. Download **DxWnd** from [sourceforge.net/projects/dxwnd](https://sourceforge.net/projects/dxwnd)
2. Open DxWnd, select **Edit → Import** and choose `dxwnd.ini`
3. Edit the target properties
4. Save changes — DxWnd will update `dxwnd.ini` automatically

Alternatively, you can edit `dxwnd.ini` directly with a text editor.
