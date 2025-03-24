#import "../src/translations/translations.typ": init_translations
#import "../src/frontpage.typ": frontpage

#let thesis(
  lang: "en",
  title: (:),
  subtitle: (:),
  thesis-type: (en: "Master Thesis", de: "Masterarbeit"),
  academic-title: (en: "Master of Science", de: "Master of Science"),
  curriculum: none,
  author: (:),
  advisor: (:),
  assistants: (),
  reviewers: (),
  keywords: (),
  date: datetime.today(),
  font: "DejaVu Sans",
  doc,
) = {
  assert(lang in ("en", "de"))
  set text(lang: lang)
  let show-curriculum = curriculum != none

  let main-language-title = title.at("de", default: "")
  if lang == "en" {
    main-language-title = title.at("en", default: "")
    set text(region: "GB")
  }
  set document(
    title: main-language-title,
    author: author.at("name", default: none),
    keywords: keywords,
    date: date,
  )

  let additional-translations = (
    title: title,
    subtitle: subtitle,
    academic-title: academic-title,
    thesis-type: thesis-type,
    curriculum: curriculum,
  )
  init_translations(additional-translations)

  let filled-frontpage = frontpage.with(font, author, advisor, assistants, reviewers, show-curriculum, date)

  /*text(lang: "de")[
    #filled-frontpage()
    #pagebreak()
    #pagebreak()
  ]*/
  text(lang: "en")[
    #filled-frontpage()
    //#pagebreak()
  ]

  doc
}

// export styles
#import "../src/styles/all.typ": *