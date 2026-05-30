# Credits

## AltEditor II — Original Work
- **Original authors** at Action Forms / WizardWorks (1996)
- Original map editor for Carnivores 2

## Binary Patches & Fixes
- **Tibor Harsányi** — Reverse engineering (Ghidra + WinDbg), bug fixes, compatibility improvements

## Third-Party Components

### DxWnd
- **Author:** gho (and contributors)
- **License:** GNU General Public License v2
- **Source:** https://sourceforge.net/projects/dxwnd
- Provides compatibility flags (windowed mode, GDI fixes, heap emulation, etc.)
- Hooked through `AltEditor2.bat` which launches `dxwnd.exe` alongside the editor

### 9xheap.dll
- Included with DxWnd for Windows 9x heap emulation support
