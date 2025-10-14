\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resumeClass}[2025/04/03 A simple resume class]
\raggedbottom

% Load the base class:
\LoadClass{article}

% Font Settings
\RequirePackage{fontSettings} % Load font settings from fontSettings.sty

% Load packages for layout and styling
\RequirePackage[paperwidth=8.5in, paperheight=11in, top=0.5in, bottom=0.5in, left=0.5in, right=0.5in, marginparwidth=0in, marginparsep=0in, headheight=0in, headsep=0in, footskip=0in, bindingoffset=0in]{geometry} % Strict 1 inch margins only
\RequirePackage{fontspec}             % Font selection
\RequirePackage{titlesec}             % Control section titles
\RequirePackage{enumitem}             % Customizable lists
\RequirePackage{xcolor}               % Colors
\RequirePackage[colorlinks=true, allcolors=.]{hyperref}
\RequirePackage{parskip}              % No paragraph indent, spacing between paragraphs
\RequirePackage{bookmark}             % No paragraph indent, spacing between paragraphs
\RequirePackage{tabularx}             % Tabularx for better table handling
\RequirePackage{pifont}            % For checkmark symbol
\newcommand{\cmark}{\ding{51}}     % Checkmark character
\RequirePackage{tikz}                % TikZ for drawing
\usetikzlibrary{calc}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage{datatool}
\RequirePackage{xfor}
\RequirePackage{pgf}
\RequirePackage{pgffor}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{tikz}
\RequirePackage{multicol}
\RequirePackage{varwidth}
\RequirePackage{bbding}
\usetikzlibrary{matrix, calc}

% --- Header storage without @ macros ---
\newcommand{\fullname}[1]{\renewcommand\resumeName{#1}}
\newcommand{\jobtitle}[1]{\renewcommand\resumeTitle{\mylist{#1}}}
\newcommand{\address}[1]{\renewcommand\resumeAddress{#1}}

% Initialize to empty
\newcommand\resumeName{}
\newcommand\resumeTitle{}
\newcommand\resumeAddress{}


% Custom Colors
% \definecolor{sectionbg}{RGB}{242, 188, 62}
\definecolor{sectionbg}{HTML}{FAE49E}
\definecolor{sectionTitleBg}{HTML}{EBAF70}
\definecolor{itemDivOrange}{HTML}{F0C394}
\definecolor{yellow1}{HTML}{F7D564}
\definecolor{orange}{HTML}{A15E17}
\definecolor{baseText}{HTML}{000000}
\definecolor{bulletColor}{HTML}{3D3D3D}


\pagestyle{empty} % Remove page numbers

% --- Custom pipe separator formatting (vertically centered) ---
\newcommand{\lpipe}{%
    $\vcenter{\hbox{\textcolor{orange}{\rule{0.9pt}{2.0ex}}}}$%
    \hspace{0.5em}%
}

\newcommand{\comma}{, }

\ExplSyntaxOn
\seq_new:N \l__resume_list_seq
\NewDocumentCommand{\mylist}{m}
{
    \seq_set_split:Nnn \l__resume_list_seq {,} { #1 }
    \seq_use:Nn \l__resume_list_seq { ~\lpipe~ }
}
\ExplSyntaxOff

% ===================== NEW TWO-COLUMN HEADER =====================
% Left: Name (top-left) + Title (bottom-left)
% Right: Contact info (stacked, right-aligned)
\newcommand{\resumeheader}{%
    \noindent
    \begin{tabularx}{\linewidth}{@{}p{0.75\linewidth}@{\hspace{0.15em}}p{0.43\linewidth}@{}}%
        \begin{varwidth}{\linewidth}%
            \headerFullName{\resumeName}\\[0.35em]
            \headerPosTitle{\resumeTitle}%
        \end{varwidth}%
         &
        \begin{varwidth}{\linewidth}%
            \raggedright\headerContactInfo{\resumeAddress}%
        \end{varwidth} \\
    \end{tabularx}%
    \par\vspace{0.4em}%
    \vspace{0.6em}%
}

\newcommand{\newSection}[1]{%
    \par\vspace{0.5em}
    \baseText{#1}
    \par\vspace{0.5em}
}
\newcommand{\contactIcon}[2]{
    \textcolor{orange}{\fontsize{11}{9}\raisebox{-0.1\height}{\selectfont\resumeFontSemiBold\addfontfeature{LetterSpace=10.0}#1}}\hspace{0.5em}#2\hspace{1.3em}
}

\newcommand{\ExpDividerLength}{1\linewidth}  % Set the length of the divider (adjust as needed)
\newcommand{\ExpDividerThickness}{0.5pt}       % Set the thickness of the divider (adjust as needed)
\newcommand{\expdivider}{%
    \par\vspace{-0.5em}%    % Paragraph break and vertical space before the divider
    \begin{center}%
        \textcolor{itemDivOrange}{\rule{\ExpDividerLength}{\ExpDividerThickness}}%
    \end{center}%
}


\newcommand{\headerInfo}[3]{%
    \noindent
    \begin{tabularx}%
        {\linewidth}{@{}Xr@{}}%
        \headerFullName{#1} & \headerContactInfo{#2} \\[0.5ex]
        \headerPosTitle{#3} &                        \\[0.5ex]
    \end{tabularx}%
    \vspace{0em}%
}

% For multi-line bullet items (a larger vertical shift)
\newcommand{\multibulletitem}[1]{%
    \item[\raisebox{-0.8ex}{\scalebox{2}{\textcolor{bulletColor}{\textbullet}}}] #1
}

\newcommand{\experienceItem}[5]{%
    \noindent
    \begin{tabularx}{\linewidth}{@{}Xr@{}}%
        \experienceCompanyName{\mylist{#1}} & \textcolor{orange}{\experienceLocation{#2}} \\[0.5ex]
        \experiencePosition{\mylist{#3}}    & \experienceDates{#4}                        \\[0.5ex]
    \end{tabularx}%
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
