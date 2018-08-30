setup() {
  url=${APP_URL:-localhost:8000}
  item='{"title": "Wash the car", "order": 1}'
  location='Location: ([^[:space:]]*)'
  curl -X DELETE $url/todos
}

@test "todobackend root" {
  run curl -oI -s -w "%{http_code}" $APP_URL
  [ $status = 0 ]
  [ $output = 200 ]
}

@test "todo items returns empty list" {
  run jq '. | length' <(curl -s $url/todos)
  [ $output = 0 ]
}

@test "create todo item" {
  run curl -i -X POST -H "Content-Type: application/json" $url/todos -d "$item"
  [ $status = 0 ]
  [[ $output =~ "201 Created" ]] || false
  [[ $output =~ $location ]] || false
  [ $(curl ${BASH_REMATCH[1]} | jq '.title') = $(echo "$item" | jq '.title') ]
}

@test "delete todo item" {
  run curl -i -X POST -H "Content-Type: application/json" $url/todos -d "$item"
  [ $status = 0 ]
  [[ $output =~ $location ]] || false
  run curl -i -X DELETE ${BASH_REMATCH[1]}
  [ $status = 0 ]
  [[ $output =~ "204 No Content" ]] || false
  run jq '. | length' <(curl -s $APP_URL/todos)
  [ $output = 0 ]
}
