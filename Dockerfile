# If you change the image here, please change it also in test.sh.
FROM dcycle/browsertesting:3

RUN mkdir -p /app/code

RUN cd /app && npm install pa11y

WORKDIR /app

ADD docker-resources/config.json /app/config/config.json

ENTRYPOINT [ "node_modules/.bin/pa11y", "-c", "/app/config/config.json" ]
