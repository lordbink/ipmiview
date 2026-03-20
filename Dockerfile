FROM ubuntu:24.04
LABEL maintainer="Tomas Jacik <tomas@jacik.cz>"

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0.0

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD IPMIView_2.21.0_build.221118_bundleJRE_Linux_x64 /opt/IPMIView

RUN apt-get update && \
	apt-get dist-upgrade -y --no-install-recommends && \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		xvfb \
		x11vnc \
		supervisor \
		fluxbox \
		git && \
	git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
	git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
	apt-get remove --purge -y git && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /build /tmp/* /var/tmp/* /var/lib/apt/lists/*

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
