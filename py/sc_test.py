import soundcloud

def getPermalink():
    """Test SoundCloud API"""

    client = soundcloud.Client(client_id="xxx")
    app = client.get('/apps/124')

    return app.permalink_url
