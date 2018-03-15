# v2ray-cdn-docker

FROM ubuntu:16.04

MAINTAINER hikaruchang <i@rua.moe>

RUN apt-get update && apt-get install -y software-properties-common openssh-server git curl wget bash unzip daemon

ADD https://storage.googleapis.com/v2ray-docker/v2ray /usr/bin/v2ray/
ADD https://storage.googleapis.com/v2ray-docker/v2ctl /usr/bin/v2ray/
ADD https://storage.googleapis.com/v2ray-docker/geoip.dat /usr/bin/v2ray/
ADD https://storage.googleapis.com/v2ray-docker/geosite.dat /usr/bin/v2ray/
RUN mkdir /var/log/v2ray/ &&\
    chmod +x /usr/bin/v2ray/v2ctl && \
    chmod +x /usr/bin/v2ray/v2ray
ENV PATH /usr/bin/v2ray:$PATH

RUN echo "export TERM=xterm" >> /etc/bash.bashrc
RUN wget -qO ee rt.cx/ee && printf 'v2ray\ndocker@v2ray.com'|sudo bash ee

RUN echo "root:password"|chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
	sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN git clone https://github.com/snooda/net-speeder.git net-speeder
WORKDIR net-speeder
RUN sh build.sh

RUN mv net_speeder /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/net_speeder

COPY config.json /etc/v2ray/
COPY v2ray.conf /root/
COPY nginx.conf /root/

COPY config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/config.sh

# Configure container to run as an executable
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
EXPOSE 22