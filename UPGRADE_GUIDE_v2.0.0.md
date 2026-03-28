# Upgrade Guide to v2.0.0

**Date:** 2026-03-28
**From Version:** 1.0.0
**To Version:** 2.0.0

---

## Overview

Version 2.0.0 includes critical bug fixes, cross-platform improvements, and repository reorganization. This guide will help you upgrade existing projects.

---

## Breaking Changes

### 1. Directory Structure Changed

**Old Structure:**
```
gimmatek_report_latex_template/
├── packages/          ← OLD
│   ├── *.cls
│   └── *.sty
└── img/               ← OLD
    └── *.png
```

**New Structure:**
```
gimmatek_report_latex_template/
├── src/               ← NEW
│   ├── *.cls
│   └── *.sty
├── assets/            ← NEW
│   └── *.png
└── tools/             ← NEW
    └── Makefile*
```

### 2. Required Changes in Your Documents

If you have existing documents using v1.0.0, update the `\input@path`:

**Before (v1.0.0):**
```latex
\makeatletter
\def\input@path{{gimmatek_report_latex_template/packages/}}
\makeatother
```

**After (v2.0.0):**
```latex
\makeatletter
\def\input@path{{gimmatek_report_latex_template/src/}}
\makeatother
```

### 3. TEXINPUTS Environment Variable

If using Makefile or shell scripts:

**Before:**
```bash
export TEXINPUTS=.:./gimmatek_report_latex_template/packages//:
```

**After:**
```bash
export TEXINPUTS=.:./gimmatek_report_latex_template/src//:
```

---

## New Features

### 1. Cross-Platform Font Support

The template now automatically detects your platform and uses appropriate fonts:

- **macOS:** PingFang TC + Menlo
- **Windows:** Microsoft JhengHei + Consolas
- **Linux:** Noto Sans CJK TC + DejaVu Sans Mono

No configuration needed! Just compile and it works.

### 2. Configurable Logo Path

You can now customize the logo location:

```latex
% Override default logo path
\logopath{custom/path/to/logo.png}
```

If the logo file doesn't exist, the template displays a placeholder instead of failing.

### 3. `\frontmatter` and `\mainmatter` Commands

These commands now work correctly (they were undefined in v1.0.0):

```latex
\begin{document}
\frontmatter               % ← Now works!
\makefrontmatter

\mainmatter                % ← Now works!
\chapter{Introduction}
...
\end{document}
```

### 4. TOC Depth Control

New commands to control table of contents depth:

```latex
\tocchaptersonly        % Show only chapters
\tocsections            % Show chapters + sections
\tocsubsections         % Show chapters + sections + subsections (default)
\tocsubsubsections      % Show all levels
```

Usage:
```latex
\begin{document}
\frontmatter
\tocsections            % Set before \makefrontmatter
\makefrontmatter
...
```

### 5. Production-Ready Makefiles

Two Makefiles included:

- **`tools/Makefile`** - For building template examples
- **`tools/Makefile.project`** - Template for your projects

Copy `tools/Makefile.project` to your project root as `Makefile`:

```bash
cp gimmatek_report_latex_template/tools/Makefile.project Makefile
```

Then edit `MAIN` variable to match your main `.tex` filename.

---

## Bug Fixes

### Critical Fixes

1. **Fixed undefined `\frontmatter`/`\mainmatter`** - These commands now work in report class
2. **Fixed package name mismatch** - No more warnings on compilation
3. **Fixed hardcoded image path** - Logo system now has graceful fallback

### Platform Fixes

1. **Linux compatibility** - Added Noto CJK font detection
2. **Windows compatibility** - Added Microsoft JhengHei font support
3. **Font missing errors** - Now shows helpful installation instructions

---

## Upgrade Steps

### Step 1: Backup Your Work

```bash
# Backup your project
cp -r your_project your_project.backup
```

### Step 2: Update Template Repository

```bash
cd your_project/
cd gimmatek_report_latex_template/
git pull origin main  # Or re-clone if not using git
```

Or re-clone completely:

```bash
cd your_project/
rm -rf gimmatek_report_latex_template/
git clone https://github.com/gimmatekmac05/gimmatek_report_latex_template.git
```

### Step 3: Update Your Document Paths

Edit your main `.tex` file:

```bash
# Find and replace in your .tex files
sed -i 's|packages/|src/|g' *.tex
```

Or manually:
```latex
% Change this line:
\def\input@path{{gimmatek_report_latex_template/packages/}}

% To this:
\def\input@path{{gimmatek_report_latex_template/src/}}
```

### Step 4: Update Makefile (if you have one)

```bash
# Update TEXINPUTS path
sed -i 's|/packages/|/src/|g' Makefile
```

### Step 5: Test Compilation

```bash
xelatex your_document.tex
xelatex your_document.tex
```

Check for any errors or warnings.

### Step 6: Update Symlinks (if you use them)

If you created symlinks to the `img/` directory:

```bash
# Remove old symlink
rm img

# Create new symlink
ln -s gimmatek_report_latex_template/assets img
```

---

## Verification Checklist

After upgrading, verify these items:

- [ ] Document compiles without errors
- [ ] `\frontmatter` and `\mainmatter` work correctly
- [ ] Page numbering is correct (roman → arabic)
- [ ] Table of contents appears
- [ ] Logo appears in headers (or placeholder if missing)
- [ ] Chinese characters display correctly
- [ ] No package name mismatch warnings
- [ ] Cross-references resolve correctly

---

## Troubleshooting

### Error: "File gimmatek-report-template.cls not found"

**Cause:** `\input@path` points to old `packages/` directory.

**Fix:** Update to `src/`:
```latex
\def\input@path{{gimmatek_report_latex_template/src/}}
```

### Error: "CJK fonts not found"

**Cause:** Platform-specific fonts not installed.

**Fix (Linux):**
```bash
sudo apt install fonts-noto-cjk fonts-noto-cjk-extra
```

**Fix (Windows):**
Install Microsoft JhengHei (usually pre-installed).

**Fix (macOS):**
PingFang TC is pre-installed, no action needed.

### Warning: "Package name mismatch"

**Cause:** Using old template version.

**Fix:** Pull latest version (v2.0.0+) which has this fixed.

### Logo Not Appearing

**Cause:** Logo path incorrect or file missing.

**Behavior in v2.0.0:** Shows `[Logo]` placeholder instead of failing.

**Fix:** Set correct logo path:
```latex
\logopath{gimmatek_report_latex_template/assets/gimmatek_confidential.png}
```

---

## Rollback Instructions

If you need to rollback to v1.0.0:

```bash
cd gimmatek_report_latex_template/
git checkout v1.0.0
```

Or restore from backup:
```bash
rm -rf your_project/
cp -r your_project.backup your_project/
```

---

## Getting Help

- **Documentation:** See `README.md` and `docs/` directory
- **Issues:** https://github.com/gimmatekmac05/gimmatek_report_latex_template/issues
- **Changelog:** See `CHANGELOG.md` for detailed changes

---

## Summary of Benefits

Upgrading to v2.0.0 gives you:

✅ **Cross-platform compatibility** (macOS, Windows, Linux)
✅ **Bug-free compilation** (all critical issues fixed)
✅ **Flexible logo system** (configurable with fallback)
✅ **Better documentation** (clearer instructions)
✅ **Production tools** (Makefiles included)
✅ **More control** (TOC depth commands)

**Recommended:** All users should upgrade to v2.0.0 for stability and compatibility.

---

**Document Version:** 1.0
**Last Updated:** 2026-03-28
