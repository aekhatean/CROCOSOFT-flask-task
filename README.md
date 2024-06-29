# CROCOSOFT task

Develop a Dockerized Python simple social network. 

## Prerequisites

- WSL (For non-unix users)
- Docker

## clone this repository

- Open your terminal in your home directory (Optional location).
- Create a `src` directory to contain the project
  - mkdir src && cd src
  - clone the repository

## Docker Scripts Setup (One Use)

1. Run `source scripts.sh`.
2. Stay in the same terminal to be able to access docker shell commands.

## Docker Scripts Setup (Permenant)

1. Make sure your docker is installed and the daemon is running
   - By running: `docker ps`
2. Set environment variables in your ~/.profile or ~/.bash_profile:
   ```
   export CT_DIR="{the absolute path to the repo}"
   ```
   Example: `/home/user/src/crocosoft-task`
3. Open new terminal to load the new variable
4. Load docker shell commands
   - Go to the project root directory and run `source scripts.sh`
   - Or you can add `source ${CT_DIR}/scripts.sh`to your ~/.bash to have the commands always available.

## Project Setup

Once shell commands are loaded, you can now use them to set and run the project in this order:

1.  create `.env` file by running `cp sample.env .env` and fill it with you credintials.
2.  `ct-build`: to build docker container from image.
3.  `ct-up`: to run the container
4.  `ct-run`: to run flask server
5.  `ct-down`: Once you are done with the container you can use this command to take it down (recommended to save your computer resources).

NOTE: If you run ct-run, it will automatically build and start up the container.
NOTE: After runing the container for the first time, give it a fex seconds before making requests just to make sure all services are up.

## DB ERD

![alt text](<db-erd.png>)

