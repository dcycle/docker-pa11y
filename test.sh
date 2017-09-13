set -e
# If you change the node version here, please change it also in Dockerfile.
docker pull node:6
docker pull dcycle/pa11y
docker build -t local-dcycle-pa11y-image .

docker run dcycle/pa11y
docker run local-dcycle-pa11y-image
