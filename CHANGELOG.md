# Changelog

All notable changes to the Gimmatek Report LaTeX Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-03-28

### Added
- Initial release of Gimmatek Report LaTeX Template
- `gimmatek-report-template.cls` - Custom document class with Stanford/Silicon Valley styling
- `gimmatek-report-frontmatter.sty` - Front matter abstraction package
- Automated front matter generation (Abstract, TOC, LOT, LOF)
- Chinese (CJK) typography support via XeLaTeX
- Professional color scheme and styling
- Complete documentation:
  - `LATEX_REPORT_STARTGUIDE.md` - AI agent instructions and user guide
  - `README.md` - Quick start guide
  - `INSTALL.md` - Installation instructions
  - `ABSTRACTION_GUIDE.md` - Detailed usage guide
  - `LATEX_ANALYSIS.md` - Technical analysis
- Example documents:
  - `minimal_example.tex` - Basic usage example
- Git repository structure with proper `.gitignore`

### Features
- 86-93% code reduction vs traditional LaTeX front matter
- Single command front matter generation: `\makefrontmatter`
- Configurable lists (TOC, LOT, LOF) via flags
- Flexible TOC depth control
- Custom cover page support
- Professional table and figure styling
- Automatic page numbering (Roman → Arabic)
- Cross-reference support

### Documentation
- Comprehensive AI agent workflow instructions
- Step-by-step user guides
- Installation methods for different use cases
- LaTeX writing best practices
- Troubleshooting guide
- Complete API reference

### Tested
- ✅ Compilation with XeLaTeX
- ✅ Chinese/English mixed content
- ✅ Multiple chapters with tables and figures
- ✅ Cross-references and labels
- ✅ Professional PDF output quality

---

## [2.0.0] - 2026-03-28

### Added
- Cross-platform font detection (macOS/Windows/Linux)
- Configurable logo path with automatic fallback
- `\frontmatter` and `\mainmatter` commands for report class
- `standalone_example.tex` - Example for project root usage
- Production-ready Makefiles for template and projects
- TOC depth control commands
- Comprehensive error messages with installation hints

### Fixed
- **Critical**: Fixed undefined `\frontmatter`/`\mainmatter` commands
- **Critical**: Fixed package name mismatch warning
- **Critical**: Fixed hardcoded image path breaking template
- Font compatibility issues on Linux and Windows
- Version number inconsistencies

### Changed
- Reorganized repository structure (src/, assets/, tools/)
- Improved documentation clarity
- Enhanced font configuration with platform detection
- Logo system now gracefully handles missing files

### Documentation
- Updated all examples to use new features
- Added cross-platform installation instructions
- Improved AI agent instructions
- Added troubleshooting for common issues

---

## [Unreleased]

### Planned
- Figure/table helper commands abstraction
- Additional example templates
- CI/CD integration examples
- More color schemes
- English-only variant

---

[2.0.0]: https://github.com/gimmatekmac05/gimmatek_report_latex_template/releases/tag/v2.0.0
[1.0.0]: https://github.com/gimmatekmac05/gimmatek_report_latex_template/releases/tag/v1.0.0
