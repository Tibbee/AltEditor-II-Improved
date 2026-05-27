# Changelog

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
