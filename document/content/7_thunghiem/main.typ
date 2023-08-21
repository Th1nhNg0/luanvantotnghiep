#pagebreak()
= Thử nghiệm <phan3>

Từ những gì đã làm được trong bài báo *Intelligent Retrieval System on Legal Information* @mypaper ở hội thảo khoa học quốc tế *ACIIDS* #footnote([ACIIDS ( Asian Conference on Intelligent Information and Database Systems ) là hội thảo khoa học quốc tế về nghiên cứu trong lĩnh vực hệ thống thông tin và cơ sở dữ liệu thông minh, được tổ chức từ ngày 24 đến ngày 26 tháng 7 năm 2023 tại Phuket, Thái Lan.]), cùng với thầy Nguyễn Thanh Bình và các cộng sự, tôi tiếp tục phát triển các bộ dữ liệu về luật với chủ đề là bảo hiểm xã hội.

Phần cứng sử dụng:

- CPU: Intel Core i5-12400F
- GPU: RTX 3060, riêng fine-tuning sử dụng 4 GPU RTX 4090
- RAM: 32GB DDR4


Trong phạm vi của bài luận này, tôi chỉ sử dụng các văn bản liên quan tới lĩnh vực bảo hiểm xã hội và việc làm, bao gồm 761 điều luật để thử nghiệm và đánh giá. Một số văn bản luật:

#let luat_su_dung=csv("../../data/luat_su_dung.csv")
#list(
  ..luat_su_dung.flatten()
)


#include "./1_xay_dung_dataset_luat.typ"
#include "./2_xay_dung_dataset_qa.typ"
#include "./3_infomation_retrieval.typ"

