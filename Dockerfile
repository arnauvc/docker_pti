FROM scratch
ADD openwrt-18.06.1-x86-generic-generic-rootfs.tar.gz /

RUN 	mkdir /var/lock 
RUN 	mkdir /var/run
#ADD	sysctl.conf /etc/sysctl.conf

RUN	opkg update && \
	opkg install bmx7 bmx7-uci-config luci-app-bmx7 

USER root

CMD ["/sbin/init"]



