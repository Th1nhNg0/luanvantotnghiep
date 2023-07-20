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
    title: "Deep learning in legal system: Opportunities and Challenges"
)


#set page(
    paper:"a4",
    margin: (
      inside: 2.5cm,
      outside: 2cm,
    )
)

#set text(size:13pt,
        font: "TeX Gyre Pagella",
        lang:"vi",
)
#show raw:set text(font: "Courier New")
#show table: set par(justify: false)
#show table: set text(size:12pt,spacing:90%)

#set cite(
    style: "numerical",
)
#set par(
    justify: true,
)

#include "./content/1_cover.typ"
#pagebreak()
#include "./content/2_loicamon.typ"

#counter(page).update(1)
#set page(
    header: getHeader(),
    numbering: "1",
)

#outline(indent: true)
#pagebreak()
#outline(
    title: [Danh mục bảng biểu],
    target: figure.where(kind: table)
)

#outline(
    title: [Danh mục hình ảnh],
    target: figure.where(kind: image)
)


#pagebreak()
#include "./content/3_loinoidau.typ"
#set heading(
    numbering: "1.1.1.a.",
)

#include "./content/4_kienthucchuanbi.typ"
#include "./content/5_ungdung_thachthuc.typ"
#include "./content/7_thunghiem/main.typ"
#include "./content/8_ketluan.typ"

#pagebreak()


#set text(size:12.5pt)
#bibliography("ref.bib") 
