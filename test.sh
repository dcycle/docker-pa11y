set -e
# If you change the image here, please change it also in Dockerfile.
docker pull dcycle/browsertesting:3
docker pull dcycle/pa11y
docker build -t local-dcycle-pa11y-image .

docker run --rm dcycle/pa11y:1
docker run --rm local-dcycle-pa11y-image

docker run --rm --entrypoint='/bin/bash' local-dcycle-pa11y-image -c \
'export start_date=1000-01-01; \
export start_threshold=1000; \
export end_date=2999-04-25; \
export end_threshold=50; \
export verbose=1; \
python /scripts/calc-threshold.py'
docker run --rm --entrypoint='/bin/bash' local-dcycle-pa11y-image -c \
'export start_date=2019-01-01; \
export start_threshold=1000; \
export end_date=2019-04-25; \
export end_threshold=50; \
export verbose=1; \
python /scripts/calc-threshold.py'
docker run --rm --entrypoint='/bin/bash' local-dcycle-pa11y-image -c \
'export start_date=2019-01-01; \
export start_threshold=1000; \
export end_date=2019-04-25; \
export end_threshold=50; \
export verbose=0; \
python /scripts/calc-threshold.py'
