import streamlit as st
import pandas as pd
import numpy as np
import plotly.express as px
import string
df = pd.read_json('./answers.jsonl', lines=True)
law_id = dict()

for answer in df['answers'].tolist():
    answer = [x.split(' > ')[0].strip() for x in answer]
    for a in answer:
        if a not in law_id:
            law_id[a] = 1
        else:
            law_id[a] += 1

law_id = pd.DataFrame.from_dict(law_id, orient='index', columns=['count'])
law_id = law_id.sort_values(by=['count'], ascending=False)
law_id = law_id.reset_index()
law_ids = law_id['index'].tolist()
law_ids = [str(x) + ' - ' + str(y)
           for x, y in zip(law_ids, law_id['count'].tolist())]


st.title('EDA')
st.header('Dataset')
st.dataframe(df)
# pie chart on df linhvuc
st.subheader('Lĩnh vực')
st.write('Số lượng câu hỏi theo lĩnh vực')
fig = px.pie(df, names='linhvuc')
# set fig size
# title
fig.update_layout(
    title={
        'text': "Số lượng câu hỏi theo lĩnh vực",
    })
st.plotly_chart(fig)

# plot law_id
st.subheader('Các luật được sử dụng')
min = st.number_input('Min count', value=50, min_value=1)
new_law_id = law_id[law_id['count'] >= min]
st.bar_chart(new_law_id)
print(new_law_id)
st.subheader('Số điều luật trích dẫn trong 1 câu hỏi')
data = df['answers'].apply(len).value_counts().reset_index()
data.columns = ['index', 'answers']
fig = px.pie(data, names='index', values='answers')
st.plotly_chart(fig)

st.subheader('Thống kê theo văn bản luật')
choice = st.selectbox('Choose law id', law_ids)


def if_answer_container_law_id(answers):
    answers = [x.split(' > ')[0].strip() for x in answers]
    return choice.split(' - ')[0] in answers


choice_df = df[df['answers'].apply(if_answer_container_law_id)]
choice_df = choice_df.reset_index(drop=True)

article = dict()
for answer in choice_df['answers'].tolist():
    for x in answer:
        split = x.split('>')
        if len(split) > 1:
            temp = split[1].lower().strip()
            if "điều" not in temp:
                continue
            # replace punctuation
            temp = temp.translate(str.maketrans('', '', string.punctuation))
            if temp not in article:
                article[temp] = 1
            else:
                article[temp] += 1
article = pd.DataFrame.from_dict(article, orient='index', columns=['count'])
st.bar_chart(article)
