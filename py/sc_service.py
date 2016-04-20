import soundcloud
import pyotherside
import sys

import constants

class SoundCloudService:

    def __init__(self):
        self.access_token = None
        self.client = self._get_client()
        pass

    @staticmethod
    def _get_client():
        return soundcloud.Client(client_id=constants.CLIENT_ID,
                                 client_secret=constants.CLIENT_SECRET,
                                 redirect_uri=constants.REDIRECT_URL)

    def get_authorize_url(self):
        return self.client.authorize_url() + "&display=popup"

    def auth_user_with_redirect_url(self, redirect_url):
        """
        Get access token if user auth was valid. Return true if user authenticated.
        """
        code_ind = redirect_url.find('code=')

        if code_ind > -1:
            end = redirect_url.find("&", code_ind)

            if end is None or end == -1:
                end = len(redirect_url)

            code_start = code_ind + len('code=')
            code = redirect_url[code_start:end]

            try:
                self.access_token = self.client.exchange_token(code)
                pyotherside.send("access token fetched " + self.access_token)
            except:
                pyotherside.send("Not able to exchange access token, error:" + sys.exc_info()[0])

            if self.access_token:
                return True

        return True

service = SoundCloudService()
