<img width="800" alt="CitrusCV" src="assets/logo_banner_clear.png"/>


<div align="center">

![Build](https://img.shields.io/github/actions/workflow/status/alanoj/CitrusCV/latex-build.yml?style=for-the-badge)

![Release](https://img.shields.io/github/v/release/alanoj/CitrusCV?style=for-the-badge)

![License](https://img.shields.io/github/license/alanoj/CitrusCV?style=for-the-badge)

![Last Commit](https://img.shields.io/github/last-commit/alanoj/CitrusCV?style=for-the-badge)

![LaTeX](https://img.shields.io/badge/LaTeX-%23008080.svg?style=for-the-badge&logo=latex&logoColor=white)

![ChatGPT](https://img.shields.io/badge/ChatGPT-74aa9c?style=for-the-badge&logo=openai&logoColor=white)

</div>

# CitrusCV 


### Resume Preview

![Resume Preview](assets/resume_preview.png)

---

## Overview

**CitrusCV** is a modular LaTeX resume template designed to help technical professionals showcase their skills and experience in a polished, maintainable format. Built from the ground up with customization in mind, this project separates styling, layout, and content into dedicated files so you can tweak typography, colors, and structural components without touching the core content.

Key goals:

- **Impress recruiters** with a clean, consistent design.
- **Demonstrate technical proficiency** through a well‑structured codebase.
- **Enable forks and modifications** by providing clear APIs for each component.

---

## Table of Contents

- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [File Reference](#file-reference)
   - [FontSettings.sty](#fontsettingssty)
   - [resume.cls](#resumeccls)
   - [main.tex](#maintex)
- [Customization Guide](#customization-guide)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

---

## Getting Started

### Prerequisites

- A recent LaTeX distribution (TeX Live, MacTeX, or MiKTeX).
- Optional: `latexmk` for automated building and watch mode.
- Git to clone the repository.

### Quick Installation

```bash
# Clone the repo
git clone https://github.com/alanoj/CitrusCV.git
cd CitrusCV

# Build PDF
latexmk -pdf main.tex
```

If you prefer a single-step build:

```bash
pdflatex main.tex
``` 

---

## Project Structure

```text
CitrusCV/
├── assets/            # Logo, preview, and any other assets
│   ├── logo.png       # Project logo
│   └── resume_preview.png
├── FontSettings.sty   # Central font and spacing configuration
├── resume.cls         # Custom class with section and component macros
└── main.tex           # Master document composing all sections
``` 

---

## File Reference

### `FontSettings.sty` {#fontsettingssty}

This file centralizes all typographic settings and spacing. Tweak here to change the look and feel globally.

#### Sections

1. **Font Families**
   - Defines primary serif and sans-serif fonts:
     ```latex
     \RequirePackage{fontspec}
     \setmainfont{TeX Gyre Termes}
     \setsansfont{TeX Gyre Heros}
     ```
   - To switch fonts, update the font names.

2. **Font Sizes & Weights**
   - Custom commands for headings and body:
     ```latex
     \newcommand{\HUGE}{\fontsize{18pt}{20pt}\selectfont}
     \newcommand{\BodyFont}{\fontsize{10pt}{12pt}\selectfont}
     ```
   - Modify `fontsize{<size>}{<baseline>}` pairs to adjust scale.

3. **Line Spacing & Margins**
   - Adjusts `\linespread{1.05}` for readability.
   - Sets page geometry via `geometry` package options.

4. **Color Palette**
   - Defines brand colors:
     ```latex
     \definecolor{CitrusOrange}{HTML}{EBAF70}
     \definecolor{AccentGray}{HTML}{555555}
     ```
   - Change hex codes to match your branding.

5. **How to Extend**
   - Add new `\newcommand` blocks for additional font styles or sizes.
   - Use `\RequirePackage` to include extra typographic packages (e.g., `microtype` for kerning).

---

### `resume.cls` {#resumeccls}

Custom document class defining layout components and section macros. This serves as the API for your resume structure.

#### Core Macros

1. **Header Component**: `\newcommand{\resumeheader}{...}`
   - Centers your name, contact info, and title.
   - Key elements inside:
     ```latex
     \headerFullName{\resumeName}\par
     \headerContactInfo{\mylist{\resumeAddress}}\par
     \textcolor{CitrusOrange}{\rule{0.8\linewidth}{0.2em}}\par
     \headerPosTitle{\resumeTitle}
     ```
   - **Customization**: Change line thickness by editing `\rule{<width>}{<height>}`. Update color token if you renamed your palette.

2. **Section Header**: `\newcommand{\sectionheader}[1]{...}`
   - Renders a colored title bar with the section name.
   - **Params**: `#1` = section title text.
   - **Modify**: Tweak padding and rule thickness here.

3. **Divider Rule**: `\newcommand{\divider}{...}`
   - Inserts a horizontal rule with default margin.
   - **Change**: Adjust spacing around rule or color.

4. **Skill Tag**: `\newcommand{\skilltag}[1]{...}`
   - Wraps each skill in a colored box with padding.
   - **Parameter**: `#1` = skill text.
   - **Customize**: Modify `\fboxsep`, `\fboxrule`, or color settings.

5. **Skill Section**: `\newcommand{\skillsection}[1]{...}`
   - Takes comma‑separated skills and applies `\skilltag` to each.
   - **Example Usage**: `\skillsection{Python, C++, Git}`.

#### Adding New Macros

- Define additional components by copying the above patterns:
  ```latex
  \newcommand{\projectitem}[2]{%
     \textbf{#1}: #2\\[0.2em]
  }
  ```
- Remember to document new macros here for future maintainers.

---

### `main.tex` {#maintex}

The master document that composes all sections and content. Edit this file to update personal details and entries.

#### Structure

1. **Preamble**
   ```latex
   \documentclass[12pt]{resume}
   \input{FontSettings.sty}
   \addtolength{\topmargin}{-0.5in}
   ```
2. **Header Invocation**
   ```latex
   \begin{document}
   \resumeheader
   ```
3. **Summary Section**
   ```latex
   \sectionheader{Professional Summary}
   A results-driven software engineer with X years...
   ```
4. **Experience & Education**
   - Each entry uses standard `\textbf`, `\emph`, and `\divider` for layout.

5. **Skills**
   ```latex
   \sectionheader{Technical Skills}
   \skillsection{Python, JavaScript, React, Docker}
   ```

6. **Custom Sections**
   - Add new sections by calling `\sectionheader{<Title>}` and writing content below.

7. **Document End**
   ```latex
   \end{document}
   ```

#### How to Modify Content

- **Update Personal Info**: Change variables in the class or at the top of `main.tex`:
  ```latex
  \newcommand{\resumeName}{Alan Ordorica}
  \newcommand{\resumeTitle}{Senior Software Engineer}
  ```
- **Add Roles**: Copy and adjust an experience block. Use `\divider` to separate items.
- **Include Images**: Place images in `images/` and use `\includegraphics[width=...]`.

---

## Customization Guide

1. **Global Styles**: Tweak `FontSettings.sty`.
2. **Layout & Components**: Extend or adjust macros in `resume.cls`.
3. **Content Editing**: Modify `main.tex` to update text and structure.
4. **Build Settings**: Adjust geometry or marginal tweaks in `main.tex` preamble.

---

## Usage

- **Build PDF**:
  ```bash
  latexmk -pdf main.tex
  ```
- **Live Preview**:
  ```bash
  latexmk -pdf -pvc main.tex
  ```
- **Clean Aux Files**:
  ```bash
  latexmk -c
  ```

---

## Contributing

1. Fork and clone the repo.
2. Create a feature branch: `git checkout -b feature/my-changes`.
3. Make edits and update documentation.
4. Run `latexmk -c && latexmk -pdf` to verify build.
5. Commit and push your branch.
6. Submit a pull request and describe your improvements.

Please follow existing style conventions and update this README when adding new features.

---

## License

This project is released under the MIT License. See [LICENSE](LICENSE) for details.
