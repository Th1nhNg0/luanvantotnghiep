= Cơ hội và thách thức

== Sử dụng LLM để tra cứu và soạn thảo


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

DoNotPay@donotpay là một công ty khởi nghiệp công nghệ đứng sau ứng dụng được gọi là "robot luật sư đầu tiên trên thế giới", sử dụng trí tuệ nhân tạo để bảo vệ quyền lợi của người tiêu dùng. Trí tuệ nhân tạo này sẽ hướng dẫn các bị cáo cách trả lời trước tòa án bằng cách sử dụng một tai nghe có khả năng kết nối Bluetooth, theo bài báo của Matthew Sparkes trên tạp chí New Scientist@matthewsparkes_2023_ai.

Joshua Browder, người sáng lập DoNotPay, trong bài phỏng vấn với David Lumb của CNET@lumb_2023_ai, cho biết các dịch vụ và phí pháp lý có thể đắt đỏ, ngăn cản một số người thuê luật sư truyền thống để đấu tranh cho họ tại tòa án. "Hầu hết mọi người không đủ khả năng đại diện pháp lý". Luật sư AI "sẽ là một bằng chứng về khái niệm cho các tòa án cho phép sử dụng công nghệ trong phòng xử án".

Robot luật sư của DoNotPay sẽ được cung cấp âm thanh của các quá trình tố tụng tại tòa án khi chúng diễn ra, sau đó nó sẽ phản hồi bằng các lập luận pháp lý. Các bị cáo đã đồng ý lặp lại với thẩm phán chính xác những gì chatbot nói.

Robot luật sư sẽ sử dụng GPT-J@gpt-j, một mô hình ngôn ngữ mã nguồn mở được phát hành bởi EleutherAI#footnote([EleutherAI là một phòng thí nghiệm nghiên cứu AI phi lợi nhuận tập trung vào khả năng diễn giải và căn chỉnh của các mô hình lớn.]). DoNotPay đã huấn luyện chatbot để tranh luận bằng cách sử dụng các sự kiện thay vì bịa ra mọi thứ để thắng kiện. Họ cũng lập trình nó để đôi khi giữ im lặng, vì không phải mọi thứ trước tòa đều cần có phản hồi.

Vụ án đầu tiên liên quan đến luật sư robot được ấn định vào ngày 22 tháng 2, Browder tiết lộ trên Twitter vào ngày 21 tháng 1. Vụ án này liên quan đến một cáo buộc vi phạm tốc độ khi tham gia giao thông.

#figure(
    image("../images/tweet.png",width:65%),
    caption: [
        Công bố vụ án đầu tiên của robot luật sư trên Twitter
    ]
)


Tuy còn nhiều tranh cãi xoay quanh vấn đề này, nhưng có thể nói rằng đây là một bước tiến quan trọng trong việc ứng dụng trí tuệ nhân tạo vào lĩnh vực pháp lý. Với tốc độ phát triển của ngành AI hiện nay, khả năng robot luật sư trở thành một thứ gì đó "bình dân" không còn là điều quá xa vời. 

== Thách thức

Tuy các ứng dụng của AI mang lại nhiều lợi ích, nhưng cũng có những thách thức cần được giải quyết. Một số vấn đề mà cộng đồng AI trên thế giới đang phải đối mặt đó là:

*Bảo mật thông tin:*

Hiện nay các model LLM có độ chính xác cao nhất đều là do bên thứ 3 cung cấp, vd: OpenAI, Cohere, Stability AI... Do đó, những doanh nghiệp có dữ liệu nhạy cảm rất khó để sử dụng các công cụ này. Theo tạp chí Fortune@mcglauflin_2023_apple, một số công ty như Apple, Samsung... đã cấm nhân viên của mình sử dụng ChatGPT vì lo ngại các thông tin nhạy cảm có thể bị rò rỉ.

Do vậy, để dùng được các công cụ này, các doanh nghiệp phải tự chủ được các công nghệ AI. Mà để tự chủ được các công nghệ này thì cần một chi phí cực kì cao. Theo Business Insider, một ngày OpenAI có thể phải trả tới 700,000 USD để duy trì hệ thống của mình.@mok_2023_chatgpt


*Chi phí cao:*

Hiện nay để