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

\pagestyle{empty} % Remove page numbers

% Custom Colors
% \definecolor{sectionbg}{RGB}{242, 188, 62}
\definecolor{sectionbg}{HTML}{FAE49E}
\definecolor{sectionTitleBg}{HTML}{EBAF70}
\definecolor{itemDivOrange}{HTML}{F0C394}
\definecolor{yellow1}{HTML}{F7D564}
\definecolor{orange}{HTML}{C4731C}
\definecolor{baseText}{HTML}{000000}
\definecolor{bulletColor}{HTML}{3D3D3D}

% --- Replace the current font toggle block (starting from "Define storage for header elements") with the following:

% Define storage for header elements
\def\fullname#1{\def\@name{#1}}
\def\@name {}
\def\jobtitle#1{\def\@title{#1}}
\def\@title {}
\newcommand{\address}[1]{\def\@address{#1}}
\def\@address{}

% --- Custom pipe separator formatting (vertically centered) ---
\newcommand{\lpipe}{%
    $\vcenter{\hbox{\textcolor{orange}{\rule{0.9pt}{2.0ex}}}}$%
    \hspace{0.5em}%
}

% --- Skills grid with max rows, dynamic columns ---
\ExplSyntaxOn
\seq_new:N \l__skills_seq
\int_new:N \l__skills_total_int
\int_new:N \l__skills_cols_int
\tl_new:N  \l__skills_cols_tl
\NewDocumentCommand{\skillsGridRows}{O{4}m}{%
    \vspace{1.5em}% Add space after section title
    % Split comma list into sequence
    \seq_set_split:Nnn \l__skills_seq {,} {#2}
    % Total number of items
    \int_set:Nn \l__skills_total_int { \seq_count:N \l__skills_seq }
    % Compute number of columns = ceil(total / max rows)
    \int_set:Nn \l__skills_cols_int { \int_eval:n { ( \l__skills_total_int + #1 - 1 ) / #1 } }
    % Prepare column count
    \tl_set:Nx \l__skills_cols_tl { \int_to_arabic:n { \l__skills_cols_int } }
    % Adjust multicol spacing and draw
    {\setlength{\columnsep}{0.5em}%
        \setlength{\multicolsep}{0pt}%
        \setlength{\premulticols}{0pt}%
        \setlength{\postmulticols}{0pt}%
        \begin{multicols}{\tl_use:N \l__skills_cols_tl}
            \begin{itemize}[
                    leftmargin=1em,
                    itemsep=0.1em,
                    parsep=0pt,
                    topsep=0pt,
                    label=$\vcenter{\hbox{\textcolor{orange}{\cmark}}}$,
                    labelsep=0.3em
                ]
                % Only produce \item for non-empty entries
                \seq_map_inline:Nn \l__skills_seq {%
                \tl_set:Nx \l_tmpa_tl { \tl_trim_spaces:n {##1} }%
                \tl_if_blank:VTF \l_tmpa_tl
                { }% do nothing if empty
                { \item \l_tmpa_tl }%
                      }
            \end{itemize}
        \end{multicols}%
    }%
    \vspace{1em}
}
\ExplSyntaxOff

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
        \headerFullName{\@name}\par\vspace{0.2em}
        \headerContactInfo{\expandafter\mylist\expandafter{\@address}}\par
        \textcolor{orange}{\rule{0.9\linewidth}{0.2em}}\par
        \vspace{0.3em}
        \headerPosTitle{\@title}
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
