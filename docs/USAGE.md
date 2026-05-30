# Usage Guide

## Requirements

- **Carnivores 2** (original game) — installed or available on the same machine
- **Windows 7, 8, 10, or 11** (32-bit or 64-bit)
- No administrator privileges required

## Quick Start

1. Extract the zip to a folder of your choice
2. Double-click **`AltEditor2.exe`**
3. The editor opens with all compatibility fixes applied

That's it. No configuration needed.

## Manual DxWnd Configuration (If Needed)

If you want to tweak the compatibility settings:

1. Download and open **DxWnd** from [sourceforge.net/projects/dxwnd](https://sourceforge.net/projects/dxwnd)
2. The tool's settings are already saved in `dxwnd.ini`
3. Open DxWnd, go to **Edit → Import** and select `dxwnd.ini`, or edit `dxwnd.ini` directly

## Troubleshooting

### The editor window doesn't open
- Make sure `dxwnd.exe`, `dxwnd.dll`, `dxwnd.ini`, `9xheap.dll`, and `Editor.exe` are all in the same folder as `AltEditor2.exe`
- Run `AltEditor2.exe` as administrator if DxWnd fails to hook into the process
- Check `dxwnd.log` for any error messages

### The editor runs but looks wrong (colors/position)
- The DxWnd settings include color and window-position fixes
- If they don't work for your system, open the tool through DxWnd GUI and tweak the settings

### Antivirus false positive
- Some antivirus programs flag modified executables
- This is a false positive — the binary was patched manually with Ghidra
- You can verify the file hash against the release notes
