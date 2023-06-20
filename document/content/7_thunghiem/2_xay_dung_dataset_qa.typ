
== Xây dựng bộ dữ liệu hỏi đáp luật <datasetqa>

Từ những gì đã làm được ở Intelligent Retrieval System on Legal Information@mypaper, tôi tiếp tục phát triển bộ dữ liệu hỏi đáp về luật với chủ đề là bảo hiểm xã hội.

Bộ câu hỏi được lấy từ website #link("https://baohiemxahoi.gov.vn")[baohiemxahoi.gov.vn], cổng thông tin điện tử bảo hiểm xã hội Việt Nam. Bao gồm 19330 bộ câu hỏi-trả lời được phân vào nhiều lĩnh vực khác nhau, xem @chlv. Tôi chỉ lấy các data point mà câu trả lời có trích dẫn đến các văn bản luật, xem @chtl. Do đó, số lượng thật sự của bộ dữ liệu là 4368 câu hỏi.

#figure(
  image("../../images/cauhoitheolinhvuc.svg"),
  caption: [
    Số lượng câu hỏi theo lĩnh vực
  ]
) <chlv>

#figure(
  block(
    stroke: 1pt,
    inset: 10pt,
    
  )[
    #align(left)[
  *_Nội dung câu hỏi:_*\
Sổ BHXH của tôi đã được chốt tại BHXH Ba Đình - Hà Nội. Hiện tại tôi bị mất 2 tờ rời của sổ , tôi đang sinh sống ở tỉnh Long An thì có thể ra cơ quan BHXH của tỉnh để xin cấp lại tờ rời BHXH hay không? hay phải ra cơ quan BHXH đã chốt sỗ thì mới có thể xin cấp lại được? Xin cảm ơn

*_Câu trả lời:_*\
Theo quy định tại *Tiết a Điểm 2.1* và *Tiết a Điểm 2.2 Khoản 2 Điều 3 Văn bản hợp nhất số 2089/VBHN-BHXH* thì:
- BHXH huyện được cấp lại sổ BHXH cho người đang bảo lưu thời gian đóng BHXH, BHTN, BHTNLĐ, BNN ở huyện, tỉnh khác.
- BHXH tỉnh được cấp lại sổ BHXH cho người đã hưởng BHXH hoặc đang bảo lưu thời gian đóng BHXH, BHTN, BHTNLĐ, BNN ở huyện, tỉnh khác.

Đồng thời, theo quy định tại *Tiết a Điểm 1.1 Khoản 1 Điều 27 Văn bản hợp nhất số 2089/VBHN-BHXH* ngày 26/6/2020 của BHXH Việt Nam ban hành Quy trình thu BHXH, BHYT, BHTN, BHTNLĐ, BNN; quản lý sổ BHXH, thẻ BHYT thì hồ sơ để cấp lại sổ BHXH gồm Tờ khai tham gia, điều chỉnh thông tin BHXH, BHYT (Mẫu TK1-TS). Vì vậy, nếu Bạn thuộc các trường hợp nêu trên thì có thể nộp hồ sơ xin cấp lại sổ BHXH tại cơ quan BHXH ở Long An nơi Bạn đang sinh sống.
  ]],
  caption: [
    Ví dụ câu hỏi và câu trả lời
  ]
) <chtl>

Sau khi có được bộ dữ liệu hỏi đáp luật, tôi tiếp tục sử dụng Label Studio@LabelStudio để gán nhãn cho câu trả lời. Nhãn của câu trả lời là một danh sách các chỉ mục chứa nội dung liên quan tới câu trả lời. Có định dạng:

```
[id luật] > [chỉ mục level 0] > [chỉ mục level 1] > ...

Ví dụ:
146/2018/NĐ-CP > điều 12 > khoản 5
2089/VBHN-BHXH > điều 27
2089/VBHN-BHXH > điều 47 > khoản 2 > điểm 2.2
2089/VBHN-BHXH > điều 3 > khoản 2 > điểm 2.2 > tiết a
```
