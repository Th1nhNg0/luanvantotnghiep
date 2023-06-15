#set page(
    paper:"a4",
    margin: 2.5cm,
    numbering: "1",
)
#set text(size:13pt,
        font:"Times New Roman",
        lang:"vi",
        )
#set heading(
    numbering: "1.1.1.a.",
)
#set cite(
    style: "numerical",
)
#set par(
    justify: true
)

#include "./content/cover.typ"
#include "./content/loicamon.typ"
#outline(indent: true)
#pagebreak()
#include "./content/loinoidau.typ"
#include "./content/kienthucchuanbi.typ"
#include "./content/ketluan.typ"

#pagebreak()
#outline(
    title: [Phụ lục],
    target: figure
)
#pagebreak()
#bibliography("ref.yml",style:"mla")
