import os
import logging


class cyral_config:
    def __init__(self):
        self.api_scheme = os.environ.get("CYRAL_API_SCHEME", "https")
        self.api_version = os.environ.get("CYRAL_API_VERSION", "v1")
        self.api_port = os.environ.get("CYRAL_API_PORT", "443")
        self.api_hostname = os.environ.get("CYRAL_API_HOST", None)
        self.api_client_id = os.environ.get("CYRAL_API_CLIENT_ID", None)
        self.api_client_secret = os.environ.get("CYRAL_API_CLIENT_SECRET", None)
        self.auth_before_ping = self.set_ping_value()
        try:
            self.validate_config()
        except Exception as e:
            logging.fatal(e)
            exit()

    def get(self):
        return self

    def set_ping_value(self):
        ping_value = os.environ.get("CYRAL_API_PING_AUTH", "True")
        if ping_value.lower() == "false":
            ping_value = "false"

        return ping_value

    def validate_config(self):
        if self.api_scheme not in ["http", "https"]:
            raise Exception(f"{self.api_scheme} is an invalid API Scheme")

        if self.api_version not in ["v1"]:
            raise Exception(f"{self.api_version} is an invalid API Version")

        if self.api_port not in ["443", "8000"]:
            raise Exception(f"{self.api_port} is not a standard Cyral API Port")

        if not self.api_hostname:
            raise Exception(
                "You must specify a valid hostname for your Cyral Control Plane"
            )

        if not self.api_client_id:
            raise Exception(
                "You must provide a valid Client ID for your Cyral Control Plane"
            )

        if not self.api_client_secret:
            raise Exception(
                "You must provide a valid Client Secret for your Cyral Control Plane"
            )

        return True
