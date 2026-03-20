FROM --platform=linux/amd64 ubuntu:24.04
LABEL maintainer="Tomas Jacik <tomas@jacik.cz>"

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0.0
ENV JAVA_HOME=/opt/IPMIView/jre
ENV PATH=/opt/IPMIView/jre/bin:$PATH

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD fluxbox/menu /root/.fluxbox/menu

# Supermicro IPMIView — extract tarball into IPMIView_2.21.0_build.221118_bundleJRE_Linux_x64/ before building
ADD IPMIView_2.21.0_build.221118_bundleJRE_Linux_x64 /opt/IPMIView

# Raritan MPC — place Raritan-mpc-installer.MPC_7.0.3.5.60.zip in kxclient/
ADD kxclient /opt/kxclient

# ATEN iClientJ — place cn8000_iClientJ_v2.3.227.zip in ATENJavaClient/
ADD ATENJavaClient /opt/ATENJavaClient

RUN apt-get update && \
	apt-get dist-upgrade -y --no-install-recommends && \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		unzip \
		xvfb \
		x11vnc \
		supervisor \
		fluxbox \
		novnc \
		python3-websockify \
		xterm && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN unzip /opt/ATENJavaClient/cn8000_iClientJ_v2.3.227.zip -d /opt/ATENJavaClient && \
	rm /opt/ATENJavaClient/cn8000_iClientJ_v2.3.227.zip

RUN unzip /opt/kxclient/Raritan-mpc-installer.MPC_7.0.3.5.60.zip -d /opt/kxclient && \
	rm /opt/kxclient/Raritan-mpc-installer.MPC_7.0.3.5.60.zip

RUN java -Djava.awt.headless=true -jar /opt/kxclient/mpc-installer.MPC_7.0.3.5.60.jar /opt/kxclient/auto-install.xml || true
RUN test -f /usr/local/raritan-mpc/start.sh && \
	ln -s /usr/local/raritan-mpc/start.sh /usr/local/bin/raritan-mpc && \
	rm -rf /opt/kxclient

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
