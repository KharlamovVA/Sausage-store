#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
sudo rm -f /home/front-user/frontend||true
#Переносим артефакт в нужную папку
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPOFRONT_URL}/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo cp ./sausage-store.tar.gz /home/front-user/frontend||true #"<...>||true" говорит, если команда обвалится — продолжай
tar xvzf /home/front-user/frontend/sausage-store.tar.gz
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-backend 