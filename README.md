# Docker Local Dev Bootstrapper 

This is a template used for your app to bootstrap a docker container locally for development purpose.

## How to use

1. Update `docker/config.sh` with your local settings
2. Complete `docker/Dockerfile` to build the base docker image for your application
3. Clone / Copy your app code to root directory
4. Start the container with

```
bash docker/start.sh
```

5. To start a debug interative ssh session:

```
bash docker/debug.sh
```

## Clean up after done

```
bash docker/purge.sh
```