FROM mcr.microsoft.com/playwright/python:v1.29.0-focal

RUN apt update
RUN sudo apt-get update -y
RUN sudo apt-get install -y python

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install playwright
RUN playwright install
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python3", "bot.py"]
