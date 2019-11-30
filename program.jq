jsoniq version "1.0";

let $apps:= [
  {"id": 1, "name": "Maps", "provider": "Google"},
  {"id": 2, "name": "Safari", "provider": "Apple"},
  {"id": 3, "name": "Atom", "provider": "Github"},
  {"id": 4, "name": "Java", "provider": "Oracle"},
  {"id": 5, "name": "Office", "provider": "Microsoft"}
]

let $log_messages:= [
  {"appId": 1, "message": "foo", "level": "INFO"},
  {"appId": 2, "message": "error", "level": "CRITICAL"},
  {"appId": 3, "message": "leak", "level": "WARNING"},
  {"appId": 3, "message": "compiled", "level": "INFO"},
  {"appId": 5, "message": "undefined", "level": "WARNING"},
  {"appId": 1, "message": "print", "level": "INFO"},
  {"appId": 2, "message": "run", "level": "INFO"},
  {"appId": 3, "message": "unused", "level": "WARNING"},
  {"appId": 5, "message": "assign", "level": "INFO"},
  {"appId": 5, "message": "display", "level": "INFO"},
  {"appId": 1, "message": "initialize", "level": "INFO"},
  {"appId": 2, "message": "copy", "level": "INFO"},
  {"appId": 3, "message": "paste", "level": "INFO"},
  {"appId": 2, "message": "cut", "level": "INFO"},
  {"appId": 5, "message": "delete", "level": "INFO"}
]

let $app_status :=
  for $app in $apps[]
    let $not_reliable :=
      some $log in $log_messages[]
        satisfies
          $log.appId eq $app.id
          and ($log.level eq "WARNING" or $log.level eq "CRITICAL")
  return {
    "app": $app.name,
    "provider": $app.provider,
    "isReliable": not $not_reliable
  }

  return {$app_status}
