import os 
from playwright import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.newPage()
    page.goto('https://proxitok.pabloferreiro.es/tag/gamer', timeout = 30000)

    # Find the video element and click it to start playing
    video_element = page.querySelector('video')
    video_element.click()

    # Wait for the video to start playing and then download it 
    page.waitForSelector('video[playing]')
    video_url = page.evaluate('(video) => video.src', video_element)

    # Download the video using requests library 
    import requests 

    r = requests.get(video_url, stream=True)

    with open("video.mp4", 'wb') as f: 
        for chunk in r: 
            f.write(chunk)
            

with sync_playwright() as t:
    browser2 = t.chromium.launch()
    page = browser2.newPage()

    # Log in to YouTube using environment variables
    page.goto('https://www.youtube.com/signin', timeout = 30000)
    page.fill('#identifierId', os.environ['YOUTUBE_USERNAME'])
    page.click('#identifierNext')
    page.waitForSelector('input[type="password"]')
    page.fill('input[type="password"]', os.environ['YOUTUBE_PASSWORD'])
    page.click('#passwordNext')

    # Upload video to YouTube channel 
    page.goto('https://www.youtube.com/upload') 
    page.waitForSelector('.upload-prompt-box input[type="file"]') 
    fileInput = page.$('.upload-prompt-box input[type="file"]') 
    fileInput._upload([os.path.abspath("video.mp4")])
