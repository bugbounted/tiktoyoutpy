FROM mcr.microsoft.com/playwright/python:v1.29.0-focal

ARG PYTHON_VERSION=3.11.1

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && \
    apt install -y python3.11.1

RUN apt-get install -y python-ffmpeg

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install playwright
RUN playwright install
RUN playwright install-deps chromium
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python3", "bot.py"]
