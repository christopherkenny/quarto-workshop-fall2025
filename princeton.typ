#import "@preview/polylux:0.4.0": *

// Color palette inspired by the original university theme
#let color-a = rgb("#e98338")
#let color-b = rgb("#010101")
#let color-c = rgb("#ffffff")

// add short names
#let short-author = "Christopher T. Kenny"
#let short-date = "2025-10-20"
#let short-title = "Reproducibility with Quarto"

// Progress bar
#let progress-bar = toolbox.progress-ratio( ratio => {
  //set grid.cell(inset: (y: 0em))
  grid(
    columns: (ratio * 100%, 1fr),
    rows: (0.1em),
    grid.cell(fill: color-a)[],
    grid.cell(fill: color-b)[],
  )
})

#let projector-theme = (doc) => {

  let slide-header = toolbox.next-heading(txt => {
    v(.1em)
    set align(horizon)
    toolbox.full-width-block()[#progress-bar]
    grid(
      columns: (60%, 1fr),
      align: (left, right),
      grid.cell(text(fill: color-a, size: 1.15em, weight: "semibold")[
        #txt
      ]),
      grid.cell(text(fill: color-b, size: 1.15em, weight: "semibold")[
        #toolbox.current-section
      ])
    )
  })

  let slide-footer = [
    #set align(bottom)
    #toolbox.full-width-block(inset: 0pt)[
      //#set text(size: 0.8em)
      #set align(horizon)
      #set text(fill: color-c)
      #grid(
        columns: (25%, 1fr, 15%, 10%),
        rows: (1.4em),
        align: (center, center, center, center),
        grid.cell(fill: color-a, stroke: color-a, short-author),
        grid.cell(fill: color-b, stroke: color-b, short-title),
        grid.cell(fill: color-b, stroke: color-b, short-date),
        grid.cell(fill: color-b, stroke: color-b, align: center)[#toolbox.slide-number]
      )
    ]
  ]

  set page(
    fill: color-c,
    header: slide-header,
    footer: slide-footer,
  )

  set text(fill: black, size: 1em)

  show raw: set text(fill: color-a)

  show heading.where(level: 1): set text(size: 0.5em)
  show heading.where(level: 1): hide

  doc
}

#let title-slide(title, subtitle, authors, date) = slide[
  #set page(footer: none)
  #set align(center + horizon)

  #v(1fr)
  #text(size: 3em, weight: "bold", fill: color-a)[#title]

  #if subtitle != none and subtitle != "" {
    text(size: 2em, fill: color-a)[#subtitle]
  }
  #v(1fr)
  #if authors != none and authors != [] {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: ncols,
      align: center,
      row-gutter: 1.5em,
      column-gutter: 1em,
      ..authors.map(author => [
        #set text(size: 2em)
        #author.name \
        #author.affiliation
      ])
    )
  }
  #if date != none and date != "" {
    text(size: 1em, fill: color-b)[#date]
  }
  #v(1fr)

  #place(bottom + right, image("DDSS-stacked_PU_shield_black.png", height: 10%))
]


#let toc-slide(toc_title) = slide[
  #set align(left + top)
  #text(size: 2em, weight: "bold", fill: color-a)[#toc_title]
  #v(0.8em)
  #set text(size: 1.5em)
  #toolbox.all-sections((sections, current) => {
    list(..sections)
  })
]

#let section-slide(name) = slide[
  #toolbox.register-section(name)
  #set align(left + horizon)
  #text(size: 1.75em, weight: "bold", fill: color-a)[#name]
  #rect(height: 1pt, width: 100%, fill: color-b)
]
