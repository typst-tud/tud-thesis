// utility and helper functions
#import "colors.typ" as colors: *

// output line if not none
#let ifnn-line(
  e,
) = if e != none [#e \ ]

// create the TUD CD gradient
#let tud-gradient(
  width: 100%,
  height: 100%,
) = {
  rect(
    width: width,
    height: height,
    fill: gradient.linear(
      cddarkblue,
      cdblue,
      angle: 45deg,
    ),
  )
}

// insert empty page
#let empty-page(insert: false, to: "odd") = {
  if insert {
    set page(numbering: none)
    pagebreak(to: to)
  }
}


/*
* Figures and Listings
*/
// allow for flexible captions of figures
// e.g. a long caption in the body and a short caption for the list of figures
// source: https://github.com/typst/typst/issues/1295#issuecomment-2085030750
#let in-outline = state(
  "in-outline",
  false,
)
#let flex-caption(
  long,
  short,
) = (
  context if in-outline.get() {
    short
  } else {
    long
  }
)

// listing helper function
// listing("List of Figures", image)
// kind can be image, table, code or a custom kind
#let listing(
  title,
  kind,
  text-size,
) = {
  // only display if there is something to list
  context if counter(
    figure.where(kind: kind),
  ).get().at(0) > 0 {
    set text(size: text-size)

    // get short caption if available and
    // set heading size
    show outline: it => {
      show heading: set text(size: 1.25em)
      in-outline.update(true)
      it
      in-outline.update(false)
    }

    show outline.entry.where(level: 1): it => {
      v(
        1.2em,
        weak: true,
      )
      // because the outline show definitions stack we
      // need to negate strong() (weight delta +300)
      strong(
        delta: -300,
        it,
      )
    }

    outline(
      title: title,
      target: figure.where(kind: kind),
    )
    pagebreak(weak: true)
  }
}

/*
* Acronyms
* acronyms have to be defined in the dictionary `acronyms`
* we recommend to create a separate file for the dict
*/
// TODO: make acronyms accessable, maybe use state?
// #let acr(
//   it,
// ) = link(
//   label(it),
// )[ #acronyms.at(it) (#it) ]

// list acronyms
#let list-acr(
  acronyms,
) = {
  if acronyms == none {
    return
  }

  // sort keys by first letter
  // but sort case insensitive
  let keys_dict = (:)
  for k in acronyms.keys() {
    keys_dict.insert(
      lower(k),
      k,
    )
  }

  // lowercase keys sorted
  let keys_lc_sorted = keys_dict.keys().sorted()

  let list = ()
  for k in (keys_lc_sorted) {
    let k = keys_dict.at(k)
    list.push(
      table.cell([
        #strong(k)#label(k)
      ]),
    )
    list.push(
      table.cell(
        // only get the singular definition at position 0
        acronyms.at(k).at(0),
      ),
    )
  }

  heading(
    outlined: false,
    numbering: none,
    [List of Acronyms],
  )

  columns(2)[
    #table(
      columns: 2,
      rows: keys_lc_sorted.len(),
      stroke: 1pt + cdgray,
      align: (
        right,
        left,
      ),
      table.header(
        [*Acronym*],
        [*Definition*],
      ),
      ..list,
    )
  ]
}

/*
* Debugging
* show some debug infos
*/
#let debug-info(
  cdfont,
  sans-font,
  serif-font,
) = {
  // font comparison
  let blind-text = [
    cdfont = #cdfont \
    text.size = #context text.size\
    text.font = #context text.font\

    abcdefghijklmnopqrstuvwxyzß \
    ABCDEFGHIJKLMNOPQRSTUVWXYZẞ

    0123456789 \
    0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20

    1/2 1/3 1/4 100/123 \
    5m 5mm 5cm

    #lorem(50)

    #lorem(75)

    #lorem(20)
  ]

  grid(
    columns: (
      1fr,
      1fr,
    ),
    text(
      font: sans-font,
      size: 11pt,
      blind-text,
    ),
    text(
      font: serif-font,
      size: 11pt + 0.75pt,
      blind-text,
    ),
  )
}
