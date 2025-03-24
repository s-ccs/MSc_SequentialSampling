#let general-styles = rest => {
  set par(justify: true)

  show emph: it => {
    text(it, spacing: 4pt)
  }

  show link: underline
  show heading.where(level: 1): it => {
    pagebreak()
    text(it, size: 1.6em)
    v(14pt)
  }

  show heading.where(level: 2): it => {
    text(it, size: 1.3em)
    v(6pt)
  }

  show heading.where(level: 3): it => {
    text(it, size: 1.1em)
    v(6pt)
  }

  show figure: it => {
    it
    v(20pt)
  }

  rest
}