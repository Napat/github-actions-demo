```sh
napat_joe@napat-001:~$ ls
Caddyfile  compose.caddy.yaml  compose.nginx.yaml  compose.wt.yaml  compose.yaml  snap
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ cat Caddyfile 
r00.duckdns.org {
        reverse_proxy web:3000
}
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ cat compose.caddy.yaml 
version: "3"s

services:
  caddy:
    container_name: caddy
    image: caddy:2
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config:/config
    # extra_hosts:
    #   - "host.docker.internal:host-gateway"
    networks:
      - caddy
networks:
  caddy:
    external: true
volumes:
  caddy_data:
  caddy_config:
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ cat compose.nginx.yaml 
services:
  nginx:
    image: nginx:latest
    container_name: nginx
    networks:
      - caddy
    labels:
      - "com.centurylinklabs.watchtower.enable=true"
networks:
  caddy:
    external: true
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ cat compose.wt.yaml 
services:
  watchtower:
    image: containrrr/watchtower
    container_name: watchtower
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      # --- การตั้งค่าพื้นฐาน ---
      - WATCHTOWER_LABEL_ENABLE=true
      - WATCHTOWER_POLL_INTERVAL=30
      - WATCHTOWER_ROLLING_RESTART=true

      # --- การตั้งค่าเพิ่มเติม ---
      - WATCHTOWER_CLEANUP=true
      - WATCHTOWER_NOTIFICATIONS=shoutrrr
      - WATCHTOWER_NOTIFICATIONS_LEVEL=info
      #- WATCHTOWER_NOTIFICATION_URL=discord://token@channel
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ 
napat_joe@napat-001:~$ cat compose.yaml 
services:
  web:
    image: napat/github_actions_demo:latest
    container_name: github_actions_demo
    ports:
      - "3000:3000"
    restart: always
    labels:
      - "com.centurylinklabs.watchtower.enable=true"
    networks:
      - caddy
networks:
  caddy:
    external: true
napat_joe@napat-001:~$ 
```
