# If you change the image here, please change it also in test.sh.
# A note about using the base image dcycle/browsertesting:3 instead of "node"
# directly. With the latter, I get an "error while loading shared libraries"
# when trying to launch pa11y. I normally don't like to base of other than
# an official image, but because I know Chromium/Puppeteer (used by pa11y)
# work well on dcycle/browsertesting, I'll use that as a base image instead.
FROM dcycle/browsertesting:4

RUN mkdir -p /app/code && \
  cd /app && apk add --no-cache python3 && \
  npm install pa11y

WORKDIR /app

ADD docker-resources/config.json /app/config/config.json

ADD docker-resources/calc-threshold.py /scripts/calc-threshold.py

ENTRYPOINT [ "node_modules/.bin/pa11y", "-c", "/app/config/config.json" ]
