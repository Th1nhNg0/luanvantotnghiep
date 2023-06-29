#let buildMainHeader(mainHeadingContent, ) = {
  [
    #smallcaps(mainHeadingContent)  #h(1fr)  #emph([Ngô Phú Thịnh]) 
    #line(length: 100%)
  ]
}

#let getHeader() = {
  locate(loc => {
    // Find if there is a level 1 heading on the current page
    let nextMainHeading = query(selector(heading).after(loc), loc).find(headIt => {
     headIt.location().page() == loc.page() and headIt.level == 1
    })
    if (nextMainHeading != none) {
      return buildMainHeader(nextMainHeading.body)
    }
    // Find the last previous level 1 heading -- at this point surely there's one :-)
    let lastMainHeading = query(selector(heading).before(loc), loc).filter(headIt => {
      headIt.level == 1
    }).last()
    return buildMainHeader(lastMainHeading.body)
  })
}


#set document(
    author: "Ngô Phú Thịnh",
    title: "Deep Learning in the Legal System of Vietnam: Opportunities and Challenges"
)


#set page(
    paper:"a4",
    margin: 2.5cm,
    numbering: "1",
)
#set text(size:13pt,
        font: "Times New Roman",
        lang:"vi",
        )
#show raw:set text(font: "Courier New")

#set cite(
    style: "numerical",
)
#set par(
    justify: true
)

#include "./content/1_cover.typ"
#include "./content/2_loicamon.typ"
#outline(indent: true)
#pagebreak()
#include "./content/3_loinoidau.typ"
#set heading(
    numbering: "1.1.1.a.",
)
#set page(
    header: getHeader()
)
#include "./content/4_kienthucchuanbi.typ"
#include "./content/5_ungdung_thachthuc.typ"
#include "./content/7_thunghiem/main.typ"
#include "./content/8_ketluan.typ"

#pagebreak()
#outline(
    title: [Phụ lục],
    target: figure
)
#pagebreak()
#bibliography("ref.bib",style:"ieee")
