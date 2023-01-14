FROM mcr.microsoft.com/playwright/python:v1.29.0-focal

RUN apt update
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.9 get-pip.py --user
RUN apt install python3.9-distutils

RUN mkdir /app
ADD . /app
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install playwright --upgrade
RUN pip playwright install-with-deps
RUN playwright install-deps
RUN playwright install
RUN pip install requests
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python3", "bot.py"]
