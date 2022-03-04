## Docker 
**Устанавливаем docker:**<br> 
```
sudo pacman -Syu
sudo pacman -S docker
```
Устанавливаем docker compose: `sudo pacman -S docker-compose`

## TOR 
![](https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Tor-logo-2011-flat.svg/306px-Tor-logo-2011-flat.svg.png)

**Проверка работоспособности:**<br>  
```
# Вне контейнера
curl --socks5 http://localhost:9050 -L http://ifconfig.me
# Из другого контейнера (192.168.0.141 - ip host)
curl --socks5 http://192.168.0.141:9050 -L http://ifconfig.me
```

**Переменные окружения:**<br> 
```
sudo nano ~/.bashrc
# Задаем переменные 
source ~/.bashrc
```
**Прокси у Firefox:**<br> 
![картинка](https://lumpics.ru/wp-content/uploads/2016/08/Tor-dlya-Firefox-3.png)

## Radarr
![](https://github.com/Radarr/Radarr/blob/develop/Logo/400.png?raw=true)

Чтобы обойти ограничение обхода списков (у меня [imdb](https://www.imdb.com), делаем его публичным) прописываем `crontab -e`: 
```
# Radarr
@hourly curl -X POST "http://localhost:7878/api/v3/command?apikey=yor_api_key" -H "accept: application/json" -d '{"name":"ImportListSync"}'
```
## Jackett
В  поля Proxy URL и Proxy port прописываем `IP` и `port` нашего TOR.

## Plex 
![картинка](https://lg-help.ru/img/868_1.gif)

[Образ](https://hub.docker.com/r/linuxserver/plex)

**claim**<br>
[claim](https://www.plex.tv/claim/)

**Запуск**<br>
`your-ip:32400/web`

**Стриминг на VLC** 
1. На сервере DLNA -> Включить DLNA сервер.
1. В плейлисте VLC открыть "Протокол UPnP".

**Смартфон** 
Устанавливаем [Plex: Stream Free Movies, Shows, Live TV & more](https://www.tvbox.one/apps/plex.html )

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
# Проверка работы 
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```
**Плагин для импорта метаданных фильмов**<br>
![картинка](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Kinopoisk_colored_logo_%282021-present%29.svg/220px-Kinopoisk_colored_logo_%282021-present%29.svg.png)<br>
Установка описана [тут](https://github.com/Jenstel/Kinopoisk.bundle).

## Смартфон
Устанавливаем [nzb360](https://play.google.com/store/apps/details?id=com.kevinforeman.nzb360)<br>
![](https://play-lh.googleusercontent.com/hjpWUw2sBsC0fpbPFUAChsjx-yC0-57zjZLdG8GQUw_FhVehK19pY0HIdDDysrdh7BM=s180)
