#FROM scratch
#ADD https://downloads.openwrt.org/chaos_calmer/15.05/x86/generic/openwrt-15.05-x86-generic-Generic-rootfs.tar.gz /

FROM zoobab/openwrt-x86-attitude:latest



EXPOSE 80

RUN mkdir /var/lock && \
    opkg update && \
    opkg list | grep -i bmx && \
    opkg update 

USER root

# using exec format so that /sbin/init is proc 1 (see procd docs)
#CMD ["/sbin/init"]
CMD ["/bin/ash"]
