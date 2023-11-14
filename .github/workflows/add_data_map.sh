#!/usr/bin/env bash
changelog="liquibaseChangelog/changelog.sql"
current_datamap_file="/tmp/current_datamap.json"
new_datamap_file="/tmp/new_datamap.json"
staging_datamap_file="/tmp/staging_datamap.json"

echo "Processing labels for $changelog..."

validate_env() {
    if ! command -v jq 2>&1 1>/dev/null; then
        echo "jq is required, please install it"
        exit 1
    fi

    if ! command -v curl 2>&1 1>/dev/null; then
        echo "curl is required, please install it"
        exit 1
    fi

    if [ -z "$CYRAL_CONTROL_PLANE" ]; then
        echo "Missing Env Var: CYRAL_CONTROL_PLANE"
        exit 1
    fi

    if [ -z "$CYRAL_CLIENT_ID" ]; then
        echo "Missing Env Var: CYRAL_CLIENT_ID"
        exit 1
    fi

    if [ -z  "$CYRAL_CLIENT_SECRET" ]; then
        echo "Missing Env Var: CYRAL_CLIENT_SECRET"
        exit 1
    fi
}

get_repo_id() {
    if (($# != 2 )); then
        echo "Expecting 2 arguments, dataRepo return_variable"
        echo "Got: $*"
        exit 1
    fi

    dataRepo=$1

    TOKEN=$(curl -s --request POST "https://$CYRAL_CONTROL_PLANE/v1/users/oidc/token" \
    -d grant_type=client_credentials \
    -d client_id="$CYRAL_CLIENT_ID" \
    -d client_secret="$CYRAL_CLIENT_SECRET" | jq -r .access_token)

    #validate repo
    repos=$(curl -s "https://$CYRAL_CONTROL_PLANE/v1/repos" -H "authorization: Bearer $TOKEN")
    if ! repo=$(echo "$repos" | jq ".repos[] | select(.repo.name == \"$dataRepo\")"); then
        echo "Unable to find repo $dataRepo"
        exit 1
    fi
    repoId=$(echo "$repo" | jq -r ".id")
    eval "$2=$repoId"
}

get_current_datamap() {
    if (($# != 1 )); then
        echo "Expecting 1 argument, repoId"
        echo "Got: $*"
        exit 1
    fi

    local repoId=$1
    TOKEN=$(curl -s --request POST "https://$CYRAL_CONTROL_PLANE/v1/users/oidc/token" \
    -d grant_type=client_credentials \
    -d client_id="$CYRAL_CLIENT_ID" \
    -d client_secret="$CYRAL_CLIENT_SECRET" | jq -r .access_token)

    curl -s "https://$CYRAL_CONTROL_PLANE/v1/repos/${repoId}/datamap" -H "authorization: Bearer $TOKEN" | jq -S . > $current_datamap_file
}

generate_new_datamap() {
    if  labels=$(grep "CYRAL_LABEL" $changelog); then
        echo "{}" > $new_datamap_file
        while read -r line; do
            read -r -a args <<< "$(echo "$line" | rev | cut -d" "  -f1-5 | rev)"
            label="${args[1]}"
            schema="${args[2]}"
            table="${args[3]}"
            field="${args[4]}"
            attribute="${schema}.${table}.${field}"
            if ! index=$(cat $new_datamap_file | jq -e ".labels.${label}.attributes"); then
                # echo "Creating label for $label"
                cat $new_datamap_file |jq ".labels.${label}.attributes = []" |jq ".labels.${label}.endpoints = []"> $staging_datamap_file
                mv $staging_datamap_file $new_datamap_file

            fi
            if ! index=$(cat $new_datamap_file | jq -e ".labels.${label}.attributes | index( \"${attribute}\" )"); then
                # echo "Creating $attribute for label $label"
                cat $new_datamap_file |jq ".labels.${label}.attributes[.labels.${label}.attributes | length] = \"${attribute}\"" > $staging_datamap_file
                mv $staging_datamap_file $new_datamap_file
            fi
        done < <(printf '%s\n' "$labels")
    else
         echo "Change log $changelog has no annotations, exiting"
    fi
}

generate_diff() {
    echo "Generating diff of datamap changes...."
    diff --color -u <(jq -S . $current_datamap_file) <(jq -S . $new_datamap_file)
}

commit_datamap() {
    if (($# != 1 )); then
        echo "Expecting 1 argument, repoId"
        echo "Got: $*"
        exit 1
    fi

    local repoId=$1
    local mapData=$(jq '.' $new_datamap_file )
    local dataMap=$(echo '{}'| jq ".dataMap = $mapData")
    echo "Updating datamap for repoID ${repoId}"
    # echo $dataMap

    TOKEN=$(curl -s --request POST "https://$CYRAL_CONTROL_PLANE/v1/users/oidc/token" \
    -d grant_type=client_credentials \
    -d client_id="$CYRAL_CLIENT_ID" \
    -d client_secret="$CYRAL_CLIENT_SECRET" | jq -r .access_token)

    output=$(curl -s --request PUT "https://$CYRAL_CONTROL_PLANE/v1/repos/${repoId}/datamap" -H "Content-Type: application/json" -H "authorization: Bearer $TOKEN" -d "${dataMap}")
    if [[ "$output" != "{}" ]]; then
        echo "Error creating datamap!"
        echo "$output"
        exit 1
    fi

}

# We check to make sure our environment is functional
validate_env

echo "Repo Name is: $1"
get_repo_id $1 cyral_repo_id

echo "Repo ID is: $cyral_repo_id"
get_current_datamap $cyral_repo_id

generate_new_datamap

generate_diff

if [ ! -z "$2" ] && [ "$2" == "apply_changes" ]; then
    commit_datamap $cyral_repo_id
fi
