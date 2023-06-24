= Cơ hội và thách thức

== Sử dụng LLM để tra cứu và soạn thảo

=== Sử dụng cơ bản

Sự ra đời của ChatGPT đã thay đổi cách chúng ta tìm kiếm nội dung trên internet. Thay vì phải nhập từ khóa, chúng ta có thể đặt câu hỏi và nhận được câu trả lời ngay lập tức. Và ChatGPT còn có thể hiểu được cuộc hội thoại đang diễn ra và đưa ra những câu trả lời phù hợp. Điều này giúp chúng ta tiết kiệm thời gian và tăng cường hiệu quả tìm kiếm.

#figure(
    image("../images/chatgpt.png"),
    caption: [
        Một cuộc hội thoại với ChatGPT
    ]
)

Về bản chất thì ChatGPT là một mô hình ngôn ngữ, cách hoạt động có thể hiểu đơn giản là nó dự đoán xác suất của từ tiếp theo dựa theo các từ đã xuất hiện trước đó. Ví dụ:

$ "Con mèo đang đuổi theo con ______" cases(
    "chó" 5%,
    "chuột" 70%,
    "sóc" 20%,
    "dế" 5%,
    "ngôi nhà" 0%,
) $

Do đó, không có gì chứng minh được câu trả lời là chính xác tuyệt đối. Để giải quyết vấn đề này, nhiều nhà nghiên cứu đã đưa thêm nội dung từ search engine (công cụ tìm kiếm) để ChatGPT có thể thông minh hơn. Cụ thể, trước khi trả lời cho một câu hỏi, ta sẽ thực hiện thêm một bước tìm kiếm các nội dung liên quan đến câu hỏi, sau đó đưa các nội dung này vào mô hình để tạo ra câu trả lời, theo format:

```
{nội dung tìm kiếm}
========
Dựa vào nội dung bên trên, bạn hãy trả lời câu hỏi sau: {câu hỏi}
```

#figure(
    stack(
        image("../images/chat1.png",width:80%),
        image("../images/chat2.png",width:80%)
    ),
    caption: [
        So sánh câu trả lời của ChatGPT không có và có nội dung tìm kiếm
    ]
) <sschat>

Cách làm này đã tạo ra một định nghĩa, ngành nghề hoàn toàn mới: *prompt engineering*, là quá trình tìm kiếm, lựa chọn và sắp xếp các từ, cụm từ hoặc câu văn để hướng dẫn mô hình ngôn ngữ tạo ra các nội dung hữu ích và phù hợp với mục đích và yêu cầu của người dùng.

Theo Langchain@Chase_LangChain_2022, có bốn phương pháp thường gặp để cung cấp thêm kiến thức cho mô hình ngôn ngữ:

*1. Stuff documents:* là phương pháp đơn giản nhất. Phương pháp này nhận một danh sách các tài liệu liên quan tới câu hỏi, rồi đưa chúng vào mô hình để tạo ra câu trả lời như @sschat. Phương pháp này phù hợp khi độ dài của các tài liệu là nhỏ và chỉ một lượng ít tài liệu được truyền vào mô hình.

#figure(
    image("../images/c1.jpg"),
    caption: [
        Phương pháp "stuff documents"
    ]
)

*2. Refine documents:* tạo ra câu trả lời bằng cách duyệt qua từng tài liệu liên quan và cập nhật lại câu trả lời dựa trên nội dung của tài liệu. Phương pháp này phù hợp khi độ dài của các tài liệu là lớn và tác vụ cần phân tích nhiều tại liệu mới đưa ra được câu trả lời. Điểm yếu của phương pháp này là phải gọi mô hình nhiều lần, dẫn đến tốc độ chậm.

#figure(
    image("../images/c2.jpg"),
    caption: [
        Phương pháp "refine documents"
    ]
)



*3. Map reduce:* đầu tiên áp dụng mô hình ngôn ngữ cho từng tài liệu riêng biệt (Map step), xem output như một tài liệu mới. Sau đó đưa tất cả các tài liệu mới này vào mô hình ngôn ngữ khác để tạo ra một output duy nhất (Reduce step). 

#figure(
    image("../images/c3.jpg"),
    caption: [
        Phương pháp "map reduce"
    ]
)

*4. Map re-rank:* tương tự bước Map của phương pháp *Map reduce* tuy nhiên, output của phương pháp này có thêm 1 field là score, dùng để đánh giá độ tự tin của câu trả lời.

#figure(
    image("../images/c4.jpg"),
    caption: [
        Phương pháp "map re-rank"
    ]
)

Nhờ có các công cụ này mà người dùng có thể tìm kiếm thông tin một cách nhanh chóng, chuẩn xác. Đối với các câu hỏi cần tính chuyên môn cao như chuyên ngành luật, ta có thể hiểu ngay vấn đề cần tìm hiểu bằng cách hỏi chatbot, không hiểu chỗ nào thì hỏi ngay chỗ đó.

=== Sử dụng nâng cao

Phiên bản GPT 4 được ra mắt vào ngày 9 tháng 3 năm 2023, mang lại vô số tính năng cải tiến. Trong đó, tính năng đặc biệt nhất là người dùng có thể thêm hình ảnh vào câu hỏi. Từ đó ta có thể upload tài liệu của mình và hỏi chatbot những nội dung xoay quanh đó. Như hợp đồng, báo cáo tài chính, bản thỏa thuận...

#figure(
    image("../images/gpt4sum.png"),
    caption: [
        GPT 4 tóm tắt nội dung của một bài báo khoa học
    ]
)

Các nhà nghiên cứu tại MIT đã có một thử nghiệm nhỏ trên lĩnh vực luật@Greenwood2023Legal. Họ đã yêu cầu ChatGPT đưa ra các lập luận pháp lý để đáp lại "Kiến nghị của OpenAI, về việc bác bỏ vụ kiện Copilot". Tóm tắt kết quả như sau: từ một văn bản dài 25 trang, các nhà nghiên cứu yêu cầu ChatGPT tóm tắt lại nội dung của văn bản, và đưa ra ví dụ chứng minh cho một tuyên bố: "Hành động của OpenAI là nguyên nhân trực tiếp dẫn đến tổn thất của Nguyên đơn". Thời gian để ChatGPT tạo ra kết quả trong vỏn vẹn một phút, trong khi đó thời gian để một luật sư hay tư vấn viên có thể đưa ra kết quả tương tự là hơn 1 giờ, với chi phí từ 500\$/giờ.

#figure(
    image("../images/lawmit.png"),
    caption: [
        Kết quả cuối cùng của thí nghiệm ở MIT
    ]
)

Với sức mạnh của GPT4, ta có thể thấy rõ ràng rằng, trong tương lai, các công việc liên quan đến tìm kiếm thông tin, tìm hiểu vấn đề, đọc hiểu văn bản, sẽ được thay thế bởi các chatbot thông minh. Điều này sẽ giúp con người tiết kiệm được rất nhiều thời gian và chi phí, đồng thời tăng cường hiệu quả công việc.

== Robot luật sư



== Thách thức