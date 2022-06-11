## Docker (Ubuntu)
```
# Устаналиваем пакеты для работы с сетью
sudo apt install net-tools
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
# Устанавливаем Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get -y install docker-ce
# Добавляем пользователя в группу docker, чтобы не запускать docker через sudo
sudo usermod -aG docker ${USER}
# Устанавливаем docker-compose
sudo apt install python3-pip
sudo pip3 install docker-compose

# fix ошибки failed to add the host (veth92ce8d0) <=> sandbox (veth7a8e3f2) pair interfaces: operation not supported
sudo apt install linux-modules-extra-raspi
```

## TOR 
![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Tor-logo-2011-flat.svg/306px-Tor-logo-2011-flat.svg.png)

**Переменные окружения:**<br> 
```
sudo nano /etc/bash.bashrc 
# Задаем переменные 
source /etc/bash.bashrc 
```
Пример конфигурации взял [отсюда](https://gitlab.com/skobkin/docker-stacks/-/tree/master/tor-privoxy). Там же взял пример [torrc](https://gitlab.com/skobkin/docker-stacks/-/blob/master/tor-privoxy/config/torrc.dist).

**Проверка работоспособности:**<br>  
```
# Вне контейнера
curl --socks5 http://localhost:9050 -L http://ifconfig.me
# Из другого контейнера (192.168.0.140 - ip host)
curl --socks5 http://192.168.0.140:9050 -L http://ifconfig.me
```
**Прокси у Firefox:**<br> 
![картинка](https://lumpics.ru/wp-content/uploads/2016/08/Tor-dlya-Firefox-3.png)

## Radarr
![](https://github.com/Radarr/Radarr/blob/develop/Logo/400.png?raw=true)

Чтобы обойти ограничение обхода списков (у меня [imdb](https://www.imdb.com), делаем его публичным) прописываем `crontab -e`: 
```
# Radarr
@hourly curl -i -s -k -X $'POST' \
    -H $'Host: host:7878' -H $'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:97.0) Gecko/20100101 Firefox/97.0' -H $'Accept: application/json, text/javascript, */*; q=0.01' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Content-Type: application/json' -H $'X-Api-Key: 43aa93d733de4a938cf6a8860fb46882' -H $'X-Requested-With: XMLHttpRequest' -H $'Content-Length: 25' -H $'Origin: http://host:7878' -H $'DNT: 1' -H $'Connection: close' -H $'Referer: http://host:7878/system/tasks' \
    --data-binary $'{\"name\":\"ImportListSync\"}' \
    $'http://host:7878/api/v3/command''
```
## Jackett
В  поля Proxy URL и Proxy port прописываем `IP` и `port` нашего TOR.

## Plex 
![картинка](https://lg-help.ru/img/868_1.gif)

[Образ](https://hub.docker.com/r/linuxserver/plex):
1. **lscr.io/linuxserver/plex** - образ использует ресурсы CPU при [транскодировании](https://en.wikipedia.org/wiki/Transcoding). 
1. **nixta/plex-nvdec** - образ использует ресурсы NVidia видеокарты при [транскодировании](https://en.wikipedia.org/wiki/Transcoding). При использовании этого образа не работает приложение на смартфоне и ТВ (не видны прокинутые папки).

**claim**<br>
[claim](https://www.plex.tv/claim/)


**Запуск**<br>
`your-ip:32400/web`

**Стриминг на VLC** 
1. На сервере DLNA -> Включить DLNA сервер.
1. В плейлисте VLC открыть "Протокол UPnP".

**Смартфон** приложение Nextcloud для смартфона устанавливаем через [FDroid](https://f-droid.org/). Мой [репозиторий Nextcloud](https://github.com/VolokzhaninVadim/nextcloud).

**Transcode Nvidia**
* Удаляем старые драйвера
```
# Удаляем старые драйвера
sudo apt remove nvidia-*
sudo add-apt-repository --remove ppa:graphics-drivers/ppa
sudo apt remove xserver-xorg-video-nvidia-*
sudo apt update
rm -Rf /usr/local/cuda/
sudo reboot
```
* Устанавливаем драйвера и cuda
```
# Возвращаем нужный репозиторий
sudo add-apt-repository ppa:graphics-drivers/ppa 
# Вывод всех доступных версий драйвера
sudo apt list nvidia-driver-* 
# Устанавливаем необхлодимую версию драйвера
sudo apt install nvidia-driver-450 
# Устанавливаем nv-runtime для докера
sudo apt-get install -y nvidia-container-toolkit 
sudo reboot
```
* Проверка работы 
```
# Проверка работы 1 
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi

# Проверка работы 2
nvidia-smi
```
![картинка](https://user-images.githubusercontent.com/27136123/158003064-36a0e350-ce76-4f23-99f0-5c9f930171b2.png)

**Плагин для импорта метаданных фильмов**<br>
![картинка](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Kinopoisk_colored_logo_%282021-present%29.svg/220px-Kinopoisk_colored_logo_%282021-present%29.svg.png)<br>
Установка описана [тут](https://github.com/Jenstel/Kinopoisk.bundle).

## Смартфон
Устанавливаем [nzb360](https://play.google.com/store/apps/details?id=com.kevinforeman.nzb360)<br>
![](https://play-lh.googleusercontent.com/hjpWUw2sBsC0fpbPFUAChsjx-yC0-57zjZLdG8GQUw_FhVehK19pY0HIdDDysrdh7BM=s180)
