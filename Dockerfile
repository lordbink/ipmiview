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
		curl \
		xvfb \
		x11vnc \
		supervisor \
		fluxbox \
		git && \
	install -d -m 0755 /etc/apt/keyrings && \
	curl -fsSL https://packages.mozilla.org/apt/repo-signing-key.gpg \
		-o /etc/apt/keyrings/packages.mozilla.org.asc && \
	echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
		> /etc/apt/sources.list.d/mozilla.list && \
	echo 'Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000' \
		> /etc/apt/preferences.d/mozilla && \
	apt-get update && \
	apt-get install -y --no-install-recommends firefox-esr && \
	git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
	git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
	apt-get remove --purge -y git curl && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /build /tmp/* /var/tmp/* /var/lib/apt/lists/*

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
