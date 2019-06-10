[![CircleCI](https://circleci.com/gh/dcycle/docker-pa11y.svg?style=svg)](https://circleci.com/gh/dcycle/docker-pa11y)

Find accessibility problems with [Pa11y](https://github.com/pa11y/pa11y)

Get help:

    docker run --rm dcycle/pa11y:2

Run pa11y on amazon.com:

    docker run --rm dcycle/pa11y:2 https://amazon.com

See [this project on the Docker Hub](https://hub.docker.com/r/dcycle/pa11y/).

About the Axe runner
-----

Version 1 of this image (dcycle/pa11y:1) uses the standard pa11y runner. A more standard alternative, the [https://www.deque.com/axe/](Axe runner), can be used as the engine instead. That is what is used on branch 2 (dcycle/pa11y:2).

Thresholds
-----

One technique to avoid being overwhelmed by dozens, or hundreds of accessibility errors on a legacy site is to define thresholds. For example, you might want to accept 100 errors on a site but not more; in which case you can do:

    docker run --rm dcycle/pa11y:2 https://example.com -T 100

Thresholds diminishing with time
-----

This image ships with a utility allowing to define diminishing thresholds. For example if your team decides that you want to go from a threshold of 100 errors on Jan 1st, 2019, to a threshold of 50 errors on Jan 1st, 2020, you can run:

    THRESHOLD=$(docker run --rm --entrypoint='/bin/bash' dcycle/pa11y:2 -c \
    'export start_date=2019-01-01; \
    export start_threshold=100; \
    export end_date=2020-01-01; \
    export end_threshold=50; \
    export verbose=0; \
    python /scripts/calc-threshold.py')
    docker run --rm dcycle/pa11y:2 https://example.com -T "$THRESHOLD"

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

    docker run --rm --network myproject_default dcycle/pa11y:2 http://web

In the above example, the network name is "myproject_default" and the service name is "web" (which corresponds to the name of the service in the docker-compose.yml file).

Resources
-----

* [An approach to automating Drupal accessibility tests, April 07, 2019, Dcycle blog](https://blog.dcycle.com/blog/2019-04-07/accessibility/).

Troubleshooting
-----

If you get "PhantomJS operation canceled" but you can see the website just fine in your browser, you may have an authentication popup which was "remembered" in your browser. Visit the site with a browser you rarely use or another device on which you haven't yet visited the site to see if it requires an htauth username/password, and disable it. See also https://github.com/pa11y/pa11y/pull/310, yet I'm not sure how to do this within the Docker container.
