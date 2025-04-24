\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2025/04/03 A simple resume class]

% Load the base class:
\LoadClass{article}

% Font Settings
\RequirePackage{fontSettings} % Load font settings from fontSettings.sty

% Load packages for layout and styling
\RequirePackage[paperwidth=8.5in, paperheight=11in, top=0.5in, bottom=0.5in, left=0.5in, right=0.5in, marginparwidth=0in, marginparsep=0in, headheight=0in, headsep=0in, footskip=0in, bindingoffset=0in, showframe]{geometry} % Strict 1 inch margins only
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
\newcommand{\address}[1]{\renewcommand\resumeAddress{\mylist{#1}}}

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

% ----------------------------------------------------------
% Dynamic-width skill boxes using TikZ
% ----------------------------------------------------------

\ExplSyntaxOn
%— internal storage
\clist_new:N \l__ltt_clist
\int_new:N   \l__ltt_rows_int
\int_new:N   \l__ltt_cols_int
\tl_new:N    \l__ltt_table_tl

%— build the table body into \l__ltt_table_tl
\cs_new_protected:Nn \ltt_create_table:n {%
    % store the list and set row-count=3
    \clist_set:Nn \l__ltt_clist { #1 }
    \int_set:Nn \l__ltt_rows_int { 3 }
    % compute columns = ceil(total_items ÷ 3)
    \int_set:Nn \l__ltt_cols_int
    {
        \int_eval:n
        {
            ( \clist_count:N \l__ltt_clist
            + \l__ltt_rows_int - 1 )
            / \l__ltt_rows_int
        }
    }
    % assemble each of 3 rows
    \tl_clear:N \l__ltt_table_tl
    \int_step_inline:nn { \l__ltt_rows_int }
    {
        \int_step_inline:nn { \l__ltt_cols_int }
        {
            % Only prepend '&' if not the first column
            \int_compare:nNnTF { ####1 } = { 1 }
                {
                    \tl_put_right:Nx \l__ltt_table_tl
                    { \clist_item:Nn
                        \l__ltt_clist
                        { \int_eval:n { (####1-1) * \l__ltt_rows_int + ##1 } }
                    }
                }
                {
                    \tl_put_right:Nx \l__ltt_table_tl
                    { & \clist_item:Nn
                        \l__ltt_clist
                        { \int_eval:n { (####1-1) * \l__ltt_rows_int + ##1 } }
                    }
                }
        }
        \tl_put_right:Nn \l__ltt_table_tl { \\ }
    }
}

\newcommand{\skillCheck}{
    {
            \color{orange}%
            \scalebox{0.8}{\Checkmark}%
        }
    \,
}

%— user-level command
\NewDocumentCommand \listtoTable { m } {
    \par\noindent                   % ensure vertical mode before starting
    \ExplSyntaxOn
    \ltt_create_table:n { #1 }    % build the row data
    \ExplSyntaxOff
    {\renewcommand{\arraystretch}{0.7}% reset row spacing
        \begin{tabularx}{\linewidth}
            {*{\int_use:N \l__ltt_cols_int}{>{\skillCheck\raggedright\arraybackslash}X}}
            \l__ltt_table_tl
        \end{tabularx}
    }
    \par                            % end paragraph cleanly
}
\ExplSyntaxOff
% —————————————————————————————————————————————

\newcommand{\skillBox}[2]{%
    \begin{tcolorbox}[
            title=\centering\textbf{#1},
            size=small,
            coltitle=black,
            before upper=\vspace{-0.5em},
            height=6.99em,
            arc=1.5mm,
            colframe=sectionTitleBg,
            rounded corners,
            boxsep=0.3em,
            left=0.5em,
            right=0.5em,
            top=0.2em,
            bottom=0.5em]%
        % Replace CSV-list itemize with direct table
        \par\noindent
        \begin{minipage}{\linewidth}
            \listtoTable{#2}%
        \end{minipage}
        \par\noindent
    \end{tcolorbox}%
}

\newcommand{\skillsBoxes}[3]{%
    \vspace{-0.5em}
    \bgroup
    \def\arraystretch{1.5}
    \setlength{\tabcolsep}{0.5em}
    \begin{tabularx}{\textwidth}{%
        >{\centering\arraybackslash}p{0.4\textwidth}
        >{\centering\arraybackslash}p{0.35\textwidth}
        >{\centering\arraybackslash}p{0.20\textwidth}
        }
        #1 & #2 & #3
    \end{tabularx}
    \egroup
    \vspace{-0.5em}
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
