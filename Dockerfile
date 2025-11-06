FROM ubuntu:22.04
LABEL maintainer="marie-france"
RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx git ca-certificates && \
    rm -rf /var/lib/apt/lists/*
RUN rm -Rf /var/www/html/*
RUN git clone https://github.com/mariefrance2/Portfolio.git /var/www/html/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
