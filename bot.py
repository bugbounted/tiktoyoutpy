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
            

    page2 = browser.newPage()

    # Log in to YouTube
    page2.goto('https://www.youtube.com/signin')
    page2.fill('#identifierId', '<your-username>')
    page2.click('#identifierNext')
    page2.fill('input[type="password"]', '<your-password>')
    page2.click('#passwordNext')

    # Upload video to YouTube channel 
    page2.goto('https://www.youtube.com/upload') 
    file_input = page2.querySelector('input[type="file"]') 
    file_input.uploadFile(os.path.abspath("video.mp4")) 

    # Publish video 
    page2.click("#submit-upload-button")
