%SWJTUletter.cls

% This class based on "brownletter.cls" Copyright 2003, Nesime Tatbul (tatbul@cs.brown.edu)

% Modified by Luyi Li (owenliluyi@gmail.com) to fit the need of NJU students based on the FDU version modified by Huang Weiran (huangweiran1998@outlook.com).

% New version modified by He Yaxuan (ashleyhe678@163.com) based on NJU template, 10 January 2022

% New version modified by ZhenyuZhang (zzy1997@my.swjtu.edu.com), 2024,3,25

% Notes:
%
% 1. This class can be used for creating letters with SWUFE logo at the header and  department address at the footer 
% 2. It is based on the standard Latex document class, letter.cls.
% 3. Required packages are epsfig and ifthen.
% 4. If SWUFE logo is to be included in the head, then the file
%    SWUFElogo.eps must be provided. Otherwise, the logo is omitted.


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SWJTUletter}
\RequirePackage{graphicx}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\definecolor{slcolor}{HTML}{882B21}
%\RequirePackage{fontspec}
\DeclareGraphicsExtensions {.png} %{.pdf}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} % we always use letter paper

\newcommand{\subjectname}{Subject}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

\newboolean{logofound}
\IfFileExists{SWJTU_logo_horizontal.png}
    {\setboolean{logofound}{true}}
    {\setboolean{logofound}{false}}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.0in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newsavebox{\departmentfoot}
%\newsavebox{\emptyfoot}

\sbox{\departmenthead}{
    \begin{tabular*}{\textwidth}
                    {@{}l@{\extracolsep{0.0in}}|@{\extracolsep{0.125in}}l@{}}           

% HELP FOR SETTING UP PARBOXES
% \parbox[position][height][inner-pos]{width}{text}
% The \parbox has two mandatory arguments:
%     width - specifies the width of the parbox, and
%     text - the text that goes inside the parbox. 
% LaTeX will position a parbox so its center lines up with the center of the text line. The optional position argument allows you to line up either the top or bottom line in the parbox (default is top).
% If the height argument is not given, the box will have the natural height of the text.
% The inner-pos argument controls the placement of the text inside the box. If it is not specified, position is used.
%     t -- text is placed at the top of the box.
%     c -- text is centred in the box.
%     b -- text is placed at the bottom of the box.
%LOGO

% NOTE: The bit that changes the size of logo are the numbers in 'height=0.95in' (from He)

    \parbox{4.00in}
    {\raggedright
        \ifthenelse{\boolean{logofound}}
           {\includegraphics[width=0.45\textwidth]{SWJTU_logo_horizontal.png}}
           {\parbox[c][2.0in][c]{4.0in}{\hfill} 
            \ClassWarning{SWJTUletter}{SWJTU_logo_horizontal.png COULD NOT BE FOUND!}}
    } &
%DEPARTMENT OR SCHOOL
%  This just sets the size of the box to the right of the logo, and the size of the vertical line.  The vertical line is set by the size of the first numerical argument of the \parbox command.
%
% In the future, the "From" address might be better set using "tikz".
    \parbox[c][1.8in][c]{2.225in}{{~}\\
}\\
    \end{tabular*}
}

\savebox{\departmentfoot}[\textwidth][c]{\ixcmrmn
     SWJTU $\cdot$
     ~School of Information Science and Technology $\cdot$
     ~No. 999, Xi'an Road $\cdot$
     ~Chengdu, Sichuan, 611756, P.R.China
}

%\savebox{\emptyfoot}[\textwidth][c]{\ixcmrmn
   % \hspace*{\textwidth}
%}

% header and footer should be placed only on the first page
\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{\usebox{\departmenthead}}
    \renewcommand{\@evenfoot}{\usebox{\departmentfoot}}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{1.0in}
    \setlength{\headsep}{0.5in}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\usebox{\departmentfoot}}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}

% we add the subject command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        %{\raggedleft\@date\par}%
    \else  % home address
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            %\@date
            \end{tabular}\par
        }%
     \fi
     \vspace{-6\parskip}
     \@date \vspace{2\parskip}\\
     {\raggedright \toname \\ \toaddress \par}%
     \vspace{1\parskip}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}%
     #1\par\nobreak
}

% we push closing to the right
%\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
%   \stopbreaks
%   \noindent
%   \hspace*{0.6\textwidth}\parbox{0.4\textwidth}{\raggedright
%   \ignorespaces #1\\[4\medskipamount]%
%   \ifx\@empty\fromsig
%       \fromname
%   \else \fromsig 
%   \fi\strut}%
%   \par
%}