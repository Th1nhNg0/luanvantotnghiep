
== Use ChatGPT

Theo Langchain@Chase_LangChain_2022, có bốn phương pháp thường gặp để cung cấp thêm kiến thức cho mô hình ngôn ngữ:

*1. Stuff documents:* là phương pháp đơn giản nhất. Phương pháp này nhận một danh sách các tài liệu liên quan tới câu hỏi, rồi đưa chúng vào mô hình để tạo ra câu trả lời như @sschat. Phương pháp này phù hợp khi độ dài của các tài liệu là nhỏ và chỉ một lượng ít tài liệu được truyền vào mô hình.

#figure(
    image("../../images/c1.jpg"),
    caption: [
        Phương pháp "stuff documents"
    ]
)

*2. Refine documents:* tạo ra câu trả lời bằng cách duyệt qua từng tài liệu liên quan và cập nhật lại câu trả lời dựa trên nội dung của tài liệu. Phương pháp này phù hợp khi độ dài của các tài liệu là lớn và tác vụ cần phân tích nhiều tại liệu mới đưa ra được câu trả lời. Điểm yếu của phương pháp này là phải gọi mô hình nhiều lần, dẫn đến tốc độ chậm.

#figure(
    image("../../images/c2.jpg"),
    caption: [
        Phương pháp "refine documents"
    ]
)



*3. Map reduce:* đầu tiên áp dụng mô hình ngôn ngữ cho từng tài liệu riêng biệt (Map step), xem output như một tài liệu mới. Sau đó đưa tất cả các tài liệu mới này vào mô hình ngôn ngữ khác để tạo ra một output duy nhất (Reduce step). 

#figure(
    image("../../images/c3.jpg"),
    caption: [
        Phương pháp "map reduce"
    ]
)

*4. Map re-rank:* tương tự bước Map của phương pháp *Map reduce* tuy nhiên, output của phương pháp này có thêm 1 field là score, dùng để đánh giá độ tự tin của câu trả lời.

#figure(
    image("../../images/c4.jpg"),
    caption: [
        Phương pháp "map re-rank"
    ]
)