FROM node:6

RUN mkdir -p /app/code

RUN cd /app && npm install -g pa11y

WORKDIR /app

ENTRYPOINT [ "pa11y" ]
