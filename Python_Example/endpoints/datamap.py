from client import cyral_sdk
from common import config
import logging


class datamap:
    def __init__(self):
        try:
            self.api_client = cyral_sdk.CyralAPIClient(config.cyral_config())
        except Exception as e:
            logging.error(e)
            exit()

    def _valid_recommendation(self, recommendation):
        if "id" not in recommendation:
            logging.error("'id' not found in recommendation")
            return False

        if "repo" not in recommendation:
            logging.error("'repo' not found in recommendation")
            return False

        if "attribute" not in recommendation:
            logging.error("'attribute' not found in recommendation")
            return False

        if "label" not in recommendation:
            logging.error("'label' not found in recommendation")
            return False

        if "status" not in recommendation:
            logging.error("'status' not found in recommendation")
            return False

        if "source" not in recommendation:
            logging.error("'source' not found in recommendation")
            return False

        if "createdAt" not in recommendation:
            logging.error("'createdAt' not found in recommendation")
            return False

        if "updatedAt" not in recommendation:
            logging.error("'updatedAt' not found in recommendation")
            return False

        return True

    def recommendations_as_dict(self):
        recommendations = self.get_recommendations()

        if "recommendations" not in recommendations:
            raise Exception("Unexpected Recommendations Format")

        if len(recommendations) < 1:
            raise Exception("No Recommendations Found")

        recommendations_dict = {}
        for recommendation in recommendations["recommendations"]:
            if self._valid_recommendation(recommendation):
                if recommendation["repo"] not in recommendations_dict:
                    recommendations_dict[recommendation["repo"]] = []
                recommendations_dict[recommendation["repo"]].append(recommendation)

        return recommendations_dict

    def get_recommendations(
        self, page=1, items_per_page=2147483647, status="RECOMMENDED"
    ):
        # Query the Control Plane to get the list of recommendations
        try:
            params = {"page": page, "itemsPerPage": items_per_page, "status": status}
            return self.api_client.list_resources(
                resource_type="datamap/recommendations", params=params
            )
        except Exception as e:
            logging.info(e)
            raise Exception("Failed to get recommendations")

    def get_datamap(self, repo_id):
        # Query the Control Plane to get the list of recommendations
        try:
            return self.api_client.list_resources(
                resource_type=f"repos/{repo_id}/datamap"
            )
        except Exception as e:
            logging.info(e)
            raise Exception("Failed to get datamap")

    def manage_recommendation(self, repo_id, recommendation_id, status="DISMISSED"):
        # Query the Control Plane to set the status of the recommendation
        try:
            data = {"status": status}
            return self.api_client.update_resource(
                resource_type=f"repos/{repo_id}/datamap/recommendations/{recommendation_id}/status",
                data=data,
            )
        except Exception as e:
            logging.info(e)
            raise Exception("Failed to update recommendation")
