FROM mcr.microsoft.com/playwright/python:v1.29.0-focal

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
