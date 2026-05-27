# Usage Guide

## Requirements

- **Carnivores 2** (original game) — installed or available on the same machine
- **Windows 7, 8, 10, or 11** (32-bit or 64-bit)
- No administrator privileges required

## Quick Start

1. Extract the zip to a folder of your choice
2. Double-click **`ae2.exe`**
3. The editor opens with all compatibility fixes applied

That's it. No configuration needed.

## Manual DxWnd Configuration (If Needed)

If you want to tweak the compatibility settings:

1. Download and open **DxWnd** from [sourceforge.net/projects/dxwnd](https://sourceforge.net/projects/dxwnd)
2. The tool's settings are already saved in `dxwnd.dxw`
3. You can import this file into DxWnd to edit flags

## Troubleshooting

### "Cannot load original winmm.dll library"
- Make sure all files from the zip are extracted to the same folder
- Try running as administrator
- On some systems, Windows Update may have changed system files — re-extract the zip

### The editor runs but looks wrong (colors/position)
- The DxWnd settings include color and window-position fixes
- If they don't work for your system, open the tool through DxWnd GUI and tweak the settings

### Antivirus false positive
- Some antivirus programs flag modified executables
- This is a false positive — the binary was patched manually with Ghidra
- You can verify the file hash against the release notes
