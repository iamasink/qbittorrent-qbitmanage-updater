# qbittorrent & qbitmanage version matcher

A minimal watcher container that keeps your `QBITTORRENT_VERSION` and `QBITTORRENT_API_VERSION` in sync with qbit_manage’s supported versions.

## Prerequisites
1. Ensure you have a .env file for the docker-compose.yml that your qbittorrent & qbit_manage containers are in (can be empty:)
```bash
touch .env
```
3. Modify your qbittorrent image version like so:
```yml
image: linuxserver/qbittorrent:${QBITTORRENT_VERSION:-5.1.0}
```