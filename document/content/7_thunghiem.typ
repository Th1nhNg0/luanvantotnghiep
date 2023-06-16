= Thử nghiệm

== Xây dựng bộ dữ liệu văn bản luật

#let tvpl_loaivanban = csv("../data/tvpl_loaivanban.csv")
#let tvpl_linhvuc = csv("../data/tvpl_linhvuc.csv")


Theo dữ liệu Thư viện pháp luật#footnote([thuvienphapluat.vn là trang chuyên cung cấp cơ sở dữ liệu, tra cứu và thảo luận pháp luật]), hiện nay Việt Nam có khoảng 303936 văn bản vi phạm pháp luật. Bao gồm #tvpl_loaivanban.len() loại văn bản và #tvpl_linhvuc.len() lĩnh vực khác nhau:

#figure(
  grid(
    columns: (1fr,1fr),
    column-gutter: 10pt,
    table(
      columns: (1fr,1fr),
      [*Loại văn bản*], [*Số lượng*],
      ..tvpl_loaivanban.slice(0, calc.floor(tvpl_loaivanban.len()/2)).flatten()
    ),
    table(
      columns: (1fr,1fr),
      [*Loại văn bản*], [*Số lượng*],
      ..tvpl_loaivanban.slice(calc.floor(tvpl_loaivanban.len()/2), tvpl_loaivanban.len()).flatten()
    ),
  ),
  caption: [
    Số lượng văn bản vi phạm pháp luật theo loại văn bản
  ]
)

#figure(
  grid(
    columns: (1fr,1fr),
    column-gutter: 10pt,
    table(
      columns: (1fr,1fr),
      [*Loại văn bản*], [*Số lượng*],
      ..tvpl_linhvuc.slice(0, calc.ceil(tvpl_linhvuc.len()/2)).flatten()
    ),
    table(
      columns: (1fr,1fr),
      [*Loại văn bản*], [*Số lượng*],
      ..tvpl_linhvuc.slice(calc.ceil(tvpl_linhvuc.len()/2), tvpl_linhvuc.len()).flatten()
    ),
  ),
  caption: [
    Số lượng văn bản vi phạm pháp luật theo lĩnh vực
  ]
)


== Xây dựng bộ dữ liệu câu hỏi luật

== Tra cứu văn bản luật bằng ChatGPT API