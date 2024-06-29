from os import environ

MYSQL_DATABASE = environ.get('MYSQL_DATABASE')
MYSQL_USER = environ.get('MYSQL_USER')
MYSQL_PASSWORD = environ.get('MYSQL_PASSWORD')
MYSQL_ROOT_PASSWORD = environ.get('MYSQL_ROOT_PASSWORD')
DB_CONF = {
    "host": "db",  # Use the service name defined in docker-compose.yml
    "database": MYSQL_DATABASE,
    "user": MYSQL_USER,
    "password": MYSQL_PASSWORD,
}
