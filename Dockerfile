FROM serversideup/s6-overlay:ubuntu-22.04

RUN apt update

# Add "add-apt-repository" command
RUN apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg

# Add additional repositories for PHP, Redis, and MariaDB
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php

# Add Redis official APT repository
RUN curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list

# Update repositories list
RUN apt update

# Install Dependencies
RUN apt -y install php8.1 php8.1-common php8.1-cli php8.1-gd php8.1-mysql php8.1-mbstring php8.1-bcmath php8.1-xml php8.1-fpm php8.1-curl php8.1-zip mariadb-server nginx tar unzip git redis-server

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir -p /var/www/pterodactyl

WORKDIR /var/www/pterodactyl

RUN curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz && \
    tar -xzvf panel.tar.gz && \
    chmod -R 755 storage/* bootstrap/cache/

COPY /root /