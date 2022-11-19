## Docker (Ubuntu)
```
# Install packages for work with net
sudo apt install net-tools
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get -y install docker-ce
# Add user in docker group, that do not launch docker with sudo 
sudo usermod -aG docker ${USER}
# Install docker-compose
sudo apt install python3-pip
sudo pip3 install docker-compose
```

## [TOR](https://gitlab.com/skobkin/torproxy-obfs4)
![image](https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Tor-logo-2011-flat.svg/306px-Tor-logo-2011-flat.svg.png)

**Variable environments:**<br> 
```
sudo nano /etc/bash.bashrc 
# Set variables 
source /etc/bash.bashrc 
```
Example for config got from [here](https://gitlab.com/skobkin/docker-stacks/-/tree/master/tor-privoxy). Example for [torrc](https://gitlab.com/skobkin/docker-stacks/-/blob/master/tor-privoxy/config/torrc.dist).

**Checking work:**<br>  
```
# Outside of container
curl --socks5 http://localhost:9050 -L http://ifconfig.me
# From another container (192.168.0.140 - ip host)
curl --socks5 http://192.168.0.140:9050 -L http://ifconfig.me
```
**Proxy server in Firefox:**<br> 
![picture](https://lumpics.ru/wp-content/uploads/2016/08/Tor-dlya-Firefox-3.png)

## [Radarr](https://github.com/linuxserver/docker-radarr?ysclid=lanu31pwpf129931383)
Film finder

![image](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/radarr.png)

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

## [Plex](https://github.com/linuxserver/docker-plex?ysclid=lanuewxt9n57033389) 
Media server

![image](https://lg-help.ru/img/868_1.gif)

[image](https://hub.docker.com/r/linuxserver/plex):
1. **lscr.io/linuxserver/plex** - image use CPU for [transcode](https://en.wikipedia.org/wiki/Transcoding). 
1. **nixta/plex-nvdec** - image use NVIDIA for [транскодировании](https://en.wikipedia.org/wiki/Transcoding). Do not work app for smartphone, if you use this image (not visible folders).

**claim**<br>
[claim](https://www.plex.tv/claim/)

**Launch**<br>
`your-ip:32400/web`

**Streaming in VLC** 
1. On server DLNA -> DLNA on.
1. In playlist VLC open "Protocol UPnP".

**Transcode Nvidia**
* Del old drivers
```
# Del old drivers
sudo apt remove nvidia-*
sudo add-apt-repository --remove ppa:graphics-drivers/ppa
sudo apt remove xserver-xorg-video-nvidia-*
sudo apt update
rm -Rf /usr/local/cuda/
sudo reboot
```
* Install drivers and cuda
```
# Set repository
sudo add-apt-repository ppa:graphics-drivers/ppa 
# View all drivers
sudo apt list nvidia-driver-* 
# Install necessary driver version
sudo apt install nvidia-driver-450 
# Install nv-runtime for docker
sudo apt-get install -y nvidia-container-toolkit 
sudo reboot
```
* Check work
```
# Check work 1 
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi

# Check work 2
nvidia-smi
```
![image](https://user-images.githubusercontent.com/27136123/158003064-36a0e350-ce76-4f23-99f0-5c9f930171b2.png)

**Plagin for import films**<br>
![image](https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Kinopoisk_colored_logo_%282021-present%29.svg/220px-Kinopoisk_colored_logo_%282021-present%29.svg.png)<br>
[Describing of install](https://github.com/Jenstel/Kinopoisk.bundle).

## Cron 
```
# Radarr
@hourly curl -i -s -k -X $'POST' -H $'Host: vvy.tplinkdns.com:7878' -H $'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:97.0) Gecko/20100101 Firefox/97.0' -H $'Accept: application/json, text/javasc>
# Photoprism
@hourly docker exec -t photoprism photoprism index
# Change owner 
@daily sudo chown -R ubuntu:ubuntu /mnt/media/video /mnt/media/serial /mnt/media/music
```
## Smartphone
Install [nzb360](https://play.google.com/store/apps/details?id=com.kevinforeman.nzb360)<br>
![](https://play-lh.googleusercontent.com/hjpWUw2sBsC0fpbPFUAChsjx-yC0-57zjZLdG8GQUw_FhVehK19pY0HIdDDysrdh7BM=s180)
