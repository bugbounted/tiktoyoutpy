FROM mcr.microsoft.com/playwright/python:v1.29.0-focal

RUN apt install ffmpeg libsm6 libxext6  -y
RUN apt install python3-pip -y

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install playwright
RUN playwright install
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python3", "bot.py"]
