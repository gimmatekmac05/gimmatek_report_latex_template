# Git Repository Setup Guide

Instructions for initializing this directory as a Git repository and pushing to GitHub.

---

## 📋 Pre-Flight Checklist

Before initializing, ensure:
- [ ] All files are in place (run: `ls -la`)
- [ ] `.gitignore` exists
- [ ] No sensitive data in repository
- [ ] Documentation is complete

---

## 🚀 Quick Setup (GitHub)

### Step 1: Initialize Local Repository

```bash
cd /Users/tzuhuailin/Dev/smartehr_report/gimmatek_report_latex_template

# Initialize git
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial release v1.0.0

- Add gimmatek-report-template.cls document class
- Add gimmatek-report-frontmatter.sty abstraction package
- Add comprehensive documentation
- Add minimal example
- Add installation guides
- Add AI agent instructions in LATEX_REPORT_STARTGUIDE.md"
```

### Step 2: Create GitHub Repository

**Option A: Via GitHub CLI**

```bash
# Create public repository
gh repo create gimmatek/report-latex-template --public --source=. --remote=origin

# Push code
git push -u origin main
```

**Option B: Via GitHub Web Interface**

1. Go to https://github.com/new
2. Repository name: `report-latex-template`
3. Description: `Professional LaTeX template for technical reports with automated front matter generation`
4. **Public** or **Private** (your choice)
5. **Do NOT** initialize with README (we already have one)
6. Click "Create repository"

Then connect and push:

```bash
# Add remote
git remote add origin https://github.com/gimmatek/report-latex-template.git

# Push code
git branch -M main
git push -u origin main
```

### Step 3: Create Initial Release

```bash
# Tag the release
git tag -a v1.0.0 -m "Release v1.0.0

Initial release of Gimmatek Report LaTeX Template.

Features:
- Automated front matter generation (86-93% code reduction)
- Chinese (CJK) typography support
- Professional Stanford-inspired styling
- Complete AI agent integration guide
- Comprehensive documentation

See CHANGELOG.md for details."

# Push tag
git push origin v1.0.0
```

Then create release on GitHub:
1. Go to repository → Releases → "Create a new release"
2. Choose tag: `v1.0.0`
3. Release title: `v1.0.0 - Initial Release`
4. Copy description from tag message
5. Click "Publish release"

---

## 📦 Repository Settings (Recommended)

### After Repository Creation

**1. Add Description:**
```
Professional LaTeX template for technical reports with automated front matter generation
```

**2. Add Topics (Tags):**
- `latex`
- `latex-template`
- `document-class`
- `technical-writing`
- `chinese-typography`
- `cjk`
- `xelatex`
- `ai-agents`

**3. Add Website (if applicable):**
```
https://gimmatek.com
```

**4. Set Default Branch:**
- Ensure `main` is the default branch

**5. Enable Features:**
- ✅ Issues (for bug reports)
- ✅ Wiki (optional)
- ✅ Discussions (optional)
- ❌ Projects (probably not needed)

---

## 📝 README.md Badges (Optional)

Add to top of README.md:

```markdown
# Gimmatek Report LaTeX Template

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![LaTeX](https://img.shields.io/badge/LaTeX-XeLaTeX-orange)
![Status](https://img.shields.io/badge/status-production%20ready-brightgreen)

Professional LaTeX template for technical reports...
```

---

## 🔒 Repository Protection (Optional)

For team repositories:

### Branch Protection Rules

1. Go to Settings → Branches → Add rule
2. Branch name pattern: `main`
3. Enable:
   - ✅ Require pull request reviews before merging
   - ✅ Require status checks to pass before merging
   - ❌ Include administrators (if you want freedom)
4. Save changes

---

## 👥 Collaboration Setup

### Add Collaborators

1. Settings → Collaborators
2. Add team members
3. Set permission level:
   - **Write** for regular contributors
   - **Maintain** for maintainers
   - **Admin** for co-owners

### Create CODEOWNERS (Optional)

Create `.github/CODEOWNERS`:

```
# Default owners for everything
* @your-github-username

# Package maintainers
/packages/ @latex-expert @another-maintainer

# Documentation
/docs/ @doc-writer
*.md @doc-writer
```

---

## 📊 Repository Structure Validation

Run this to verify everything is in place:

```bash
# Check file structure
ls -R

# Expected output:
# ./packages/gimmatek-report-template.cls
# ./packages/gimmatek-report-frontmatter.sty
# ./img/gimmatek_confidential.png
# ./examples/minimal_example.tex
# ./docs/LATEX_ANALYSIS.md
# ./docs/ABSTRACTION_GUIDE.md
# ./README.md
# ./LATEX_REPORT_STARTGUIDE.md
# ... and other files
```

---

## 🔄 Maintenance Workflow

### Making Changes

```bash
# Create feature branch
git checkout -b feature/new-feature

# Make changes
# ... edit files ...

# Commit
git add .
git commit -m "Add new feature: description"

# Push
git push -u origin feature/new-feature

# Create pull request on GitHub
# After merge, update main
git checkout main
git pull
```

### Creating New Releases

```bash
# Update VERSION file
echo "1.1.0" > VERSION

# Update CHANGELOG.md
# ... add new entries ...

# Commit
git add VERSION CHANGELOG.md
git commit -m "Bump version to 1.1.0"

# Tag
git tag -a v1.1.0 -m "Release v1.1.0 - Description"

# Push
git push origin main
git push origin v1.1.0

# Create release on GitHub
```

---

## 📚 Documentation Updates

Keep these synced:
- `README.md` - Quick start
- `LATEX_REPORT_STARTGUIDE.md` - AI agent guide
- `CHANGELOG.md` - Version history
- `VERSION` - Current version

---

## 🎯 Clone URL

After setup, users will clone with:

```bash
# HTTPS
git clone https://github.com/gimmatek/report-latex-template.git latex-template

# SSH
git clone git@github.com:gimmatek/report-latex-template.git latex-template

# As submodule
git submodule add https://github.com/gimmatek/report-latex-template.git latex-template
```

---

## ✅ Verification

Repository is ready when:
- ✅ Can clone from GitHub
- ✅ All files present after clone
- ✅ README displays correctly on GitHub
- ✅ Release v1.0.0 exists
- ✅ Topics/description set
- ✅ No sensitive data exposed

---

## 🔐 Security Notes

**Before making repository public:**
- [ ] Review all files for sensitive data
- [ ] Check image files (no internal screenshots)
- [ ] Verify no API keys or credentials
- [ ] Confirm company logo usage rights

**Files checked:**
- `gimmatek-report-template.cls` - ✅ No sensitive data
- `gimmatek-report-frontmatter.sty` - ✅ No sensitive data
- `*.md` files - ✅ Documentation only
- `img/gimmatek_confidential.png` - ⚠️ Verify usage rights

---

**Ready to push to GitHub! 🚀**

```bash
# Quick command summary:
git init
git add .
git commit -m "Initial release v1.0.0"
git remote add origin https://github.com/gimmatek/report-latex-template.git
git push -u origin main
git tag -a v1.0.0 -m "Initial release"
git push origin v1.0.0
```
