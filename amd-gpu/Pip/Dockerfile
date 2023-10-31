FROM huggingface/transformers-pytorch-amd-gpu

RUN python3 -c "from transformers import Automodel;Automodel.from_pretrained('ehartford/dolphin-2.1-mistral-7b')" 
RUN python3 -c "from transformers import Autotokenizer;Autotokenizer.from_pretrained('ehartford/dolphin-2.1-mistral-7b')"

RUN pip install fastapi uvicorn

EXPOSE 8888

ENTRYPOINT [ "transformers-cli","serve","--port=8888","--host=0.0.0.0" ,"--task=question-answering","--model='ehartford/dolphin-2.1-mistral-7b'" ]
