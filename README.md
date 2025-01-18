## [Radarr](https://github.com/linuxserver/docker-radarr?ysclid=lanu31pwpf129931383)
Film finder

![image](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/radarr.png)

## [Sonarr](https://github.com/linuxserver/docker-sonarr)
TV series finder

![image](https://github.com/Sonarr/Sonarr/blob/develop/Logo/256.png)

## [Lidarr](https://github.com/linuxserver/docker-lidarr?ysclid=lanu5lhe2r188588298)
Music finder

![image](https://github.com/lidarr/Lidarr/raw/develop/Logo/256.png)

## [Photoprism](https://github.com/photoprism/photoprism?ysclid=lanua0fmt9285434596)
AI-Powered Photos/Videos App

![image](https://dl.photoprism.app/img/logo/logo.svg)

## [Jackett](https://github.com/linuxserver/docker-jackett)
Torrents indexator

![image](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/jackett-banner.png)

In fields 'Proxy URL' and 'Proxy port' set ip and port our tor proxy.

## [Toerrserver](https://github.com/YouROK/TorrServer)
Torrent stream server

![](https://cs9f3b.4pda.ws/24750223.png)

For Android [download](https://f-droid.org/packages/ru.yourok.torrserve)

## [Lampa](https://github.com/immisterio/Lampac)
Media server for torrents

![](https://raw.githubusercontent.com/yumata/lampa/fcf3d5e6ff4a7bcab079705c600907b7cc8be4a0/img/logo-icon.svg)

[Apps](https://cub.red/lampa)

## [Plex](https://github.com/linuxserver/docker-plex?ysclid=lanuewxt9n57033389)
Media server

![image](https://lg-help.ru/img/868_1.gif)

[Source image](https://hub.docker.com/r/linuxserver/plex). I took the idea from [plex-nvdec](https://github.com/niXta1/plex-nvdec).

**claim**<br>
[claim](https://www.plex.tv/claim/)

**Launch**<br>
`your-ip:32400/web`

**Streaming in VLC**
1. On server DLNA -> DLNA on.
1. In playlist VLC open "Protocol UPnP".

**Transcode Nvidia**
* Delete old drivers
```bash
# Del old drivers
sudo apt remove nvidia-*
sudo add-apt-repository --remove ppa:graphics-drivers/ppa
sudo apt remove xserver-xorg-video-nvidia-*
sudo apt update
rm -Rf /usr/local/cuda/
sudo reboot
```
* Install drivers and cuda
```bash
# Install 
sudo apt install build-essential
gcc --version


wget https://us.download.nvidia.com/XFree86/Linux-x86_64/550.107.02/NVIDIA-Linux-x86_64-550.107.02.run 
chmod +x NVIDIA-Linux-x86_64-550.107.02.run 
sudo sh ./NVIDIA-Linux-x86_64-550.107.02.run
sudo reboot
```
* Install container for work cuda in docker 
```bash 
sudo apt install nvidia-cuda-toolkit

curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo sed -i -e '/experimental/ s/^#//g' /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update 
sudo apt-get install -y nvidia-container-toolkit
```
Edit `/etc/docker/daemon.json`: 
```json
{
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    },
    "default-runtime": "nvidia"
}
```
`sudo systemctl restart docker`

* Check work
```bash
# Check work 1
docker run --rm --gpus all nvidia/cuda:11.0.3-base-ubuntu20.04 nvidia-smi

# Check work 2
nvidia-smi

```
![image](https://user-images.githubusercontent.com/27136123/158003064-36a0e350-ce76-4f23-99f0-5c9f930171b2.png)

**Plagin for import films**<br>
![image](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Kinopoisk_colored_logo_%282021-present%29.svg/220px-Kinopoisk_colored_logo_%282021-present%29.svg.png)<br>
[Describing of install](https://github.com/Jenstel/Kinopoisk.bundle).<br>
[All plex-plugins](https://github.com/Plex-Plugins).

## Cron
```bash
# Radarr
@hourly curl -i -s -k -X $'POST' -H $'Host: vvy.tplinkdns.com:7878' -H $'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:97.0) Gecko/20100101 Firefox/97.0' -H $'Accept: application/json, text/javasc>
# Photoprism
@hourly docker exec -t photoprism photoprism index
# Change owner
@daily sudo chown -R ubuntu:ubuntu /mnt/media/video /mnt/media/serial /mnt/media/music
```
## Smartphone
1. Install [nzb360](https://play.google.com/store/apps/details?id=com.kevinforeman.nzb360)<br>
![](https://play-lh.googleusercontent.com/hjpWUw2sBsC0fpbPFUAChsjx-yC0-57zjZLdG8GQUw_FhVehK19pY0HIdDDysrdh7BM=s180)
1. Install [plex](https://play.google.com/store/apps/details/Plex_Stream_Free_Movies_Watch_Live_TV_Shows_Now?id=com.plexapp.android&hl=en_GB&gl=US)<br>
![](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Plex_logo_2022.svg/120px-Plex_logo_2022.svg.png)

## Browser
Install add-on [Servarr Auto Search (Sonarr, Radarr, Lidarr and Readarr)](https://github.com/trossr32/sonarr-radarr-lidarr-autosearch-browser-extension).
