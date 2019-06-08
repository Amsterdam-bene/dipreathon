Dipreathon
==========

## Run latest docker container
There is an autobuild following the master branch, you can run it simply with
```
IMAGE="amsterdambene/bot"
ALIAS="botfurbone"

docker stop "${ALIAS}" 2>/dev/null
docker rm "${ALIAS}" 2>/dev/null
docker pull "${ALIAS}" 2>/dev/null
docker run -d --restart unless-stopped \
    -e TZ='Europe/Amsterdam' \
    -v /tmp/my_config_file.yaml:/usr/src/bot/etc/config.yaml \
    --name "${ALIAS}" "${IMAGE}"
```

The sample config file in the repo provides a working bot to start from.

## Developing the bot

Prep the enviroment
```
git submodule init
git submodule update
```

Write new bugs and test them
```
docker build --pull  -t bot_name .
docker run bot_name
```

Commit your changes and open a PR, when approved the docker hub repo will update accordingly.
