#!/bin/sh
for i in {21..121}
do
#     curl -s localhost/item/item$i
    curl -X POST -H "Content-Type: application/json" -d "{\"user\":{\"email\":\"john$i@jacob.com\", \"password\":\"johnnyjacob\", \"username\":\"johnjacob$i\"}}" http://localhost:3000/api/users
    token=$(curl -X POST -H "Content-Type: application/json" -d "{\"user\":{\"email\":\"john$i@jacob.com\", \"password\":\"johnnyjacob\"}}" http://localhost:3000/api/users/login | jq -r '.[].token')
    echo "
    index $i, token $token
    "
    slug=$(curl --location --request POST 'http://localhost:3000/api/items' \
    --header 'Content-Type: application/json' \
    --header "Authorization: Token $token" \
    --data-raw "{\"item\":{\"title\":\"item_$i\", \"description\":\"Ever wonder how?\", \"body\":\"Very carefully.\", \"tagList\":[\"dragons\",\"training\"]}}" | jq -r '.[].slug')

    echo "
    Adding comment for item $i slug $slug
    "
    curl --location -g --request POST "http://localhost:3000/api/items/$slug/comments" \
    --header 'Content-Type: application/json' \
    --header 'X-Requested-With: XMLHttpRequest' \
    --header "Authorization: Token $token" \
    --data-raw "{\"comment\":{\"body\":\"Thank you so much $i!\"}}"
done

