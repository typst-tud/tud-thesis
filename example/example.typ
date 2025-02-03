#import "../tud-thesis.typ": *

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
  show-assignment: true,
  // assignment-file: "assignment.svg",

  cdfont: true,
  draft-mode: false,
  print-mode: true,
  debug-mode: false,
)

= Some Typst hints
== References
See #link("https://typst.app/docs/reference/model/cite/") for more details.

References to sources look like this @examplebib2024.
```typst
References to sources look like this @examplebib2024.
```


== Links
See #link("https://typst.app/docs/reference/model/link/") for more details.

This is an external link to the web page of #link("https://tu-dresden.de")[Technische Universität Dresden]. This one is an internal link to chapter #link(<cha:evaluation>)[Evaluation].

```typst
This is an external link to the web page of #link("https://tu-dresden.de")[Technische Universität Dresden]. This one is an internal link to chapter #link(<cha:evaluation>)[Evaluation].
```

== Figures
See #link("https://typst.app/docs/reference/model/figure/") for more details.

=== Images
#figure(
  // image("", width: 100%),
  rect(width: 100%, height: 7em, stroke: 3pt + cddarkblue, fill: cdblue),
  caption: [A curious figure.],
) <glacier>

```typst
#figure(
  image("figures/glacier.jpg", width: 80%),
  caption: [A curious figure.],
) <glacier>
```

=== Tables
#figure(
  table(
    columns: 4,
    [t],
    [1],
    [2],
    [3],

    [y],
    [0.3s],
    [0.4s],
    [0.8s],
  ),
  caption: [A table of measurements],
)


=== Code
Use single backticks to show code inline: \` fn main() \`
Use triple backticks to show code as a block:
\`\`\`rust
    fn main() {
        println!("Hello World!");
    }
\`\`\`

#figure(
  ```rust
    fn main() {
        println!("Hello World!");
    }
  ```,
  caption: [Magnificent code],
)

```typst
` ` `rust
    fn main() {
        println!("Hello World!");
    }
` ` `
```

== Math
See #link("https://typst.app/docs/reference/math/") for more details.

$
  a^2 + b^2 = c^2
$
```typst
$
  a^2 + b^2 = c^2
$
```

$ sqrt(3 - 2 sqrt(2)) = sqrt(2) - 1 $
```typst
$ sqrt(3 - 2 sqrt(2)) = sqrt(2) - 1 $
```

$ integral_a^b f(x) dif x $
```typst
$ integral_a^b f(x) dif x $
```

= Introduction
<cha:introduction>

#lorem(100)

= Background
<cha:background>

#lorem(200)

== Background to this
#lorem(300)

== Background to that
#lorem(500)

= Requirements and Related Work
<cha:requirements_and_related_work>

#lorem(100)

= Design
<cha:design>

#lorem(200)

== Really thougt about it
#lorem(1000)

== Why its a great design
#lorem(200)

== What are its pittfalls
#lorem(750)

= Implementation
<cha:implementation>

#lorem(1000)

= Evaluation
<cha:evaluation>

#lorem(200)

= Conclusion
<cha:conclusion>

#lorem(100)

