# Symfony Docker

Modifications apportées:

- Dockerfile
```
# Add Symfony CLI
COPY --link \
--from=ghcr.io/symfony-cli/symfony-cli:latest \
/usr/local/bin/symfony /usr/local/bin/symfony
```

- frankenphp/docker-entrypoint.sh
```
# Add Symfony ORM pack if a database is configured
composer req symfony/orm-pack

# Add Symfony Maker bundle for development environment
composer req --dev symfony/maker-bundle
```

.env
DATABASE_URL=mysql://${MYSQL_USER:-app}:${MYSQL_PASSWORD:-!ChangeMe!}@database:3306/${MYSQL_DATABASE:-app}?serverVersion=${MYSQL_VERSION:-8}&charset=${MYSQL_CHARSET:-utf8mb4}

Il est impératif de modifier les variables d'environnement MYSQL_USER, MYSQL_PASSWORD et MYSQL_DATABASE pour sécuriser l'accès à la base de données.


# Lancement de l'application

Création des conteneurs Docker
```bash
docker compose build --pull --no-cache
```

lancement de l'application Symfony:

```bash
docker compose up --wait
```

Tester le setup avec la base de données MySQL:

```
docker compose exec php bin/console dbal:run-sql -q "SELECT 1" && echo "OK" || echo "Connection is not working"
```

Open `https://localhost` in your favorite web browser and [accept the auto-generated TLS certificate](https://stackoverflow.com/a/15076602/1352334)

# Eteindre l'application

Run `docker compose down --remove-orphans` to stop the Docker containers.


A [Docker](https://www.docker.com/)-based installer and runtime for the [Symfony](https://symfony.com) web framework,
with [FrankenPHP](https://frankenphp.dev) and [Caddy](https://caddyserver.com/) inside!

![CI](https://github.com/dunglas/symfony-docker/workflows/CI/badge.svg)

## Getting Started

1. If not already done, [install Docker Compose](https://docs.docker.com/compose/install/) (v2.10+)
2. Run `docker compose build --pull --no-cache` to build fresh images
3. Run `docker compose up --wait` to set up and start a fresh Symfony project
4. Open `https://localhost` in your favorite web browser and [accept the auto-generated TLS certificate](https://stackoverflow.com/a/15076602/1352334)
5. Run `docker compose down --remove-orphans` to stop the Docker containers.

## Features

- Production, development and CI ready
- Just 1 service by default
- Blazing-fast performance thanks to [the worker mode of FrankenPHP](https://frankenphp.dev/docs/worker/)
- [Installation of extra Docker Compose services](docs/extra-services.md) with Symfony Flex
- Automatic HTTPS (in dev and prod)
- HTTP/3 and [Early Hints](https://symfony.com/blog/new-in-symfony-6-3-early-hints) support
- Real-time messaging thanks to a built-in [Mercure hub](https://symfony.com/doc/current/mercure.html)
- [Vulcain](https://vulcain.rocks) support
- Native [XDebug](docs/xdebug.md) integration
- Super-readable configuration

**Enjoy!**

## Docs

1. [Options available](docs/options.md)
2. [Using Symfony Docker with an existing project](docs/existing-project.md)
3. [Support for extra services](docs/extra-services.md)
4. [Deploying in production](docs/production.md)
5. [Debugging with Xdebug](docs/xdebug.md)
6. [TLS Certificates](docs/tls.md)
7. [Using MySQL instead of PostgreSQL](docs/mysql.md)
8. [Using Alpine Linux instead of Debian](docs/alpine.md)
9. [Using a Makefile](docs/makefile.md)
10. [Updating the template](docs/updating.md)
11. [Troubleshooting](docs/troubleshooting.md)

## License

Symfony Docker is available under the MIT License.

## Credits

Created by [Kévin Dunglas](https://dunglas.dev), co-maintained by [Maxime Helias](https://twitter.com/maxhelias) and sponsored by [Les-Tilleuls.coop](https://les-tilleuls.coop).
