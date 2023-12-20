#!/bin/bash

CONTAINER=${CONTAINER:-aibox-base-devel:latest}

XAUTHORITY=$(xauth info | grep "Authority file" | awk '{print $3}')
RENDER_GROUP_ID=$(stat -c '%g' /dev/dri/renderD128)

mkdir -p $HOME/models
chmod 777 $HOME/models

echo Running container ${CONTAINER}...

set -x
docker run -ti --rm ${ENTRYPOINT} \
    --device /dev/dri \
    --group-add ${RENDER_GROUP_ID} \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
    --volume ${HOME}/.Xauthority:/home/aibox/.Xauthority:ro \
    --volume ${HOME}/models:/home/aibox/models \
    --env DISPLAY=:0 \
    --env XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
    --env no_proxy=$no_proxy \
    ${CONTAINER} 
