FROM ubuntu:22.04
LABEL maintainer="marie-france"
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y nginx git
RUN rm -Rf /var/www/html/*
RUN git clone https://github.com/mariefrance2/Portfolio.git /var/www/html/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
