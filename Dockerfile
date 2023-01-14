FROM mcr.microsoft.com/playwright:v1.23.0-focal

RUN apt update
RUN apt install ffmpeg libsm6 libxext6  -y
RUN apt install python3-pip -y

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install playwright --upgrade
RUN playwright install-deps
RUN pip install requests
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python3", "bot.py"]
