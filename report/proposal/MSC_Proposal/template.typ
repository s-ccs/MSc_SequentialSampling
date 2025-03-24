// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(title: "", subtitle: "", authors: "", date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "New Computer Modern", lang: "en")
  show math.equation: set text(weight: 400)
  set heading(numbering: "1.1")

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(1.5em, weak: true)
    #block(text(weight: 400, 1.75em, subtitle))
    #v(2em, weak: true)
  ]

  align(center)[
      #authors
      #v(1em, weak: true)
      #date
  ]
  // Main body.
  set par(justify: true)

  body
}