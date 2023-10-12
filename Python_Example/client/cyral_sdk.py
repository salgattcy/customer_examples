import requests
import logging


class CyralAPIClient:
    def __init__(self, config):
        self.cyral_api_endpoint = f"{config.api_scheme}://{config.api_hostname}:{config.api_port}/{config.api_version}"
        self.api_scheme = config.api_scheme
        self.api_hostname = config.api_hostname
        self.api_port = config.api_port
        self.api_client_id = config.api_client_id
        self.api_client_secret = config.api_client_secret
        self.api_version = config.api_version
        self.auth_before_ping = config.auth_before_ping
        self._ping_api()

    def _ping_api(self):
        try:
            if self.auth_before_ping == "True":
                headers = {
                    "Accept": "application/json",
                    "Authorization": "Bearer " + self._get_jwt(),
                    "Content-Type": "application/json",
                }
            else:
                headers = {
                    "Accept": "application/json",
                    "Content-Type": "application/json",
                }
            response = requests.get(self.cyral_api_endpoint + "/ping", headers=headers)

            # We should receive a 200 response
            # Return False if we don't get a 200
            if response.status_code != 200:
                logging.debug(response.status_code)
                raise Exception("Ping Invalid Response Code")

            # Everything is contained within the Ping path so we'll check for it
            json_response = response.json()
            if "Ping" not in json_response:
                logging.error(json_response)
                raise Exception("Invalid Ping Response")

            # We need to check for a status and make sure it's what status we expect
            if "Status" not in json_response["Ping"]:
                logging.error(json_response)
                raise Exception("Not Status found Ping Response")

            # Check to make sure the status is OK
            if json_response["Ping"]["Status"] != "OK":
                logging.error(json_response)
                raise Exception("Failure status received in Ping Response")

            # Everything was good so we'll return true for testing
            return True

        except Exception as e:
            logging.critical(e)
            logging.critical("Unable to connect to Cyral Control Plane Status URL")
            exit()

    def _get_jwt(self):
        data = {
            "grant_type": "client_credentials",
            "client_id": self.api_client_id,
            "client_secret": self.api_client_secret,
        }

        # Query the customer CP for a JWT
        try:
            response = requests.post(
                self.cyral_api_endpoint + "/users/oidc/token",
                data=data,
            )
        except Exception as error:
            logging.error(error)
            raise Exception("JWT Request Failed")

        # We should receive a 200 response
        # Return False if we don't get a 200
        if response.status_code != 200:
            logging.debug(response.status_code)
            raise Exception("JWT Invalid Response Code")

        # access_token contains the JWT so make sure the response contains this
        if "access_token" not in response.json():
            logging.error(response.json())
            raise Exception("Invalid JWT Response")

        # Return the generated JWT
        return response.json()["access_token"]

    def _make_request(self, endpoint, method="GET", params=None, data=None):
        try:
            headers = {
                "Accept": "application/json",
                "Authorization": "Bearer " + self._get_jwt(),
                "Content-Type": "application/json",
            }

            """Helper function to make API requests."""
            url = f"{self.cyral_api_endpoint}/{endpoint}"
            logging.debug(f"URL Requested: {url}")
            logging.debug(f"Method Used : {method}")
            logging.debug(f"Parameters On Request : {params}")
            logging.debug(f"Data On Request: {data}")
            response = requests.request(
                method, url, headers=headers, params=params, json=data
            )

            if response.status_code >= 400:
                logging.warning(response.json())
                raise Exception(
                    f"Request failed with status code {response.status_code}"
                )

            return response.json()
        except Exception as e:
            logging.error(f"Request failed for Reason : {e}")
            return {}

    def get_resource(self, resource_type=None, resource_id=None):
        """Get a specific resource from the API."""
        return self._make_request(endpoint=resource_type)

    def list_resources(self, resource_type=None, params=None):
        """List all resources from the API."""
        return self._make_request(resource_type, params=params)

    def create_resource(self, resource_type=None, data=None):
        """Create a new resource in the API."""
        return self._make_request(endpoint=resource_type, method="POST", data=data)

    def update_resource(self, resource_type, data):
        """Update an existing resource in the API."""
        return self._make_request(endpoint=resource_type, method="PUT", data=data)
