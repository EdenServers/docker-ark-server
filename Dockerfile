FROM ubuntu:latest
MAINTAINER EdenServers

#Ubuntu Requirements
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get -y install lib32gcc1 wget

#Ark Requirements
ADD sysctl.conf /etc/sysctl.conf 
RUN sysctl -p /etc/sysctl.conf
ADD limits.conf /etc/security/limits.conf
ADD common-session /etc/pam.d/common-session

#Steamcmd installation
RUN mkdir -p /server/steamcmd
RUN mkdir -p /server/ark
WORKDIR /server/steamcmd
RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
RUN tar -xvzf steamcmd_linux.tar.gz
RUN ./steamcmd.sh +login anonymous \
                 +force_install_dir /server/ark \
                 +app_update 376030 validate \
                 +quit

#Scp Server
RUN apt-get install -y openssh-server rssh
ADD rssh.conf /etc/rssh.conf

EXPOSE 27015/udp 7778/udp
EXPOSE 32330/tcp

#Server Start
WORKDIR /server/ark
ADD start.sh /server/ark/start.sh
RUN chmod 755 /server/ark/start.sh

CMD ["/server/ark/start.sh"]


