# Carnivores — AltEditor II (Fixed Edition)

[![Download Latest](https://img.shields.io/badge/Download-Latest_Release-green)](https://github.com/Tibbee/AltEditor-II-Improved/releases/latest)

A **fixed and improved** version of the original AltEditor II map editor for
**Carnivores 2** (1996, Action Forms / WizardWorks) and it's community version of **Carnivores 2 Modders Edition**.

The original tool suffered from several compatibility issues on modern Windows
systems. Using **Ghidra** (static analysis) and **WinDbg** (dynamic debugging),
the root causes were identified and patched directly in the binary.

## What's Fixed

- **64-object limit removed** — Projects with up to 127 objects now load correctly (previously broke at 64)
- **Polygon crash fixed** — The "Define Polygon" tool no longer crashes when placing 113+ vertices
- **DxWnd pre-integrated** — Ships with a seamless compatibility layer for modern Windows (no manual setup)

## Download

Grab the latest build from
**[GitHub Releases](https://github.com/Tibbee/AltEditor-II-Improved/releases/latest)**.

No installer — just download the zip, extract, and run `ae2.exe`.

## How to Use

1. Download and extract the zip to any folder
2. Double-click `ae2.exe`
3. The tool launches with all compatibility fixes applied automatically

See [docs/USAGE.md](docs/USAGE.md) for detailed instructions.

## What's Included

| File | Purpose |
|------|---------|
| `ae2.exe` | The fixed AltEditor II binary |
| `winmm.dll` | Ultimate ASI Loader — proxy loader |
| `dxwnd.asi` | DxWnd proxy DLL — applies compatibility hooks |
| `dxwnd.dll` | DxWnd engine |
| `9xheap.dll` | Win9x heap emulation (for legacy memory handling) |
| `dxwnd.dxw` | Pre-configured DxWnd settings |

## How It Works

The tool uses **Ultimate ASI Loader** (renamed as `winmm.dll`) to intercept the
game's multimedia library calls. The ASI loader then loads `dxwnd.asi`
(DxWnd's proxy), which initializes the DxWnd engine (`dxwnd.dll`) with a
pre-configured set of compatibility flags.

This chain happens automatically — no manual DxWnd configuration needed.

## Building from Source

There is no source code to build — this is a binary-patched release of a
1996-era tool. The patches were applied directly to the original executable
using Ghidra. A write-up of the reverse engineering process may be added in
the future.

## Credits

See [CREDITS.md](CREDITS.md).

## Disclaimer

This is an **unofficial, community-maintained** fix. I do not own the original code.
