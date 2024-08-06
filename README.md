# Ovpn-Warp

This project made in order to make it possible to just forward a single port behind a ovpn connection using docker

this project uses [dperson/openvpn-client:latest](https://hub.docker.com/r/dperson/openvpn-client/) as its base image
and [warp](https://github.com/FMotalleb/warp) to forward the port

## How to run

0. build this container on your own machine
1. set your ovpn username and password in vpn/vpn.auth file
2. update contents of vpn/vpn.conf with your own .ovpn file
3. use the run command below to open a port to server only visible to the ovpn client

## Usage

```bash
docker run --rm -it \
  -v ./vpn/:/vpn \
  -p 22:22 \
  -e LISTEN_PORT=22 \
  -e REMOTE_ADDRESS=<target addr> \
  -e REMOTE_PORT=<target port> \
  --cap-add=NET_ADMIN \
  ovpn-warp
```

## Configuration: Environments

### Listening configuration

- listen address: LISTEN_ADDRESS (default: 0.0.0.0)
- listen port: LISTEN_PORT (default: 443)
- listen protocol: LISTEN_PROTOCOL (default: tcp)

### Remote configuration (target)

- remote address: REMOTE_ADDRESS (default: 1.1.1.1)
- remote port: REMOTE_PORT (default: 443)
- remote protocol: REMOTE_PROTOCOL (default: tcp)

### Misc

- max concurrent connections: MAX_THREADS (default: 50)
- timeout (closes connection after this time): TIMEOUT (default: 0/unlimited)

> In order to open more ports clone this repository and create more units in the warp.ini file (using supervisor configuration).

## Debugging

- logs will be recorder at /var/log/(service).log
- Ovpn client: /var/log/ovpn.log
- Warp: /var/log/warp.log
- Supervisor: /var/log/supervisord.log
