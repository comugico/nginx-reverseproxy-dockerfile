FROM centos:centos7

RUN yum update -y
RUN yum install -y wget tree sudo systemd

RUN wget "http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm" -O "/opt/downloaded.rpm"
RUN yum localinstall -y /opt/downloaded.rpm
RUN yum install -y nginx

ADD reverseproxy.conf /etc/nginx/conf.d/nginx-reverseproxy-dockerfile.conf
ADD nginx.conf.patch /opt/nginx.conf.patch

RUN patch /etc/nginx/nginx.conf < /opt/nginx.conf.patch

EXPOSE 80
WORKDIR /etc/nginx
CMD nginx -g "daemon off;"