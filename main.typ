#import "template/cover.typ": cover
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
    numbering: "1.1",
)

#set par(
    justify: true
)

#cover(
    "Ngô Phú Thịnh",
    "Deep Learning in the Legal System: Opportunities and Challenges"
)

#include "content/loicamon.typ"
#outline(indent: true)
#pagebreak()
#include "content/loinoidau.typ"
