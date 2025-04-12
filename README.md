# Docker for PostgreSQL Development

## Overview

This project provides a Docker environment for building and debugging PostgreSQL. It includes a `Dockerfile` and a `docker-compose.yml` file to simplify the setup process.

Additionally, this project includes a configuration files for Visual Studio Code (VS Code). By using the tasks defined in this configuration file, you can build, run and debug PostgreSQL from VS Code interface.

## Setup Instructions

### Step 1: Clone the Repository

Clone this repository into your host machine:

```bash
git clone git@github.com:yuyash/postgres-development.git
```

Navigate into the cloned repository:

```bash
cd postgres-development
```

### Step 2: Launch Docker Container

Run the following command to launch the Docker container in detached mode:

```bash
docker-compose up -d
```

### Step 3: Verify Container Status

Check if the Docker container is running using:

```bash
docker ps
```

The output should resemble:

```bash
CONTAINER ID   IMAGE                         COMMAND                  CREATED         STATUS         PORTS     NAMES
6f7a496d36f5   postgres/development:master   "sh -c 'pg_ctl -l ${…"   9 seconds ago   Up 9 seconds             postgres-master
```

## Building PostgreSQL using Visual Studio Code

This section explains how to build and run PostgreSQL using VS Code. For instructions on using the command line, please refer to the next section. In addition to VS Code, we have also installed the following plugins:

Install the following extensions into local VS Code:

- [Docker](https://marketplace.visualstudio.com/items/?itemName=ms-azuretools.vscode-docker)
- [Dev Containers](https://marketplace.visualstudio.com/items/?itemName=ms-vscode-remote.remote-containers)

![Build](https://raw.github.com/wiki/yuyash/postgres-development/images/build.gif)

## Building & Running PostgreSQL using command line

### Step 1: Access the Container

Log into the container using:

```bash
docker exec -it postgres-master bash
```

You should be in the `/home/<YOUR_USER>/Workplace/postgresql` directory. If not, navigate to the directory.

### Step 2: Stop PostgreSQL

By default, PostgreSQL is running when you start the docker container. Stop it before start building PostgreSQL source code.

```bash
pg_ctl stop -m fast
```

### Step 2: Configure and Build PostgreSQL

Run the following commands:

```bash
make clean
./configure --prefix=${PG_DIR_PREFIX} --enable-depend --enable-debug --enable-cassert --enable-tap-tests CFLAGS=-O0
make
make install
```

Note: The `PG_DIR_PREFIX` environment variable is set to `${HOME}/Workplace/build/postgres/master` by default. You can modify the `BUILD_DIR` argument in the `docker-compose.yml` file if you want to change the directory.

### Step 3: Configure and Build PostgreSQL

The `PGDATA` directory is set to `${HOME}/Workplace/build/postgres/master/data`. Run the following commands to start PostgreSQL:

```bash
rm -rf ${PGDATA}/*
initdb -U postgres --auth-local=trust --auth-host=scram-sha-256
pg_ctl start -l ${PGDATA}/postgresql.log
```

### Step 4: Configure and Build PostgreSQL

Use the `psql` command to log into your PostgreSQL instance:

```bash
psql -U postgres -d postgres
```

Example output:

```bash
psql (18devel)
Type "help" for help.

postgres=# select version();
                                                    version                                                     
----------------------------------------------------------------------------------------------------------------
 PostgreSQL 18devel on aarch64-unknown-linux-gnu, compiled by gcc (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0, 64-bit
(1 row)

postgres-# \q
```

### Step 5: Configure and Build PostgreSQL

Run the following command to stop your PostgreSQL instance:

```bash
pg_ctl stop -m fast
```

## Debugging PostgreSQL backend process

For debugging PostgreSQL processes on VS Code, install the following extensions in the container-connected VS Code instance:

- [C/C++](https://marketplace.visualstudio.com/items/?itemName=ms-vscode.cpptools)
- [C/C++ Extension Pack](https://marketplace.visualstudio.com/items/?itemName=ms-vscode.cpptools-extension-pack)
- [PostgreSQL](https://marketplace.visualstudio.com/items/?itemName=cweijan.vscode-postgresql-client2)

![Debug](https://raw.github.com/wiki/yuyash/postgres-development/images/debug.gif)

## Destroying the Docker Container

Use the following command to destroy the Docker container:

```bash
docker-compose down 
```

If you want to delete all images, add the `--rmi all` option:

```bash
docker-compose down --rmi all
```
