\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2025/04/03 A simple resume class]

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
\RequirePackage{multicol}
\RequirePackage{pifont}            % For checkmark symbol
\newcommand{\cmark}{\ding{51}}     % Checkmark character
\RequirePackage{tikz}                % TikZ for drawing
\usetikzlibrary{calc}
\RequirePackage{xparse}
\RequirePackage{etoolbox}

% --- Header storage without @ macros ---
\newcommand{\fullname}[1]{\renewcommand\resumeName{#1}}
\newcommand{\jobtitle}[1]{\renewcommand\resumeTitle{\mylist{#1}}}
\newcommand{\address}[1]{\renewcommand\resumeAddress{\mylist{#1}}}

% Initialize to empty
\newcommand\resumeName{}
\newcommand\resumeTitle{}
\newcommand\resumeAddress{}

% Measure widest skill entry
\newlength\skillMaxWidth
\newcount\skillCols
\newdimen\sk@tempdima
\newdimen\skillTotalWidth

\newcommand{\measureSkill}[1]{%
    \settowidth\sk@tempdima{\cmark\ #1}%
    \ifdim\sk@tempdima>\skillMaxWidth
        \global\skillMaxWidth=\sk@tempdima
    \fi%
}

% Custom Colors
% \definecolor{sectionbg}{RGB}{242, 188, 62}
\definecolor{sectionbg}{HTML}{FAE49E}
\definecolor{sectionTitleBg}{HTML}{EBAF70}
\definecolor{itemDivOrange}{HTML}{F0C394}
\definecolor{yellow1}{HTML}{F7D564}
\definecolor{orange}{HTML}{C4731C}
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

% Updated resumeheader command with equal vertical spacing above and below the horizontal line
\newcommand{\resumeheader}{%
    \begin{center}
        \headerFullName{\resumeName}\par\vspace{0.2em}
        \headerContactInfo{\mylist{\resumeAddress}}\par
        \textcolor{orange}{\rule{0.9\linewidth}{0.2em}}\par
        \vspace{0.3em}
        \headerPosTitle{\resumeTitle}
    \end{center}%
    \vspace{0.5em}
}

\newcommand{\newSection}[1]{%
    \baseText{#1}
    \par\vspace{0em}
}

\newcommand{\ExpDividerLength}{1\linewidth}  % Set the length of the divider (adjust as needed)
\newcommand{\ExpDividerThickness}{0.5pt}       % Set the thickness of the divider (adjust as needed)
\newcommand{\expdivider}{%
    \par\vspace{-0.5em}%    % Paragraph break and vertical space before the divider
    \begin{center}%
        \textcolor{itemDivOrange}{\rule{\ExpDividerLength}{\ExpDividerThickness}}%
    \end{center}%
    \vspace{0em}\par%    % Vertical space and paragraph break after the divider
}

% Automatically fit skills into evenly sized columns
% Usage: \autoSkills{comma,list,of,skills}
\newcommand{\autoSkills}[1]{%
    \vspace{-0.5em}%
    \setlength\skillMaxWidth{0pt}%
    \forcsvlist{\measureSkill}{#1}%
    \skillCols=\numexpr(\textwidth+\columnsep)/(\skillMaxWidth+\columnsep)\relax
    \ifnum\skillCols<1 \skillCols=1\fi
    % Calculate total grid width = (skillMaxWidth * skillCols) + (columnsep * (skillCols - 1))
    \skillTotalWidth=\dimexpr \skillMaxWidth * \skillCols
    + \columnsep * (\skillCols - 1)\relax
    \begin{center}
        \begin{minipage}{\skillTotalWidth}
            \begin{multicols}{\the\skillCols}
                \begin{itemize}[leftmargin=1em,itemsep=0.2em,
                        label=$\vcenter{\hbox{\textcolor{orange}{\cmark}}}$]
                    \renewcommand*\do[1]{\item ##1}%
                          \docsvlist{#1}%
                \end{itemize}
            \end{multicols}
        \end{minipage}
    \end{center}
}

\newcommand{\skillsItem}[2]{%
    \skillTitle{#1}%
    \skillsList{\vspace{0.1em} #2}\par
    \vspace{0em}%
}

\NewDocumentCommand{\skillsSectionThree}{mmmmmm}{%
    \begin{tabularx}{\linewidth}{@{} >{\raggedright\arraybackslash}X
            >{\raggedright\arraybackslash}X
            >{\raggedright\arraybackslash}X @{}}
        \skillTitle{#1}\par\skillsList{#2} &
        \skillTitle{#3}\par\skillsList{#4} &
        \skillTitle{#5}\par\skillsList{#6}
    \end{tabularx}%
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
        \experienceCompanyName{\mylist{#1}} & \textcolor{orange}{\experienceLocation{#2}} \\[0.5ex]
        \experiencePosition{\mylist{#3}}    & \experienceDates{#4}                        \\[0.5ex]
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
