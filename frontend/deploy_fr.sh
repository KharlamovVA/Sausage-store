#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service

#Переносим артефакт в нужную папку
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPOFRONT_URL}/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo cp ./sausage-store.tar.gz /home/front-user/sausage-store.tar.gz||true #"<...>||true" говорит, если команда обвалится — продолжай
sudo mkdir /home/front-user/frontend
sudo mkdir /home/front-user/test
sudo cp /home/front-user/sausage-store.tar.gz /home/front-user/test
sudo tar xzf /home/front-user/sausage-store.tar.gz
sudo tar xzf /home/front-user/test/sausage-store.tar.gz
#sudo rm -f /home/front-user/sausage-store.tar.gz||true
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-frontend 