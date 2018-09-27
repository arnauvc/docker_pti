FROM scratch
ADD https://downloads.openwrt.org/releases/18.06.1/targets/x86/generic/openwrt-18.06.1-x86-generic-generic-rootfs.tar.gz  /

EXPOSE 80

RUN mkdir -pv /var/lock && \
    mkdir -pv /var/run && \
    opkg update && \
    #opkg list | grep -i bmx6 | awk '{print $1}' | xargs opkg install && \
    opkg install bmx6 bmx6-uci-config luci-app-bmx6 && \
    opkg update 

USER root

# using exec format so that /sbin/init is proc 1 (see procd docs)
CMD ["/sbin/init"]
