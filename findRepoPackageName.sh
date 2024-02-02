#!/bin/bash

pathToFolder=$1
owner=$2
inputToken=$3

repoName=$(basename `git -C "$pathToFolder" rev-parse --show-toplevel`)

if [ -z "$pathToFolder" ] && [ -z "$owner" ] && [ -z "$inputToken" ]; then
  echo -e "You should provide the path, the owner of the repo and the token with the correct access rights\n"
elif [ -n "$pathToFolder" ] && [ -z "$owner" ] && [ -z "$inputToken" ]; then
  echo -e "You should provide the owner as the second argument and the token as the third argument\n"
elif [ -n "$pathToFolder" ] && [ -n "$owner" ] && [ -z "$inputToken" ]; then
  echo -e "You should provide the token with the correct access rigths as the third argument\n"
fi

query='
query repoPackageName {
  repository(owner: \"'"${owner}"'\", name: \"'"${repoName}"'\") {
    packages(first: 1) {
      nodes {
        name
      }
    }
  }
}
'
graphQL_query="$(echo $query)"

graphQL_endpoint="https://api.github.com/graphql"

token="${inputToken}"

graphQL_response=$(curl -s -X POST \
  -H "Authorization: bearer $token" \
  -H "Content-Type: application/json" \
  -d "{\"query\":\"$graphQL_query\"}" \
  $graphQL_endpoint)


#----------another way to perform the graphQL query------------#
# query='{"query": "{ repository(owner: \"'"${owner}"'\", name: \"'"${repoName}"'\"){ packages(first: 1) { nodes { name } } } }" }'
# echo $query > query.json

# graphQL_endpoint="https://api.github.com/graphql"

# token="${inputToken}"

# graphQL_response=$(curl -s -X POST \
#   -H "Authorization: bearer $token" \
#   -H "Content-Type: application/json" \
#   -d "@query.json" \
#   $graphQL_endpoint)

name=$(echo "$graphQL_response" | grep -o '"name":"[^"]*' | awk -F'"' '{print $4}')
echo "$name"