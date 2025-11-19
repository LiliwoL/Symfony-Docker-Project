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
docker-compose build --pull --no-cache
```

Lancement des containers Docker
```bash
docker-compose up --wait
```


Accès aux containers:
- Symfony https://localhost
  - Vous devrez valider le certificat TLS auto-signé. Pour que ça soit permanent, ajoutez-le aux certificats de confiance de votre OS.
  - https://stackoverflow.com/a/15076602/1352334


# Eteindre l'application

Run `docker-compose down --remove-orphans` to stop the Docker containers.

