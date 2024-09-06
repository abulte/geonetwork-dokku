# geonetwork-dokku

Hosts a geonetwork 3 on dokku with postgres.

Needs a postgis database:

```
dokku postgres:create geonetwork --image "postgis/postgis" --image-version "13-3.4"
dokku postgres:link geonetwork geonetwork
```

Needs port mapping redefiniton:

```
dokku ports:add http:80:8080
dokku ports:remove http:8080:8080
```

`custom-entrypoint.sh` will parse `$DATABASE_URL` and set the necessary environment variables for geonetwork, and call the original entrypoint to init the database.

➡️ https://geonetwork.app.france.sh/geonetwork/

## TODO

- [ ] add a volume for catalog data
