#!/bin/bash

# Создаем резервную копию
cd /home/volokzhanin/docker/media_server/
tar cvpzf /mnt/backup/backup/vvy_media_server/"$(date '+%Y-%m-%d').tar.gz" ./
# Удаляем архивы резервной копии старше n дней
find /mnt/backup/backup/vvy_media_server// -mtime +3 -type f -delete

# restore 
# cd /home/volokzhanin/docker/vvy_media_server// & tar xpvzf /mnt/backup/backup/vvy_media_server//2021-10-09.tar.gz
