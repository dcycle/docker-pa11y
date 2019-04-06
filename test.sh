set -e
# If you change the image here, please change it also in Dockerfile.
docker pull dcycle/browsertesting:3
docker pull dcycle/pa11y
docker build -t local-dcycle-pa11y-image .

docker run dcycle/pa11y
docker run local-dcycle-pa11y-image
