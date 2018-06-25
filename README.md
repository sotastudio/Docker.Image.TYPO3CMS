# TYPO3 CMS Docker Images

Just a kickstart repo to get things started quickly. Images are build on debian stretch slim.

## Usage

**Create database container**

```
$ docker run -d --name typo3-db \
    -e MYSQL_ROOT_PASSWORD=yourrootpassword \
    -e MYSQL_USER=typo3 \
    -e MYSQL_PASSWORD=yourpassword \
    -e MYSQL_DATABASE=typo3 \
    mariadb:latest \
    --character-set-server=utf8 \
    --collation-server=utf8_unicode_ci
```

**Create web container**

```
$ docker run -d --name typo3-web \
    --link typo3-db:db \
    -p 80:80 \
    sotastudio/typo3cms:8
```

**Get started**

Call localhost and setup the CMS. Use above defined database container name instead of localhost or 127.0.0.1.