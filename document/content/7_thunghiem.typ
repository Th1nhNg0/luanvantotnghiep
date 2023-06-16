#pagebreak()
= Thử nghiệm

== Xây dựng bộ dữ liệu văn bản vi phạm pháp luật

=== Sơ lược về dữ liệu

#let tvpl_loaivanban = csv("../data/tvpl_loaivanban.csv")
#let tvpl_linhvuc = csv("../data/tvpl_linhvuc.csv")


Theo dữ liệu từ Thư viện pháp luật#footnote([thuvienphapluat.vn là trang chuyên cung cấp cơ sở dữ liệu, tra cứu và thảo luận pháp luật]), hiện nay Việt Nam có khoảng 303936 văn bản vi phạm pháp luật. Bao gồm #tvpl_loaivanban.len() loại văn bản và #tvpl_linhvuc.len() lĩnh vực khác nhau:

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
      align: center + horizon,
      columns: (1fr,1fr),
      [*Lĩnh vực*], [*Số lượng*],
      ..tvpl_linhvuc.slice(0, calc.ceil(tvpl_linhvuc.len()/2)).flatten()
    ),
    table(
      columns: (1fr,1fr),
      align: center + horizon,
      [*Lĩnh vực*], [*Số lượng*],
      ..tvpl_linhvuc.slice(calc.ceil(tvpl_linhvuc.len()/2), tvpl_linhvuc.len()).flatten()
    ),
  ),
  caption: [
    Số lượng văn bản vi phạm pháp luật theo lĩnh vực
  ]
)

Các thuộc tính của một văn bản quy phạm pháp luật gồm: tên văn bản, số hiệu văn bản, loại văn bản, nơi ban hành, người ký, ngày ban hành, ngày hiệu lực, ngày công báo, số công báo.

Ngoài ra các thuộc tính trên, còn có lược đồ thể hiện mối quan hệ giữa các văn bản quy phạm pháp luật dựa trên _văn bản đang tham chiếu_:

- Văn bản được hướng dẫn: là văn bản ban hành trước, có hiệu lực pháp lý cao hơn _Văn bản tham chiếu_ và được _Văn bản tham chiếu_ hướng dẫn hoặc quy định chi tiết nội dung của nó.
- Văn bản được hợp nhất: Là văn bản ban hành trước, bao gồm các văn bản được sửa đổi, bổ sung và văn bản sửa đổi, bổ sung, được _Văn bản tham chiếu_ hợp nhất nội dung lại với nhau.
- Văn bản bị sửa đổi bổ sung: Là văn bản ban hành trước, bị _Văn bản tham chiếu_ sửa đổi, bổ sung một số nội dung.
- Văn bản bị đính chính: Là văn bản ban hành trước, bị _Văn bản tham chiếu_ đính chính các sai sót như căn cứ ban hành, thể thức, kỹ thuật trình bày,…
- Văn bản bị thay thế: Là văn bản ban hành trước, bị _Văn bản tham chiếu_ quy định thay thế, bãi bỏ toàn bộ nội dung.
- Văn bản được dẫn chiếu: Là văn bản ban hành trước, trong nội dung của _Văn bản tham chiếu_ có quy định dẫn chiếu trực tiếp đến điều khoản hoặc nhắc đến nó.
- Văn bản được căn cứ: Là văn bản ban hành trước _Văn bản tham chiếu_, bao gồm các văn bản quy định thẩm quyền, chức năng của cơ quan ban hành _Văn bản tham chiếu_ văn bản có hiệu lực pháp lý cao hơn quy định nội dung, cơ sở để ban hành _Văn bản tham chiếu_.
- Văn bản liên quan ngôn ngữ: Là bản dịch Tiếng Anh của _Văn bản tham chiếu_.
- Văn bản hướng dẫn: Là bản tiếng Việt của _Văn bản tham chiếu_.
- Văn bản hợp nhất: Là văn bản ban hành sau, hợp nhất lại nội dung của _Văn bản tham chiếu_ và văn bản sửa đổi, bổ sung của _Văn bản tham chiếu_.
- Văn bản sửa đổi bổ sung: Là văn bản ban hành sau, sửa đổi, bổ sung một số nội dung của _Văn bản tham chiếu_.
- Văn bản đính chính: Là văn bản ban hành sau, nhằm đính chính các sai sót như căn cứ ban hành, thể thức, kỹ thuật trình bày,...của _Văn bản tham chiếu_.
- Văn bản thay thế: Là văn bản ban hành sau, có quy định đến việc thay thế, bãi bỏ toàn bộ nội dung của _Văn bản tham chiếu_
- Văn bản liên quan cùng nội dung: Là văn bản có nội dung tương đối giống, hoặc có phạm vi điều chỉnh, đối tượng điều chỉnh tương tự _Văn bản tham chiếu_.

Mục lục của văn bản là phần quan trọng không thể thiếu. Tuy nhiên không phải văn bản nào cũng có mục lục, và cũng không có một định dạng chuẩn cho mục lục. Các chỉ mục thường thấy là: phần, chương, mục, điều, khoản, điểm.



=== Cấu trúc dữ liệu

#figure(
  image("../images/csdl.svg", width: 70%, ),
  caption: [
    Cấu trúc dữ liệu của văn bản vi phạm pháp luật
  ]
)



Trong phạm vi của bài luận này, tôi chỉ sử dụng các văn bản liên quan tới lĩnh vực bảo hiểm xã hội và việc làm để thử nghiệm và đánh giá:

#let luat_su_dung=csv("../data/luat_su_dung.csv")
#list(
  ..luat_su_dung.flatten()
)





== Xây dựng bộ dữ liệu câu hỏi luật

== Tra cứu văn bản luật bằng ChatGPT API