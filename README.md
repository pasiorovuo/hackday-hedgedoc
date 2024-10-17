# A preconfigured HedgeDoc deployment for hackparties

# DEPLOYMENT

Copy `.env_template` to `.env` and input proper values for the variables. For instructions on setting up an Entra ID
application, see Microsoft's documentation. Once the environment variables are set, execute `docker compose up`. After a
few minutes a Let's Encrypt certificate should be acquired automatically for given domain, and you should be good to go.

## Docker Compose installation on Amazon Linux 2

Amazon Linux 2 does not have Docker Compose in the package repository. To install it, execute:

```bash
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.29.6/docker-compose-linux-aarch64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
docker compose version
```
