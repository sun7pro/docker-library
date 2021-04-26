Docker hub: https://hub.docker.com/r/sun7pro/

To build for multiple platform, use `docker buildx`:

```sh
docker buildx create --name docker-multiarch
docker buildx inspect --builder docker-multiarch --bootstrap
docker buildx build --builder docker-multiarch --platform linux/amd64,linux/arm/v7 -f 7.4.Dockerfile -t sun7pro/magento2-php-fpm:php7.4 --push .
```
