#Docker Image for PHP-Apache by Float.com

## php-apache
dockerized php with PHP extensions for Yii:
  _mcrypt, gd, pdo mysql, phpredis, apache rewrite, etc._

### tags:
Dockerhub Tags: [https://hub.docker.com/r/floatapp/docker-php-apache/tags/](https://hub.docker.com/r/floatapp/docker-php-apache/tags/)

### php version - update FROM attribute in Dockerfile
see: https://hub.docker.com/_/php/ for more info

### build examples:
* `docker build -t floatapp/docker-php-apache:32-ab434ab .`

### run example:
* `docker run --rm -p8081:80 -v $(pwd)/html:/var/www/html floatapp/docker-php-apache:20-a60f186`

### php Composer:
Composer installed to: /usr/local/bin/composer<br/>
Use it: `php /usr/local/bin/composer`