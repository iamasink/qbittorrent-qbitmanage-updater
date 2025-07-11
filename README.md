# qbittorrent & qbitmanage version matcher

A minimal container that sets an env var so qbittorrent never updates past qbit_manage's supported versions
No more errors like this:
```
| Connecting to Qbittorrent...                                                                       
| qBittorrent: v5.1.0                                                                                
| qBittorrent Web API: 2.11.4                                                                        
| qbit_manage supported versions: v4.3.0 - v5.0.4                                                    
| Qbittorrent Error: qbit_manage is only compatible with v5.0.4 or lower. You are currently on v5.1.0. 
| Please downgrade your qBittorrent version to v5.0.4 to use qbit_manage.                            
```

## Instructions

1. Ensure you have a `.env` file for the `docker-compose.yml` that your qbittorrent container is in (may be empty)

2. Add this container to your docker-compose.yml
(see [docker-compose.yml](/docker-compose.yml))

And set the `.env` volume for this container  
(you can leave it as this default if its beside the docker-compose.yml)
```yml
    volumes:
      - ./.env:/.env:rw
```  


3. Modify your qbittorrent container image version like so:
```yml
    image: linuxserver/qbittorrent:${QBITTORRENT_VERSION:-latest}
```  


4. Run the container(s)!
```
docker compose up
```

