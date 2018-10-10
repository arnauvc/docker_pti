FROM scratch
ADD openwrt-18.06.1-x86-generic-generic-rootfs.tar.gz /

RUN 	mkdir /var/lock 
RUN 	mkdir /var/run

ADD	init_bmx7.sh /bin/init_bmx7.sh
RUN	chmod +x /bin/init_bmx7.sh

RUN	opkg update && \
	opkg install bmx7 bmx7-uci-config luci-app-bmx7 
RUN	opkg install vim
USER root

CMD ["/sbin/init"]



