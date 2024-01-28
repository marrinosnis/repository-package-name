#!/bin/bash

pathToFolder=$1
owner=$2
inputToken=$3

repoName=$(basename `git rev-parse --show-toplevel`)

# echo "The pathToFolder is ${pathToFolder}"
#Let's break down the line 22, about the repoName expantion.
#The whole graphQL query will be inside single quotes ( ' ' )
#The arguments must be in a double quotes ( " " ). This is a rule from the graphQL query language. So the arguments, owner & name, must be in double quotes.
#Because the double quotes ( " " ) are inside the query, which is inside the singe quotes ( ' ' ), the double quotes have to be escaped ( \ ) in order to have the actual meaning of the double quote. 
#Otherwise the query fails and the graphQL responses with: Problems parsing JSON.
#Up until now, we have that single quotes for the query, double quotes inside it needs to be escaped. 
#To pass a bash script variable into the graphQL query, we have to close the single quote ( ' ), use/expand the variable, and then reopen the single quote ( ' ), in order the query to reach the end.
#To expand correctly a variable in bash script, it has to be enclosed in double quotes ( " " ), and then use the dollar sign ( $ ) and curly braces ( {} ).
#So the bash variable in native bash script expantion would be: "${variable}"
#The final form is: 
# expand the variable ============================================================================> = "${variable}"
# use the varialbe in graph query -> stop with single quote - use of variable - reopen single quote = '"${variable}"'
# escape the double quotes beacuase it is rule of graphQL language ===============================> = \"'"${variable}"'\"
#Another way would be to just use the variable after and before the 2nd single quotes -> \"'$variable'\". Although this is not good practise and it should be avoided.

if [ -z "$owner" ] && [ -z "$inputToken" ]; then
  echo -e "You should provide the owner of the repo and the token with the correct access rights\n"
elif [ -n "$owner" ] && [ -z "$inputToken" ]; then
  echo -e "You should provide also the token as the second argument\n"
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