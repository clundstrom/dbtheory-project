# Database Theory - Assignment 3

This is the final project for the course 2DV513 at Linnaeus University winter 2020.

This project means to provide an API and Database backend for a personal website. 
When testing the application I recommend running it in Docker. Two simple commands will get everything up and running.
Use the following one liner from the directory for a quick start (omit -d if you don't want to run containers in detached mode).

``
docker-compose build db api && docker-compose up -d db api
``

To verify that the API is up and running it should be available at [http://localhost:8000/api/v1/test]() when deployed.

### Structure

* Database setup and constraints is found under **database_setup/setup.sql**
* Database Queries/Interface is found under **src/interfaces/open_interface.py**
* API endpoints is found under **src/routes/open.py**


### Container environment

* Requires Docker 19.03 and docker-compose 3.8 

**/database_setup/db.env**
```dotenv
# DB SETUP ENVIRONMENT VARIABLES
MYSQL_HOST=localhost
MYSQL_USER=dbtheory
MYSQL_PASSWORD=thisisapassword
MYSQL_ROOT_PASSWORD=thisisarootpassword
MYSQL_DATABASE=general
MYSQL_PORT=3306
```

**/api_setup/api.env**
```dotenv
# DB CONNECTION ENVIRONMENT
MYSQL_HOST=localhost
MYSQL_USER=dbtheory
MYSQL_PASSWORD=thisisapassword
MYSQL_ROOT_PASSWORD=thisisarootpassword
MYSQL_DATABASE=general
MYSQL_PORT=3306

# MISC
RUN_IN_CONTAINER=1
DEBUG=0
```
Api and db connection requries matching credentials. Using separate credential files allows for better decoupling.

#### Building images
```bash
docker-compose build api db
```

#### Starting containers
```bash
docker-compose up -d api db
```

#### Stopping containers
```bash
docker-compose down
```

### Local environment

#### Install dependencies

* MariaDB 10.5.5
* Python packages

```bash
pip install -r api_setup/req.txt
```

#### Setting Environments

```dotenv
# Must be set to zero when running locally. 
# If not MYSQL_HOST will resolve to docker internal hostname 'db'
RUN_IN_CONTAINER=0
```

Setup tables using setup.sql in MariaDB.

#### Running

```bash
python server.py
``` 