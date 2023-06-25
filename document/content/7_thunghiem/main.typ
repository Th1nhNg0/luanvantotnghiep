= Thử nghiệm

Phần cứng sử dụng:

- CPU: Intel Core i5-12400F
- GPU: RTX 3060, riêng fine-tuning sử dụng 4 GPU RTX 4090
- RAM: 32GB DDR4


Trong phạm vi của bài luận này, tôi chỉ sử dụng các văn bản liên quan tới lĩnh vực bảo hiểm xã hội và việc làm, bao gồm 761 điều luật để thử nghiệm và đánh giá:

#let luat_su_dung=csv("../../data/luat_su_dung.csv")
#list(
  ..luat_su_dung.flatten()
)


#include "./1_xay_dung_dataset_luat.typ"
#include "./2_xay_dung_dataset_qa.typ"
#include "./3_infomation_retrieval.typ"

