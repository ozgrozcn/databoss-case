FROM python:3.8-slim

WORKDIR /app

ADD https://raw.githubusercontent.com/databossdevops/devops-case-study/main/main.py /app/main.py 
ADD https://raw.githubusercontent.com/databossdevops/devops-case-study/main/requirements.txt /app/requirements.txt


RUN pip install -r requirements.txt

ENTRYPOINT [ "streamlit","run","main.py","--server.port","8080"]


