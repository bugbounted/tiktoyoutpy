FROM mcr.microsoft.com/playwright/python:v1.29.0-focal

WORKDIR /app

# Install Python
RUN apt-get update \
    && apt-get install -y python3.9-dev python3-pip nano \
    && python3.9 -m pip install --no-cache-dir --upgrade pip \
    && python3.9 -m pip install --no-cache-dir playwright

COPY requirements.txt /app/requirements.txt
RUN rm -rf /ms-playwright/* \
    && python3.9 -m playwright install --with-deps chromium \
    && chmod -Rf 777 /ms-playwright \
    && mv /ms-playwright/chromium-* /ms-playwright/chromium \
    # && mv /ms-playwright/firefox-* /ms-playwright/firefox \
    # && mv /ms-playwright/webkit-* /ms-playwright/webkit \

COPY . /app

RUN playwright install
RUN pip install requests
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python3", "bot.py"]
