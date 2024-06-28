#!/bin/bash


# Build the image
ct-build()
{
    docker compose -f docker-compose.yml build
}

# Run the container
ct-up()
{
    docker compose -f docker-compose.yml up -d
}

# To take down the container
ct-down()
{
    echo "Stopping the containers.."
    docker compose down --remove-orphans &> /dev/null
    echo -e "\033[92mContainers Stopped successfully!\033[m"
}

# Run flask server
ct-run()
{
    ct-down
    ct-build
    ct-up
    docker compose -f docker-compose.yml run --rm web python -m flask run --debug

}

# Access interactive shell
ct-shell()
{
    ct-down
    ct-build
    ct-up
    docker compose -f docker-compose.yml run --rm web bash

}

ct-f8() {
    docker compose -f docker-compose.yml run --rm web python -m flake8
}