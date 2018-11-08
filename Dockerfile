FROM scratch
ADD openwrt-18.06.1-x86-generic-generic-rootfs.tar.gz /

RUN 	mkdir /var/lock 
RUN 	mkdir /var/run

RUN	opkg update && \
	opkg list | grep -i bmx6 | awk '{print $1}' | xargs opkg install && \
	opkg install vim && \
	opkg update

USER root

CMD ["/sbin/init"]



