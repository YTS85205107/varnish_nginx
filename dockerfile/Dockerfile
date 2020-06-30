From ubuntu:18.04
MAINTAINER ken

RUN apt update -y ; \
	apt-get update -y ; \
	apt-get install -y  ; \	
	apt install -y	software-properties-common \
					iputils-ping \
					curl \
					gnupg \
					apt-transport-https ; \
	add-apt-repository ppa:gluster/glusterfs-5 ; \
	curl -L https://packagecloud.io/varnishcache/varnish60lts/gpgkey | apt-key add - ; \	
	echo deb https://packagecloud.io/varnishcache/varnish60lts/ubuntu/ bionic main >> /etc/apt/sources.list.d/varnishcache_varnish60lts.list ; \
	echo deb-src https://packagecloud.io/varnishcache/varnish60lts/ubuntu/ bionic main >> /etc/apt/sources.list.d/varnishcache_varnish60lts.list ; \	
	apt update -y ; \
	apt install -y 	varnish \
					glusterfs-client \ 
					nginx; \
	apt clean ; \
    apt-get clean ; \
    rm -rf /var/lib/apt/lists/*
ADD Varnish_conf_file/default.vcl /etc/varnish/default.vcl
ADD Nginx_conf_file/nginx.conf /etc/nginx/nginx.conf
ADD Nginx_conf_file/default /etc/nginx/sites-enabled/default
ADD startup.sh /startup.sh
Run chmod 777 /etc/nginx/sites-enabled/default ; \
	chmod 777 /etc/nginx/nginx.conf ; \
	chmod 777 /etc/varnish/default.vcl ; \
	chmod 777 /startup.sh

ENTRYPOINT ["/startup.sh"]
