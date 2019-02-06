# Dockerfile for dehydrated incl. Hetzner hook


## Build image
```
cd docker-dehydrated-hetzner
docker build --tag letsencrypt .
```

## Prepare volume
```
mkdir /opt/letsencrypt
cp config/config /opt/letsencrypt
cp config/domains.txtexample /opt/letsencrypt/domains.txt
vim /opt/letsencrypt/domains.txt
```

## Run the container

run once to register account
```
docker run --rm -it -v /opt/letsencrypt:/etc/dehydrated letsencrypt --register --accept-terms
```

create / update certificats
```
docker run --rm -it \
       -e "HETZNER_AUTH_USERNAME=xxx" \
       -e "HETZNER_AUTH_PASSWORD=xxx" \
       -v /opt/letsencrypt:/etc/dehydrated \
       --user ($id -u):$(id -g) \
       letsencrypt -c
```
