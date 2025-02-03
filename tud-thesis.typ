// based on https://github.com/piepert/grape-suite/tree/main
// and https://github.com/tud-cd/tudscr

// #import "@preview/tablex:0.0.8": tablex, cellx, rowspanx, colspanx
#import "colors.typ" as colors: *
#import "utils.typ" as utils: *

#let thesis(
    // thesis details
    title: none,
    alttitle: none, // alternative title, e.g. without linebreaks or with abbreviations
    subtitle: none,
    // subject: "Master of …",
    graduation: none,
    abstract: none,
    supervisor: "Dr. Supervisor",
    // professor: "Prof. Dr. Professor",
    professor: none,

    // institutional details
    university: "Technische Universität Dresden",
    faculty: "Faculty of …",
    institute: "Institute of …",
    chair: "Chair of …",

    // personal details
    author: "Firstname Lastname",
    dateofbirth: none,
    placeofbirth: none,
    matriculationnumber: none,
    matriculationyear: none,
    email: "Firstname.Lastname@mailbox.tu-dresden.de",

    date: datetime.today(),
    date-format: (date) => date.display("[day].[month].[year]"),

    bibliography-file: "bibliography.bib",
    bibliography-style: "ieee",

    show-assignment: true,
    assignment-file: none,
    show-statement-of-authorship: true,
    statement-of-authorship: none,

    acronyms: none,

    // set base text size
    text-size: 11pt,

    // use the TUD Corporate Design font Open Sans
    // if false uses a "nicer" serif font for the main text content
    cdfont: true,

    // font selection, depends on cdfont option
    sans-font: (
      "Open Sans", // TUD CD font
      "Noto Sans", // good alternative for Open Sans
    ),
    serif-font: (
      "Libertinus Serif", // a nice serif font included with Typst, https://github.com/alerque/libertinus
    ),

    // draft mode hides some content, e.g. the assignment and the statement-of-authorship
    // and shows content slightly more condensed
    draft-mode: false,

    // print mode deactivates draft mode and
    // removes some formatting which is not useful for a printed version,
    // e.g. hyperlink formatting
    print-mode: false,

    debug-mode: false,

    body
) = {

  if print-mode {
    draft-mode = false
  }

  // show some borders for layout debugging
  let debug-stroke = none
  if debug-mode {
    debug-stroke = 1pt + red
  }

  // add a font size correction for serif font,
  // otherwise the serif font is too small
  if not cdfont {
    text-size = text-size + 0.75pt
  }

  // basic font setup
  set text(
    font: sans-font,
    size: text-size,
    weight: "light",
    kerning: true,
    ligatures: true,
    number-type: "lining",
  )
  // set font for math equations
  show math.equation: set text(font: "New Computer Modern Math") // default math font of Typst
  // show math.equation: set text(font: "Libertinus Math")

  // page setup
  //
  // according to Corporpate Design grid for A4 paper
  // https://tu-dresden.de/intern/services-und-hilfe/ressourcen/dateien/kommunizieren_und_publizieren/corporate-design/cd-elemente/CD_Manual_Stand-2022-02.pdf
  // X => margin from left to logo = 11mm
  // Y => margin from top to logo = 13.5mm
  // B => width of logo = 57mm
  // T => main axis from left, aligned to logo text = 30mm
  // K => main header height = 40mm
  // content = auto
  // MB => margin from bottom = 28mm from old CD
  let X = 11mm
  let Y = 13.5mm
  let K = 40mm
  let B = 57mm
  let T = 30mm
  let MB = 28mm

  // binding correction 4mm, eq. BCOR in tudscr for LaTeX
  let BCOR = 4mm

  set page(
    paper: "a4",
    binding: left,
    margin: (
        top: K,
        bottom: MB,
        left: T + BCOR,
        right: 20mm,
        // inside: (100% - 4mm) / 9 + 4mm,
        // outside: (100% - 4mm)/ 9 * 2
    ),
    // header: none, // TODO: show current chapter title
    number-align: center + bottom,
    numbering: "1",
    header: if debug-mode { rect(width: 100%, height: 100%, stroke: debug-stroke) },
    // footer: if debug-mode { rect(width: 100%, height: 100%, stroke: debug-stroke) },
  )

  // paragraph formatting
  // decrease line spacing and text size when in draft mode
  let leading = 0.65em
  if draft-mode {
    text-size = 9pt
    leading = 0.5em
  }
  set par(
    justify: true,
    leading: leading,
  )

  // figures
  show figure: it => {
    set align(center) // aligns whole figure on page
    show figure.caption: it => [
      #set align(left) // align the caption to the left
      #set text(size: 0.85em)
      #set text(weight: "semibold")
      #it.supplement
      #context it.counter.display(it.numbering)
      #h(0.3em)
      #set text(weight: "regular")
      #it.body
    ]
    [
      #v(
        1.5em,
        weak: true,
      )
      #box(inset: 1em)[
        #it.body
        #v(
          1em,
          weak: true,
        )
        // Fig. #it.caption
        #it.caption
      ]
      #v(
        2em,
        weak: true,
      )
    ]
  }

  // list indentation
  set enum(indent: 1em)
  set list(indent: 1em)

  // tables
  show table: set text(size: 0.75em)
  set table(
    align: center + horizon,
    stroke: 0.5pt + cdgray,
    fill: (
      x,
      y,
    ) => if y == 0 {
      cdgray.lighten(80%)
    },
  )
  show table.cell.where(y: 0): set text(weight: "semibold")

  // link formatting
  show link: it => {
    if type(it.dest) != str {
      // internal document links, e.g. to sections
      it
    } else {
      // external links, e.g. mailto or http
      // put an arrow after link
      if not print-mode {
        [#it#super(
          baseline: -1em,
          size: 0.5em,
          sym.arrow.tr,
        )]
      } else {
        it
      }
    }
  }

  // title page
  [
    #set page(
        margin: (left: X + BCOR), // all other margins stay the same as default
        header-ascent: 0pt,
        header: [
            // INFO: the header is inside top margin of the page!
            // therefore the page margin values have to be subtracted
            // to get the correct header margins
            #grid(
                columns: (T - X, 1fr), // T-X, rest of width
                rows: (Y, K - Y - 5mm, 5mm), // 5mm for the Faculty line
                gutter: 0pt,
                align: top+left,
                stroke: debug-stroke,
                inset: 0pt,
                [], // empty cell
                [], // empty cell
                grid.cell(
                    colspan: 2,
                    image("logos/TU_Dresden_Logo_schwarz.svg", width: B),
                ),
                [], // empty cell
                align(horizon,
                  text(size: 9pt, fill: cdgray, weight: "semibold",
                    [#faculty / #institute / #chair]
                  )
                ),
            )
        ],
        numbering: none,
        // background: tud-gradient()
    )

    #set text(
      size: 1.25em,
      weight: "light",
      hyphenate: false,
    )
    #set par(justify: false)

    #block(
      width: 100%,
      height: 100%,
      stroke: debug-stroke,
      inset: (left: T - X),
      [

        #v(7em)

        #if draft-mode {
          align(
            center,
            text(
              size: 2em,
              weight: "regular",
              style: "italic",
              [– Draft #datetime.today().display() – ],
            ),
          )
        }

        #ifnn-line(
          text(
            weight: "medium",
            graduation,
          ),
        )

        #v(1em)
        // title & subtitle
        #text(
          size: 2em,
          weight: "semibold",
          title,
        ) \
        #if subtitle != none {
          v(0em)
          text(
            size: 1.5em,
            subtitle,
          )
        }

        #v(1em)
        #ifnn-line(
          text(
            weight: "medium",
            author,
          ),
        )

        // personal details
        #if dateofbirth != none {
          [Born on: #dateofbirth in #placeofbirth \ ]
        }

        #if matriculationnumber != none {
          [Matriculation number: #matriculationnumber \ ]
        }

        #if matriculationyear != none {
          [Matriculation year: #matriculationyear \ ]
        }

        #if email != none {
          [E-mail: #link("mailto:"+email) \ ]
        }

        // pushes supervisors to bottom
        #v(1fr)

        // supervisor & professor
        #if supervisor != none {
          [Supervisor \ ]
          text(
            weight: "medium",
            supervisor,
          )
        }
        #v(0.1em)
        #if professor != none {
          [Supervising Professor \ ]
          text(
            weight: "medium",
            professor,
          )
        }
      ],
    )
  ]

  empty-page(insert: print-mode)

  // include assignment
  // INFO: embedding of PDFs is not yet possible with typst
  // you must convert the assignment document to a PNG or SVG beforehand
  if show-assignment and not draft-mode {
    set page(margin: (0mm))
    pagebreak(weak: true)
    set page(numbering: none)

    if assignment-file != none {
      image(
        assignment-file,
        width: 100%,
        height: 100%,
      )
    } else {
      set align(center + horizon)
      set text(
        size: 2em,
        fill: red,
      )
      rect(
        width: 100%,
        height: 100%,
        stroke: 10pt + red,
        [
          *Include Assignment Document*
          \
          \
          embedding of PDFs is not yet possible with Typst,
          \
          convert the assignment PDF \
          to a PNG or SVG file beforehand
          \
          \
          use `assignment-file` to set the assignment's file path:
          ```typst
          #show: thesis.with(
              …
              assignment-file: "../assignment.png",
              …
          )
          ```
          \
          set `show-assignment: false` if you don't want \
          to include the assignment document:
          ```typst
          #show: thesis.with(
              …
              show-assignment: false,
              …
          )
          ```
        ],
      )
    }

    empty-page(insert: print-mode)
  }

  // declaration of independent work
  if show-statement-of-authorship and not draft-mode {
    pagebreak(weak: true)
    set page(numbering: none)

    v(8em)

    heading(
      outlined: false,
      numbering: none,
      [Statement of authorship],
    )

    if statement-of-authorship == none {
      let statement-of-authorship-title = title
      if alttitle != none {
        statement-of-authorship-title = alttitle
      }
      [
        I hereby certify that I have authored this document entitled
        #v(1em)
        #h(3em) #statement-of-authorship-title
        #v(1em)
        independently and without undue assistance from third parties.
        No other than the resources and references indicated in this document have been used.
        I have marked both literal and accordingly adopted quotations as such.
        During the preparation of this document I was only supported
        by the following persons:
        #v(1em)
        #h(3em) #supervisor
        #v(1em)
        Additional persons were not involved in the intellectual preparation of the present document.
        I am aware that violations of this declaration may lead to subsequent withdrawal of the academic degree.
        #v(5em)
        #author
      ]
    } else {
      statement-of-authorship
    }

    empty-page(insert: print-mode)
  }

  // abstract
  if abstract != none {
    pagebreak(weak: true)
    set page(footer: [])

    heading(
      outlined: false,
      numbering: none,
      [Abstract],
    )

    // set font for abstract body text
    set text(font: if cdfont {
      sans-font
    } else {
      serif-font
    })
    abstract

    empty-page(insert: print-mode)
  }

  // outline
  // show level 1 titles larger and bold
  show outline.entry.where(level: 1): it => {
    v(
      1.2em,
      weak: true,
    )
    strong(it)
  }
  outline(indent: true)
  pagebreak(weak: true)

  empty-page(insert: print-mode)

  // start a new page for new chapters and
  // add some spacing around chapter headings
  show heading.where(level: 1): it => {
    if not draft-mode {
      pagebreak(weak: true)
      v(5em)
      it
      v(1em)
    } else {
      v(1em)
      it
    }
  }

  // headings always use a sans font
  show heading: set text(font: sans-font)
  // font size for heading levels
  show heading.where(level: 1): set text(
    size: 1.5em,
    weight: "semibold",
  )
  show heading.where(level: 2): set text(size: 1.25em)
  show heading.where(level: 3): set text(size: 1em)
  set heading(numbering: "1.1")

  // set font for body text
  set text(font: if cdfont {
    sans-font
  } else {
    serif-font
  })

  // main body
  body

  // display bibliography
  if bibliography-file != none {

    show bibliography: it => {
      set text(
        size: text-size,
        ligatures: false,
      )
      show heading: set text(size: 1.25em)
      it
    }

    // show bibliography: set text(
    //   size: text-size,
    //   ligatures: false,
    // )

    pagebreak(weak: true)
    bibliography(
      bibliography-file,
      title: "References",
      style: bibliography-style,
    )
    pagebreak(weak: true)
  }

  // list of figures
  listing(
    "List of Figures",
    image,
    text-size,
  )

  // list of tables
  listing(
    "List of Tables",
    table,
    text-size,
  )

  // list of code
  listing(
    "List of Code",
    raw,
    text-size,
  )

  // list of acronyms
  list-acr(acronyms)

  if draft-mode and debug-mode {
    debug-info(
      cdfont,
      sans-font,
      serif-font,
    )
  }
}
