# app

Onlife Playground

## Getting Started

Add Mapbox key to config.json

```json
{
  "MAPBOX_ACCESS_TOKEN": "key here"
}
```

Got "Run -> Edit Configurations -> Additional run args", and following 

```
--dart-define-from-file=config.json
```


Add Github personal access token to .netrc

```
machine api.github.com
login <username>
password <token>
```
