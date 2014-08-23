FROM centos:centos7

RUN yum update -y
RUN yum install -y wget tree sudo systemd diffutils patch

RUN wget "http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm" -O "/opt/downloaded.rpm"
RUN yum localinstall -y /opt/downloaded.rpm
RUN yum install -y nginx

ADD reverseproxy.conf /etc/nginx/conf.d/nginx-reverseproxy-dockerfile.conf

EXPOSE 80
WORKDIR /etc/nginx

CMD sed -i "s/set \$AIPO_PORT_80_TCP_ADDR .*;\$/set \$AIPO_PORT_80_TCP_ADDR $AIPO_PORT_80_TCP_ADDR;/g" /etc/nginx/conf.d/nginx-reverseproxy-dockerfile.conf
CMD sed -i "s/set \$AIPO_PORT_80_TCP_PORT .*;\$/set \$AIPO_PORT_80_TCP_PORT $AIPO_PORT_80_TCP_PORT;/g" /etc/nginx/conf.d/nginx-reverseproxy-dockerfile.conf
CMD cat /etc/nginx/conf.d/nginx-reverseproxy-dockerfile.conf
CMD nginx -g "daemon off;"