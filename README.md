#Docker Image for PHP-Apache by Float.com

## php-apache
dockerized php with PHP extensions for Yii:
  _mcrypt, gd, pdo mysql, phpredis, apache rewrite, etc._

### tags:
Dockerhub Tags: [https://hub.docker.com/r/floatapp/docker-php-apache/tags/](https://hub.docker.com/r/floatapp/docker-php-apache/tags/)

### php version - update FROM attribute in Dockerfile
see: https://hub.docker.com/_/php/ for more info

### build examples:
* `docker build -t floatapp/docker-php-apache:32-ab434ab`

### run examples:
* `docker-compose run`
* `docker-compose run --rm -p 8080:80`

### php Composer:
Composer installed to: /usr/local/bin/composer<br/>
Use it: `php /usr/local/bin/composer`