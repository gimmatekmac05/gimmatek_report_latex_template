# Installation Guide

## For Users (Recommended Method)

### Method 1: Include as Subfolder (Easiest)

This method keeps the template with your project:

```bash
# In your project directory
git clone https://github.com/gimmatek/report-latex-template.git latex-template

# Your project structure:
# my_project/
# ├── latex-template/     # Template files here
# ├── main.tex
# └── chapters/
```

**Advantages:**
- ✅ Self-contained project
- ✅ Works offline
- ✅ Can version-lock template
- ✅ No system configuration needed

**Usage in document:**
```latex
\documentclass{gimmatek-report-template}
\makeatletter
\def\input@path{{latex-template/packages/}}
\makeatother
\RequirePackage{gimmatek-report-frontmatter}
```

---

### Method 2: Git Submodule

For version-controlled projects:

```bash
# Add as submodule
git submodule add https://github.com/gimmatek/report-latex-template.git latex-template

# Clone project with submodules
git clone --recurse-submodules <your-project-url>

# Or initialize submodules after cloning
git submodule update --init --recursive
```

**Advantages:**
- ✅ Version controlled
- ✅ Easy updates: `git submodule update --remote`
- ✅ Shared across team

---

### Method 3: TEXINPUTS Environment Variable

For advanced users who want system-wide access:

```bash
# Add to ~/.bashrc or ~/.zshrc
export TEXINPUTS=.:~/latex-templates/gimmatek//:

# Clone template to known location
mkdir -p ~/latex-templates
cd ~/latex-templates
git clone https://github.com/gimmatek/report-latex-template.git gimmatek
```

**Usage in document:**
```latex
\documentclass{gimmatek-report-template}  % Found automatically
\RequirePackage{gimmatek-report-frontmatter}
```

**Advantages:**
- ✅ Works globally
- ✅ No per-project setup
- ✅ Cleaner project structure

---

### Method 4: Personal texmf Tree (Most Professional)

Install into your personal TeX directory:

```bash
# Find your texmf home
TEXMF=$(kpsewhich -var-value TEXMFHOME)
echo "Installing to: $TEXMF"

# Create directory structure
mkdir -p "$TEXMF/tex/latex/gimmatek"

# Clone or copy files
cd "$TEXMF/tex/latex/"
git clone https://github.com/gimmatek/report-latex-template.git gimmatek

# Refresh TeX database
texhash "$TEXMF"
```

**Usage in document:**
```latex
\documentclass{gimmatek-report-template}  % Found automatically
\RequirePackage{gimmatek-report-frontmatter}
```

**Advantages:**
- ✅ Standard TeX installation method
- ✅ Works like published packages
- ✅ Clean project structure
- ✅ Easy updates

**Update procedure:**
```bash
cd "$TEXMF/tex/latex/gimmatek"
git pull
texhash "$TEXMF"
```

---

## Verification

Test your installation:

```bash
# Create test file
cat > test.tex << 'EOF'
\documentclass{gimmatek-report-template}
\RequirePackage{gimmatek-report-frontmatter}
\docabstract{Test}
\begin{document}
\makefrontmatter
\chapter{Test}
Works!
\end{document}
EOF

# Compile
export TEXINPUTS=.:./latex-template/packages//:  # If using Method 1
xelatex test.tex
```

If you see `test.pdf`, installation successful! ✅

---

## Troubleshooting

### Error: `gimmatek-report-template.cls not found`

**Solution for Method 1:**
```latex
% In your document, add:
\makeatletter
\def\input@path{{latex-template/packages/}}
\makeatother
```

**Solution for Method 3/4:**
```bash
# Check TEXINPUTS
echo $TEXINPUTS

# Or check texmf
kpsewhich gimmatek-report-template.cls
```

### Error: Chinese characters not showing

```
Cause: Using pdflatex instead of xelatex
Solution: Always use xelatex for this template
```

### Error: Package not found after texmf installation

```bash
# Refresh TeX database
texhash ~/Library/texmf  # macOS
texhash ~/texmf          # Linux

# Verify
kpsewhich gimmatek-report-template.cls
```

---

## Recommended Setup by Use Case

**Individual User, Single Project:**
→ Method 1 (Subfolder)

**Team with Multiple Projects:**
→ Method 2 (Git Submodule)

**Power User, Many Projects:**
→ Method 4 (Personal texmf)

**CI/CD Pipeline:**
→ Method 1 or 2 (Reproducible)

---

## Updating

### Method 1 & 2 (Git):
```bash
cd latex-template
git pull
```

### Method 4 (texmf):
```bash
cd $(kpsewhich -var-value TEXMFHOME)/tex/latex/gimmatek
git pull
texhash
```

---

## Uninstallation

### Method 1 & 2:
```bash
rm -rf latex-template
```

### Method 3:
```bash
# Remove from shell config (~/.bashrc or ~/.zshrc)
# Delete: export TEXINPUTS=...
```

### Method 4:
```bash
rm -rf $(kpsewhich -var-value TEXMFHOME)/tex/latex/gimmatek
texhash
```

---

**Questions?** See [LATEX_REPORT_STARTGUIDE.md](LATEX_REPORT_STARTGUIDE.md)
