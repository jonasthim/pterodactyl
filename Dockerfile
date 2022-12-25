FROM serversideup/s6-overlay:ubuntu-22.04

RUN apt update

RUN apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg

RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php

RUN curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list

RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash

RUN apt update

RUN apt-add-repository universe

RUN apt -y install php8.1 php8.1-{common,cli,gd,mysql,mbstring,bcmath,xml,fpm,curl,zip} mariadb-server nginx tar unzip git redis-server