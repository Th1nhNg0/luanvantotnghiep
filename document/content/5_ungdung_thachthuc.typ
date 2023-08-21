#pagebreak()
= Cơ hội và thách thức <phan2>

Điểm sơ qua quá trình hình thành và phát triển của các mô hình ngôn ngữ lớn:

- Ngày 30 tháng 11 năm 2022, *OpenAI* phát triển và ra mắt *ChatGPT*, chatbot trí tuệ nhân tạo đầu tiên.
- Ngày 6 tháng 2 năm 2023, *Google* cho ra mắt *Bard* cạnh tranh trực tiếp với *ChatGPT*.
- Ngày 7 tháng 2 năm 2023, *Microsoft* công bố phiên bản search engine *Bing* dựa trên mô hình GPT tương tự như *ChatGPT*
- Ngày 24 tháng 2 năm 2023, *Meta* cũng đã ra mắt *LLaMA*, mã nguồn mỡ, nhưng không công bố trọng số.

Trong vòng một tuần, *LLaMA* bị rò rỉ ra công chúng. Từ thời điểm này trở đi, những đổi mới trở nên mạnh mẽ và nhanh chóng hơn.

Điển hình như mô hình Vicuna@vicuna2023 được xây dựng dựa trên mô hình LLaMA, chỉ sau 3 tuần kể từ khi trọng số LLaMA bị rò rỉ. Độ chính xác so với ChatGPT đạt tới 90%, với chi phí 300\$.

#figure(
    image("../images/vicuna.png"),
    caption: [
        Chất lượng phản hồi của các mô hình được đánh giá bởi GPT-4
    ]
)

Để hiểu rõ thêm về ứng dụng của các mô hình này trong lĩnh vực pháp luật, ta sẽ đi vào phân tích chi tiết các ứng dụng của chúng.

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

Phiên bản GPT-4 được ra mắt vào ngày 9 tháng 3 năm 2023, mang lại vô số tính năng cải tiến. Trong đó, tính năng đặc biệt nhất là người dùng có thể thêm hình ảnh vào câu hỏi. Từ đó ta có thể upload tài liệu của mình và hỏi chatbot những nội dung xoay quanh đó. Như hợp đồng, báo cáo tài chính, bản thỏa thuận...

#figure(
    image("../images/gpt4sum.png"),
    caption: [
        GPT-4 tóm tắt nội dung của một bài báo khoa học
    ]
)

Các nhà nghiên cứu tại MIT đã có một thử nghiệm nhỏ trên lĩnh vực luật@Greenwood2023Legal. Họ đã yêu cầu ChatGPT đưa ra các lập luận pháp lý để đáp lại "Kiến nghị của OpenAI, về việc bác bỏ vụ kiện Copilot". Tóm tắt kết quả như sau: từ một văn bản dài 25 trang, các nhà nghiên cứu yêu cầu ChatGPT tóm tắt lại nội dung của văn bản, và đưa ra ví dụ chứng minh cho một tuyên bố: "Hành động của OpenAI là nguyên nhân trực tiếp dẫn đến tổn thất của Nguyên đơn". Thời gian để ChatGPT tạo ra kết quả trong vỏn vẹn một phút, trong khi đó thời gian để một luật sư hay tư vấn viên có thể đưa ra kết quả tương tự là hơn 1 giờ, với chi phí từ 500\$/giờ.

#figure(
    image("../images/lawmit.png"),
    caption: [
        Kết quả cuối cùng của thí nghiệm ở MIT
    ]
)

Với sức mạnh của GPT-4, ta có thể thấy rõ ràng rằng, trong tương lai, các công việc liên quan đến tìm kiếm thông tin, tìm hiểu vấn đề, đọc hiểu văn bản, sẽ được thay thế bởi các chatbot thông minh. Điều này sẽ giúp con người tiết kiệm được rất nhiều thời gian và chi phí, đồng thời tăng cường hiệu quả công việc.

== Robot luật sư

Một xu hướng mới đang nổi lên trong lĩnh vực AI là "cá nhân hóa" các mô hình ngôn ngữ lớn (LLM), tức là huấn luyện riêng biệt cho từng người dùng cụ thể thay vì cho một mô hình chung chung.

Xu hướng này được thể hiện rõ nét qua sản phẩm Claude của Anthropic. Thay vì chỉ huấn luyện trên các tập dữ liệu công khai, Anthropic đã thu thập dữ liệu riêng từ các tình nguyện viên để Claude có thể hiểu rõ và phù hợp với từng cá nhân. Một số công ty khác cũng đang thử nghiệm các phiên bản LLM cá nhân hóa, ví dụ Bard của Google có thể được huấn luyện riêng cho người dùng nếu họ cho phép chia sẻ dữ liệu cá nhân.

Các nhà phát triển hy vọng rằng với dữ liệu cá nhân hóa, LLM sẽ hiểu ngữ cảnh và ngôn ngữ tốt hơn cho từng cá nhân, từ đó có thể đưa ra phản hồi chính xác và thông minh hơn. Tuy nhiên, điều này cũng khiến người dùng lo ngại về việc liệu dữ liệu của họ có thể bị lộ ra ngoài hay không. Các công ty cần tìm cách cân bằng giữa lợi ích mang lại và việc bảo mật thông tin người dùng trong xu hướng cá nhân hóa LLM.


*DoNotPay*@donotpay là một công ty khởi nghiệp công nghệ đứng sau ứng dụng được gọi là "robot luật sư đầu tiên trên thế giới", sử dụng trí tuệ nhân tạo để bảo vệ quyền lợi của người tiêu dùng. Trí tuệ nhân tạo này sẽ hướng dẫn các bị cáo cách trả lời trước tòa án bằng cách sử dụng một tai nghe có khả năng kết nối Bluetooth, theo bài báo của Matthew Sparkes trên tạp chí New Scientist@matthewsparkes_2023_ai.

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

Tuy các ứng dụng của các mô hình ngôn ngữ lớn mang lại nhiều lợi ích, nhưng cũng có những thách thức cần được giải quyết. Một số vấn đề chung thế giới đang phải đối mặt đó là:

*Bảo mật thông tin:*

Hiện nay các model LLM có độ chính xác cao nhất đều là do bên thứ 3 cung cấp: OpenAI, Cohere, Stability AI... Do đó, những doanh nghiệp có dữ liệu nhạy cảm rất khó để sử dụng các công cụ này. Theo tạp chí Fortune@mcglauflin_2023_apple, một số công ty như Apple, Samsung... đã cấm nhân viên của mình sử dụng ChatGPT vì lo ngại các thông tin nhạy cảm có thể bị rò rỉ.

Do vậy, để dùng được các công cụ này, các doanh nghiệp phải tự chủ được các công nghệ AI. Mà để tự chủ được các công nghệ này thì cần một chi phí cực kì cao. Theo Business Insider, một ngày OpenAI có thể phải trả tới 700,000 USD để duy trì hệ thống của mình.@mok_2023_chatgpt


*Chi phí cao:*

Chi phí để huấn luyện một mô hình ngôn ngữ lớn được The Next Platform@morgan_2022_counting thống kê tại @chiphitrain. Mô hình càng lớn thì chi phí và thời gian huấn luyện càng cao. 

#let train_price = csv("../data/train_price.csv")
#figure(
    table(
        align: center + horizon,
        columns: 6,
        [*Model Name*], [*Parameter\ (billion)*],[*Tokens\ (billion)*],[*Days to train*],[*Price to train*],[*Cost per 1M parameters*],
        ..train_price.flatten()
    ),
    caption: [
    Chi phí để huấn luyện một mô hình ngôn ngữ lớn
    ]
) <chiphitrain>


Chi phí để sử dụng các model LLM do bên thứ 3 cung cấp được tính bằng tokens. Tokens là một đơn vị đo lường được sử dụng để đo lường số lượng từ được sử dụng trong một câu. Ví dụ: "Con mèo đang đuổi theo con chuột" có 7 tokens. Do đó, nếu lưu lượng sử dụng công cụ AI càng nhiều thì chi phí phải bỏ ra để vận hành càng cao.

#let openai_price = csv("../data/openai_price.csv")

#figure(
    table(
        columns: (1fr,1fr,1fr,1fr),
        [*Name*], [*Model*],[*Input*],[*Output*],
        ..openai_price.flatten()
    ),
    caption: [
        Bảng giá của OpenAI theo số token đầu vào và đầu ra
    ]
)

Ta có thể sử dụng các model LLM open source có độ hiệu quả tương tự như Bloom, GPT-J... Nhưng để chạy được những model này thì cần một lượng lớn phần cứng. Điển hình như Bloom@workshop2023bloom, để chạy model Bloom 176B (176 billion parameters) cần đến 8 card đồ họa A100 80GB. Với chi phí khoản 15000 USD cho một card, tổng chi phí để chạy model này lên tới 120,000 USD chưa tính đến chi phí vận hành và bảo trì.

Các nhà nghiên cứu đã sáng tạo ra nhiều phương pháp để khắc phục các nhược điểm này. Điển như hình LoRa@hu2022lora dùng để fine-tune các model lớn, giúp model học thêm các kiến thức mới mà không tốn quá nhiều tài nguyên. Hay GPTQ@frantar-gptq viết tắt của Generative Pre-Training Quantized, một phương pháp "nén" mô hình để có thể chạy trên các thiết bị yếu hơn, không cần GPU. Đây cũng là một trong các mục tiêu mà các nhà nghiên cứu đang hướng đến: "chạy mô hình ngôn ngữ lớn trên mọi thiết bị" như điện thoại, laptop, các thiết bị điện tử trong công nghiệp...

*Đạo đức và pháp lý:*

Theo Reuters ngày 27/1, Science Po, một trong những trường đại học hàng đầu của Pháp, đã tuyên bố cấm sử dụng ChatGPT@reuters_2023_top. Hình phạt đối với hành vi sử dụng phần mềm này có thể nặng tới mức bị đuổi khỏi trường, thậm chí là toàn bộ nền giáo dục đại học của Pháp. Lý do cho quyết định này là ChatGPT có thể tạo ra những câu trả lời sai lầm hoặc vô nghĩa, gây hiểu lầm và nhầm lẫn cho người học. Ngoài ra, ChatGPT cũng có thể bị lợi dụng để gian lận trong các bài kiểm tra hoặc thi cử.

Science Po không phải là trường đầu tiên làm như vậy. Vào đầu năm 2023, nhiều trường học ở Mỹ đã có những biện pháp tương tự để ngăn chặn việc gian lận bằng ChatGPT. Họ đã giảm bớt bài tập về nhà và yêu cầu học sinh và giáo viên không sử dụng ChatGPT trong quá trình học tập. Họ cũng đã thiết lập các hệ thống để kiểm soát quyền truy cập vào ChatGPT trên các thiết bị hoặc Internet do trường quản lý. Những biện pháp này nhằm bảo vệ chất lượng giáo dục và khuyến khích học sinh tự học mà không phụ thuộc vào AI.

"Nhiều thập kỷ trước, các trường đại học phải đối mặt với một vấn đề nhức nhối là đạo văn và tình trạng vay mượn ý tưởng. Giờ đây, cộng đồng giáo dục tiếp tục đối mặt với một thách thức mới liên quan đến việc sử dụng hệ thống mạng và trí tuệ nhân tạo trong các hoạt động khoa học và giáo dục", tuyên bố của trường đại học Russische Staatliche Geisteswissenschaftliche Universität ở Nga


Getty Images, còn được biết đến là kho ảnh trực tuyến, vào ngày 17/1 đã cáo buộc công ty công nghệ Stability AI sử dụng hình ảnh của hãng và của các đối tác để kiếm lời.

Nhiều đơn vị phát triển AI như OpenAI không công bố nguồn dữ liệu họ thu thập để huấn luyện mô hình. Còn Stability AI nói rằng quy trình huấn luyện Stable Diffusion dựa vào nguồn dữ liệu mở. Đã có bên độc lập phân tích những nguồn dữ liệu này và đi đến kết luận Stability AI thu thập rất nhiều hình ảnh từ Getty Images và những nguồn hình stock khác trên mạng internet.

Về phần Getty Images, CEO đơn vị cung cấp bản quyền hình ảnh này nói rằng công ty không quan tâm tới những khoản bồi thường về mặt tài chính, mà cũng không có ý định ngăn chặn bất kỳ nhà phát triển thuật toán AI nào, mà thay vào đó là tạo ra một án lệ, một nền tảng để những thủ tục pháp lý tương tự về sau có thể dựa vào, và đương nhiên không loại trừ khả năng Getty Images sẽ có được cho họ một thoả thuận sử dụng hình ảnh từ các nhà phát triển AI.

Từ 2 ví dụ trên, ta có thể thấy vấn đề đạo đức và pháp lý đối với các ứng dụng AI vẫn còn khá mập mờ. Chưa có một đạo luật nào để quy định, hướng dẫn, bảo vệ cho những nhân tố trong lĩnh vực này.

Rất khó khăn để có thể thương mại hóa một ứng dụng AI với điều kiện hiện nay. Vì để gia nhập cuộc chơi này thì cần một số tiền đầu tư rất lớn, nhưng kết quả thu được lại không thể đảm bảo. Nên những công nghệ này hiện nay vẫn chỉ nằm trong các phòng thí nghiệm, hay được sử dụng nội bộ trong các công ty lớn, chưa thể tiếp cận rộng rãi được với đại đa số người dùng.

\

*Thách thức đối với tiếng Việt:*

Ngoài các thách thức chung như đã nêu ở trên thì đối với các mô hình ngôn ngữ sử dụng tiếng Việt còn phải đối mặt với một số thách thức riêng.

Phần quan trọng nhất để tạo nên các mô hình ngôn ngữ lớn chính là *dữ liệu*. Hiện nay chưa có một nguồn dữ liệu mở chính thống có kiểm duyệt nào cho tiếng Việt. Các nguồn dữ liệu hiện có đều là từ các trang web, các bài báo, các bài viết trên mạng internet. Những nguồn dữ liệu này chỉ mang tính chất thông tin thông thường, trong đó còn có nhiễu bởi các thông tin độc hại, sai sự thật. Do đó, các mô hình ngôn ngữ lớn cho tiếng Việt hiện nay đều có độ chính xác thấp hơn các mô hình cho tiếng Anh.

Các tri thức tiếng Việt đa số đều ở trong sách vở, các nguồn tại liệu đóng... mà những nguồn này đều không được công khai, nếu khai thác các nguồn dữ liệu này có thể vi phạm bản quyền, sở hữu trí tuệ của các tác giả có liên quan.

Để có thể phát triền mảng AI ở Việt Nam, ta cần một chính sách nới lỏng hơn cho các nhà nghiên cứu có thể tiếp cận các nguồn dữ liệu này. Theo Technomancers.ai@prime_2023_japan, chính phủ Nhật Bản đã công bố một chính sách cho phép các ứng dụng AI có thể dùng bất kì loại dữ liệu nào  "bất kể đó là vì mục đích phi lợi nhuận hay thương mại, cho dù đó là một hành động không phải là sao chép hay đó là nội dung thu được từ các trang web bất hợp pháp hay cách khác". Cho thấy sự sẵn sàng để cạnh tranh với các nước khác trong lĩnh vực AI.

Đối với dữ liệu về văn bản vi phạm pháp luật ở Việt Nam, những văn bản này được nhà nước ban hành và miễn phí sử dụng cho người dân. Vì vậy việc sử dụng các văn bản này sẽ không có vấn đề về pháp lý. Tuy nhiên, dữ liệu còn ở dạng thô (raw data), chưa phù hợp để huấn luyện mô hình vì thế trong @datasetluat tôi có đề xuất xây dựng một bộ dữ liệu về văn bản vi phạm pháp luật.

Với dữ liệu hỏi đáp liên quan tới luật thì khó hơn, vì nó cần qua sự kiểm duyệt của con người để đảm bảo tính chính xác. Và người kiểm duyệt phải có chuyên môn về luật. Do đó, việc xây dựng một bộ dữ liệu hỏi đáp liên quan tới luật hiện tại vẫn đang là một việc làm khó khăn và tốn kém.

Một vấn đề khác cũng quan trọng không kém đó là kiến trúc của các model LLM. Hay cụ thể hơn là phần tokenizer#footnote([Tokenizer là một quá trình chuyển đổi văn bản thành các token (đơn vị nhỏ nhất trong xử lý ngôn ngữ tự nhiên) để có thể xử lý dữ liệu bằng máy tính. Các token có thể là từ, ký tự hoặc sub-word. Tokenizer được sử dụng để tạo từ vựng trong một kho ngữ liệu (một tập dữ liệu trong NLP). Từ vựng này sau đó được chuyển thành số (ID) và giúp chúng ta lập mô hình]) của các model này, nó chỉ phù hợp cho nội dung là tiếng Anh vì cách dùng từ, cách đặt câu của tiếng Anh và tiếng Việt khác nhau. Và bảng mã sử dụng cho hai ngôn ngữ cũng khác, tiếng Anh sử dụng bảng mã ASCII, tiếng việt sử dụng bảng mã Unicode. Ở @sstoken ta có thể thấy được sự khác biệt này, tuy đoạn chữ tiếng Việt có ít kí tự hơn nhưng số lượng token lại nhiều hơn. Do đó, khi sử dụng các model này với tiếng Việt thì thời gian chạy rất lâu và độ chính xác rất thấp. 

#figure(
    image("../images/tokenizer.png"),
    caption: [
        So sánh tokenizer của giữa tiếng Việt và tiếng Anh
    ]
) <sstoken>