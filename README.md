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

No installer — just download the zip, extract, and run `AltEditor2.exe`.

## How to Use

1. Download and extract the zip to any folder
2. Double-click `AltEditor2.exe`
3. The tool launches with all compatibility fixes applied automatically

See [docs/USAGE.md](docs/USAGE.md) for detailed instructions.

For a complete reference of all DxWnd compatibility flags applied, see [docs/DXWND_CONFIG.md](docs/DXWND_CONFIG.md).

## What's Included

| File | Purpose |
|------|---------|
| `AltEditor2.exe` | Launcher — starts DxWnd and hooks into the editor |
| `Editor.exe` | The fixed AltEditor II binary (renamed from original) |
| `dxwnd.exe` | DxWnd application — applies compatibility hooks |
| `dxwnd.dll` | DxWnd engine |
| `dxwnd.ini` | Pre-configured DxWnd settings |
| `9xheap.dll` | Win9x heap emulation (for legacy memory handling) |

See [docs/DXWND_CONFIG.md](docs/DXWND_CONFIG.md) for a detailed breakdown of every compatibility flag.

## How It Works

The tool ships with **DxWnd** pre-configured via `dxwnd.ini`. The `AltEditor2.exe`
launcher starts `dxwnd.exe`, which automatically hooks into `Editor.exe`
(the actual editor binary) and applies all compatibility settings. No manual
DxWnd configuration needed — just run `AltEditor2.exe`.

## Building from Source

There is no source code to build — this is a binary-patched release of a
1996-era tool. The patches were applied directly to the original executable
using Ghidra. A write-up of the reverse engineering process may be added in
the future.

## Credits

See [CREDITS.md](CREDITS.md).

## Disclaimer

This is an **unofficial, community-maintained** fix. I do not own the original code.
