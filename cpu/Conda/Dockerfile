from continuumio/miniconda3

RUN conda install -c cond-forge pytorch-cpu
RUN conda install -c cond-forge fastapi 
RUN conda install -c cond-forge uvicorn
RUN conda install -c cond-forge huggingface_hub 
RUN conda install -c huggigface transformers

EXPOSE 8888

ENTRYPOINT [ "transformers-cli","serve","--port=8888","--host=0.0.0.0" ,"--task=question-answering","--model=bert-base-uncased" ]

