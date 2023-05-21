#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -rf /home/${DEV_USER}/sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service
#Переносим артефакт в нужную папку
sudo curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o /home/jarservice/sausage-store-${VERSION}.jar ${NEXUS_REPOBACK_URL}/${VERSION}/sausage-store-${VERSION}.jar
sudo cp /home/jarservice/sausage-store-${VERSION}.jar /home/jarservice/sausage-store.jar||true #"<...>||true" говорит, если команда обвалится — продолжай
sudo rm -f /home/jarservice/sausage-store-${VERSION}.jar||true
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-backend 