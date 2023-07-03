#!/bin/bash

# Atualizar repositórios
sudo apt-get update

# Instalar o Apache e PHP
sudo apt-get install apache2 -y
/etc/init.d/apache2 restart
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 php php-cli php-dev php-curl php-gd libapache2-mod-php --assume-yes
/etc/init.d/apache2 restart

# Configurar o Postfix
sudo debconf-set-selections <<< postfix postfix/mailname string mail.live.com
sudo debconf-set-selections <<< postfix postfix/main_mailer_type string 'Internet Site'
sudo apt-get install -y postfix
sudo /etc/init.d/postfix restart

# Instalar pacotes adicionais
sudo apt-get -y install unzip
sudo apt-get -y install make

# Reiniciar serviços
sudo service postfix restart
sudo /etc/init.d/apache2 restart

# Dar permissões ao diretório do Apache
chmod -R 0777 /var/www/html/

# Limpar o histórico de comandos
history -c
