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

#include "./content/1_cover.typ"
#include "./content/2_loicamon.typ"
#outline(indent: true)
#pagebreak()
#include "./content/3_loinoidau.typ"
#include "./content/4_kienthucchuanbi.typ"
#include "./content/5_ungdung.typ"
#include "./content/6_thachthuc.typ"
#include "./content/7_thunghiem.typ"
#include "./content/8_ketluan.typ"

#pagebreak()
#outline(
    title: [Phụ lục],
    target: figure
)
#pagebreak()
#bibliography("ref.bib",style:"ieee")
