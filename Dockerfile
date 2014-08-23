FROM centos:centos7

RUN yum update -y
RUN yum install -y wget tree sudo systemd

RUN wget "http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm" -O "/opt/downloaded.rpm"
RUN yum localinstall -y /opt/downloaded.rpm
RUN yum install -y nginx

RUN systemctl stop nginx.service
RUN systemctl disable nginx.service

ADD nginx.conf /etc/nginx/conf.d/nginx-reverseproxy-dockerfile.conf

EXPOSE 80
WORKDIR /etc/nginx
CMD nginx -c /etc/nginx/conf.d/nginx-reverseproxy-dockerfile.conf