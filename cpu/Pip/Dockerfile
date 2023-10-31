# For most models, consider deploying using gpu
FROM huggingface/transformers-pytorch-cpu


RUN python3 -c "from transformers import Automodel;Automodel.from_pretrained('bert-base-uncased')" 
RUN python3 -c "from transformers import Autotokenizer;Autotokenizer.from_pretrained('bert-base-uncased')"

RUN pip install fastapi uvicorn

EXPOSE 8888

ENTRYPOINT [ "transformers-cli","serve","--port=8888","--host=0.0.0.0" ,"--task=question-answering","--model=bert-base-uncased" ]

