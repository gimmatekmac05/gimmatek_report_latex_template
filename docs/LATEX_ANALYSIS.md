# LaTeX Project Analysis: Technical Documentation Template

**Analysis Date:** 2026-03-28
**Original Project:** SmartEHR Coder使用者操作手冊 (used as case study)
**Template Class:** gimmatek-report-template.cls (formerly smartehr.cls v2.0)

> **Note:** This document analyzes the original SmartEHR Coder project which served as the basis for creating the generalized Gimmatek Report Template. References to "SmartEHR" in this document are historical and refer to the source project. The template has been generalized as `gimmatek-report-template` for broader use.

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Document Class & Preamble Structure](#document-class--preamble-structure)
3. [Package Usage & Configuration](#package-usage--configuration)
4. [Custom Commands & Environments](#custom-commands--environments)
5. [Common Structural Patterns](#common-structural-patterns)
6. [Formatting Conventions](#formatting-conventions)
7. [Repeated Code Blocks (Abstraction Opportunities)](#repeated-code-blocks-abstraction-opportunities)
8. [Cross-Referencing Patterns](#cross-referencing-patterns)
9. [Figure & Table Patterns](#figure--table-patterns)
10. [Version Differences Analysis](#version-differences-analysis)
11. [Chapter Organization](#chapter-organization)
12. [Recommended Template Abstractions](#recommended-template-abstractions)
13. [Best Practices & Guidelines](#best-practices--guidelines)

---

## Executive Summary

This project uses a **custom LaTeX document class** (`smartehr.cls`) built on the standard `report` class, specifically designed for technical documentation with CJK (Chinese-Japanese-Korean) support. The document requires **XeLaTeX** compilation for proper font rendering.

### Key Characteristics:

- **Custom Class:** Stanford/Silicon Valley inspired design aesthetic
- **CJK Support:** Full Chinese typography using PingFang TC font
- **Modular Structure:** Chapter-based organization with conditional compilation
- **Professional Styling:** Booktabs tables, colored boxes, GitHub-style code blocks
- **Three Build Variants:** Standard, V2, and Engineering builds

### File Statistics:

- **Total LaTeX files:** 21
- **Active chapters:** 7 (+ 1 appendix)
- **Old chapters:** 9 (archived)
- **Largest file:** [ch_5.tex](chapters/ch_5.tex) (543 lines - Expert Functions)
- **Total figures:** 39 labels across current chapters

---

## Document Class & Preamble Structure

### Custom Document Class: `smartehr.cls`

**Base Configuration:**
```latex
\LoadClass[12pt,a4paper]{report}
```

**Version Information:**
```latex
\ProvidesClass{smartehr}[2025/03/27 v2.0 SmartEHR Technical Documentation Class]
```

**Compiler Requirement:** XeLaTeX (for fontspec and xeCJK packages)

### Main Document Variants

The project maintains three main document files:

1. **[SmartEHR Coder使用者操作手冊.tex](SmartEHR%20Coder使用者操作手冊.tex)**
   - Simple wrapper that inputs V2 version
   ```latex
   \input{\detokenize{SmartEHR Coder使用者操作手冊_V2.tex}}
   ```

2. **[SmartEHR Coder使用者操作手冊_V2.tex](SmartEHR%20Coder使用者操作手冊_V2.tex)**
   - Main production document
   - Complete preamble with metadata configuration
   - Conditional appendix logic

3. **[SmartEHR Coder使用者操作手冊_工程版.tex](SmartEHR%20Coder使用者操作手冊_工程版.tex)**
   - Engineering build variant
   - Defines `\ENGINEERINGBUILD` flag
   - Includes appendix automatically

### Document Metadata Setup

```latex
\documentclass[12pt,a4paper]{smartehr}

% Document metadata
\doctitle{SmartEHR Coder使用者操作手冊}
\doctitlepage{SmartEHR Coder使用者操作手冊}
\docsubtitle{Stanford x Silicon Valley Engineering Style}
\docversion{V2}
\doctype{System Operation & Governance Manual}
```

### Conditional Compilation Pattern

```latex
\newif\ifincludeappendix
\ifdefined\ENGINEERINGBUILD
  \includeappendixtrue
\else
  \includeappendixfalse
\fi

% Later in document
\ifincludeappendix
  \appendix
  \input{chapters/appendix_a.tex}
\fi
```

---

## Package Usage & Configuration

### Page Layout & Geometry

```latex
\RequirePackage[margin=1in,headheight=45pt]{geometry}
```
- **Margins:** 1 inch on all sides
- **Head height:** 45pt (accommodates two-row header)

### CJK & Font Support

```latex
\RequirePackage{fontspec}
\RequirePackage{xeCJK}

\setCJKmainfont{PingFang TC}[
  UprightFont = * Light,
  BoldFont = * Semibold,
  ItalicFont = * Light,
  BoldItalicFont = * Medium
]
\setmonofont{Menlo}
```

**Font Strategy:**
- **CJK Text:** PingFang TC (Apple's system font for Traditional Chinese)
- **Monospace:** Menlo (for code blocks)
- **Requires:** macOS or manual font installation

### Table Packages

```latex
\RequirePackage{longtable}      % Multi-page tables
\RequirePackage{booktabs}       % Professional table rules
\RequirePackage{tabularx}       % Auto-width tables
\RequirePackage{array}          % Enhanced table features
\RequirePackage[table]{xcolor}  % Table cell colors
```

**Usage Pattern:**
- `booktabs` for publication-quality tables (no vertical rules)
- `tabularx` with `X` column type for flexible widths
- `\arraystretch` set to 1.25 globally, 1.5 locally

### Mathematics

```latex
\RequirePackage{amsmath}
\RequirePackage{amssymb}
```

**Usage:** Minimal in current project (technical manual, not mathematical)

### Text Formatting

```latex
\RequirePackage{indentfirst}    % Indent first paragraph
\RequirePackage{setspace}       % Line spacing control
\RequirePackage{enumitem}       % Customized lists
\RequirePackage{caption}        % Caption formatting
```

**Spacing Configuration:**
```latex
\setstretch{1.3}                           % 1.3× line spacing
\setlength{\parindent}{2em}                % 2em paragraph indent
\setlength{\parskip}{0.4em}                % 0.4em paragraph skip
```

### Graphics & Diagrams

```latex
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{shapes.geometric,arrows.meta,positioning,calc,fit,backgrounds}
```

**TikZ Libraries Used:**
- `shapes.geometric` - For system architecture diagrams
- `arrows.meta` - Modern arrow styles
- `positioning` - Relative node placement
- `calc` - Coordinate calculations
- `fit` - Bounding boxes
- `backgrounds` - Background layers

### Special Features

```latex
\RequirePackage[most]{tcolorbox}    % Colored boxes
\RequirePackage{fancyhdr}           % Headers/footers
\RequirePackage{titlesec}           % Section formatting
\RequirePackage{listings}           % Code blocks
```

### Hyperlinks (Last Package)

```latex
\RequirePackage[hidelinks]{hyperref}
```

**Best Practice:** Loaded last to avoid conflicts, with `hidelinks` option to remove colored boxes around links.

---

## Custom Commands & Environments

### Document Metadata Commands

Defined in `smartehr.cls`:

```latex
\newcommand{\doctitle}[1]{\renewcommand{\@doctitle}{#1}}
\newcommand{\doctitlepage}[1]{\renewcommand{\@doctitlepage}{#1}}
\newcommand{\docsubtitle}[1]{\renewcommand{\@docsubtitle}{#1}}
\newcommand{\docversion}[1]{\renewcommand{\@docversion}{#1}}
\newcommand{\doctype}[1]{\renewcommand{\@doctype}{#1}}
```

**Usage in Main Document:**
```latex
\doctitle{SmartEHR Coder使用者操作手冊}          % Header title
\doctitlepage{SmartEHR Coder使用者操作手冊}      % Title page
\docsubtitle{Stanford x Silicon Valley Engineering Style}
\docversion{V2}
\doctype{System Operation & Governance Manual}
```

### Custom Environments

#### `insightbox` Environment

**Definition:**
```latex
\newtcolorbox{insightbox}[1][]{
  colback=svCloud!50,
  colframe=svNavy,
  fonttitle=\bfseries,
  title=#1,
  boxrule=1pt,
  arc=2pt
}
```

**Usage Example (from oldchapters):**
```latex
\begin{insightbox}[Chapter Insight]
本章提供整份手冊的結構導覽，協助讀者依據角色快速定位需要閱讀的章節。
\end{insightbox}
```

**Status:** Defined in class but **NOT used** in current chapters (only in oldchapters).

### Local Custom Commands

#### Array Stretch Override

Found in [ch_1.tex:58](chapters/ch_1.tex#L58):
```latex
\renewcommand{\arraystretch}{1.5}
```
Increases table row height locally for specific tables.

#### Engineering Build Flag

Found in [SmartEHR Coder使用者操作手冊_工程版.tex:1](SmartEHR%20Coder使用者操作手冊_工程版.tex#L1):
```latex
\def\ENGINEERINGBUILD{1}
```

---

## Common Structural Patterns

### Chapter Organization Pattern

**Current Chapters Structure:**
```latex
\chapter{章節標題}
\section{節標題}
\subsection{子節標題}
\subsubsection{子子節標題}  % Only in ch_5.tex
```

**Old Chapters Structure:**
```latex
\chapter*{章節標題}  % Unnumbered
\addcontentsline{toc}{chapter}{章節標題}  % Manual TOC entry
\begin{insightbox}[Chapter Insight]
本章重點摘要...
\end{insightbox}
\section*{節標題}  % Unnumbered sections
```

### Pattern: Interface Documentation

**Repeated 7+ times in [ch_5.tex](chapters/ch_5.tex) (Expert Functions):**

```latex
\section{功能名稱}

% 1. Interface description paragraph
本介面提供專家使用者XXX的功能...

% 2. List view figure
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/xxxList_1.png}
\caption{XXX管理介面 - 列表檢視}
\label{fig:xxx_list_1}
\end{figure}

% 3. Detail view figure
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/xxxList_2.png}
\caption{XXX管理介面 - 詳細檢視}
\label{fig:xxx_list_2}
\end{figure}

% 4. Usage instructions
\subsection{使用說明與系統執行流程}

\subsubsection{列表與檢視詳細}
\begin{enumerate}
\item 進入介面可瀏覽...
\item 點擊單一...
\item 可在左側...
\end{enumerate}

\subsubsection{新增XXX}
\begin{enumerate}
\item 步驟說明...
\end{enumerate}

\subsubsection{編輯XXX}
\begin{enumerate}
\item 步驟說明...
\end{enumerate}

\subsubsection{比較版本}
\begin{enumerate}
\item 步驟說明...
\end{enumerate}
```

**Abstraction Opportunity:** This exact pattern repeats for:
- Component 管理 (Component Management)
- Template 管理 (Template Management)
- Prompt 管理 (Prompt Management)
- Vocabulary 管理 (Vocabulary Management)
- Test Cases 管理 (Test Cases Management)

### Pattern: Medical Staff Functions

**Found in [ch_4.tex](chapters/ch_4.tex):**

```latex
\section{功能名稱}

% 1. Description paragraph
此功能提供...

% 2. Single interface screenshot
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/xxx.png}
\caption{功能介面截圖}
\label{fig:xxx}
\end{figure}

% 3. Usage instructions
\subsection{使用方法}
\begin{enumerate}
\item 步驟一...
\item 步驟二...
\end{enumerate}

% 4. System execution flow
\subsection{系統執行流程}
\begin{enumerate}
\item 系統載入...
\item 系統處理...
\item 系統回傳...
\end{enumerate}
```

### Pattern: Enumerated Step-by-Step Instructions

**Usage Frequency:** Very high (40+ occurrences)

```latex
\begin{enumerate}
\item 進入XXX介面可瀏覽所有可用的XXX
\item 於XXX文字框中可編輯XXX的內容
\item 確認滿意後，點擊「XXX」按鈕儲存更改
\item 使用「手動重新載入XXX」按鈕可確保XXX更新生效
\end{enumerate}
```

**Characteristics:**
- Always numbered lists for sequential actions
- Consistent verb patterns: 進入/點擊/編輯/確認/使用
- Often 3-5 steps per instruction block

### Pattern: Feature Lists

**Usage:** Chapter introductions and capability descriptions

```latex
\begin{itemize}
\item 提供醫事人員使用之簡化介面
\item 專家介面提供完整的系統管理功能
\item 即時測試功能可快速驗證Prompt效果
\item 版本控制確保變更的可追溯性與安全性
\end{itemize}
```

---

## Formatting Conventions

### Color Scheme

**Stanford/Silicon Valley Style (defined in smartehr.cls):**

```latex
\definecolor{svCardinal}{HTML}{8C1515}      % Primary accent (Stanford Cardinal)
\definecolor{svNavy}{HTML}{0A2540}          % Titles & headings
\definecolor{svSlate}{HTML}{1F2937}         % Body text
\definecolor{svMuted}{HTML}{6B7280}         % Secondary text
\definecolor{svCloud}{HTML}{F8FAFC}         % Backgrounds
\definecolor{svBlue}{HTML}{0B63CE}          % Links & accents
\definecolor{svGreen}{HTML}{059669}         % Code comments
\definecolor{svPurple}{HTML}{7C3AED}        % Code keywords
```

**Usage:**
- Chapter numbers: `svCardinal`
- Chapter titles: `svNavy`
- Section titles: `svNavy` bold
- Body text: `svSlate`
- Code backgrounds: `svCloud`

### Typography Settings

**Paragraph Formatting:**
```latex
\setlength{\parindent}{2em}                 % First line indent
\setlength{\parskip}{0.4em}                 % Space between paragraphs
\setstretch{1.3}                            % Line spacing multiplier
```

**List Formatting:**
```latex
\setlist[itemize]{
  topsep=4pt,
  itemsep=3pt,
  leftmargin=2.2em
}
\setlist[enumerate]{
  topsep=4pt,
  itemsep=3pt,
  leftmargin=2.2em
}
```

### Section Formatting

**Chapter Style:**
```latex
\titleformat{\chapter}[display]
  {\normalfont\huge\bfseries\color{svNavy}}
  {\textcolor{svCardinal}{\fontsize{40}{48}\selectfont\thechapter}}
  {20pt}
  {\Huge}
  [\vspace{2pt}{\titlerule[1pt]\color{svCardinal}}]
```

**Visual Effect:**
- Large cardinal-colored chapter number (40pt)
- Navy-colored chapter title (Huge)
- Cardinal-colored rule underneath

**Section/Subsection Styles:**
```latex
\titleformat{\section}
  {\Large\bfseries\color{svNavy}}{\thesection}{1em}{}

\titleformat{\subsection}
  {\large\bfseries\color{svSlate}}{\thesubsection}{1em}{}
```

### Table Formatting

**Default Array Stretch:**
```latex
\renewcommand{\arraystretch}{1.25}  % Global default
```

**Local Override Example ([ch_1.tex:58](chapters/ch_1.tex#L58)):**
```latex
\renewcommand{\arraystretch}{1.5}   % Increased spacing for specific table
```

**Booktabs Style (Professional):**
```latex
\begin{tabularx}{\textwidth}{l X}
\toprule
\textbf{欄位} & \textbf{說明} \\
\midrule
內容 & 說明文字 \\
\bottomrule
\end{tabularx}
```

**Traditional Style (with borders):**
```latex
\begin{tabular}{|p{3cm}|p{5.5cm}|p{5.5cm}|}
\hline
\textbf{層面} & \textbf{傳統方法} & \textbf{SmartEHR Coder} \\
\hline
內容... & 內容... & 內容... \\
\hline
\end{tabular}
```

### Code Block Formatting

**GitHub-Inspired Style:**
```latex
\lstdefinestyle{github-shell}{
  basicstyle=\ttfamily\small\color{svSlate},
  backgroundcolor=\color{svCloud},
  frame=single,
  rulecolor=\color{svMuted},
  numbers=left,
  numberstyle=\tiny\color{svMuted},
  commentstyle=\color{svGreen},
  keywordstyle=\color{svPurple}\bfseries,
  stringstyle=\color{svBlue},
  breaklines=true,
  tabsize=4
}
```

**Usage in [appendix_a.tex](chapters/appendix_a.tex):**
```latex
\begin{lstlisting}
pnpm install
\end{lstlisting}

\begin{lstlisting}
pnpm dev
\end{lstlisting}
```

---

## Repeated Code Blocks (Abstraction Opportunities)

### 1. Standard Figure Pattern

**Frequency:** 40+ occurrences across all chapters

**Current Pattern:**
```latex
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/example.png}
\caption{圖片說明文字}
\label{fig:example}
\end{figure}
```

**Recommended Abstraction:**
```latex
% Add to smartehr.cls or preamble
\newcommand{\fullwidthfig}[3]{%
  \begin{figure}[htbp]
  \centering
  \includegraphics[width=\textwidth]{figures/#1}
  \caption{#2}
  \label{fig:#3}
  \end{figure}
}
```

**Usage:**
```latex
% Before (7 lines)
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/simple.png}
\caption{簡化介面截圖}
\label{fig:simple}
\end{figure}

% After (1 line)
\fullwidthfig{simple.png}{簡化介面截圖}{simple}
```

**Savings:** 6 lines per figure × 40 figures = **240 lines**

### 2. Two-Figure Interface Pattern

**Frequency:** 7+ times in [ch_5.tex](chapters/ch_5.tex)

**Current Pattern:**
```latex
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/componentList_1.png}
\caption{Component管理介面 - 列表檢視}
\label{fig:component_list_1}
\end{figure}

\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/componentList_2.png}
\caption{Component管理介面 - 詳細檢視}
\label{fig:component_list_2}
\end{figure}
```

**Recommended Abstraction:**
```latex
% Add to smartehr.cls
\newcommand{\interfacefigures}[3]{%
  % #1 = base filename (e.g., "component")
  % #2 = Chinese display name (e.g., "Component管理")
  % #3 = label base (e.g., "component")
  \begin{figure}[htbp]
  \centering
  \includegraphics[width=\textwidth]{figures/#1List_1.png}
  \caption{#2介面 - 列表檢視}
  \label{fig:#3_list_1}
  \end{figure}

  \begin{figure}[htbp]
  \centering
  \includegraphics[width=\textwidth]{figures/#1List_2.png}
  \caption{#2介面 - 詳細檢視}
  \label{fig:#3_list_2}
  \end{figure}
}
```

**Usage:**
```latex
% Before (14 lines)
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/componentList_1.png}
\caption{Component管理介面 - 列表檢視}
\label{fig:component_list_1}
\end{figure}

\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/componentList_2.png}
\caption{Component管理介面 - 詳細檢視}
\label{fig:component_list_2}
\end{figure}

% After (1 line)
\interfacefigures{component}{Component管理}{component}
```

**Savings:** 13 lines per interface × 7 interfaces = **91 lines**

### 3. Tabularx with Booktabs Pattern

**Frequency:** 8+ times

**Current Pattern:**
```latex
\begin{table}[htbp]
\centering
\begin{tabularx}{\textwidth}{l X}
\toprule
\textbf{欄位} & \textbf{說明} \\
\midrule
內容1 & 說明1 \\
內容2 & 說明2 \\
\bottomrule
\end{tabularx}
\caption{表格標題}
\label{tab:example}
\end{table}
```

**Recommended Abstraction:**
```latex
% Environment for two-column description tables
\newenvironment{desctable}[2]{%
  % #1 = caption, #2 = label
  \begin{table}[htbp]
  \centering
  \begin{tabularx}{\textwidth}{l X}
  \toprule
  \textbf{欄位} & \textbf{說明} \\
  \midrule
}{%
  \bottomrule
  \end{tabularx}
  \caption{#1}
  \label{tab:#2}
  \end{table}
}
```

**Usage:**
```latex
% Before (12 lines)
\begin{table}[htbp]
\centering
\begin{tabularx}{\textwidth}{l X}
\toprule
\textbf{欄位} & \textbf{說明} \\
\midrule
內容1 & 說明1 \\
內容2 & 說明2 \\
\bottomrule
\end{tabularx}
\caption{表格標題}
\label{tab:example}
\end{table}

% After (6 lines)
\begin{desctable}{表格標題}{example}
內容1 & 說明1 \\
內容2 & 說明2 \\
\end{desctable}
```

**Savings:** 6 lines per table × 8 tables = **48 lines**

### 4. Interface Documentation Section Pattern

**Frequency:** 7 times in [ch_5.tex](chapters/ch_5.tex)

**Current Pattern (50+ lines each):**
```latex
\section{Component管理}

本介面提供專家使用者管理Component的功能...

\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/componentList_1.png}
\caption{Component管理介面 - 列表檢視}
\label{fig:component_list_1}
\end{figure}

\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/componentList_2.png}
\caption{Component管理介面 - 詳細檢視}
\label{fig:component_list_2}
\end{figure}

\subsection{使用說明與系統執行流程}

\subsubsection{列表與檢視詳細}
\begin{enumerate}
\item ...
\end{enumerate}

\subsubsection{新增Component}
\begin{enumerate}
\item ...
\end{enumerate}

\subsubsection{編輯Component}
\begin{enumerate}
\item ...
\end{enumerate}

\subsubsection{比較版本}
\begin{enumerate}
\item ...
\end{enumerate}
```

**Recommended Template File:**

Create `templates/interface_section.tex`:
```latex
% Template for interface documentation section
% Usage: Copy this file and fill in the placeholders

\section{[INTERFACE_NAME_ZH]管理}

本介面提供專家使用者管理[INTERFACE_NAME_ZH]的功能...

\interfacefigures{[FILENAME_BASE]}{[INTERFACE_NAME_ZH]管理}{[LABEL_BASE]}

\subsection{使用說明與系統執行流程}

\subsubsection{列表與檢視詳細}
\begin{enumerate}
\item 進入[INTERFACE_NAME_ZH]介面可瀏覽所有可用的[INTERFACE_NAME_ZH]
\item 點擊單一[INTERFACE_NAME_ZH]項目可在右側檢視完整定義內容
\item 可在左側列表使用搜尋功能快速篩選[INTERFACE_NAME_ZH]
\end{enumerate}

\subsubsection{新增[INTERFACE_NAME_ZH]}
\begin{enumerate}
\item [STEP_1]
\item [STEP_2]
\item [STEP_3]
\end{enumerate}

\subsubsection{編輯[INTERFACE_NAME_ZH]}
\begin{enumerate}
\item [STEP_1]
\item [STEP_2]
\item [STEP_3]
\end{enumerate}

\subsubsection{比較版本}
\begin{enumerate}
\item [STEP_1]
\item [STEP_2]
\item [STEP_3]
\end{enumerate}
```

**Benefit:** Provides consistent structure template for documentation writers.

### 5. Usage Instructions Pattern

**Frequency:** 15+ times

**Current Pattern:**
```latex
\subsection{使用方法}
\begin{enumerate}
\item 進入XXX介面...
\item 於XXX文字框編輯...
\item 確認滿意後，點擊...
\item 使用「手動重新載入...」按鈕...
\end{enumerate}
```

**Recommended Abstraction:**
```latex
% Semantic environment for usage instructions
\newenvironment{usageinstructions}{%
  \subsection{使用方法}
  \begin{enumerate}
}{%
  \end{enumerate}
}

% Alternative: system execution flow
\newenvironment{executionflow}{%
  \subsection{系統執行流程}
  \begin{enumerate}
}{%
  \end{enumerate}
}
```

**Usage:**
```latex
% Before (6 lines)
\subsection{使用方法}
\begin{enumerate}
\item 步驟1
\item 步驟2
\item 步驟3
\end{enumerate}

% After (5 lines with clearer semantics)
\begin{usageinstructions}
\item 步驟1
\item 步驟2
\item 步驟3
\end{usageinstructions}
```

**Benefit:** Semantic clarity + consistency. Can later modify all usage instruction styling globally.

---

## Cross-Referencing Patterns

### Label Naming Conventions

**Figures:**
```latex
\label{fig:descriptive_name}
```

**Examples from codebase:**
- `fig:basic` - Basic interface
- `fig:expert` - Expert interface
- `fig:admin` - Admin interface
- `fig:system-architecture` - Architecture diagram
- `fig:component_list_1` - Component list view
- `fig:template_list_2` - Template detail view

**Convention Analysis:**
- **Prefix:** Always `fig:` for figures
- **Separator:** Mix of underscores `_` (current chapters) and hyphens `-` (ch_1.tex)
- **Numbering:** Use `_1`, `_2` suffix for multi-figure sequences
- **Style:** Lowercase with descriptive names

**Tables:**
```latex
\label{tab:descriptive_name}
```

**Examples:**
- `tab:traditional_vs_smartehr` - Comparison table
- `tab:performance_metrics_explanation` - Metrics description

**Convention:** Consistent underscore separators for tables.

### Cross-Reference Statistics

**By Chapter:**
- [ch_1.tex](chapters/ch_1.tex): 5 labels (1 table, 4 figures)
- [ch_2.tex](chapters/ch_2.tex): 0 labels
- [ch_3.tex](chapters/ch_3.tex): 3 labels (3 figures)
- [ch_4.tex](chapters/ch_4.tex): 3 labels (3 figures)
- **[ch_5.tex](chapters/ch_5.tex): 19 labels (19 figures)** ← Highest
- [ch_6.tex](chapters/ch_6.tex): 6 labels (6 figures)
- [ch_7.tex](chapters/ch_7.tex): 3 labels (1 table, 2 figures)
- **Total: 39 labels**

### Automatic Localization

**Chinese Figure/Table Numbering:**
```latex
% Defined in smartehr.cls
\renewcommand{\figurename}{圖}
\renewcommand{\tablename}{表}
\renewcommand{\thefigure}{\figurename\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\tablename\thechapter.\arabic{table}}
```

**Effect:**
- Figures appear as: 圖1.1, 圖1.2, 圖2.1...
- Tables appear as: 表1.1, 表2.1...
- No manual Chinese numbering needed

### Reference Best Practices

**Current Usage (implicit):**
- Labels placed immediately after `\caption{}`
- References likely used in text (not visible in current analysis)
- Consistent prefixing prevents label collisions

**Recommended Standard:**
```latex
% Figure reference in text
如圖~\ref{fig:system-architecture}所示...

% Table reference in text
詳見表~\ref{tab:performance_metrics_explanation}...
```

**Note:** The `~` (non-breaking space) prevents line breaks between "圖" and the number.

---

## Figure & Table Patterns

### Figure Patterns

#### Standard Interface Screenshot

**Placement:** `[htbp]` (here, top, bottom, page)
**Centering:** Always `\centering`
**Width:** `\textwidth` (100% width) or `0.9\textwidth` (90%)
**Format:** PNG files in `figures/` directory

**Example:**
```latex
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/simple.png}
\caption{簡化介面截圖}
\label{fig:simple}
\end{figure}
```

#### Two-Figure Interface Pattern

**Used for list + detail views:**

```latex
% Figure 1: List view
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/componentList_1.png}
\caption{Component管理介面 - 列表檢視}
\label{fig:component_list_1}
\end{figure}

% Figure 2: Detail view
\begin{figure}[htbp]
\centering
\includegraphics[width=\textwidth]{figures/componentList_2.png}
\caption{Component管理介面 - 詳細檢視}
\label{fig:component_list_2}
\end{figure}
```

**Instances:** 7 pairs in [ch_5.tex](chapters/ch_5.tex)

#### TikZ Diagram

**Complex system architecture diagram in [ch_1.tex:115-151](chapters/ch_1.tex#L115-L151):**

```latex
\begin{figure}[htbp]
\centering
\begin{tikzpicture}[
  transform shape,
  node distance=2cm and 3cm,
  component/.style={
    rectangle,
    draw=svNavy,
    fill=svCloud,
    thick,
    minimum width=2.5cm,
    minimum height=1cm,
    text centered,
    rounded corners=2pt
  },
  arrow/.style={
    ->,
    >=Stealth,
    thick,
    color=svCardinal
  }
]
  % Node definitions
  \node[component] (comp) {Component};
  \node[component, right=of comp] (temp) {Template};
  \node[component, right=of temp] (prompt) {Final Prompt};
  \node[component, right=of prompt] (llm) {LLM};
  \node[component, right=of llm] (output) {Output};

  % Arrows showing flow
  \draw[arrow] (comp) -- (temp);
  \draw[arrow] (temp) -- (prompt);
  \draw[arrow] (prompt) -- (llm);
  \draw[arrow] (llm) -- (output);

  % Feedback loop
  \draw[arrow, bend right=45] (output.south) to node[below] {Feedback} (temp.south);
\end{tikzpicture}
\caption{SmartEHR Coder 系統架構示意圖}
\label{fig:system-architecture}
\end{figure}
```

**Characteristics:**
- Uses custom node styles (component, arrow)
- Stanford color scheme (svNavy, svCloud, svCardinal)
- Rounded corners and consistent spacing
- Shows data flow with feedback loop

### Figure File Naming Conventions

**Interface Screenshots:**
```
{featureName}List_1.png    # List view
{featureName}List_2.png    # Detail view
```

**Examples:**
- `componentList_1.png`, `componentList_2.png`
- `templateList_1.png`, `templateList_2.png`
- `promptList_1.png`, `promptList_2.png`
- `vocabularyList_1.png`, `vocabularyList_2.png`
- `testCaseList_1.png`, `testCaseList_2.png`

**General Interfaces:**
- `simple.png` - Simplified interface
- `expert.png` - Expert interface
- `admin.png` - Admin interface

**Reused Figures:**
- `versionControl.png` - Used with different labels in multiple contexts

### Table Patterns

#### Pattern 1: Comparison Table (Bordered Style)

**Used in [ch_1.tex:58-75](chapters/ch_1.tex#L58-L75):**

```latex
\renewcommand{\arraystretch}{1.5}
\begin{table}[htbp]
\centering
\begin{tabular}{|p{3cm}|p{5.5cm}|p{5.5cm}|}
\hline
\textbf{層面} & \textbf{傳統方法} & \textbf{SmartEHR Coder} \\
\hline
學習成本 & 需熟悉API... & 使用自然語言... \\
\hline
變更管理 & 修改程式碼... & 調整Template... \\
\hline
專業分工 & 依賴工程師... & 醫學專家可直接... \\
\hline
\end{tabular}
\caption{傳統方法與SmartEHR Coder之比較}
\label{tab:traditional_vs_smartehr}
\end{table}
```

**Characteristics:**
- Fixed-width columns: `p{width}` specification
- Full borders: `|` vertical, `\hline` horizontal
- Increased array stretch (1.5) for readability
- Three-column comparison format

#### Pattern 2: Description Table (Booktabs Style)

**Used in [ch_7.tex:37-44](chapters/ch_7.tex#L37-L44):**

```latex
\begin{table}[htbp]
\centering
\begin{tabular}{|l|p{10cm}|}
\hline
\textbf{指標} & \textbf{說明} \\
\hline
Latency (ms) & 從使用者送出請求... \\
\hline
Token 使用量 & 完整Prompt所包含... \\
\hline
\end{tabular}
\caption{效能指標說明}
\label{tab:performance_metrics_explanation}
\end{table}
```

**Characteristics:**
- Two columns: fixed label + flexible description
- Left-aligned labels, paragraph-wrapped descriptions
- Still uses borders (older style)

#### Pattern 3: Booktabs Professional Style

**Not extensively used in current chapters, but defined in class:**

```latex
\begin{tabularx}{\textwidth}{l X}
\toprule
\textbf{欄位} & \textbf{說明} \\
\midrule
Content & Description \\
Content & Description \\
\bottomrule
\end{tabularx}
```

**Characteristics:**
- No vertical rules (publication quality)
- Thicker top/bottom rules, thinner mid rule
- Auto-width `X` column for flexible content

### Table Caption Patterns

**All tables use descriptive Chinese captions:**
- 傳統方法與SmartEHR Coder之比較
- 效能指標說明

**Format:** Noun phrase describing table contents, no ending punctuation.

---

## Version Differences Analysis

### Current `chapters/` vs Old `oldchapters/`

#### 1. Chapter Numbering

**Current chapters/:**
```latex
\chapter{系統簡介}
\section{產品定位}
\subsection{核心價值}
```
- Fully numbered hierarchy
- Automatic TOC entries

**Old oldchapters/:**
```latex
\chapter*{簡介}
\addcontentsline{toc}{chapter}{簡介}
\section*{本手冊之目標讀者}
\section*{閱讀指南}
```
- Unnumbered chapters and sections (`*` variant)
- Manual TOC entries with `\addcontentsline`

#### 2. Insightbox Usage

**Current:** NOT used (0 occurrences)

**Old:** Heavy usage (9 occurrences)

**Example from [oldchapters/ch_1.tex](oldchapters/ch_1.tex):**
```latex
\begin{insightbox}[Chapter Insight]
本章提供整份手冊的結構導覽，協助讀者依據角色快速定位需要閱讀的章節。
\end{insightbox}
```

**Implication:** Design decision to remove colored callout boxes in favor of cleaner, more streamlined presentation.

#### 3. Content Organization

**Current Structure (7 chapters + 1 appendix):**
1. 系統簡介 (System Introduction)
2. 權限與安全 (Permissions & Security)
3. 一般系統功能 (General System Functions)
4. 醫事人員功能 (Medical Staff Functions)
5. 專家功能 (Expert Functions)
6. 管理員功能 (Admin Functions)
7. 數據與效能 (Data & Performance)
A. 安裝與部署 (Installation & Deployment)

**Old Structure (9 chapters):**
1. 簡介 (Introduction with reading guide)
2. 系統簡介 (System Overview)
3. 基本功能 (Basic Functions)
4. Template與Component (Templates & Components)
5. Prompt管理 (Prompt Management)
6. Vocabulary與Test Cases (Vocabulary & Test Cases)
7. 版本控制 (Version Control)
8. 系統管理與監控 (System Management & Monitoring)
9. 附錄：PromptOps與最佳實踐 (Appendix: PromptOps & Best Practices)

**Key Differences:**
- **Old:** Separated reading guide chapter, feature-based organization
- **Current:** Role-based organization (Medical Staff/Expert/Admin), merged related features
- **Old:** More methodological content (PromptOps pipeline, best practices)
- **Current:** More operational focus (installation moved to appendix)

#### 4. Documentation Style

**Current:** Operational manual
- Step-by-step instructions
- Interface screenshots with annotations
- Usage methods + execution flows
- Concise, task-oriented

**Old:** Methodological + operational hybrid
- Conceptual explanations
- Feature descriptions with context
- Tables explaining engineering concepts
- More verbose, educational tone

**Example - Old style (tables explaining concepts):**
```latex
\begin{tabularx}{\textwidth}{l X}
\toprule
\textbf{概念} & \textbf{說明} \\
\midrule
Component & 提示詞的基本組成單元... \\
Template & 組織多個Component的框架... \\
\bottomrule
\end{tabularx}
```

**Example - Current style (direct instructions):**
```latex
\begin{enumerate}
\item 進入Component管理介面可瀏覽所有可用的Component
\item 點擊單一Component項目可在右側檢視完整定義內容
\end{enumerate}
```

#### 5. Chapter 1 Comparison

**Current [ch_1.tex](chapters/ch_1.tex):**
- Title: 系統簡介 (System Introduction)
- Content: Product positioning, core value, comparison table, architecture diagram
- Length: 153 lines
- Numbered chapter

**Old [oldchapters/ch_1.tex](oldchapters/ch_1.tex):**
- Title: 簡介 (Introduction)
- Content: Target audience, reading guide, document structure, role-based reading paths
- Length: ~80 lines
- Unnumbered chapter with insightbox
- Meta-documentation (how to read this manual)

**Implication:** Current version jumps straight into system description; old version provided more onboarding.

#### 6. Figure Usage Patterns

**Current chapters:**
- Heavy screenshot usage (39 figures)
- Consistent naming: `{feature}List_1.png`, `{feature}List_2.png`
- All figures full-width

**Old chapters:**
- Fewer screenshots
- More conceptual diagrams
- Mix of widths

#### 7. Section Depth

**Current:**
- ch_5.tex uses `\subsubsection` extensively (3-level hierarchy)
- Other chapters use 2-level hierarchy

**Old:**
- Maximum 2-level hierarchy
- No `\subsubsection` usage

#### 8. Appendix Handling

**Current:**
- Conditional compilation: `\ifdefined\ENGINEERINGBUILD`
- Separate appendix file: [appendix_a.tex](chapters/appendix_a.tex)
- Installation/deployment instructions

**Old:**
- Chapter 9 served as appendix: "附錄：PromptOps與最佳實踐"
- Integrated into main chapter sequence
- Focused on methodology, not deployment

### Version File Variants

#### 1. [SmartEHR Coder使用者操作手冊.tex](SmartEHR%20Coder使用者操作手冊.tex)

**Purpose:** Simple wrapper/alias

```latex
\input{\detokenize{SmartEHR Coder使用者操作手冊_V2.tex}}
```

**Use case:** Default entry point, redirects to V2

#### 2. [SmartEHR Coder使用者操作手冊_V2.tex](SmartEHR%20Coder使用者操作手冊_V2.tex)

**Purpose:** Main production document

**Structure:**
- Complete preamble with metadata
- Front matter (cover, abstract, TOC)
- 7 chapters via `\input{chapters/ch_X.tex}`
- Conditional appendix

**Configuration:**
```latex
\doctitle{SmartEHR Coder使用者操作手冊}
\docversion{V2}
\doctype{System Operation & Governance Manual}
```

#### 3. [SmartEHR Coder使用者操作手冊_工程版.tex](SmartEHR%20Coder使用者操作手冊_工程版.tex)

**Purpose:** Engineering build with appendix

```latex
\def\ENGINEERINGBUILD{1}
\input{\detokenize{SmartEHR Coder使用者操作手冊_V2.tex}}
```

**Effect:** Sets flag that triggers:
```latex
\ifincludeappendix
  \appendix
  \input{chapters/appendix_a.tex}
\fi
```

**Use case:** Internal documentation with deployment instructions

---

## Chapter Organization

### Content Distribution Analysis

**By Line Count:**
| Chapter | File | Lines | Focus |
|---------|------|-------|-------|
| Ch 5 | [ch_5.tex](chapters/ch_5.tex) | 543 | 專家功能 (Expert Functions) |
| Ch 1 | [ch_1.tex](chapters/ch_1.tex) | 153 | 系統簡介 (System Introduction) |
| Ch 2 | [ch_2.tex](chapters/ch_2.tex) | 85 | 權限與安全 (Permissions & Security) |
| Ch 4 | [ch_4.tex](chapters/ch_4.tex) | 77 | 醫事人員功能 (Medical Staff Functions) |
| Ch 3 | [ch_3.tex](chapters/ch_3.tex) | 60 | 一般系統功能 (General System Functions) |
| App A | [appendix_a.tex](chapters/appendix_a.tex) | 48 | 安裝與部署 (Installation & Deployment) |
| Ch 6 | [ch_6.tex](chapters/ch_6.tex) | 45 | 管理員功能 (Admin Functions) |
| Ch 7 | [ch_7.tex](chapters/ch_7.tex) | 43 | 數據與效能 (Data & Performance) |

**Total:** ~1,054 lines of content

**Observation:** Chapter 5 (Expert Functions) dominates at 51% of total content.

### Section Depth by Chapter

**Chapter 1 (Introduction):**
```
\chapter{系統簡介}
  \section{產品定位}
    \subsection{核心價值}
  \section{與傳統方法的比較}
  \section{系統架構}
```
- **Depth:** 2 levels (section → subsection)
- **Features:** 1 table, 4 figures, 1 TikZ diagram

**Chapter 5 (Expert Functions):**
```
\chapter{專家功能}
  \section{Component管理}
    \subsection{使用說明與系統執行流程}
      \subsubsection{列表與檢視詳細}
      \subsubsection{新增Component}
      \subsubsection{編輯Component}
      \subsubsection{比較版本}
  \section{Template管理}
    \subsection{使用說明與系統執行流程}
      \subsubsection{列表與檢視詳細}
      \subsubsection{新增Template}
      ...
```
- **Depth:** 3 levels (section → subsection → subsubsection)
- **Pattern:** Each feature gets 4 consistent subsubsections
- **Features:** 19 figures (interface screenshots)

**Chapters 2-4, 6-7:**
- **Depth:** 2 levels maximum
- **Style:** Simpler, task-oriented structure

### Document Flow

**Complete Reading Order:**

```
1. Cover Page (full-bleed image)
   ↓
2. 摘要 (Abstract) - page i
   ↓
3. 目錄 (Table of Contents) - auto-generated
   ↓
4. 表目錄 (List of Tables) - auto-generated
   ↓
5. 圖目錄 (List of Figures) - auto-generated
   ↓
6. Chapter 1: 系統簡介 - page 1
   ↓
7. Chapter 2: 權限與安全
   ↓
8. Chapter 3: 一般系統功能
   ↓
9. Chapter 4: 醫事人員功能
   ↓
10. Chapter 5: 專家功能 (longest)
   ↓
11. Chapter 6: 管理員功能
   ↓
12. Chapter 7: 數據與效能
   ↓
13. [IF ENGINEERING BUILD] Appendix A: 安裝與部署
```

**Page Numbering:**
- **Front matter (摘要, TOC, LOT, LOF):** Roman numerals (i, ii, iii, iv...)
- **Main content (Ch 1-7, Appendix):** Arabic numerals (1, 2, 3...)

### Role-Based Content Organization

**Medical Staff User:**
- Chapter 3: General system functions
- Chapter 4: Medical staff specific functions

**Expert User:**
- Chapter 3: General system functions
- **Chapter 5: Expert functions** (component/template/prompt/vocabulary/test case management)

**Administrator:**
- Chapter 2: Permissions & security
- Chapter 6: Admin functions
- Chapter 7: Data & performance monitoring
- Appendix A: Installation & deployment (engineering build)

### Content Density Metrics

**Figures per Chapter:**
- Ch 1: 4 figures (1 TikZ)
- Ch 2: 0 figures
- Ch 3: 3 figures
- Ch 4: 3 figures
- **Ch 5: 19 figures** (mostly screenshots)
- Ch 6: 6 figures
- Ch 7: 2 figures

**Tables per Chapter:**
- Ch 1: 1 table (comparison)
- Ch 7: 1 table (metrics)
- Others: 0 tables

**Average Lines per Figure:**
- Ch 5: 543 lines ÷ 19 figures = **28.5 lines/figure**
- Ch 1: 153 lines ÷ 4 figures = **38.3 lines/figure**

**Observation:** Chapter 5 is figure-dense, with a figure every ~30 lines.

---

## Recommended Template Abstractions

### 1. Front Matter Abstraction (TOC/LOT/LOF)

**Current Implementation:**

The front matter is currently manually specified in each main document:

```latex
% In SmartEHR Coder使用者操作手冊_V2.tex
\chapter*{摘要}
本手冊旨在建立...

\tableofcontents
\clearpage
\listoftables
\clearpage
\listoffigures
\clearpage
\pagenumbering{arabic}
```

**Abstraction Strategy 1: Custom Command**

Add to `smartehr.cls`:

```latex
%===============================================================================
% FRONT MATTER GENERATION
%===============================================================================

% Abstract text storage
\newcommand{\@docabstract}{}
\newcommand{\docabstract}[1]{\renewcommand{\@docabstract}{#1}}

% Generate standard front matter
% Usage: \makefrontmatter (called after \begin{document})
\newcommand{\makefrontmatter}{%
  % Abstract
  \chapter*{摘要}
  \addcontentsline{toc}{chapter}{摘要}
  \@docabstract

  % Table of contents
  \clearpage
  \tableofcontents

  % List of tables (only if tables exist)
  \clearpage
  \iftotalfigures
    \listoftables
  \fi

  % List of figures (only if figures exist)
  \clearpage
  \iftotalfigures
    \listoffigures
  \fi

  % Start main content
  \clearpage
  \pagenumbering{arabic}
}
```

**Usage in Main Document:**

```latex
\begin{document}

% Cover page
\makecover  % (can also be abstracted, see below)

% Front matter
\frontmatter
\pagenumbering{roman}

\docabstract{%
本手冊旨在建立 SmartEHR Coder 平台於臨床 AI 文件處理情境中的標準化操作框架...
}
\makefrontmatter

% Main matter
\mainmatter
\input{chapters/ch_1.tex}
...
```

**Abstraction Strategy 2: Conditional Lists**

For more control, create selective list generation:

```latex
% Conditional list generation commands
\newif\ifincludetoc   \includetoctrue    % Default: include TOC
\newif\ifincludelot   \includelottrue    % Default: include LOT
\newif\ifincludelof   \includeloftrue    % Default: include LOF

\newcommand{\makefrontmatter}[1][]{%
  % Parse optional flags: e.g., \makefrontmatter[toc,lof]

  % Abstract
  \chapter*{摘要}
  \addcontentsline{toc}{chapter}{摘要}
  \@docabstract

  % Table of contents
  \ifincludetoc
    \clearpage
    \tableofcontents
  \fi

  % List of tables
  \ifincludelot
    \clearpage
    \listoftables
  \fi

  % List of figures
  \ifincludelof
    \clearpage
    \listoffigures
  \fi

  % Start main content
  \clearpage
  \pagenumbering{arabic}
}
```

**Usage with Flags:**

```latex
% Include only TOC and LOF
\includelotfalse
\makefrontmatter

% Or for minimal document
\includelotfalse
\includeloffalse
\makefrontmatter
```

**Abstraction Strategy 3: Cover Page Abstraction**

The cover page can also be abstracted:

```latex
% In smartehr.cls
\newcommand{\makecover}[1][img/cover.png]{%
  \begingroup
  \thispagestyle{empty}
  \newgeometry{margin=0cm}
  \begin{tikzpicture}[remember picture,overlay]
  \node[inner sep=0pt] at (current page.center) {%
    \includegraphics[width=\paperwidth,height=\paperheight]{#1}
  };
  \end{tikzpicture}
  \clearpage
  \endgroup
  \restoregeometry
}
```

**Full Abstracted Front Matter Example:**

```latex
% In main document
\begin{document}

% Cover (abstracted)
\makecover  % Uses default img/cover.png
% OR
\makecover[img/custom_cover.png]  % Custom cover image

% Front matter (abstracted)
\frontmatter
\pagenumbering{roman}

\docabstract{%
本手冊旨在建立 SmartEHR Coder 平台於臨床 AI 文件處理情境中...
}
\makefrontmatter

% Main content
\mainmatter
\input{chapters/ch_1.tex}
...

\end{document}
```

**Benefits:**

1. **Consistency:** All documents use same front matter structure
2. **Maintainability:** Change front matter layout once in class file
3. **Flexibility:** Easy to toggle lists on/off per document
4. **Simplicity:** Main document reduced from ~30 lines to ~10 lines for front matter
5. **Error reduction:** No forgotten `\clearpage` or `\pagenumbering` commands

**Advanced: Customizable TOC Depth**

```latex
% In smartehr.cls
\newcommand{\settoclevels}[3]{%
  % #1 = TOC depth, #2 = LOT depth, #3 = LOF depth
  \setcounter{tocdepth}{#1}
  \setcounter{lotdepth}{#2}
  \setcounter{lofdepth}{#3}
}

% Default depths
\settoclevels{3}{2}{2}  % Show up to subsubsection in TOC
```

**Usage:**

```latex
% Show only chapters and sections in TOC
\settoclevels{1}{2}{2}
\makefrontmatter
```

**TOC/LOT/LOF Styling Customization**

Already configured in `smartehr.cls`:

```latex
% Chinese names (lines 174-176)
\renewcommand{\contentsname}{目錄}
\renewcommand{\listfigurename}{圖目錄}
\renewcommand{\listtablename}{表目錄}
```

**Additional Styling Options:**

```latex
% Add to smartehr.cls for enhanced TOC styling
\RequirePackage{tocloft}  % Advanced TOC control

% Customize TOC appearance
\renewcommand{\cftchapfont}{\bfseries\color{svNavy}}
\renewcommand{\cftsecfont}{\color{svSlate}}
\renewcommand{\cftsubsecfont}{\color{svMuted}}

% Add dots for chapters
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}

% Adjust spacing
\setlength{\cftbeforechapskip}{8pt}
\setlength{\cftbeforesecskip}{4pt}
```

---

### 2. Custom Commands Library

**Add to `smartehr.cls` or create `smartehr-helpers.sty`:**

```latex
%===============================================================================
% SMARTEHR HELPER COMMANDS
%===============================================================================

%--------------------------------------------------
% Figure Helpers
%--------------------------------------------------

% Full-width figure
% Usage: \fullwidthfig{filename}{caption}{label}
\newcommand{\fullwidthfig}[3]{%
  \begin{figure}[htbp]
  \centering
  \includegraphics[width=\textwidth]{figures/#1}
  \caption{#2}
  \label{fig:#3}
  \end{figure}
}

% Variable-width figure
% Usage: \widthfig{0.8}{filename}{caption}{label}
\newcommand{\widthfig}[4]{%
  \begin{figure}[htbp]
  \centering
  \includegraphics[width=#1\textwidth]{figures/#2}
  \caption{#3}
  \label{fig:#4}
  \end{figure}
}

% Two-figure interface pattern (list + detail views)
% Usage: \interfacefigures{component}{Component管理}{component}
\newcommand{\interfacefigures}[3]{%
  \begin{figure}[htbp]
  \centering
  \includegraphics[width=\textwidth]{figures/#1List_1.png}
  \caption{#2介面 - 列表檢視}
  \label{fig:#3_list_1}
  \end{figure}

  \begin{figure}[htbp]
  \centering
  \includegraphics[width=\textwidth]{figures/#1List_2.png}
  \caption{#2介面 - 詳細檢視}
  \label{fig:#3_list_2}
  \end{figure}
}

%--------------------------------------------------
% Table Helpers
%--------------------------------------------------

% Two-column description table environment
% Usage:
%   \begin{desctable}{Caption}{label}
%   Field1 & Description1 \\
%   Field2 & Description2 \\
%   \end{desctable}
\newenvironment{desctable}[2]{%
  \begin{table}[htbp]
  \centering
  \begin{tabularx}{\textwidth}{l X}
  \toprule
  \textbf{欄位} & \textbf{說明} \\
  \midrule
}{%
  \bottomrule
  \end{tabularx}
  \caption{#1}
  \label{tab:#2}
  \end{table}
}

% Three-column comparison table environment
% Usage:
%   \begin{comparetable}{Caption}{label}
%   Aspect & Traditional & SmartEHR \\
%   ...
%   \end{comparetable}
\newenvironment{comparetable}[2]{%
  \begin{table}[htbp]
  \centering
  \renewcommand{\arraystretch}{1.5}
  \begin{tabular}{|p{3cm}|p{5.5cm}|p{5.5cm}|}
  \hline
  \textbf{層面} & \textbf{傳統方法} & \textbf{SmartEHR Coder} \\
  \hline
}{%
  \hline
  \end{tabular}
  \caption{#1}
  \label{tab:#2}
  \end{table}
}

%--------------------------------------------------
% Semantic Section Environments
%--------------------------------------------------

% Usage instructions section
\newenvironment{usageinstructions}{%
  \subsection{使用方法}
  \begin{enumerate}
}{%
  \end{enumerate}
}

% System execution flow section
\newenvironment{executionflow}{%
  \subsection{系統執行流程}
  \begin{enumerate}
}{%
  \end{enumerate}
}

% Combined usage and flow section (for ch_5 pattern)
\newenvironment{usageandflow}{%
  \subsection{使用說明與系統執行流程}
}{%
}

%--------------------------------------------------
% Utility Commands
%--------------------------------------------------

% Styled button reference
% Usage: 點擊\btn{儲存}按鈕
\newcommand{\btn}[1]{「\textbf{#1}」}

% UI element reference
% Usage: 在\ui{Component名稱}文字框中輸入
\newcommand{\ui}[1]{\textit{#1}}

% Menu path
% Usage: \menupath{檔案 > 開啟 > 最近的檔案}
\newcommand{\menupath}[1]{\textsf{#1}}
```

### 2. Template Files

#### Template: Interface Documentation Section

**File:** `templates/interface_section_template.tex`

```latex
% ============================================================================
% TEMPLATE: Interface Documentation Section
% ============================================================================
% INSTRUCTIONS:
%   1. Copy this file to your chapter file
%   2. Replace all [PLACEHOLDERS] with actual content
%   3. Delete this instruction block
%
% PLACEHOLDERS:
%   [NAME_EN]       - English name (e.g., "component")
%   [NAME_ZH]       - Chinese name (e.g., "Component")
%   [DESCRIPTION]   - Brief description paragraph
%   [STEP_XXX]      - Numbered step instructions
% ============================================================================

\section{[NAME_ZH]管理}

[DESCRIPTION]

\interfacefigures{[NAME_EN]}{[NAME_ZH]管理}{[NAME_EN]}

\begin{usageandflow}

\subsubsection{列表與檢視詳細}
\begin{enumerate}
\item 進入[NAME_ZH]管理介面可瀏覽所有可用的[NAME_ZH]
\item 點擊單一[NAME_ZH]項目可在右側檢視完整定義內容
\item 可在左側列表使用搜尋功能快速篩選[NAME_ZH]
\end{enumerate}

\subsubsection{新增[NAME_ZH]}
\begin{enumerate}
\item [STEP_ADD_1]
\item [STEP_ADD_2]
\item [STEP_ADD_3]
\item [STEP_ADD_4]
\end{enumerate}

\subsubsection{編輯[NAME_ZH]}
\begin{enumerate}
\item [STEP_EDIT_1]
\item [STEP_EDIT_2]
\item [STEP_EDIT_3]
\item [STEP_EDIT_4]
\end{enumerate}

\subsubsection{比較版本}
\begin{enumerate}
\item [STEP_COMPARE_1]
\item [STEP_COMPARE_2]
\item [STEP_COMPARE_3]
\end{enumerate}

\end{usageandflow}
```

#### Template: Simple Feature Section

**File:** `templates/feature_section_template.tex`

```latex
% ============================================================================
% TEMPLATE: Simple Feature Section (Medical Staff Functions Pattern)
% ============================================================================
% PLACEHOLDERS:
%   [FEATURE_NAME]  - Feature name in Chinese
%   [FIGURE_FILE]   - Screenshot filename
%   [LABEL]         - Label for cross-reference
%   [DESCRIPTION]   - Feature description paragraph
% ============================================================================

\section{[FEATURE_NAME]}

[DESCRIPTION]

\fullwidthfig{[FIGURE_FILE]}{[FEATURE_NAME]介面截圖}{[LABEL]}

\begin{usageinstructions}
\item [USAGE_STEP_1]
\item [USAGE_STEP_2]
\item [USAGE_STEP_3]
\item [USAGE_STEP_4]
\end{usageinstructions}

\begin{executionflow}
\item [FLOW_STEP_1]
\item [FLOW_STEP_2]
\item [FLOW_STEP_3]
\end{executionflow}
```

### 3. Chapter Template

**File:** `templates/chapter_template.tex`

```latex
% ============================================================================
% CHAPTER TEMPLATE
% ============================================================================
% INSTRUCTIONS:
%   1. Copy this file to chapters/ directory
%   2. Rename to ch_X.tex
%   3. Fill in chapter title and content sections
%   4. Add to main document with \input{chapters/ch_X.tex}
% ============================================================================

\chapter{[章節標題]}

% Optional: Chapter introduction paragraph
[簡短描述本章內容與目標讀者]

%------------------------------------------------------------------------------
% Section 1
%------------------------------------------------------------------------------
\section{[第一節標題]}

[內容段落]

% Example: Adding a figure
\fullwidthfig{example.png}{圖片說明}{example}

% Example: Adding a table
\begin{desctable}{表格說明}{example_table}
欄位1 & 說明1 \\
欄位2 & 說明2 \\
\end{desctable}

%------------------------------------------------------------------------------
% Section 2
%------------------------------------------------------------------------------
\section{[第二節標題]}

\subsection{[子節標題]}

[內容段落]

% Example: Usage instructions
\begin{usageinstructions}
\item 步驟一說明
\item 步驟二說明
\item 步驟三說明
\end{usageinstructions}

%------------------------------------------------------------------------------
% Add more sections as needed
%------------------------------------------------------------------------------
```

### 4. Main Document Template

**File:** `templates/main_document_template.tex`

```latex
%===============================================================================
% SMARTEHR TECHNICAL MANUAL TEMPLATE
%===============================================================================
% INSTRUCTIONS:
%   1. Update document metadata below
%   2. Uncomment/comment chapter inputs as needed
%   3. Compile with XeLaTeX
%===============================================================================

\documentclass[12pt,a4paper]{smartehr}

%-------------------------------------------------------------------------------
% Document Metadata
%-------------------------------------------------------------------------------
\doctitle{[文件標題]}
\doctitlepage{[封面標題]}
\docsubtitle{[副標題]}
\docversion{[版本號]}
\doctype{[文件類型]}

%-------------------------------------------------------------------------------
% Conditional Compilation Flags
%-------------------------------------------------------------------------------
\newif\ifincludeappendix

% Uncomment for engineering build:
% \ifdefined\ENGINEERINGBUILD
%   \includeappendixtrue
% \else
%   \includeappendixfalse
% \fi

% Or manually set:
\includeappendixfalse  % Change to \includeappendixtrue to include appendix

%-------------------------------------------------------------------------------
% Document Body
%-------------------------------------------------------------------------------
\begin{document}

% Cover page (full-bleed image)
\begingroup
\thispagestyle{empty}
\newgeometry{margin=0cm}
\begin{tikzpicture}[remember picture,overlay]
\node[inner sep=0pt] at (current page.center) {%
  \includegraphics[width=\paperwidth,height=\paperheight]{img/cover.png}
};
\end{tikzpicture}
\clearpage
\endgroup
\restoregeometry

% Front matter
\frontmatter
\pagenumbering{roman}

% Abstract
\chapter*{摘要}
\addcontentsline{toc}{chapter}{摘要}
[摘要內容]

% Table of contents
\tableofcontents
\listoftables
\listoffigures

% Main matter
\mainmatter
\pagenumbering{arabic}

% Chapters
\input{chapters/ch_1.tex}
\input{chapters/ch_2.tex}
\input{chapters/ch_3.tex}
\input{chapters/ch_4.tex}
\input{chapters/ch_5.tex}
\input{chapters/ch_6.tex}
\input{chapters/ch_7.tex}

% Appendix (conditional)
\ifincludeappendix
  \appendix
  \input{chapters/appendix_a.tex}
\fi

\end{document}
```

---

## Best Practices & Guidelines

### 1. File Organization

**Recommended Structure:**
```
project_root/
├── smartehr.cls                    # Custom document class
├── smartehr-helpers.sty            # NEW: Helper commands package
├── main.tex                        # Main document
├── engineering.tex                 # Engineering build wrapper
├── chapters/                       # Chapter content files
│   ├── ch_1.tex
│   ├── ch_2.tex
│   └── appendix_a.tex
├── figures/                        # Screenshot images
│   ├── simple.png
│   ├── componentList_1.png
│   └── componentList_2.png
├── img/                           # Logos and cover art
│   ├── cover.png
│   └── gimmatek_confidential.png
├── templates/                      # NEW: Template files
│   ├── chapter_template.tex
│   ├── interface_section_template.tex
│   ├── feature_section_template.tex
│   └── main_document_template.tex
└── build/                         # NEW: Build output directory
    ├── main.pdf
    └── engineering.pdf
```

### 2. Compilation Workflow

**Required Compiler:** XeLaTeX (for CJK font support)

**Build Commands:**
```bash
# Standard build
xelatex main.tex
xelatex main.tex  # Second pass for TOC/references

# Engineering build
xelatex engineering.tex
xelatex engineering.tex

# Automated build with latexmk
latexmk -xelatex -output-directory=build main.tex
```

**Latexmk Configuration (`.latexmkrc`):**
```perl
$pdf_mode = 5;  # XeLaTeX
$xelatex = 'xelatex -synctex=1 -interaction=nonstopmode';
$out_dir = 'build';
$clean_ext = 'synctex.gz synctex.gz(busy) run.xml tex.bak bbl bcf fdb_latexmk run tdo %R-blx.bib';
```

### 3. Naming Conventions

#### File Names
- **Chapters:** `ch_X.tex` (lowercase, underscore separator, numbered)
- **Appendices:** `appendix_X.tex` (lowercase, descriptive)
- **Figures:** `descriptiveName.png` (camelCase) or `featureList_1.png` (underscore + number)

#### Labels
- **Figures:** `fig:descriptive_name` (lowercase, underscores)
- **Tables:** `tab:descriptive_name` (lowercase, underscores)
- **Sections:** `sec:descriptive_name` (if needed)
- **Equations:** `eq:descriptive_name` (if needed)

#### Consistency Rules
1. Always use lowercase for label names
2. Use underscores for multi-word labels
3. Use descriptive names, not `fig:1`, `fig:2`
4. Keep label names concise but meaningful

### 4. Figure Management

#### Screenshot Guidelines
- **Format:** PNG (web-optimized, 72-150 DPI)
- **Width:** Match document width or slightly larger (will be scaled)
- **Naming:** Descriptive, avoid spaces, use camelCase or underscores
- **Storage:** All figures in `figures/` directory

#### List + Detail Pattern
- **Naming:** `{feature}List_1.png` (list view), `{feature}List_2.png` (detail view)
- **Consistency:** Always show same feature in both views
- **Captions:** "XXX介面 - 列表檢視" and "XXX介面 - 詳細檢視"

#### Reference in Text
```latex
如圖~\ref{fig:system-architecture}所示，系統架構包含...
```
Note the `~` (non-breaking space) to prevent line breaks.

### 5. Table Guidelines

#### Style Selection
- **Comparison tables:** Use bordered style (`\hline`, `|`)
- **Description tables:** Use booktabs style (`\toprule`, `\midrule`, `\bottomrule`)
- **Wide content:** Use `tabularx` with `X` column for auto-width

#### Column Width Specification
```latex
% Fixed width for predictable layout
\begin{tabular}{|p{3cm}|p{5.5cm}|p{5.5cm}|}

% Auto-width for flexible content
\begin{tabularx}{\textwidth}{l X}
```

#### Array Stretch
- **Default:** 1.25 (defined in class)
- **Increase for readability:** `\renewcommand{\arraystretch}{1.5}` before table
- **Scope:** Local to group, resets after `\end{table}`

### 6. Writing Style Guidelines

#### Chinese Typography
- **Punctuation:** Use full-width Chinese punctuation (，。、；：)
- **Numbers:** Use half-width Arabic numerals (1, 2, 3)
- **English terms:** Keep in English when technical (Component, Template, Prompt)
- **Spacing:** LaTeX handles Chinese/English spacing automatically

#### Enumerated Lists
- **Action steps:** Use `\enumerate` with imperative verbs
  - ✓ 點擊「儲存」按鈕
  - ✗ 使用者點擊「儲存」按鈕
- **Feature lists:** Use `\itemize` with noun phrases
  - ✓ 提供完整的版本控制功能
  - ✗ 系統提供完整的版本控制功能

#### Consistent Terminology
- **UI elements:** Always use 「」for button/menu names
- **Code elements:** Use `\texttt{}` or listings environment
- **Emphasis:** Use **bold** sparingly, prefer structure

### 7. Version Control Best Practices

#### What to Track
```
✓ .tex files (all)
✓ .cls files (document class)
✓ .sty files (packages)
✓ figures/ (images)
✓ templates/ (template files)
✓ .latexmkrc (build config)
✓ README.md (documentation)
```

#### What to Ignore (`.gitignore`)
```
# LaTeX build artifacts
*.aux
*.log
*.out
*.toc
*.lof
*.lot
*.synctex.gz
*.fdb_latexmk
*.fls
*.bbl
*.bcf
*.blg
*.run.xml

# Build directory
build/

# Editor files
*.swp
*.bak
*~
.DS_Store
```

### 8. Modularization Strategy

#### Current Structure (Good)
```latex
% Main document
\input{chapters/ch_1.tex}
\input{chapters/ch_2.tex}
```

#### Advanced Modularization (If Needed)
```latex
% Split large chapters into sections
chapters/
├── ch_5/
│   ├── main.tex              % Chapter wrapper
│   ├── component_mgmt.tex    % Section 1
│   ├── template_mgmt.tex     % Section 2
│   └── prompt_mgmt.tex       % Section 3

% In ch_5/main.tex:
\chapter{專家功能}
\input{chapters/ch_5/component_mgmt.tex}
\input{chapters/ch_5/template_mgmt.tex}
\input{chapters/ch_5/prompt_mgmt.tex}
```

**When to use:**
- Chapters exceed 500 lines
- Multiple authors working on same chapter
- Sections are logically independent

### 9. Accessibility Considerations

#### Alt Text for Figures
```latex
% Current (no alt text)
\caption{Component管理介面 - 列表檢視}

% Better (descriptive caption)
\caption{Component管理介面列表檢視，顯示所有可用Component的名稱、描述、版本與最後修改時間}
```

#### Semantic Structure
- Use proper heading hierarchy (don't skip levels)
- Use semantic environments (enumerate for steps, itemize for features)
- Provide descriptive labels for cross-references

#### Color Contrast
- Current Stanford color scheme meets WCAG AA standards
- Text colors: svSlate (#1F2937) on white background = 14.7:1 contrast ratio

### 10. Performance Optimization

#### Compilation Speed
- **Use draft mode** for quick previews: `\documentclass[draft]{smartehr}`
- **Compile specific chapters** by commenting out others
- **Use latexmk** for intelligent recompilation

#### Figure Optimization
- **Compress PNGs** before inclusion (use pngquant, optipng)
- **Appropriate resolution:** 72-150 DPI for screen display
- **Avoid huge images:** Resize before inclusion, don't rely on `\includegraphics` scaling

#### Build Artifacts
- **Separate build directory** keeps source clean
- **Clean regularly:** `latexmk -C` removes all artifacts

---

## Implementation Examples

### Created Files

Based on this analysis, the following abstraction files have been created:

1. **[gimmatek-report-frontmatter.sty](gimmatek-report-frontmatter.sty)** - Package for abstracting TOC/LOT/LOF generation
2. **[example_with_abstracted_frontmatter.tex](example_with_abstracted_frontmatter.tex)** - Example usage
3. **[ABSTRACTION_GUIDE.md](ABSTRACTION_GUIDE.md)** - Complete guide to using the abstraction packages

### Front Matter Abstraction Usage

**Quick Start:**

```latex
\documentclass{smartehr}
\RequirePackage{gimmatek-report-frontmatter}

\docabstract{Your abstract text here...}

\begin{document}
\makecover
\frontmatter
\pagenumbering{roman}
\makefrontmatter

\mainmatter
\input{chapters/ch_1.tex}
...
\end{document}
```

**Code Reduction:**
- **Before:** ~30 lines of front matter boilerplate
- **After:** ~7 lines with abstraction
- **Savings:** 77% reduction in front matter code

### Available Commands Summary

**From gimmatek-report-frontmatter.sty:**

| Command | Purpose |
|---------|---------|
| `\makecover` | Generate full-bleed cover page |
| `\makecover[file.png]` | Generate cover with custom image |
| `\coverimage{file.png}` | Set default cover image path |
| `\docabstract{text}` | Set abstract text |
| `\makefrontmatter` | Generate TOC + LOT + LOF |
| `\makeminimalfrontmatter` | Generate TOC only |
| `\makestandardfrontmatter` | Generate TOC + LOF |
| `\makefullfrontmatter` | Generate TOC + LOT + LOF (alias) |
| `\makefrontmatterwith{title}` | Generate with custom abstract title |
| `\includetocfalse` | Skip table of contents |
| `\includelotfalse` | Skip list of tables |
| `\includeloffalse` | Skip list of figures |
| `\includeabstractfalse` | Skip abstract |
| `\tocchaptersonly` | Show only chapters in TOC |
| `\tocsections` | Show up to sections in TOC |
| `\tocsubsections` | Show up to subsections (default) |
| `\tocsubsubsections` | Show up to subsubsections |
| `\settoclevels{n}{}{}`| Set TOC depth (n=0-3) |

---

## Summary & Key Recommendations

### Strengths of Current Project

1. **Professional custom class** with comprehensive styling
2. **Modular structure** with separate chapter files
3. **Consistent formatting** through centralized class definition
4. **Good CJK support** with proper font configuration
5. **Conditional compilation** for different build variants
6. **Clear visual hierarchy** with Stanford-inspired design

### Immediate Improvements (Quick Wins)

1. **Create `smartehr-helpers.sty`** with abstraction commands:
   - `\fullwidthfig{}{}{}`
   - `\interfacefigures{}{}{}`
   - `\begin{usageinstructions}...\end{usageinstructions}`

2. **Standardize label naming:**
   - Always lowercase
   - Always underscores (not hyphens)
   - Update [ch_1.tex](chapters/ch_1.tex) labels to match convention

3. **Add template files** to `templates/` directory for new content

4. **Create `.latexmkrc`** for automated builds

5. **Document the `insightbox` environment** or remove from class if deprecated

### Medium-Term Improvements

1. **Refactor [ch_5.tex](chapters/ch_5.tex)** using new helper commands:
   - Reduce from 543 lines to ~300 lines
   - Improve maintainability

2. **Create style guide document** for contributors

3. **Add build automation** (Makefile or shell script)

4. **Implement figure optimization pipeline**

5. **Version control `.tex` files** with meaningful commit messages

### Long-Term Considerations

1. **Internationalization:** Prepare for English version
   - Separate content from formatting
   - Use babel or polyglossia for multi-language support

2. **Advanced features:**
   - Index generation (`\makeindex`)
   - Bibliography management (biblatex)
   - Glossary for technical terms

3. **Documentation website:**
   - Convert LaTeX to HTML (LaTeXML, tex4ht)
   - Provide web-based documentation alongside PDF

4. **Continuous integration:**
   - Auto-compile on git push
   - Version numbering from git tags
   - Automated PDF deployment

---

## Conclusion

This SmartEHR Coder LaTeX project demonstrates professional technical documentation practices with a custom document class, modular structure, and consistent styling. The analysis reveals significant opportunities for abstraction, particularly around repeated figure and table patterns, which can reduce code duplication by an estimated **380+ lines**.

Key actionable items:
1. Implement helper command library
2. Create reusable templates
3. Standardize naming conventions
4. Optimize Chapter 5's repetitive structure
5. Document build process

By following the recommendations in this analysis, the project can achieve:
- **Better maintainability** through abstraction
- **Faster authoring** with templates
- **Consistent quality** through standardization
- **Easier onboarding** for new contributors

The current foundation is solid—these improvements will make it excellent.

---

**Document Generated:** 2026-03-28
**Analysis Coverage:** 21 LaTeX files, 1 custom class, 39 figures, 2 tables
**Total Project Size:** ~1,054 lines of content + custom class infrastructure
