from client import cyral_sdk
from common import config, helpers
import json
import logging


class user_account:
    def __init__(
        self,
        user_account_id="",
        name="",
        auth_database_name="",
        auth_scheme={},
        config=None,
    ):
        self.userAccountID = user_account_id
        self.name = name
        self.authDatabaseName = auth_database_name
        self.authScheme = auth_scheme
        self.config = config


class access_approval:
    def __init__(
        self,
        approval_action="",
        comments="",
        mod_counter=0,
        actor_type="email",
        actor_name="",
        approvalID="",
        repoID="",
    ):
        self.approvalAction = approval_action
        self.comments = comments
        self.modCounter = mod_counter
        self.actor = {"type": actor_type, "name": actor_name}
        self.approval_id = approvalID
        self.repo_id = repoID

    def as_dict(self):
        return vars(self)

    def get_mod_counter(self):
        try:
            response = cyral_sdk.CyralAPIClient(config.cyral_config()).get_resource(
                resource_type=f"repos/{self.repo_id}/approvals/{self.approval_id}"
            )
            if "modCounter" in response:
                return response["modCounter"]
            else:
                raise Exception(
                    f"No modification counter found for repo / approval ID : {self.repo_id} / {self.approval_id}"
                )
        except Exception as e:
            logging.info(e)
            raise Exception(
                f"Failed to get modification counter for repo / approval ID : {self.repo_id} / {self.approval_id}"
            )

    def manage_approval(self):
        try:
            return cyral_sdk.CyralAPIClient(config.cyral_config()).create_resource(
                resource_type=f"repos/{self.repo_id}/approvals/{self.approval_id}/manage",
                data=self.as_dict(),
            )
        except Exception as e:
            logging.info(e)
            raise Exception("Failed to update approval")


class access_request:
    def __init__(
        self,
        repo_id="",
        user_account_id="",
        identity_type="email",
        identity_name="",
        source="Cyral Python SDK",
        valid_from=helpers.get_utc_time(),
        valid_until=helpers.get_utc_time(),
        override_fields=[],
    ):
        self.repoID = repo_id
        self.userAccountID = user_account_id
        self.identity = {"type": identity_type, "name": identity_name}
        self.overrides = {"fields": override_fields}
        self.source = source
        self.validFrom = valid_from
        self.validUntil = valid_until

    def as_dict(self):
        return vars(self)

    def as_json(self):
        return json.dumps(self.as_dict())

    def create_access_request(self):
        try:
            return cyral_sdk.CyralAPIClient(config.cyral_config()).create_resource(
                resource_type=f"repos/{self.repoID}/approvals", data=self.as_dict()
            )
        except Exception as e:
            logging.info(e)
            raise Exception("Failed to create access request")


class repos:
    def __init__(self):
        try:
            self.api_client = cyral_sdk.CyralAPIClient(config.cyral_config())
        except Exception as e:
            logging.error(e)
            exit()

    # Helper function to convert the JSON response from
    # /v1/repos into a Python Dictionary
    def repos_to_dict(self, repo_dict):
        return_dict = {}
        if repo_dict is None:
            return return_dict

        if "repos" not in repo_dict:
            return return_dict

        if len(repo_dict["repos"]) < 1:
            return return_dict

        for entry in repo_dict["repos"]:
            if "id" not in entry:
                continue

            if "repo" not in entry:
                continue

            if "name" not in entry["repo"]:
                continue

            if "repoNodes" not in entry["repo"]:
                continue

            if "labels" not in entry["repo"]:
                continue

            if len(entry["repo"]["repoNodes"]) < 1:
                continue

            return_dict[entry["id"]] = {
                "name": entry["repo"]["name"],
                "id": entry["id"],
                "repo_nodes": [],
                "labels": entry["repo"]["labels"],
            }

            for repo_node in entry["repo"]["repoNodes"]:
                return_dict[entry["id"]]["repo_nodes"].append(repo_node["host"])

        return return_dict

    def get_repos(self):
        # Query the Control Plane to get the list of repos
        try:
            return self.repos_to_dict(self.api_client.list_resources("repos"))
        except Exception as e:
            logging.info(e)
            raise Exception("Failed to get repos")

    def user_accounts_object_list(self, users):
        if not users:
            raise Exception("No Users Found")

        if "userAccountList" not in users:
            raise Exception("No Account List")

        if len(users["userAccountList"]) < 1:
            raise Exception("User Account List is empty")

        user_dict = {}
        for user in users["userAccountList"]:
            my_user = user_account(user_account_id=user["userAccountID"])
            user_dict[my_user.userAccountID] = my_user

        return user_dict

    def get_user_accounts(self, repo_id):
        # Query the Control Plane to get the list of user accounts for the repo
        try:
            return self.user_accounts_object_list(
                self.api_client.list_resources(f"repos/{repo_id}/userAccounts")
            )
        except Exception as e:
            logging.info(e)
            raise Exception("Failed to get user accounts")
