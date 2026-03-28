# LaTeX Abstraction Guide for SmartEHR Project

This guide explains how to use the abstraction packages and templates created for the SmartEHR Coder documentation project.

---

## Table of Contents

1. [Front Matter Abstraction](#front-matter-abstraction)
2. [Quick Reference](#quick-reference)
3. [Migration Guide](#migration-guide)
4. [Examples](#examples)

---

## Front Matter Abstraction

### Package: `gimmatek-report-frontmatter.sty`

This package abstracts away the repetitive boilerplate for document front matter, including:
- Cover page generation
- Abstract
- Table of Contents (TOC)
- List of Tables (LOT)
- List of Figures (LOF)

### Installation

The package is already in your project root. To use it, simply add to your document:

```latex
\RequirePackage{gimmatek-report-frontmatter}
```

---

## Quick Reference

### Basic Commands

#### Cover Page

```latex
% Use default cover image (img/cover.png)
\makecover

% Use custom cover image
\makecover[img/custom_cover.png]

% Or set default cover image in preamble, then use \makecover
\coverimage{img/my_default_cover.png}
```

#### Abstract

```latex
% Set abstract text (in preamble)
\docabstract{%
Your abstract text here.
Can span multiple paragraphs.
}
```

#### Generate Front Matter

```latex
% Full front matter (Abstract + TOC + LOT + LOF)
\makefrontmatter

% Minimal (TOC only)
\makeminimalfrontmatter

% Standard (TOC + LOF, skip LOT)
\makestandardfrontmatter

% Full (alias for \makefrontmatter)
\makefullfrontmatter

% Custom abstract title (e.g., for English version)
\makefrontmatterwith{Abstract}
```

#### Control Flags

```latex
% Skip specific lists (set before \makefrontmatter)
\includetocfalse    % Skip table of contents
\includelotfalse    % Skip list of tables
\includeloffalse    % Skip list of figures
\includeabstractfalse  % Skip abstract
```

#### TOC Depth Control

```latex
% Show only chapters in TOC
\tocchaptersonly

% Show up to sections
\tocsections

% Show up to subsections (default)
\tocsubsections

% Show up to subsubsections (needed for ch_5)
\tocsubsubsections

% Or set depth manually (0=chapter, 1=section, 2=subsection, 3=subsubsection)
\settoclevels{3}{}{} % Third parameter unused, kept for compatibility
```

---

## Migration Guide

### Before (Old Way)

**Main document had ~30 lines of boilerplate:**

```latex
\begin{document}

% Cover page (12 lines)
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

% Front matter (15+ lines)
\frontmatter
\pagenumbering{roman}

\chapter*{摘要}
本手冊旨在建立 SmartEHR Coder 平台於...
[Long abstract text...]

\tableofcontents
\clearpage
\listoftables
\clearpage
\listoffigures
\clearpage
\pagenumbering{arabic}

% Main content
\input{chapters/ch_1.tex}
...
```

### After (New Way)

**Only 7-10 lines:**

```latex
\RequirePackage{gimmatek-report-frontmatter}  % In preamble

\docabstract{%                          % In preamble
本手冊旨在建立 SmartEHR Coder 平台於...
[Long abstract text...]
}

\begin{document}

\makecover                              % 1 line
\frontmatter                            % 1 line
\pagenumbering{roman}                   % 1 line
\makefrontmatter                        % 1 line

\mainmatter                             % 1 line
\input{chapters/ch_1.tex}               % Content
...
```

**Result: 77% reduction in front matter code**

---

## Examples

### Example 1: Full Document with All Lists

```latex
\documentclass[12pt,a4paper]{smartehr}
\RequirePackage{gimmatek-report-frontmatter}

\doctitle{SmartEHR Coder使用者操作手冊}
\docversion{V2}

\docabstract{%
本手冊旨在建立 SmartEHR Coder 平台於臨床 AI 文件處理情境中的標準化操作框架...
}

\begin{document}

\makecover
\frontmatter
\pagenumbering{roman}
\makefrontmatter  % Generates Abstract + TOC + LOT + LOF

\mainmatter
\input{chapters/ch_1.tex}
\input{chapters/ch_2.tex}
...

\end{document}
```

### Example 2: Skip List of Tables

```latex
\documentclass{smartehr}
\RequirePackage{gimmatek-report-frontmatter}

\docabstract{Your abstract...}

\begin{document}

\makecover
\frontmatter
\pagenumbering{roman}

\includelotfalse  % Skip List of Tables
\makefrontmatter  % Generates Abstract + TOC + LOF only

\mainmatter
\input{chapters/ch_1.tex}
...

\end{document}
```

### Example 3: Minimal Document (TOC Only)

```latex
\documentclass{smartehr}
\RequirePackage{gimmatek-report-frontmatter}

\docabstract{Your abstract...}

\begin{document}

\makecover
\frontmatter
\pagenumbering{roman}
\makeminimalfrontmatter  % Only Abstract + TOC

\mainmatter
\input{chapters/ch_1.tex}
...

\end{document}
```

### Example 4: Custom Cover Image

```latex
\documentclass{smartehr}
\RequirePackage{gimmatek-report-frontmatter}

\docabstract{Your abstract...}

\begin{document}

\makecover[img/engineering_cover.png]  % Custom cover
\frontmatter
\pagenumbering{roman}
\makefrontmatter

\mainmatter
\input{chapters/ch_1.tex}
...

\end{document}
```

### Example 5: Control TOC Depth

```latex
\documentclass{smartehr}
\RequirePackage{gimmatek-report-frontmatter}

\docabstract{Your abstract...}

\begin{document}

\makecover
\frontmatter
\pagenumbering{roman}

% Show up to subsubsections in TOC (needed for detailed ch_5)
\tocsubsubsections
\makefrontmatter

\mainmatter
\input{chapters/ch_1.tex}
...

\end{document}
```

### Example 6: No Abstract, Only Lists

```latex
\documentclass{smartehr}
\RequirePackage{gimmatek-report-frontmatter}

% No \docabstract command = no abstract

\begin{document}

\makecover
\frontmatter
\pagenumbering{roman}
\makefrontmatter  % Only TOC + LOT + LOF (no abstract)

\mainmatter
\input{chapters/ch_1.tex}
...

\end{document}
```

### Example 7: Engineering Build Pattern

```latex
% engineering.tex
\def\ENGINEERINGBUILD{1}
\input{\detokenize{main.tex}}

% main.tex
\documentclass{smartehr}
\RequirePackage{gimmatek-report-frontmatter}

\docabstract{Your abstract...}

\newif\ifincludeappendix
\ifdefined\ENGINEERINGBUILD
  \includeappendixtrue
\else
  \includeappendixfalse
\fi

\begin{document}

\makecover
\frontmatter
\pagenumbering{roman}
\makefrontmatter

\mainmatter
\input{chapters/ch_1.tex}
...

\ifincludeappendix
  \appendix
  \input{chapters/appendix_a.tex}
\fi

\end{document}
```

---

## Common Patterns

### Pattern 1: Standard Manual

```latex
\makecover
\frontmatter
\pagenumbering{roman}
\makefrontmatter
```

### Pattern 2: Image-Heavy Manual (No Tables)

```latex
\makecover
\frontmatter
\pagenumbering{roman}
\makestandardfrontmatter  % Skips LOT automatically
```

### Pattern 3: Quick Draft (TOC Only)

```latex
\makecover
\frontmatter
\pagenumbering{roman}
\makeminimalfrontmatter
```

---

## Advanced Customization

### Custom Abstract Title (e.g., English Version)

```latex
% Instead of \makefrontmatter, use:
\makefrontmatterwith{Abstract}
```

### Selective List Control

```latex
% Include only TOC and LOF (skip LOT)
\includelotfalse
\makefrontmatter

% Include only TOC (skip both LOT and LOF)
\includelotfalse
\includeloffalse
\makefrontmatter
```

### No Cover Page

```latex
% Skip \makecover command entirely
\frontmatter
\pagenumbering{roman}
\makefrontmatter
```

---

## Troubleshooting

### Issue: TOC shows too many levels

**Solution:** Set TOC depth before generating

```latex
\tocsections  % Show only sections, not subsections
\makefrontmatter
```

### Issue: Empty list pages appear

**Cause:** Document has no tables/figures, but LOT/LOF still generated

**Solution:** Skip empty lists

```latex
\includelotfalse  % If no tables
\includeloffalse  % If no figures
\makefrontmatter
```

### Issue: Abstract not appearing

**Cause:** `\docabstract{}` not set

**Solution:** Add in preamble

```latex
\docabstract{Your abstract text here}
```

### Issue: Cover image not found

**Cause:** Default path `img/cover.png` doesn't exist

**Solution:** Provide correct path

```latex
\makecover[correct/path/to/cover.png]
```

---

## Comparison Table

| Feature | Before (Manual) | After (Abstracted) |
|---------|-----------------|-------------------|
| **Lines of code** | ~30 lines | ~7 lines |
| **Code reduction** | — | 77% |
| **Maintainability** | Each document different | Consistent across all |
| **Error prone** | High (manual `\clearpage`) | Low (automated) |
| **Flexibility** | High (full control) | High (with flags) |
| **Readability** | Low (boilerplate) | High (semantic) |
| **Learning curve** | Must know LaTeX internals | Simple command interface |

---

## Best Practices

1. **Always use `\makefrontmatter` family** instead of manual TOC/LOT/LOF
2. **Set abstract in preamble** with `\docabstract{}` for clarity
3. **Use flags to control lists** rather than commenting out code
4. **Use semantic presets** (`\makeminimalfrontmatter`, `\makestandardfrontmatter`) when appropriate
5. **Keep TOC depth reasonable** (subsections for most documents, subsubsections only if needed)

---

## Next Steps

After adopting front matter abstraction, consider:

1. Implement figure/table helper commands (see LATEX_ANALYSIS.md)
2. Create section templates for interface documentation
3. Standardize label naming conventions
4. Set up automated build system (latexmk)

---

## Reference

- **Full Analysis:** [LATEX_ANALYSIS.md](LATEX_ANALYSIS.md)
- **Package File:** [gimmatek-report-frontmatter.sty](gimmatek-report-frontmatter.sty)
- **Example Usage:** [example_with_abstracted_frontmatter.tex](example_with_abstracted_frontmatter.tex)

---

**Last Updated:** 2026-03-28
**Version:** 1.0
