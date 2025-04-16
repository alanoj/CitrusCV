\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2025/04/03 A simple resume class]

% Load the base class:
\LoadClass{article}

% Font Settings
\RequirePackage{fontSettings} % Load font settings from fontSettings.sty

% Load packages for layout and styling
\RequirePackage[paperwidth=8.5in, paperheight=11in, top=1.25cm, bottom=1.25cm, left=1.25cm, right=1.25cm, marginparwidth=0in, marginparsep=0in, headheight=0in, headsep=0in, footskip=0in, bindingoffset=0in]{geometry} % Strict 1 inch margins only
\RequirePackage{fontspec}             % Font selection
\RequirePackage{titlesec}             % Control section titles
\RequirePackage{enumitem}             % Customizable lists
\RequirePackage{xcolor}               % Colors
\RequirePackage[colorlinks=true, allcolors=.]{hyperref}
\RequirePackage{parskip}              % No paragraph indent, spacing between paragraphs
\RequirePackage{bookmark}             % No paragraph indent, spacing between paragraphs
\RequirePackage{tabularx}             % Tabularx for better table handling
\RequirePackage{tikz}                % TikZ for drawing
\usetikzlibrary{calc}

\pagestyle{empty} % Remove page numbers

% Custom Colors
% \definecolor{sectionbg}{RGB}{242, 188, 62}
\definecolor{sectionbg}{HTML}{FAE49E}
\definecolor{sectionTitleBg}{HTML}{F5D8B8}
\definecolor{yellow1}{HTML}{F7D564}
\definecolor{orange}{HTML}{C4731C}
\definecolor{baseText}{HTML}{1F1F1F}
\definecolor{bulletColor}{HTML}{3D3D3D}

% --- Replace the current font toggle block (starting from "Define storage for header elements") with the following:

% Define storage for header elements
\def\fullname#1{\def\@name{#1}}
\def\@name {}
\def\jobtitle#1{\def\@title{#1}}
\def\@title {}
\def\address#1{\def\@address{#1}}
\def\@address {}


% Updated resumeheader command with equal vertical spacing above and below the horizontal line
\newcommand{\resumeheader}{%
    \begin{center}
        \headerFullName{\@name}\\[0.5em]
        \headerContactInfo{\@address}\\[0.3em]\par
        \textcolor{orange}{\rule{0.9\linewidth}{0.2em}}\par
        \vspace{0.3em}
        \headerPosTitle{\@title}
    \end{center}%
    \vspace{0.5em}
}

\newcommand{\newSection}[1]{%
    \baseText{#1}
    \par\vspace{0.5em}
}

% --- Divider for Experience Items ---
\newcommand{\ExpDividerLength}{0.95\linewidth}  % Set the length of the divider (adjust as needed)
\newcommand{\ExpDividerThickness}{0.5pt}       % Set the thickness of the divider (adjust as needed)
\newcommand{\expdivider}{%
    \vspace{-0.5em}%    % Vertical space before the divider
    \centering\noindent\textcolor{orange}{\rule{\ExpDividerLength}{\ExpDividerThickness}}%
    \vspace{1em}%    % Vertical space after the divider
    \\
}

% For single-line bullet items (a smaller vertical shift)
\newcommand{\singlebulletitem}{%
    \item[\raisebox{-0.2ex}{\textcolor{bulletColor}{\textbullet}}]
}

% For multi-line bullet items (a larger vertical shift)
\newcommand{\multibulletitem}{%
    \item[\raisebox{-0.8ex}{\textcolor{bulletColor}{\textbullet}}]
}

\newcommand{\experienceItem}[5]{%
    \noindent
    \begin{tabularx}{\linewidth}{@{}Xr@{}}%
        \experienceCompanyName{#1} & \textcolor{orange}{\experienceLocation{#2}} \\[0.5ex]
        \experiencePosition{#3}    & \experienceDates{#4}                        \\[0.5ex]
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
        \experienceCompanyName{#1} & \textcolor{orange}{\experienceLocation{#2}} \\[0.5ex]
        \experiencePosition{#3}    & \experienceDates{#4}                        \\[0.5ex]
    \end{tabularx}%
    \vspace{0em}%
}
