[![CircleCI](https://circleci.com/gh/dcycle/docker-pa11y.svg?style=svg)](https://circleci.com/gh/dcycle/docker-pa11y)

Find accessibility problems with [Pa11y](https://github.com/pa11y/pa11y)

Get help:

    docker run dcycle/pa11y

Run pa11y on amazon.com:

    docker run dcycle/pa11y https://amazon.com

See [this project on the Docker Hub](https://hub.docker.com/r/dcycle/pa11y/).

How to run a test on a local website managed through Docker Compose 
-----

Let's say you have a Docker Compose setup with a service named "web", you might have a `docker-compose.yml` file like this:

    ...
    services:
      web:
        build: .
        ports:
          - "80"
        working_dir: /var/www/html
        restart: always
    ...

Now, you want to run accessibility tests against this from within a continuous integration server, or your local setup:

First, find the network name for your project, this is normally something like "parent_directory_name_default":

    $ docker network ls
    NETWORK ID          NAME                   DRIVER              SCOPE
    ...
    84a94edcb1b7        myproject_default      bridge              local
    ...

In the above example it's myproject_default. Now to get an accessibility report during local development or continuous integration, run:

    docker run --network=myproject_default dcycle/pa11y https://web
    
In the above example, the network name is "myproject_default" and the service name is "web" (which corresponds to the name of the service in the docker-compose.yml file).

Troubleshooting
-----

If you get "PhantomJS operation canceled" but you can see the website just fine in your browser, you may have an authentication popup which was "remembered" in your browser. Visit the site with a browser you rarely use or another device on which you haven't yet visited the site to see if it requires an htauth username/password, and disable it. See also https://github.com/pa11y/pa11y/pull/310, yet I'm not sure how to do this within the Docker container.
