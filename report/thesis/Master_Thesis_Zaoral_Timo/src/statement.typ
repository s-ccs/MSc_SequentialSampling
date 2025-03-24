#import "translations/translations.typ": translate
#import "utils.typ": name-with-titles

#let statement = () => {
  heading("Declaration:", outlined: false, depth: 2)
  translate("statement-own-work")
  v(3em)
    grid(
    columns: (1fr, 1fr),
    align: (left, center),
    [Date and Signature: ],
  )
  v(15em)
  heading("Erklärung:", outlined: false, depth: 2)
  translate("statement-own-work-de")
    v(3em)
    grid(
    columns: (1fr, 1fr),
    align: (left, center),
    [Datum und Unterschrift: ],
  )
}