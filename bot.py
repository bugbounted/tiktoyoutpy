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
            
# Get environment variables for gmail and password
gmail = os.environ['GMAIL']
password = os.environ['PASSWORD']


    # Navigate to YouTube 
    page.goto('https://www.youtube.com/upload', timeout = 30000)

    # Log in with gmail and password 
    page.fill('#identifierId', gmail) 
    page.click('#identifierNext') 

    page.fill('input[type="password"]', password) 
    page.click('#passwordNext')

    # Upload video file named video.mp4 
    page.uploadFile('./video.mp4')
