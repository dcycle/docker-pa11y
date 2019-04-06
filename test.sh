set -e
# If you change the image here, please change it also in Dockerfile.
docker pull dcycle/browsertesting:3
docker pull dcycle/pa11y
docker build -t local-dcycle-pa11y-image .

docker run --rm dcycle/pa11y:1
docker run --rm local-dcycle-pa11y-image
