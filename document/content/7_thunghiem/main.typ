= Thử nghiệm

Trong phạm vi của bài luận này, tôi chỉ sử dụng các văn bản liên quan tới lĩnh vực bảo hiểm xã hội và việc làm để thử nghiệm và đánh giá:

#let luat_su_dung=csv("../../data/luat_su_dung.csv")
#list(
  ..luat_su_dung.flatten()
)


#include "./1_xay_dung_dataset_luat.typ"


== Xây dựng bộ dữ liệu câu hỏi luật

Từ những gì đã làm được ở Intelligent Retrieval System on Legal Information@mypaper, tôi tiếp tục phát triển bộ dữ liệu câu hỏi về luật với chủ đề là bảo hiểm xã hội.

Bộ câu hỏi được lấy từ website #link("https://baohiemxahoi.gov.vn")[baohiemxahoi.gov.vn], cổng thông tin điện tử bảo hiểm xã hội Việt Nam.

== Information Retrieval

#let ketqua = csv("../../data/retrieval_result.csv")
//  round the score to 2 decimal places

#table(
    columns: 6,
    ..ketqua.flatten()
)

== Tra cứu văn bản luật bằng ChatGPT API