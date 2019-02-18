FROM outrigger/apache-php:php71

# Things to support drush
RUN yum install -y mysql which
ENV PATH=$PATH:/var/www/vendor/bin

COPY ./.gitlab-ci/99-project-php-settings.ini /etc/opt/remi/php71/php.d/99-project-php-settings.ini

# Bring the codebase in. Note that CI will move this Dockerfile
# before executing it so paths should be relative to the repo root
COPY . /var/www
# COPY ./.gitlab-ci/settings.common-client.php /var/www/src/sites/settings.common-client.php
