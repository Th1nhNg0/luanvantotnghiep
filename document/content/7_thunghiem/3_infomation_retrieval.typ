== Truy xuất thông tin

Dựa vào dữ liệu đã thu thập được ở @datasetluat và @datasetqa. Ta thiết lập một bài toán:

- Đầu vào: câu hỏi cần tra cứu
- Đầu ra: danh sách các nội dung liên quan có thể trả lời cho câu hỏi đó


*Hướng tiếp cận thứ 1*: Sử dụng các thuật toán cơ bản như TF-IDF và BM25, để tính toán độ tương đồng giữa câu hỏi và các nội dung trong dataset. Sau đó, sắp xếp các nội dung theo độ tương đồng giảm dần và trả về kết quả.

Để kết quả tốt hơn, tôi có sử dụng thêm một số kỹ thuật để chuẩn hóa nội dung như: loại bỏ các ký tự đặc biệt, dùng các công cụ của underthesea@underthesea để chỉnh dấu câu, phân tách từ...

#figure(
    block(
        stroke: 1pt,
        inset: 10pt,
    )[
        ```Python
from underthesea import text_normalize,word_tokenize
import re
def format_text(text,word_segmentation=False):
    text = re.sub(r'\W', ' ', text) 
    text = re.sub(r'\s+', ' ', text)
    text = text_normalize(text)
    if word_segmentation:
        text = word_tokenize(text, format="text")
    return text
```
    ],
    caption: [Hàm format_text dùng để chuẩn hóa nội dung]
)

@ketquatruyxuat1 là kết quả của cách tiếp cận đầu tiên, sử dụng 2 thuật toán cơ bản là TF-IDF và BM25. Với 2 dạng chuẩn hóa: sử dụng word segmentation và không sử dụng word segmentation.

#let ketqua = csv("../../data/retrieval_result.csv")
#let col_kq = ketqua.first()

#figure(table(
    columns: (auto  ,1fr,1fr,1fr,1fr),
    ..col_kq.map((x) =>align(left,text(weight: "bold",x))),
    ..ketqua.slice(1).flatten().map(e=>align(left,upper(e)))
),caption: [Kết quả]) <ketquatruyxuat1>


*Hướng tiếp cận thứ 2*: Sử dụng Sentence Transformers. Cụ thể ở đây là model InstructorEmbedding@INSTRUCTOR được coi là state-of-the-art trong mảng này.

Model này sẽ nhận đầu vào là một string và trả về một vector 768 chiều. Các câu hỏi có nội dung tương đồng sẽ có vector tương tự nhau. Do đó, ta có thể tính toán độ tương đồng giữa câu hỏi và các nội dung trong dataset bằng cách tính cosine similarity giữa vector của câu hỏi và vector của các nội dung trong dataset.

Tuy nhiên model này không được train trên tập dataset có nhiều tiếng Việt cho nên ta cần fine-tune lại model này trên tập dataset về luật để có kết quả tốt nhất.

Theo tác giả của Instructor Embedding dữ liệu để fine-tune model có format là file JSON, gồm danh sách các ví dụ có dạng:

#figure(
    block(
        stroke: 1pt,
        inset: 10pt,
    )[
```json
{
  "query": [
    "Represent the Wikipedia question for retrieving relevant documents;",
    "big little lies season 2 how many episodes"
  ],
  "pos": [
    "Represent the Wikipedia document for retrieval;",
    "Big Little Lies (TV series) series garnered several accolades. It received 16 Emmy Award nominations and won eight, including Outstanding Limited Series and acting awards for Kidman, Skarsgård, and Dern. The trio also won Golden Globe Awards in addition to a Golden Globe Award for Best Miniseries or Television Film win for the series. Kidman and Skarsgård also received Screen Actors Guild Awards for their performances. Despite originally being billed as a miniseries, HBO renewed the series for a second season. Production on the second season began in March 2018 and is set to premiere in 2019. All seven episodes are being written by Kelley"
  ],
  "neg": [
    "Represent the Wikipedia document for retrieval;",
    "Little People, Big World final minutes of the season two-A finale, Farm Overload. A crowd had gathered around Jacob, who was lying on the ground near the trebuchet. The first two episodes of season two-B focus on the accident, and how the local media reacted to it. The first season of Little People, Big World generated solid ratings for TLC (especially in the important 18–49 demographic), leading to the show\"s renewal for a second season. Critical reviews of the series have been generally positive, citing the show\"s positive portrayal of little people. Conversely, other reviews have claimed that the show has a voyeuristic bend"
  ],
  "task_name": "NQ"
}
```
    ],
    caption: [Format của file JSON chứa dữ liệu fine-tune],
    kind: image
)

Trong đó, `query` là câu hỏi, `pos` là các nội dung có thể trả lời cho câu hỏi, `neg` là các nội dung không thể trả lời cho câu hỏi, `task_name` là tên của dataset (có thể có nhiều dataset trong file JSON này).

Để tạo dataset cho việc fine-tune, chúng ta sẽ tận dụng dataset về hỏi đáp luật và *Hướng tiếp cận thứ 1* để tạo ra các ví dụ cho việc fine-tune. Cụ thể:

- Với mỗi hỏi đáp trong dataset, `query` sẽ là câu hỏi, `pos` sẽ là nội dung của các chỉ mục đã được gán nhãn ở @datasetqa
- Để tạo `neg`, ta sẽ sử dụng thuật toán đã nói ở *Hướng tiếp cận thứ 1* để tìm ra top k nội dung. Sau đó kiểm tra xem nội dung nào chưa nằm trong `pos`, thì nội dung đó sẽ là `neg`.

Sơ đồ: