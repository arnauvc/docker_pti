FROM scratch
ADD openwrt-18.06.1-x86-generic-generic-rootfs.tar.gz /

RUN 	mkdir /var/lock 
RUN 	mkdir /var/run
#ADD	sysctl.conf /etc/sysctl.conf

RUN	opkg update && \
	opkg install bmx7 bmx7-uci-config 

USER root

#RUN 	echo "1" > /proc/sys/net/ipv6/conf/all/forwarding

# using exec format so that /sbin/init is proc 1 (see procd docs)
CMD /sbin/init
