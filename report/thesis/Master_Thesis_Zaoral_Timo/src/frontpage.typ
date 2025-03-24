#import "translations/translations.typ": translate
#import "utils.typ": name-with-titles

#let signature = person => [
  #line(length: 90%, stroke: 0.5pt)

  #person.at("name", default: "")
]

#let frontpage(
  font,
  author,
  advisor,
  assistants,
  reviewers,
  show-curriculum,
  date,
) = {
  text(font: font)[
    #align(center)[
      #box()[
        #image("graphics/unistuttgart_logo_englisch.png", alt: "Logo University of Stuttgart")
      ]
      #v(2em)
        //#show par: set block(spacing: 1.5em)
      Institute for Visualization and Interactive Systems
      #v(1em)
      Universitätstraße 38
      
      70569 Stuttgart

      #v(5em)
      
      #text(translate("thesis-type"), size: 1.2em, weight: "bold")
      
      #box(width: 70%, height: 1em)[
        #text(translate("title"), size: 1.5em, weight: "bold")
      ]

      #v(4em)
      #name-with-titles(author)
      
      #v(18em)
      #grid(
        columns: 2,
        align: left,
        gutter: 1cm,
        ..(text("Course of Study:", weight: "bold"), text(translate("academic-title")+ " " +translate("curriculum")),
        text("Examiner:", weight: "bold"), name-with-titles(advisor),
        text("Supervisor:", weight: "bold"), name-with-titles(advisor),
        text("Commenced:",weight: "bold"), "15.10.2024",
        text("Completed:",weight: "bold"), "15.04.2025")
      )
    ]
  ]
}