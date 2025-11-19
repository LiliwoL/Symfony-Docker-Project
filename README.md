# Symfony Docker

Modifications apportées:

- Dockerfile
```
# Add Symfony CLI
COPY --link \
--from=ghcr.io/symfony-cli/symfony-cli:latest \
/usr/local/bin/symfony /usr/local/bin/symfony
```


---

# Lancement de l'application

Clone du dépôt

```bash
git clone
```

Création des conteneurs Docker
```bash
docker compose build --pull --no-cache
```

Lancement des containers Docker
```bash
docker compose up --wait
```

A la première exécution, il est nécessaire d'initialiser la base de données:

```dotenv
DATABASE_URL=mysql://${MYSQL_USER:-app}:${MYSQL_PASSWORD:-!ChangeMe!}@database:3306/${MYSQL_DATABASE:-app}?serverVersion=${MYSQL_VERSION:-8}&charset=${MYSQL_CHARSET:-utf8mb4}
```

Tester le setup avec la base de données MySQL:

```
docker compose exec php bin/console dbal:run-sql -q "SELECT 1" && echo "OK" || echo "Connection is not working"
```

Accès aux containers:
- Symfony https://localhost
  - Vous devrez valider le certificat TLS auto-signé. Pour que ça soit permanent, ajoutez-le aux certificats de confiance de votre OS.
  - https://stackoverflow.com/a/15076602/1352334
- PhpMyAdmin http://localhost:8080
- Adminer http://localhost:8081

# Eteindre l'application

Run `docker compose down --remove-orphans` to stop the Docker containers.

