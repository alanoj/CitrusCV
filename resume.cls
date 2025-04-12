\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2025/04/03 A simple resume class]

% Load the base class:
\LoadClass{article}

% Load packages for layout and styling
\RequirePackage[paperwidth=8.5in, paperheight=11in, top=1.25cm, bottom=1.25cm, left=1.25cm, right=1.25cm, marginparwidth=0in, marginparsep=0in, headheight=0in, headsep=0in, footskip=0in, bindingoffset=0in]{geometry} % Strict 1 inch margins only
\RequirePackage{fontspec}             % Font selection
\RequirePackage{titlesec}             % Control section titles
\RequirePackage{enumitem}             % Customizable lists
\RequirePackage{xcolor}               % Colors
\RequirePackage[colorlinks=true, allcolors=yellow1]{hyperref}
\RequirePackage{parskip}              % No paragraph indent, spacing between paragraphs
\RequirePackage{bookmark}             % No paragraph indent, spacing between paragraphs
\RequirePackage{tabularx}             % Tabularx for better table handling
\RequirePackage{tikz}                % TikZ for drawing
\usetikzlibrary{calc}

\pagestyle{empty} % Remove page numbers

% Custom Colors
% \definecolor{sectionbg}{RGB}{242, 188, 62}
\definecolor{sectionbg}{HTML}{FAE49E}
\definecolor{yellow1}{HTML}{F7D564}
\definecolor{baseText}{HTML}{1F1F1F}
\definecolor{bulletColor}{HTML}{B2B2B2}

% --- Replace the current font toggle block (starting from "Define storage for header elements") with the following:

% Define storage for header elements
\def\fullname#1{\def\@name{#1}}
\def\@name {}
\def\jobtitle#1{\def\@title{#1}}
\def\@title {}
\def\address#1{\def\@address{#1}}
\def\@address {}

% --- Define font mode switches: Uncomment exactly one to select your mode ---
\newif\ifusebuiltin
\newif\ifusevariable
% Uncomment one of the following lines:
\usebuiltintrue       % Use built-in fonts (Palatino)
% \usevariabletrue      % Use custom variable fonts from the EBGaramond directory
% If neither is set true, the default will be to use custom regular fonts from the CormorantGaramond directory.

\ifusebuiltin
    \def\fontpath{}                           % No external path for built-in fonts.
    \def\baseFont{Palatino}
\else\ifusevariable
        \def\fontpath{./EBGaramond/}              % Variable fonts location folder.
        \def\baseFont{EBGaramond-VariableFont_wght} % Base font name for variable fonts.
    \else
        \def\fontpath{./CormorantGaramond/}        % Custom regular fonts location.
        \def\baseFont{CormorantGaramond}           % Base font name for custom regular fonts.
    \fi\fi

% --- Define header font families based on mode ---
\ifusebuiltin
    % Built-in: Use system-installed Palatino.
    \newfontfamily\headernamefont{Palatino}
    \newfontfamily\headeraddressfont{Palatino}
    \newfontfamily\headertitlefont{Palatino}
\else\ifusevariable
        % Variable custom fonts: load from EBGaramond directory; use RawFeature to set weight.
        \newfontfamily\headernamefont[
            Path = \fontpath,
            Extension = .ttf,
            UprightFont = {\baseFont},
            RawFeature = {+wght=400}  % Adjust weight as desired.
        ]{\baseFont}
        \newfontfamily\headeraddressfont[
            Path = \fontpath,
            Extension = .ttf,
            UprightFont = {\baseFont},
            RawFeature = {+wght=400}
        ]{\baseFont}
        \newfontfamily\headertitlefont[
            Path = \fontpath,
            Extension = .ttf,
            UprightFont = {\baseFont},
            RawFeature = {+wght=500}
        ]{\baseFont}
    \else
        % Custom regular fonts: load from CormorantGaramond directory with explicit variants.
        \newfontfamily\headernamefont[
            Path = \fontpath,
            Extension = .ttf,
            UprightFont = {\baseFont-Regular},
            BoldFont = {\baseFont-Bold},
            MediumFont = {\baseFont-Medium},
            SemiBoldFont = {\baseFont-SemiBold}
        ]{\baseFont-Regular}
        \newfontfamily\headeraddressfont[
            Path = \fontpath,
            Extension = .ttf,
            UprightFont = {\baseFont-Regular}
        ]{\baseFont-Regular}
        \newfontfamily\headertitlefont[
            Path = \fontpath,
            Extension = .ttf,
            UprightFont = {\baseFont-Regular},
            BoldFont = {\baseFont-Bold}
        ]{\baseFont-Regular}
    \fi\fi


% Define separate commands for printing header elements and font attributes.
\newcommand{\headerName}[1]{%
    {\fontsize{35}{35}\selectfont \headernamefont \addfontfeature{LetterSpace=10.0} #1}%
}

\newcommand{\headerAddress}[1]{%
    {\fontsize{8}{9}\selectfont \headeraddressfont \bfseries \addfontfeature{LetterSpace=10.0} #1}%
}

\newcommand{\headerTitle}[1]{%
    {\fontsize{8}{9}\selectfont \headertitlefont\bfseries \addfontfeature{LetterSpace=12.0} #1}%
}

\newcommand{\baseText}[1]{%
    {\fontsize{9}{9}\selectfont \headertitlefont #1}%
}

\newcommand{\CompanyNameSize}{9} % Font size (pt) for company name in experience items
\newcommand{\PositionSize}{9}    % Font size (pt) for the position title in experience items
\newcommand{\LocationSize}{9}    % Font size (pt) for the position title in experience items

% \newcommand{hrefColor}{hyperref}
% Updated resumeheader command with equal vertical spacing above and below the horizontal line
\newcommand{\resumeheader}{%
    \begin{center}
        \headerName{\@name}\\[0.9em]
        \headerAddress{\@address}\\[0.3em]\par
        \textcolor{black}{\rule{0.9\linewidth}{0.09em}}\par
        \vspace{0.3em}
        \headerTitle{\@title}
    \end{center}%
    \vspace{0.5em}
}


\newcommand{\sectionTitle}[1]{%
    \par\noindent%
    \colorbox{sectionbg}{%
        \parbox{\dimexpr\linewidth-2\fboxsep}{%
            \centering\fontsize{9}{9}\selectfont\uppercase{#1}%
        }%
    }%
    \par\vspace{0.2em}%
}

\newcommand{\sectionContent}[1]{%
    {\fontsize{9}{9}\selectfont \headertitlefont #1}%
}

\newcommand{\summarySection}[1]{%
    \baseText{#1}
    \par\vspace{0.5em}
}

\newcommand{\skillsSection}[1]{%
    \baseText{#1}
    \par\vspace{0.5em}
}

\newcommand{\experienceSection}[1]{%
    \baseText{#1}
    \vspace{0.5em}%
}

\newcommand{\projectSection}[1]{%
    \baseText{#1}
    \vspace{0.5em}%
}

\newcommand{\educationSection}[1]{%
    \baseText{#1}
    \vspace{0.5em}%
}

% --- Divider for Experience Items ---
\newcommand{\ExpDividerLength}{0.95\linewidth}  % Set the length of the divider (adjust as needed)
\newcommand{\ExpDividerThickness}{0.5pt}       % Set the thickness of the divider (adjust as needed)
\newcommand{\expdivider}{%
    \vspace{-0.5em}%    % Vertical space before the divider
    \centering\noindent\textcolor{bulletColor}{\rule{\ExpDividerLength}{\ExpDividerThickness}}%
    \vspace{1em}%    % Vertical space after the divider
    \\
}

\newcommand{\experienceItem}[5]{%
    \noindent
    \begin{tabularx}{\linewidth}{@{}Xr@{}}%
        {\textbf{\fontsize{\CompanyNameSize}{\CompanyNameSize}\selectfont #1}} & {\textbf{\fontsize{\LocationSize}{\LocationSize}\selectfont #2}} \\[0.5ex]
        {\textit{\fontsize{\PositionSize}{\PositionSize}\selectfont #3}}       & {\textit{\fontsize{9}{9}\selectfont #4}}                         \\[0.5ex]
    \end{tabularx}%
    \vspace{-0.5ex}%
    \begin{itemize}[leftmargin=*,label=\textcolor{bulletColor}{\textbullet}]%
        \setlength{\itemsep}{-3pt}%
        #5
    \end{itemize}%
    \vspace{0em}%
}

\newcommand{\educationItem}[4]{%
    \noindent
    \begin{tabularx}{\linewidth}{@{}Xr@{}}%
        {\textbf{\fontsize{9}{9}\selectfont #1}} & {\textbf{\fontsize{9}{9}\selectfont #2}} \\[0.5ex]
        {\textit{\fontsize{9}{9}\selectfont #3}} & {\textit{\fontsize{9}{9}\selectfont #4}} \\[0.5ex]
    \end{tabularx}%
    \vspace{1em}%
}
