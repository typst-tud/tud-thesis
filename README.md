# tud-thesis
This is a [Typst](https://typst.app/) template for theses and papers in the corporate design of the [Technische Universität Dresden](https://tu-dresden.de/).

Please be aware that this template is unofficial and may not fully adhere to the CD specifications.

Be also aware, that this template does not aim to be a replacement of the [TUD-Script bundle for LaTeX](https://github.com/tud-cd/tudscr) with its extensive feature set.

Any corrections, modifications, or enhancements are welcome.

## Installation and Usage
### 1. get the template
- clone this repository with git

```bash
git clone https://github.com/typst-tud/tud-thesis.git
```

- or download as a ZIP-file: https://github.com/typst-tud/tud-thesis/archive/refs/heads/main.zip

#### get the fonts
This template uses the following fonts:
- Open Sans
  - is the Corporate Design font, sans-serif
  - download from https://github.com/googlefonts/opensans/tree/main/fonts/ttf
  - Typst does not yet support variable fonts, thus you need to use separate ttf files for each weight and style
- Noto Sans
  - sans-serif font alternative for Open Sans
- Libertinus Serif
  - a nice serif font included with Typst
  - download from https://github.com/alerque/libertinus

### 2. import template into your document
```typst
#import "tud-thesis.typ": *

#show: thesis.with(
  title: "My very good thesis title",
  subtitle: "This subtitle is below the title",
  graduation: "Diploma of Computer Science",

  supervisor: "Dr. Supervisor",
  professor: "Prof. Dr. Professor",

  university: "Technische Universität Dresden",
  faculty: "Faculty of …",
  institute: "Institute of …",
  chair: "Chair of …",

  author: "Firstname Lastname",
  // dateofbirth: "2.1.1990",
  // placeofbirth: "Dresden",
  matriculationnumber: "00000000",
  // matriculationyear: "2010",
  email: "Firstname.Lastname@mailbox.tu-dresden.de",

  abstract: lorem(50),

  bibliography-file: "example/bibliography.bib",
  // assignment-file: "assignment.svg",

  cdfont: false,
  draft-mode: false,
  print-mode: false,
)

= Introduction
#lorem(10)

= Background
#lorem(10)

…

= Conclusion
#lorem(10)


```

## Acknowledgments

- originally adapted from the [Grape Suite](https://github.com/piepert/grape-suite) template
- [Corporate Design Manual (login required)](https://tu-dresden.de/intern/services-und-hilfe/ressourcen/dateien/kommunizieren_und_publizieren/corporate-design/cd-elemente/CD_Manual_Stand-2022-02.pdf)
- [TUD-Script bundle for LaTeX](https://github.com/tud-cd/tudscr)

