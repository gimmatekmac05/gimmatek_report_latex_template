%% gimmatek-report-template.cls
%% LaTeX Document Class for Gimmatek Report Technical Documentation
%% Version 2.0.0
%% Date: 2026-03-28
%%
%% This class provides a professional, engineering-focused style for
%% technical manuals and system documentation, featuring:
%% - Stanford/Silicon Valley inspired color scheme
%% - CJK (Chinese-Japanese-Korean) support with XeLaTeX
%% - Custom chapter/section formatting
%% - Insight boxes for chapter summaries
%% - Code listing styles (GitHub-inspired)
%% - Enhanced table and figure formatting
%% - Comprehensive header/footer management

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gimmatek-report-template}[2026/03/28 v2.0.0 Gimmatek Report Technical Documentation Class]

%% ============================================================================
%% Class Options
%% ============================================================================

% Default font size and paper options
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{report}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{report}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{report}}
\DeclareOption{a4paper}{\PassOptionsToClass{a4paper}{report}}
\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{report}}

% Pass all other options to base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

% Execute default options
\ExecuteOptions{12pt,a4paper}

% Process class options
\ProcessOptions\relax

% Load base class
\LoadClass{report}

%% ============================================================================
%% Define \frontmatter and \mainmatter Commands
%% ============================================================================
% The report class doesn't define these (only book class does)
% We define them here for compatibility with documentation examples

\newcommand{\frontmatter}{%
  \cleardoublepage
  \pagenumbering{roman}
}

\newcommand{\mainmatter}{%
  \cleardoublepage
  \pagenumbering{arabic}
}

%% ============================================================================
%% Required Packages
%% ============================================================================

% Page geometry
\RequirePackage[margin=1in,headheight=45pt]{geometry}

% CJK and font support
\RequirePackage{xeCJK}
\RequirePackage{fontspec}
\RequirePackage{graphicx}

% Table packages
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage[table]{xcolor}

% Math support
\RequirePackage{amsmath}
\RequirePackage{amssymb}

% Text formatting
\RequirePackage{indentfirst}
\RequirePackage{setspace}
\RequirePackage{enumitem}
\RequirePackage{caption}

% Special boxes
\RequirePackage[most]{tcolorbox}

% Headers and footers
\RequirePackage{fancyhdr}

% Section formatting
\RequirePackage{titlesec}

% Code listings
\RequirePackage{listings}

% TikZ for diagrams
\RequirePackage{tikz}
\usetikzlibrary{shapes.geometric, arrows.meta, positioning, calc, fit, backgrounds}

% Patching helpers
\RequirePackage{etoolbox}

% Hyperlinks (should be loaded last)
\RequirePackage[hidelinks]{hyperref}

%% ============================================================================
%% Font Configuration with Cross-Platform Support
%% ============================================================================

\RequirePackage{iftex}

% Cross-platform font configuration using font detection (more reliable than platform detection)
% Try fonts in preference order: macOS → Windows → Linux

% Try macOS fonts first (PingFang TC)
\IfFontExistsTF{PingFang TC}{
  \setCJKmainfont{PingFang TC}
  \setCJKmonofont{PingFang TC}
  \IfFontExistsTF{Menlo}{
    \setmonofont{Menlo}
  }{
    \setmonofont{Courier}
  }
  \PackageInfo{gimmatek-report-template}{Using macOS fonts (PingFang TC)}
}{
  % Try Windows fonts (Microsoft JhengHei)
  \IfFontExistsTF{Microsoft JhengHei}{
    \setCJKmainfont{Microsoft JhengHei}
    \setCJKmonofont{Microsoft JhengHei}
    \IfFontExistsTF{Consolas}{
      \setmonofont{Consolas}
    }{
      \setmonofont{Courier New}
    }
    \PackageInfo{gimmatek-report-template}{Using Windows fonts (Microsoft JhengHei)}
  }{
    % Try Linux fonts (Noto Sans CJK TC)
    \IfFontExistsTF{Noto Sans CJK TC}{
      \setCJKmainfont{Noto Sans CJK TC}
      \setCJKmonofont{Noto Serif CJK TC}
      \IfFontExistsTF{DejaVu Sans Mono}{
        \setmonofont{DejaVu Sans Mono}
      }{
        \setmonofont{Courier}
      }
      \PackageInfo{gimmatek-report-template}{Using Linux fonts (Noto Sans CJK TC)}
    }{
      % No suitable CJK fonts found - warn but don't fail
      \PackageWarning{gimmatek-report-template}{
        No suitable CJK fonts found. Chinese text may not display correctly.\MessageBreak
        Install one of the following:\MessageBreak
        - macOS: PingFang TC (pre-installed)\MessageBreak
        - Windows: Microsoft JhengHei (pre-installed)\MessageBreak
        - Linux: sudo apt install fonts-noto-cjk\MessageBreak
        Falling back to system default CJK font.
      }
      % Let xeCJK use its default fallback (Fandol)
      \setmonofont{Courier}
    }
  }
}

% Adjust header height for fancy headers (two rows: logo + title)
\setlength{\headheight}{45pt}

%% ============================================================================
%% Logo Path Configuration
%% ============================================================================
% Default logo path - points to template subfolder
% Users can override with \logopath{custom/path/to/logo.png}
\newcommand{\@logopath}{gimmatek_report_latex_template/assets/gimmatek_confidential.png}
\newcommand{\logopath}[1]{\renewcommand{\@logopath}{#1}}

% Helper command to conditionally include logo with fallback
\newcommand{\@includelogoifexists}[1]{%
  \IfFileExists{\@logopath}{%
    \includegraphics[height=#1]{\@logopath}%
  }{%
    % Logo file not found, display placeholder
    \textcolor{svMuted}{\scriptsize [Logo]}%
  }%
}

%% ============================================================================
%% Color Definitions (Stanford/Silicon Valley Style)
%% ============================================================================

\definecolor{svCardinal}{HTML}{8C1515}      % Stanford Cardinal (primary accent)
\definecolor{svCardinalDark}{HTML}{5C0B0B}  % Dark cardinal
\definecolor{svNavy}{HTML}{0A2540}          % Deep navy (titles)
\definecolor{svSlate}{HTML}{1F2937}         % Slate gray (body text)
\definecolor{svMuted}{HTML}{6B7280}         % Muted gray (secondary text)
\definecolor{svCloud}{HTML}{F8FAFC}         % Light cloud (backgrounds)
\definecolor{svBorder}{HTML}{CBD5E1}        % Border gray
\definecolor{svBlue}{HTML}{0B63CE}          % Link blue
\definecolor{svGreen}{HTML}{0F766E}         % Green (comments)
\definecolor{svPurple}{HTML}{7C3AED}        % Purple (keywords)
\definecolor{svCalloutBg}{HTML}{EFF6FF}     % Callout background

% GitHub-style colors
\definecolor{ghBlue}{HTML}{0B63CE}
\definecolor{ghGreen}{HTML}{0F766E}

%% ============================================================================
%% Hyperlink Setup
%% ============================================================================

\hypersetup{
  colorlinks=true,
  linkcolor=svNavy,
  urlcolor=svBlue,
  pdftitle={Gimmatek Report Technical Documentation},
  pdfauthor={Gimmatek Report Team}
}

%% ============================================================================
%% Document Structure Settings
%% ============================================================================

% Table of contents depth
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{3}
% Slightly widen LOF/LOT number column without changing overall format.
\makeatletter
\renewcommand*\l@figure{\@dottedtocline{1}{1.5em}{3.8em}}
\renewcommand*\l@table{\@dottedtocline{1}{1.5em}{3.8em}}
\makeatother

% Paragraph formatting
\setlength{\parindent}{2em}
\setlength{\parskip}{0.4em}
\setstretch{1.3}

% List formatting
\setlist[itemize]{topsep=4pt,itemsep=3pt,leftmargin=2.2em}
\setlist[enumerate]{topsep=4pt,itemsep=3pt,leftmargin=2.2em}

% Table row spacing
\renewcommand{\arraystretch}{1.25}

%% ============================================================================
%% Caption Formatting
%% ============================================================================

\captionsetup{
  font=small,
  labelfont={bf,color=svCardinal}
}

% Chinese table and figure names
\renewcommand{\tablename}{表}
\renewcommand{\figurename}{圖}
\renewcommand{\appendixname}{附錄}
\renewcommand{\contentsname}{目錄}
\renewcommand{\listfigurename}{圖目錄}
\renewcommand{\listtablename}{表目錄}
\renewcommand{\thefigure}{\figurename\thechapter.\arabic{figure}}
\renewcommand{\thetable}{\tablename\thechapter.\arabic{table}}
\makeatletter
\renewcommand{\fnum@figure}{\thefigure}
\renewcommand{\fnum@table}{\thetable}
\makeatother

%% ============================================================================
%% Header and Footer Configuration
%% ============================================================================

\makeatletter

\pagestyle{fancy}
\fancyhf{}

% Document title in header (can be customized)
\newcommand{\@doctitle}{Gimmatek Report 使用者操作手冊}
\newcommand{\doctitle}[1]{\renewcommand{\@doctitle}{#1}}

% Keep header within text margins to avoid clipping
\fancyhfoffset[L]{0pt}
\fancyhfoffset[R]{0pt}

% Header with logo on right, title and chapter on left (two rows)
\fancyhead[L]{%
  \parbox[b]{0.75\textwidth}{%
    \vspace*{2pt}%
    \small\@doctitle\\
    \textcolor{svMuted}{\nouppercase{\leftmark}}%
  }%
}
\fancyhead[C]{}
\fancyhead[R]{\hspace*{-0.2cm}\@includelogoifexists{0.5cm}}

% Use \chaptername so appendix uses the localized label automatically.
\renewcommand{\chaptermark}[1]{\markboth{\chaptername \thechapter.~#1}{}}
\fancyfoot[C]{\thepage}

% Remove header rule
\renewcommand{\headrulewidth}{0pt}

% Plain page style (for chapter pages)
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhfoffset[L]{0pt}
  \fancyhfoffset[R]{0pt}
  \fancyhead[L]{%
    \parbox[b]{0.75\textwidth}{%
      \vspace*{2pt}%
      \small\@doctitle\\
      \textcolor{svMuted}{\nouppercase{\leftmark}}%
    }%
  }
  \fancyhead[C]{}
  \fancyhead[R]{\hspace*{-0.2cm}\@includelogoifexists{0.6cm}}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
}

%% ============================================================================
%% Chapter and Section Formatting
%% ============================================================================

% Chapter formatting - large number with colored rule
\titleformat{\chapter}[display]
  {\bfseries\color{svSlate}}
  {\filleft\color{svCardinal}\fontsize{40}{42}\selectfont\thechapter}
  {-8pt}
  {\Huge}
  [{\color{svCardinal}\titlerule[1pt]}]

\titlespacing*{\chapter}{0pt}{0pt}{20pt}

% Section formatting - navy blue, bold
\titleformat{\section}
  {\Large\bfseries\color{svNavy}}
  {\thesection}
  {0.8em}
  {}

% Subsection formatting - slate color, bold
\titleformat{\subsection}
  {\large\bfseries\color{svSlate}}
  {\thesubsection}
  {0.8em}
  {}

%% ============================================================================
%% Custom Environments
%% ============================================================================

% Insight box - for chapter summaries and key insights
\newtcolorbox{insightbox}[1][]{
  colback=svCalloutBg,
  colframe=svNavy,
  colbacktitle=svNavy,
  coltitle=white,
  boxrule=0.8pt,
  arc=2pt,
  left=8pt,
  right=8pt,
  top=6pt,
  bottom=6pt,
  title=#1,
  fonttitle=\bfseries
}

%% ============================================================================
%% Code Listing Styles
%% ============================================================================

% GitHub-inspired shell/code style
\lstdefinestyle{github-shell}{
  basicstyle=\ttfamily\small\color{svSlate},
  backgroundcolor=\color{svCloud},
  frame=single,
  framerule=0.8pt,
  rulecolor=\color{svBorder},
  xleftmargin=0.5em,
  xrightmargin=0.5em,
  aboveskip=0.8em,
  belowskip=0.8em,
  columns=fullflexible,
  keepspaces=true,
  showstringspaces=false,
  numbers=left,
  numberstyle=\tiny\color{svMuted},
  numbersep=8pt,
  commentstyle=\color{svGreen},
  keywordstyle=\color{svPurple}\bfseries,
  stringstyle=\color{svBlue}
}

% Set default listing style
\lstset{style=github-shell}

%% ============================================================================
%% Title Page Command
%% ============================================================================

\newcommand{\@doctitlepage}{Gimmatek Report 使用者操作手冊}
\newcommand{\@docsubtitle}{Stanford x Silicon Valley Engineering Style}
\newcommand{\@docversion}{Version 2}
\newcommand{\@doctype}{System Operation \& Governance Manual}

\newcommand{\doctitlepage}[1]{\renewcommand{\@doctitlepage}{#1}}
\newcommand{\docsubtitle}[1]{\renewcommand{\@docsubtitle}{#1}}
\newcommand{\docversion}[1]{\renewcommand{\@docversion}{#1}}
\newcommand{\doctype}[1]{\renewcommand{\@doctype}{#1}}

\renewcommand{\maketitle}{
  \thispagestyle{empty}
  \begingroup
    \centering
    \vspace*{1.5cm}
    {\color{svCardinal}\rule{0.88\textwidth}{1.2pt}\par}
    \vspace{0.6cm}
    {\Huge\bfseries\color{svNavy} \@doctitlepage\par}
    \vspace{6pt}
    {\Large\color{svMuted} \@docsubtitle\par}
    \vspace{6pt}
    {\Large\bfseries \@docversion\par}
    \vspace{0.6cm}
    {\color{svCardinal}\rule{0.88\textwidth}{0.8pt}\par}
    \vfill
    {\large 文件版本：\@docversion\par}
    {\large 產出日期：\today\par}
    \vspace{8pt}
    {\large 文件類型：\@doctype\par}
  \endgroup
  \clearpage
}

\makeatother

%% ============================================================================
%% End of Class
%% ============================================================================

\endinput
