from endpoints import datamap, repos

my_repos = repos.repos()
my_datamap = datamap.datamap()

# Get all of the repos from the Cyral Control Plane and return as a dictionary of the form
# {
#     "repo_id_1" : {
#         "name" : "Repo_name_01",
#         "id" : "repo_id_1",
#         "repo_nodes":["repo_hostname"],
#         "labels":["tag_1", "tag_2"]
#     },
#     "repo_id_2" : {
#         "name" : "Repo_name_02",
#         "id" : "repo_id_2",
#         "repo_nodes":["repo_hostname"],
#         "labels":["tag_1", "tag_2"]
#     }
# }
all_repos_dict = my_repos.get_repos()

# Iterate over all of the repos and print the datamap for each repo
# Each datamap item is of the form of:
# {
#   "labels": {
#     "LABEL_01": {
#       "attributes": [
#         "schema.table.column",
#         "schema.table.column2"
#       ],
#       "endpoints": []
#     },
#     "LABEL_02": {
#       "attributes": [
#         "schema2.table.column",
#         "schema2.table.column2"
#       ],
#       "endpoints": []
#     }
#     "LABEL_03": {
#       "attributes": [
#         "schema.table1.column",
#         "schema.table1.column2"
#       ],
#       "endpoints": []
#     }
#   }
# }
for repo_id, repo_data in all_repos_dict.items():
    print(my_datamap.get_datamap(repo_id=repo_id))
