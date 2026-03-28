# Gimmatek Report LaTeX Template

Professional LaTeX template system for creating technical reports with automated front matter generation and Chinese typography support.

---

## 🚀 Quick Start

```bash
# 1. Include this repository in your project
git clone https://github.com/gimmatek/report-latex-template.git latex-template

# 2. Create your document
cat > main.tex << 'EOF'
\documentclass[12pt,a4paper]{gimmatek-report-template}
\makeatletter
\def\input@path{{latex-template/src/}}
\makeatother
\RequirePackage{gimmatek-report-frontmatter}

\doctitle{Your Document Title}
\docabstract{Your abstract here...}

\begin{document}
\frontmatter
\pagenumbering{roman}
\makefrontmatter
\mainmatter

\chapter{First Chapter}
Content here...

\end{document}
EOF

# 3. Compile
export TEXINPUTS=.:./latex-template/src//:
xelatex main.tex
xelatex main.tex
```

---

## 📁 Repository Structure

```
gimmatek_report_latex_template/
├── README.md                          # This file
├── LATEX_REPORT_STARTGUIDE.md        # Complete guide for AI agents & users
├── CHANGELOG.md                       # Version history
├── UPGRADE_GUIDE_v2.0.0.md           # Upgrade instructions
├── src/
│   ├── gimmatek-report-template.cls                   # Document class
│   └── gimmatek-report-frontmatter.sty       # Front matter abstraction
├── assets/
│   └── gimmatek_confidential.png      # Company logo/watermark
├── examples/
│   ├── minimal_example.tex            # Minimal working example
│   └── standalone_example.tex         # Project root example
├── tools/
│   ├── Makefile                       # Build examples
│   └── Makefile.project               # Template for projects
└── docs/
    ├── LATEX_ANALYSIS.md              # Detailed analysis
    └── ABSTRACTION_GUIDE.md           # User guide
```

---

## ✨ Features

### Automated Front Matter
- ✅ Abstract generation
- ✅ Table of Contents (TOC)
- ✅ List of Tables (LOT)
- ✅ List of Figures (LOF)
- ✅ Automatic page numbering (Roman → Arabic)

### Professional Styling
- ✅ Stanford/Silicon Valley inspired design
- ✅ Chinese (CJK) typography support
- ✅ Consistent formatting
- ✅ Professional color scheme

### Developer Experience
- ✅ **86-93% code reduction** vs traditional LaTeX
- ✅ Single command front matter generation
- ✅ Prevents common errors
- ✅ Easy customization

---

## 📚 Documentation

- **[LATEX_REPORT_STARTGUIDE.md](LATEX_REPORT_STARTGUIDE.md)** - Complete guide with AI agent instructions
- **[docs/ABSTRACTION_GUIDE.md](docs/ABSTRACTION_GUIDE.md)** - Detailed usage guide
- **[docs/LATEX_ANALYSIS.md](docs/LATEX_ANALYSIS.md)** - Technical analysis

---

## 🔧 Requirements

- **XeLaTeX** (required for CJK fonts)
- **Git** (for cloning this repository)
- **Make** (optional, for Makefile usage)

---

## 💡 Usage

### Basic Document

```latex
\documentclass{gimmatek-report-template}
\makeatletter
\def\input@path{{latex-template/src/}}
\makeatother
\RequirePackage{gimmatek-report-frontmatter}

\docabstract{Your abstract...}

\begin{document}
\makefrontmatter
\chapter{Your Chapter}
\end{document}
```

### With Custom Configuration

```latex
% Skip List of Tables
\includelotfalse
\makefrontmatter

% Or minimal (TOC only)
\makeminimalfrontmatter

% Or control TOC depth
\tocsubsubsections
\makefrontmatter
```

---

## 🤖 AI Agent Integration

This template is designed to work seamlessly with AI coding assistants. See [LATEX_REPORT_STARTGUIDE.md](LATEX_REPORT_STARTGUIDE.md) for:
- Step-by-step AI agent instructions
- Automated setup workflows
- Common patterns and troubleshooting

---

## 📊 Benefits

| Feature | Before | After | Improvement |
|---------|--------|-------|-------------|
| Front matter code | ~30 lines | 4 lines | **87% reduction** |
| Manual commands | 7+ blocks | 1 command | **Automated** |
| Error prone | High | Low | **Safe** |
| Consistency | Varies | Standard | **Reliable** |

---

## 🏆 Success Stories

- ✅ Tested with 9-page technical manual
- ✅ Clean compilation (no warnings)
- ✅ Professional output quality
- ✅ Works with Chinese/English mixed content

---

## 📝 License

[Your License Here]

---

## 🤝 Contributing

Contributions welcome! Please read the contribution guidelines first.

---

## 📮 Support

- Issues: [GitHub Issues](https://github.com/gimmatek/report-latex-template/issues)
- Docs: [LATEX_REPORT_STARTGUIDE.md](LATEX_REPORT_STARTGUIDE.md)

---

**Maintained by:** Gimmatek Team
**Version:** 1.0.0
**Last Updated:** 2026-03-28
