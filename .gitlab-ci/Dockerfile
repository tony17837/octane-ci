# This Dockfile is used for the web container in Kubernetes cluster
FROM outrigger/apache-php:php71

# Things to support drush.
RUN yum install -y mysql which rsync

# Add composer installed tools to path.
ENV PATH=$PATH:/var/www/vendor/bin

# Allow PHP settings to be customized.
COPY ./.gitlab-ci/etc/99-project-php-settings.ini /etc/opt/remi/php71/php.d/99-project-php-settings.ini

# Bring the codebase in. Note that CI will move this Dockerfile
# before executing it so paths should be relative to the repo root
COPY . /var/www
