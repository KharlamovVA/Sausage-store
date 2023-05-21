
#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -rf /home/${DEV_USER}/sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
#sudo rm -f /home/front-user/sausage-store-${VERSION}.tar.gz||true
#Переносим артефакт в нужную папку
sudo curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o /home/${DEV_USER}/sausage-store-${VERSION}.tar.gz ${NEXUS_REPOFRONT_URL}/${VERSION}/sausage-store-${VERSION}.tar.gz
#sudo cp /home/front-user/sausage-store-${VERSION}.tar.gz /home/front-user/sausage-store.tar.gz||true #"<...>||true" говорит, если команда обвалится — продолжай
#sudo tar xzf /home/front-user/sausage-store.tar.gz||true #"<...>||true" говорит, если команда обвалится — продолжай
sudo tar xf /home/${DEV_USER}/sausage-store-${VERSION}.tar.gz ||true
sudo cp -R /home/${DEV_USER}/frontend /home/front-user/
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-frontend 