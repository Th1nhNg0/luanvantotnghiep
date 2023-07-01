== Xây dựng bộ dữ liệu văn bản vi phạm pháp luật <datasetluat>

=== Sơ lược về dữ liệu <soluocdulieu>

#let tvpl_loaivanban = csv("../../data/tvpl_loaivanban.csv")
#let tvpl_linhvuc = csv("../../data/tvpl_linhvuc.csv")


Theo dữ liệu từ Thư viện pháp luật#footnote([thuvienphapluat.vn là trang chuyên cung cấp cơ sở dữ liệu, tra cứu và thảo luận pháp luật]), hiện nay Việt Nam có trên dưới 303936 văn bản vi phạm pháp luật. Bao gồm #tvpl_loaivanban.len() loại văn bản và #tvpl_linhvuc.len() lĩnh vực khác nhau:


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
#[
#set par(justify: false)
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
]

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



=== Xây dựng cơ sở dữ liệu

*Cấu trúc dữ liệu* của datasets gồm 3 bảng chính: `VanBan`, `LuocDo`, `ChiMuc` được mô tả như sau:

#figure(
  table(
    columns: (auto,auto,1fr),
    align: left,
    [*Tên trường*], [*Kiểu dữ liệu*], [*Mô tả*],
    [id], [integer (PK)], [ID của văn bản],
    [ten_van_ban], [string], [Tên văn bản],
    [so_hieu_van_ban], [string], [Số hiệu văn bản],
    [loai_van_ban], [string], [Loại văn bản],
    [noi_ban_hanh], [string], [Nơi ban hành],
    [nguoi_ky], [string], [Người ký],
    [ngay_ban_hanh], [date], [Ngày ban hành],
    [ngay_hieu_luc], [date], [Ngày hiệu lực],
    [ngay_cong_bao], [date], [Ngày công báo],
    [so_cong_bao], [string], [Số công báo],
    [noi_dung_van_bang], [string], [Nội dung văn bản dạng text],
    [linh_vuc], [string], [Lĩnh vực của văn bản],
  ),
  caption: [
    Bảng `VanBan` chứa thông tin về văn bản vi phạm pháp luật
  ]
)

#figure(
  table(
    align: left,
    columns: (auto,auto,1fr),
    [*Tên trường*], [*Kiểu dữ liệu*], [*Mô tả*],
    [source], [integer (FK)], [ID của văn bản nguồn],
    [target], [integer (FK)], [ID của văn bản đích],
    [loai_quan_he], [string], [Loại quan hệ giữa văn bản nguồn và văn bản đích. VD: thay thế, hướng dẫn, sửa đổi bổ sung...],
  ),
  caption: [
   Bảng `LuocDo` chứa thông tin về mối quan hệ giữa các văn bản vi phạm pháp luật
  ]
)

#figure(
  table(
    align: left,
    columns: (auto,auto,1fr),
    [*Tên trường*], [*Kiểu dữ liệu*], [*Mô tả*],
    [ten_chi_muc], [string], [Tên của chỉ mục],
    [loai_chi_muc], [string], [Loại của mục lục. VD: phần, chương, mục, điều, khoản, điểm...],
    [start_index], [integer], [Vị trí bắt đầu của nội dung của chỉ mục trong văn bản],
    [end_index], [integer], [Vị trí kết thúc của nội dung của chỉ mục trong văn bản],
    [parent_id], [integer (FK)], [ID của chỉ mục cha (nếu có), thể hiển tree structure#footnote([Tree structure hay cây là một cấu trúc dữ liệu được sử dụng rộng rãi gồm một tập hợp các nút (node) được liên kết với nhau theo quan hệ cha-con]).],
    [vanban_id], [integer (FK)], [ID của văn bản],
  ),
  caption: [
    Bảng `ChiMuc`: chứa thông tin về mục lục của văn bản vi phạm pháp luật.
  ]
)

#figure(
  image("../../images/csdl.svg", width: 70%, ),
  caption: [
    Cấu trúc dữ liệu của cơ sở dữ liệu văn bản vi phạm pháp luật
  ]
)

*Xử lý văn bản:* Văn bản sau khi tải xuống có định dạng HTML#footnote([HTML là viết tắt của cụm từ Hypertext Markup Language (tạm dịch là Ngôn ngữ đánh dấu siêu văn bản). HTML được sử dụng để tạo và cấu trúc các thành phần trong trang web hoặc ứng dụng, phân chia các đoạn văn, heading, titles, blockquotes…]), do đó cần phải xử lý để lấy được nội dung văn bản dạng text. Để làm được điều này, tôi sử dụng thư viện BeautifulSoup@richardson2007beautiful để lấy nội dung dạng text của văn bản.

#let example_text = read("../../data/luat-bao-hiem-xa-hoi-2014/content.txt")
#let example_text=example_text.split("\n")

#figure(
  block(
    stroke: 1pt,
    inset: 10pt,
    align(left)[#example_text.slice(0,18).join("\n")......]
  ),
  caption: [
    Văn bản sau khi xử lý 
  ]
)

*Tạo mục lục:* để tạo chỉ mục cho văn bản, tôi sử dụng regex#footnote([Regex là một chuỗi các ký tự đặc biệt được định nghĩa để tạo nên các mẫu (pattern) và được sử dụng để tìm kiếm và thay thế các chuỗi trong một văn bản]) để tìm kiếm các chỉ mục trong văn bản. Như đã nêu trong @soluocdulieu các regex để tìm chỉ mục là:


#figure(
  table(
    columns: (auto,auto,1fr),
    align: left + horizon,
    [*Regex*],[*Loại chỉ mục*],[*Chú giải*],
    [^(Phần thứ [\\d\\w]+.\*)\$],[Phần],[Tìm các chỉ mục có dạng "Phần thứ \<số|chữ> \<nội dung>". Ví dụ:\ "Phần thứ nhất: Những quy định chung"],
    [^(Chương [\\d\\w]+.\*)\$],[Chương],[Tìm các chỉ mục có dạng "Chương \<số|chữ> \<nội dung>". Ví dụ:\ "Chương I: ĐIỀU KHOẢN CƠ BẢN"], 
    [^(Mục [\\d|I|V|X|L|C|D|M]+.\*)\$],[Mục],[Tìm các chỉ mục có dạng "Mục \<số|chữ số la mã> \<nội dung>". Ví dụ:\ "Mục 1. QUY ĐỊNH CHUNG VỀ QUYẾT ĐỊNH HÌNH PHẠT"],
    [^(Điều \\d+.\*)\$],[Điều],[Tìm các chỉ mục có dạng "Điều \<số> \<nội dung>". Ví dụ:\ "Điều 51. Các tình tiết giảm nhẹ trách nhiệm hình sự"],
    [^(\\d+\\. .\*)\$],[Khoản],[Tìm các chỉ mục có dạng "\<số>. \<nội dung>". Ví dụ:\ 1. Người phạm tội phải trả lại tài sản đã...],
    [^(\\w\\).\*)\$],[Điểm],[tìm các chỉ mục có dạng "\<chữ>. \<nội dung>". Ví dụ:\ a\) Người phạm tội đã ngăn chặn h...]
  ),
  caption: [
    Các regex để tìm chỉ mục trong văn bản
  ]
)

Phương pháp sử dụng regex tuy tốt nhưng vẫn chỉ là bán tự động, vì có một số trường hợp đặc biết vẫn cần sự can thiệp từ con người để có được kết quả tốt nhất.

Để đơn giản khi lập trình, tôi lưu kết quả sau khi xử lý thành định dạng JSON#footnote([JSON là viết tắt của Javascript Object Notation, là một bộ quy tắc về cách trình bày và mô tả dữ liệu trong một chuỗi lớn thống nhất được gọi chung là chuỗi JSON. Chuỗi JSON được bắt đầu bằng ký tự { và kết thúc bởi ký tự }]):

#let result = read("../../data/luat-bao-hiem-xa-hoi-2014/tree.json")
#figure(
  block(
    clip:true,
    stroke: 1pt,
    inset: 10pt,
    align(left)[#raw(result,lang: "json")]
  ),
  kind: image,
  caption: [
    Kết quả sau khi xử lý văn bản ở định dạng JSON
  ]
)

Sau khi xây dựng được datasets về luật, tôi có tạo thêm một python package dùng để truy vấn dữ liệu một cách dễ dàng @Ngo_LawQuery:

#figure(
  block(
    stroke: 1pt,
    inset: 10pt,
  )[```py
from lawquery import Engine

# create engine, law_id là số hiệu của văn bản luật
engine = Engine(law_id='58/2014/QH13')
# query single node
engine.query(node_type='điều', node_id='1')
# => [Điều 1. Phạm vi điều chỉnh]
engine.query(node_type='phần')
# => [Phần thứ nhất..., Phần thứ hai...]
engine.query(name='hôn nhân')
# => [Điều 67. Các trường hợp hưởng trợ cấp tuất hằng tháng]
# query by path: from parent to child
node = engine.query_by_path([
    {
        'node_type': 'phần',
        'node_id': 'hai'
    },
    {
        'node_type': 'chương',
        'node_id': 'I'
    },
    {
        'node_type': 'mục',
        'node_id': '1'
    },
    {
        'node_type': 'điều',
        'node_id': '50'
    }])
# => [Điều 50. Trợ cấp phục vụ]
node.content
# => Nội dung của điều luật
```],
  caption: [
    Sử dụng package `lawquery` để truy vấn dữ liệu
  ]
)