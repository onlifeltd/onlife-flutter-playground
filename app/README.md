# app

Onlife Playground

## Getting Started

Add Mapbox key to .env

```
MAPBOX_ACCESS_TOKEN="key here"
```

Got "Run -> Edit Configurations -> Additional run args", and following 

```
--dart-define-from-file=.env
```


Add Mapbox SDK download token and Github personal access token to .netrc

```
machine api.mapbox.com
login mapbox
password <mapbox token>

machine api.github.com
login <username>
password <github token>
```
