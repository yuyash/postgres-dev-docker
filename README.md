# Docker for PostgreSQL Development

## Overview

This project provides a Docker environment for building and debugging PostgreSQL. It includes a `Dockerfile` and a `docker-compose.yml` file to simplify the setup process.

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
CONTAINER ID   IMAGE                         COMMAND       CREATED          STATUS          PORTS                    NAMES
1b44906a3c20   postgres/development:master   "/bin/bash"   33 seconds ago   Up 33 seconds   0.0.0.0:5432->5432/tcp   postgres-master
```

## Building PostgreSQL

### Step 1: Access the Container

Log into the container using:

```bash
docker exec -it postgres-master bash
```

You should be in the `/home/<YOUR_USER>/Workplace` directory.

### Step 2: Configure and Build PostgreSQL

Navigate to the postgresql directory and run the following commands:

```bash
cd postgresql
./configure --prefix=${PG_DIR_PREFIX} --enable-depend --enable-debug --enable-cassert --enable-tap-tests CFLAGS=-O0
make
make install
```

Note: The `PG_DIR_PREFIX` environment variable is set to `${HOME}/Workplace/build/postgres/master` by default. You can modify the `BUILD_DIR` argument in the `docker-compose.yml` file if you want to change the directory.

## Starting PostgreSQL

Run the following commands to start PostgreSQL:

```bash
${PG_DIR_PREFIX}/bin/initdb -D ${PG_DIR_PREFIX}/data
mkdir -p ${PG_DIR_PREFIX}/pg_log
${PG_DIR_PREFIX}/bin/pg_ctl -D ${PG_DIR_PREFIX}/data -l ${PG_DIR_PREFIX}/pg_log/postgresql.log start
```

## Logging into PostgreSQL

Use the `psql` command to log into your PostgreSQL instance:

```bash
${PG_DIR_PREFIX}/bin/psql -d postgres
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

## Stopping PostgreSQL

Run the following command to stop your PostgreSQL instance:

```bash
${PG_DIR_PREFIX}/bin/pg_ctl stop -D ${PG_DIR_PREFIX}/data -m smart
```

## Destroying the Docker Container

Use the following command to destroy the Docker container:

```bash
docker-compose down 
```

If you want to delete all images, add the `--rmi all` option:

```bash
docker-compose down --rmi all
```
