FROM scratch
ADD openwrt-18.06.1-x86-generic-generic-rootfs.tar.gz /

RUN 	mkdir /var/lock 
RUN 	mkdir /var/run
ADD	sysctl.conf /etc/sysctl.conf

RUN	opkg update \
	opkg install bmx6 bmx6-uci-confi luci-app-bmx6

USER root
# using exec format so that /sbin/init is proc 1 (see procd docs)
CMD /sbin/init
