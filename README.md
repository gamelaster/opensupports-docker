# opensupports-docker
Docker container for OpenSupports

# Installation

Firstly, create new folder and download `docker-compose.yml`
```bash
mkdir opensupports
wget https://raw.githubusercontent.com/gamelaster/opensupports-docker/master/docker-compose.yml
```
After, open `docker-compose.yml`, and change `MYSQL_PASSWORD=changeme` line with your unique password. Then run the compose:
```bash
docker-compose up -d
```

In `docker-compose.yml`, if `HOST=hostname/endpoint` is set it will override the default hostname value.

Now, browse to `http://yourip:5443/`, and proceed through installation. When it will ask for database credentials, fill it following:
- MySQL Host: `mariadb`
- MySQL Database: `opensupports`
- MySQL User: `opensupports`
- MySQL Password: `password you written in previous step`

And that's all.