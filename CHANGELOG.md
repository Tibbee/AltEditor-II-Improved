# Changelog

## [1.0.5] — 2026-06-01

### Changed
- **Launcher logic** — `AltEditor2.bat` now checks if DxWnd is already running before launching. If running, it sends the `/Y:#1` command to trigger the editor; if not, it starts fresh with `/R:1`
- **Launcher executable rebuilt** — `AltEditor2.exe` rebuilt from the updated `AltEditor2.bat` source
- **DxWnd config tuned** — Disabled `GDIASYNCDC` (Async fast mode), lowered log verbosity, switched to fake-fullscreen position mode for crash troubleshooting
- **LICENSE cleaned up** — Removed Ultimate ASI Loader credit (`winmm.dll` was removed in v1.0.4)

### Removed
- `docs/DXWND_CONFIG.md` — DxWnd flag-to-config translations were too hard to maintain accurately. Future config changes will be manually logged

<details>
<summary>Previous versions</summary>

## [1.0.4] — 2026-05-30

### Changed
- **DxWnd hook mechanism** — Replaced the ASI loader approach (`winmm.dll` + `dxwnd.asi`) with a direct DxWnd setup. The editor now launches via `AltEditor2.exe`, which starts `dxwnd.exe` to apply compatibility hooks automatically
- **Launcher executable** — `AltEditor2.bat` converted to `AltEditor2.exe` using a bat-to-exe converter, so non-tech-savvy users see a familiar `.exe` to launch
- **Editor binary renamed** — Original `AltEditor2.exe` renamed to `Editor.exe` to avoid confusion with the launcher
- **DxWnd config updated** — `dxwnd.ini` now targets `Editor.exe` instead of the old executable name
- **DxWnd config format** — Migrated from `dxwnd.dxw` to `dxwnd.ini` for the configuration file
- **Removed dependencies** — Removed `winmm.dll` (Ultimate ASI Loader) and `dxwnd.asi` (DxWnd proxy DLL); no longer needed
- **Documentation updated** — All docs reflect the new `AltEditor2.exe` launcher and `Editor.exe` naming
- **README.md** — Updated file table, usage steps, and "How It Works" section
- **CREDITS.md** — Removed Ultimate ASI Loader credit; no longer included
- **docs/DXWND_CONFIG.md** — Updated config file references from `dxwnd.dxw` to `dxwnd.ini`
- **docs/USAGE.md** — Updated quick-start instructions and troubleshooting

### Added
- `release/AltEditor2.exe` — Converted launcher executable (from `AltEditor2.bat`)
- `release/Editor.exe` — The fixed AltEditor II binary (renamed)
- `release/dxwnd.ini` — DxWnd configuration in the new INI format
- `release/dxwnd.exe` — DxWnd application binary (standalone)

### Removed
- `release/winmm.dll` — Ultimate ASI Loader (no longer used)
- `release/dxwnd.asi` — DxWnd proxy DLL (no longer used)
- `release/dxwnd.dxw` — DxWnd config in the old format (replaced by `dxwnd.ini`)

## [1.0.3] — 2026-05-27

### Changed
- **Executable rename** — `ae2.exe` replaced with `AltEditor2.exe` to match the original filename from the 1996 distribution
- **DxWnd config refresh** — Re-exported `dxwnd.dxw` with DxWnd v2.06.13, resetting stale version metadata and refreshing all compatibility flags
- **Path updated for rename** — Path pattern changed from `*ae2.exe` to `*AltEditor2.exe` to match the renamed executable
- **Sound volume defaults** — Wave, MIDI, CD, and master volume levels set from 0 to 100 so in-game audio works out of the box
- **Renderer backend** — Renderer changed from 0 (DirectX default) to 3 for improved compatibility on modern systems
- **Compatibility flags tuned** — Cleared stale timing and extra flags (`tflag0`, `tflagb0`, `flagh0`, `flagl0`, etc.) that were inherited from the original DxWnd template; retained only the essential set for AltEditor II
- **Fake version removed** — `winver0` set from 1 to 0, no longer overriding the Windows version reported to the application

### Maintenance
- **`.gitignore`** — Added `drafts/` to ignored directories
- **Changelog cleanup** — Older versions folded into collapsible `<details>` section for a cleaner reading experience

## [1.0.1] — 2026-05-27

### Fixed
- **Portable DxWnd config** — Changed path from relative `.\ae2.exe` to wildcard `*ae2.exe` for reliable proxy mode support across all directories

## [1.0.0] — 2026-05-27

### Fixed
- **64-Object limit** — Projects with more than 64 objects would fail to load textures and object data. Changed the load-path cap from `0x40` (64) to `0x7F` (127), matching the static buffer capacity. Patched at `0x0040d98d` (`83 F8 40` → `83 F8 7F`).
- **Polygon crash** — The "Define Polygon" tool crashed at 113+ points because the vertex array overflowed into the framebuffer pointer. Added bounds checking via a code cave to reject points beyond index 112. Patched at `0x004487E9` and `0x00448D1C`.

### Changed
- Tool now ships with DxWnd integration for seamless compatibility
- No manual DxWnd setup required — just unzip and run
- Pre-configured compatibility flags for modern Windows (single CPU affinity, GDI fixes, Win9x heap emulation, etc.)

</details>
