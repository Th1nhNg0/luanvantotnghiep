
import logging
import sys

import pandas as pd
from chromadb.config import Settings
from langchain import HuggingFacePipeline
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
from langchain.chains.question_answering import load_qa_chain
from langchain.embeddings import HuggingFaceInstructEmbeddings
from langchain.llms import Baseten, CTransformers, OpenAI
from langchain.prompts import PromptTemplate
from langchain.vectorstores import Chroma
from langchain.llms import CTransformers

logging.basicConfig(stream=sys.stdout, level=logging.INFO)
logging.getLogger().addHandler(logging.StreamHandler(stream=sys.stdout))


embeddings = HuggingFaceInstructEmbeddings(
    query_instruction='Represent the legal question for retrieving evidence documents:',
    model_name='C:/Users/ngoph/Desktop/luanvan/model'
)


chroma = Chroma(
    collection_name='law_documents',
    client_settings=Settings(chroma_api_impl="rest",
                             chroma_server_host="localhost",
                             chroma_server_http_port="8000",
                             chroma_server_ssl_enabled=False
                             ),
    embedding_function=embeddings
)

# llm = OpenAI(
#     openai_api_key='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'
# )
llm = CTransformers(model="marella/gpt-2-ggml")
print(llm("Xin chào"))
chain = load_qa_chain(llm=llm, chain_type="refine", verbose=True)


qa_df = pd.read_json('./best.jsonl', lines=True, orient='records')

results = []

for index, row in qa_df.iterrows():
    cauhoi = row['cauhoi'].replace('Nội dung câu hỏi:', '')
    print(row['cauhoi'])
    print(row['traloi'])
    item = {
        "cauhoi": cauhoi,
        "traloi": row['traloi'],
    }
    docs = chroma.similarity_search(cauhoi)
    for doc in docs:
        doc.page_content = doc.metadata['tenvb'] + ', ' + doc.page_content
    ai = chain({"input_documents": docs, "question": cauhoi},)
    item['answer'] = ai

    print('ans:')
    print(ai['output_text'])
    print('----------------')

    results.append(item)


results_df = pd.DataFrame(results)
# save to json
results_df.to_json('./results.jsonl', orient='records', lines=True)
