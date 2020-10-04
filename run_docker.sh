#!/bin/bash

echo 'Building...'
docker build . -t speechsplit:latest

echo 'Creating volume...'
docker volume create \
  --driver local \
  --opt type=none \
  --opt device=./assets \
  --opt o=bind \
  assets_volume

  #--mount 'type=volume,src=assets_volume,dst=/app/assets' \
echo 'Running...'
docker run \
  -e MOUNT_DIR=/app/assets \
  -p 8080:8080 \
  -it \
  --rm \
  --init \
  --ipc=host \
  --gpus all \
  --entrypoint /bin/bash \
  speechsplit:latest

# source python/bin/activate ; jupyter notebook demo.ipynb --ip=0.0.0.0 --port=8080 --allow-root
