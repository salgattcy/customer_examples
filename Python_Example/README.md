# Summary

This is a limited feature library that can be used to interact with the Cyral Control Plane. Currently, this is able to perform the following functions:

 - Get a list of repos
 - Get recommendations per repo
 - Get datamaps per repo
 - Manage Recommendations

# Requirements

This requires API key that has been granted the following permissions:

 - `View Datamaps`

Refer to the [Create an API access key](https://cyral.com/docs/api-ref/api-intro#create-an-api-access-key) section of the Cyral Documentation on how to generate an API Key.

In addition to the API key, this makes use of the `requests` Python library. You can install this by running pip against the included [requirements.txt](./requirements.txt)
```
pip install -r requirements.txt
```

# Using this library

This requires the following environmental variables to be set:

| Parameter Name          | Description                                  | Default Value |
|-------------------------|----------------------------------------------|---------------|
| CYRAL_API_HOST          | The URL of the target CP                     | NULL          |
| CYRAL_API_CLIENT_ID     | The client ID of the API Account created     | NULL          |
| CYRAL_API_CLIENT_SECRET | The client Secret of the API Account created | NULL          |

## Example

The [get_datamaps.py](./get_datamaps.py) file provides an example of using this library to get all of the data map entries from all repositories.
