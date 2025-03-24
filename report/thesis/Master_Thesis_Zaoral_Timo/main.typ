#import "template/thesis.typ": *
#import "@preview/abbr:0.1.0"
#import "@preview/big-todo:0.2.0": *
#import "src/statement.typ": statement
#show: general-styles

#show: thesis.with(
  lang: "en",
  title: (en: "Simulation of EEG Activity based on Sequential Sampling Models"),
  subtitle: (:),
  thesis-type: (en: "Master Thesis"),
  academic-title: (en: "Master of Science"),
  curriculum: (en: "Wirtschaftsinformatik"),
  author: (name: "Timo Zaoral", student-number: 3670084),
  advisor: (name: "Benedikt Ehinger", pre-title: "Jun.-Prof. Dr."),
  assistants: (),
  reviewers: (),
  keywords: ("Lorem Ipsum"),
  font: "DejaVu Sans",
  date: datetime.today(),
)

#show: flex-caption-styles
#show: toc-styles
#show: front-matter-styles

// If you have non-image/table figures, you need to pass a "supplement", that is shown when referencing it (@my-alg). You can globally set this, e.g. for algorithms:
//#show figure.where(kind: "algorithm"): set figure(supplement: "Algorithm")

#abbr.make(
  ("SSM", "Sequential Sampling Model ", "Sequential Sampling Models "),
  ("DDM", "Drift Diffusion Model ","Drift Diffusion Models "),
  ("LBA", "Linear Ballistic Accumulator ","Linear Ballistic Accumulators "),
  ("EEG", "Electroencephalography ", "Electroencephalography "),
  ("ERP", "Event-related potentials ", "Event-related potentials "),
  ("CPP", "centro-parietal positivity "),
  ("KellyModel", "Advanced Drift Diffusion Model from Kelly et. al. ")
)

#include "content/front-matter.typ"
#outline()
#show outline: set heading(outlined: true)
#outline(title: [List of Figures], target: figure.where(kind: image))
#outline(title: [List of Tables], target: figure.where(kind: table))
// #outline(title: "List of Algorithms", target: figure.where(kind: "algorithm"))

#abbr.list()

#show: main-matter-styles
#show: page-header-styles

#for value in (1, 2, 3, 4, 5) {
  include "content/chapter_"+str(value)+".typ"
}
//#include "content/test.typ"

#show: back-matter-styles
#set page(header: none)

#bibliography("refs.bib", style: "american-psychological-association")

#show: appendix-styles

#include "content/appendix.typ"
#pagebreak()
#set heading(numbering: none)
#statement()