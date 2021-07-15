Docker hub: https://hub.docker.com/r/sun7pro/

To build for multiple platform, use `docker buildx`:

```sh
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --name docker-multiarch --driver docker-container --use
docker buildx inspect --builder docker-multiarch --bootstrap
docker buildx build --builder docker-multiarch --platform linux/amd64,linux/arm/v7 -f 7.4.Dockerfile -t sun7pro/magento2-php-fpm:php7.4 --push .
```
