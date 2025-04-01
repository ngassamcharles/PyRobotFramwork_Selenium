import requests
from requests_kerberos import HTTPKerberosAuth, REQUIRED
import json
from robot.api import logger
from robot.api.deco import keyword, library

@library(auto_keywords=True)
class DatachainKerberosAuth:
    def __init__(self):
        self.session = requests.Session()
        self.response = None

    @keyword
    def authenticate_and_get_kerberos_endpoint(self, username, password, url, mutual_authentification=REQUIRED):
        logger.info(f"Connexion à l'url datachain Kerberos : {url}")
        kerberos_auth = HTTPKerberosAuth(
            principal=username,
            password=password
        )
        try:
            self.response = self.session.get(url, auth=kerberos_auth)
            self.response.raise_for_status()
            logger.info(f"Status de la réponse : {self.response.status_code}")
            return self.response.text
        except requests.exceptions.RequestException as e:
            logger.error(f"Erreur lors de la requete Kerberos: {str(e)}")

    @keyword
    def get_response_as_json(self):
        if self.response:
            try:
                return self.response.json()
            except json.JSONDecodeError:
                logger.error("Réponse au format JSON invalide")
        return None

    @keyword
    def get_response_status_code(self):
        if self.response:
            return self.response.status_code

    @keyword
    def response_should_contain(self, expected_text):
        if self.response and expected_text in self.response.text:
            return True
        return False
