# If you change the node version here, please change it also in test.sh.
FROM node:6

RUN mkdir -p /app/code

RUN cd /app && npm install -g pa11y

WORKDIR /app

ENTRYPOINT [ "pa11y" ]
