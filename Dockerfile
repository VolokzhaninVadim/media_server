FROM linuxserver/plex:latest

# add scripts to modify plex binaries
COPY root/ /
RUN chmod +x /etc/plex-nvdec-patch/transcoder-nvdec-patch.sh