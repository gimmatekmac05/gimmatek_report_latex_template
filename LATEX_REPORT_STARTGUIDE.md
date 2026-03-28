# LaTeX Report Start Guide

**For AI Agents & Human Users**

This guide provides step-by-step instructions for creating professional LaTeX reports using the Gimmatek Report Template system with automated front matter generation.

---

## 🤖 AI Agent Instructions

### Context

You are helping a user create a LaTeX document using the Gimmatek Report Template system. This template provides:
- Professional document class (`gimmatek-report-template.cls`)
- Automated front matter generation (`gimmatek-report-frontmatter.sty`)
- Chinese (CJK) typography support
- Stanford/Silicon Valley inspired design

### Prerequisites Check

Before starting, verify:
1. **XeLaTeX** is installed (required for CJK fonts)
2. **Git** is available (for template download)
3. User's working directory is confirmed

---

## 📥 Step 1: Download Template Files

### Option A: If Git Repository Exists (Future)

```bash
# Clone the template repository into a subfolder
git clone https://github.com/gimmatek/report-latex-template.git latex-template

# Expected structure after clone:
# project/
# ├── latex-template/          # Template subfolder
# │   ├── packages/
# │   │   ├── gimmatek-report-template.cls
# │   │   └── gimmatek-report-frontmatter.sty
# │   └── img/
# │       └── gimmatek_confidential.png
# ├── your_document.tex
# └── chapters/
```

### Option B: Current Setup (Manual)

```bash
# For now, copy files from existing project:
mkdir -p latex-template/packages latex-template/img

# Copy package files
cp path/to/gimmatek-report-template.cls latex-template/packages/
cp path/to/gimmatek-report-frontmatter.sty latex-template/packages/

# Copy assets
cp path/to/gimmatek_confidential.png latex-template/img/
```

### ⚠️ Important for AI Agents

When the user says "use the LaTeX template" or "create a LaTeX report":
1. First check if `latex-template/` directory exists
2. If not, ask the user for the template location or offer to use the manual setup
3. Confirm the location before proceeding

---

## 📝 Step 2: Create Your Document Structure

### Recommended Project Structure

```
my_report/
├── latex-template/              # Template files (from git or manual)
│   ├── packages/
│   │   ├── gimmatek-report-template.cls
│   │   └── gimmatek-report-frontmatter.sty
│   └── img/
│       └── gimmatek_confidential.png
├── main.tex                     # Your main document
├── chapters/                    # Your content
│   ├── ch_1.tex
│   ├── ch_2.tex
│   └── ch_3.tex
├── figures/                     # Your figures (optional)
└── img/                         # Your images (optional)
    └── cover.png
```

---

## 🔧 Step 3: Setup Your Document

### Minimal Document Template

Create `main.tex`:

```latex
\documentclass[12pt,a4paper]{gimmatek-report-template}

% Load the abstraction package from template subfolder
\makeatletter
\def\input@path{{latex-template/packages/}}
\makeatother
\RequirePackage{gimmatek-report-frontmatter}

%-------------------------------------------------------------------------------
% Document Metadata
%-------------------------------------------------------------------------------
\doctitle{您的文件標題}
\doctitlepage{您的文件標題}
\docsubtitle{Document Subtitle}
\docversion{V1.0}
\doctype{Technical Report}

%-------------------------------------------------------------------------------
% Abstract
%-------------------------------------------------------------------------------
\docabstract{%
在此填寫摘要內容。可以多段落。

第二段摘要內容...
}

%===============================================================================
% DOCUMENT BODY
%===============================================================================
\begin{document}

% Generate front matter (Abstract + TOC + LOT + LOF)
\frontmatter
\pagenumbering{roman}
\makefrontmatter

% Main content
\mainmatter
\input{chapters/ch_1.tex}
\input{chapters/ch_2.tex}
\input{chapters/ch_3.tex}

\end{document}
```

### Alternative: Using TEXINPUTS

Add to compile command:

```bash
# Linux/macOS
export TEXINPUTS=.:./latex-template/packages//:
xelatex main.tex

# Or use a Makefile (see Step 5)
```

---

## ✍️ Step 4: Write Content Following LaTeX Rules

### Basic LaTeX Writing Rules

#### 1. **Chapter Files** (`chapters/ch_1.tex`)

```latex
\chapter{章節標題}

\section{節標題}

段落內容。段落之間用空行分隔。

新段落開始。

\subsection{子節標題}

\begin{itemize}
\item 項目一
\item 項目二
\item 項目三
\end{itemize}

\subsubsection{子子節標題}

\begin{enumerate}
\item 步驟一
\item 步驟二
\item 步驟三
\end{enumerate}
```

#### 2. **Tables**

**Booktabs Style (Professional):**

```latex
\begin{table}[htbp]
\centering
\begin{tabularx}{\textwidth}{l X}
\toprule
\textbf{欄位} & \textbf{說明} \\
\midrule
項目一 & 詳細說明文字... \\
項目二 & 詳細說明文字... \\
\bottomrule
\end{tabularx}
\caption{表格標題}
\label{tab:example}
\end{table}
```

**Traditional Style (with borders):**

```latex
\begin{table}[htbp]
\centering
\renewcommand{\arraystretch}{1.5}
\begin{tabular}{|l|p{5cm}|p{5cm}|}
\hline
\textbf{項目} & \textbf{說明A} & \textbf{說明B} \\
\hline
內容1 & 說明1A & 說明1B \\
\hline
內容2 & 說明2A & 說明2B \\
\hline
\end{tabular}
\caption{表格標題}
\label{tab:example2}
\end{table}
```

#### 3. **Figures**

```latex
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/example.png}
\caption{圖片說明}
\label{fig:example}
\end{figure}
```

**Reference in text:**
```latex
如圖~\ref{fig:example}所示...
詳見表~\ref{tab:example}...
```

#### 4. **Cross-References**

**Label Naming Convention:**
- Figures: `\label{fig:descriptive_name}`
- Tables: `\label{tab:descriptive_name}`
- Sections: `\label{sec:descriptive_name}`

**Always use lowercase with underscores, not hyphens.**

#### 5. **Chinese Typography**

- Use full-width punctuation: ，。、；：「」
- Use half-width numbers: 1, 2, 3
- Keep English technical terms in English
- LaTeX handles Chinese/English spacing automatically

---

## 🎨 Step 5: Use Abstraction Features

### Available Commands

**Front Matter Generation:**
```latex
% Full (Abstract + TOC + LOT + LOF)
\makefrontmatter

% Minimal (TOC only)
\makeminimalfrontmatter

% Standard (TOC + LOF, no LOT)
\makestandardfrontmatter

% Custom abstract title
\makefrontmatterwith{Abstract}
```

**Control Flags:**
```latex
% Skip specific lists (before \makefrontmatter)
\includetocfalse       % Skip TOC
\includelotfalse       % Skip List of Tables
\includeloffalse       % Skip List of Figures
\includeabstractfalse  % Skip Abstract
```

**TOC Depth:**
```latex
\tocchaptersonly       % Only chapters
\tocsections           % Up to sections
\tocsubsections        % Up to subsections (default)
\tocsubsubsections     % Up to subsubsections
```

**Cover Page:**
```latex
\makecover                        % Use default img/cover.png
\makecover[img/custom_cover.png]  % Custom cover
```

---

## 🔨 Step 6: Compile the Document

### Using Makefile (Recommended)

Create `Makefile`:

```makefile
# Makefile for LaTeX compilation with template

TEXINPUTS := .:./latex-template/packages//:
export TEXINPUTS

MAIN = main
PDF = $(MAIN).pdf

.PHONY: all clean

all: $(PDF)

$(PDF): $(MAIN).tex chapters/*.tex
	xelatex $(MAIN).tex
	xelatex $(MAIN).tex

clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.synctex.gz

distclean: clean
	rm -f $(PDF)
```

**Usage:**
```bash
make           # Compile PDF
make clean     # Remove auxiliary files
```

### Manual Compilation

```bash
# Set TEXINPUTS to find template packages
export TEXINPUTS=.:./latex-template/packages//:

# Compile (run twice for references)
xelatex main.tex
xelatex main.tex

# View PDF
open main.pdf  # macOS
# or
xdg-open main.pdf  # Linux
```

---

## 🤖 AI Agent Workflow

When a user asks to create a LaTeX document, follow this workflow:

### 1. Initial Setup

```
AI: I'll help you create a LaTeX document using the Gimmatek template.
    First, let me check if the template is available.

[Check if latex-template/ exists in current directory]

If YES:
  ✅ Template found at latex-template/

If NO:
  ⚠️  Template not found. Options:
  1. Clone from git: git clone [URL] latex-template
  2. I can create the structure manually if you provide file paths

  Which option would you prefer?
```

### 2. Create Document Structure

```
AI: I'll create the following structure:

    my_report/
    ├── main.tex
    └── chapters/
        ├── ch_1.tex
        └── ch_2.tex

    Should I proceed?
```

### 3. Generate Content

```
AI: I'll now create:
    1. main.tex with your document metadata
    2. Chapter files with your content
    3. Makefile for easy compilation

    [Create files using Write tool]
```

### 4. Compile Instructions

```
AI: Document created! To compile:

    Option 1 (Recommended):
      make

    Option 2 (Manual):
      export TEXINPUTS=.:./latex-template/packages//:
      xelatex main.tex
      xelatex main.tex

    Would you like me to compile it for you?
```

---

## 📋 LaTeX Writing Checklist

### Before Compilation

- [ ] All `\input{chapters/...}` files exist
- [ ] All `\includegraphics{...}` files exist
- [ ] All `\label{}` use lowercase with underscores
- [ ] All tables have `\caption{}` and `\label{}`
- [ ] All figures have `\caption{}` and `\label{}`
- [ ] Abstract is set with `\docabstract{}`
- [ ] Document metadata is complete

### After First Compilation

- [ ] Check PDF page numbering (Roman i-v, then Arabic 1-n)
- [ ] Verify TOC has correct page numbers
- [ ] Verify LOT lists all tables
- [ ] Verify LOF lists all figures
- [ ] Check all cross-references resolved (no ??)
- [ ] Run second compilation for references

### Common Issues

**Issue: `gimmatek-report-template.cls not found`**
```
Solution: Check TEXINPUTS or \input@path is set correctly
```

**Issue: Chinese characters not showing**
```
Solution: Use xelatex, not pdflatex
```

**Issue: References showing ??**
```
Solution: Run xelatex twice (first pass creates .aux, second resolves refs)
```

**Issue: Cover image missing**
```
Solution: Skip \makecover or provide correct image path
```

---

## 📚 Additional Resources

**Template Documentation:**
- Full Analysis: `latex-template/docs/LATEX_ANALYSIS.md`
- Abstraction Guide: `latex-template/docs/ABSTRACTION_GUIDE.md`
- Examples: `latex-template/examples/`

**LaTeX References:**
- Tables: booktabs package documentation
- Figures: graphicx package documentation
- Chinese: xeCJK package documentation

---

## 🎯 Quick Start Commands Summary

```bash
# 1. Setup (one time)
git clone [template-repo-url] latex-template

# 2. Create project
mkdir my_report && cd my_report
# [Create main.tex and chapters/]

# 3. Compile
export TEXINPUTS=.:./latex-template/packages//:
xelatex main.tex
xelatex main.tex

# Or with Makefile
make
```

---

## 📝 Example: Minimal Complete Document

**main.tex:**
```latex
\documentclass[12pt,a4paper]{gimmatek-report-template}
\makeatletter
\def\input@path{{latex-template/packages/}}
\makeatother
\RequirePackage{gimmatek-report-frontmatter}

\doctitle{測試文件}
\docversion{V1.0}

\docabstract{這是一份測試文件。}

\begin{document}
\frontmatter
\pagenumbering{roman}
\makefrontmatter

\mainmatter
\chapter{第一章}
這是內容。

\end{document}
```

**Compile:**
```bash
export TEXINPUTS=.:./latex-template/packages//:
xelatex main.tex
xelatex main.tex
```

**Result:** Professional PDF with abstract, TOC, and content!

---

## ✅ Success Criteria

Your document is ready when:
- ✅ PDF compiles without errors
- ✅ Front matter shows (Abstract, TOC, LOT/LOF if applicable)
- ✅ Page numbering correct (Roman → Arabic)
- ✅ All cross-references resolved
- ✅ Chinese text renders correctly
- ✅ Tables and figures appear in lists

---

**Version:** 1.0
**Last Updated:** 2026-03-28
**Maintained by:** Gimmatek Team
