set -e
docker pull node
docker pull dcycle/pa11y
docker build -t local-dcycle-pa11y-image .

docker run dcycle/pa11y
docker run local-dcycle-pa11y-image
