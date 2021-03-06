# mariadb-honey-alpine
Dockerized version of MariaDB as honeypot service, based on Alpine Linux

## Usage
You can run this container with this command:  
`docker run -d --name mariadb-honey-alpine -p 3306:3306 neomediatech/mariadb-honey-alpine`  

Logs are written inside the container, in /data/logs/, and on stdout. You can see realtime logs running this command:  
`docker logs -f mariadb-honey-alpine`  
`CTRL c` to stop seeing logs.  

If you want to map logs outside the container you can add:  
`-v /folder/path/on-host/logs/:/data/logs/`  
Where "/folder/path/on-host/logs/" is a folder inside your host. You have to create the host folder manually.  

You can run it on a compose file like this:  

```
version: '3'  

services:  
  mariadb:  
    image: neomediatech/mariadb-honey-alpine:latest  
    hostname: mariadb-honey  
    ports:  
      - '3306:3306'  
```
Save on a file and then run:  
`docker stack deploy -c /your-docker-compose-file-just-created.yml mariadb-honey`

If you want to map logs outside the container you can add:  
```
    volumes:
      - /folder/path/on-host/logs/:/data/logs/
```
Where "/folder/path/on-host/logs/" is a folder inside your host. You have to create the host folder manually.

Save on a file and then run:  
`docker stack deploy -c /your-docker-compose-file-just-created.yml mariadb-honey`  
