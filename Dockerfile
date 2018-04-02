FROM fedora:latest
MAINTAINER David Hannequin <david.hannequin@gmail.com>

RUN dnf update -y && dnf -y install nagios-plugins-all && \
                     dnf -y install alignak-all && \
                     dnf -y install python2-simplejson python2-pycurl python-cherrypy && \
                     dnf -y install python2-requests python-setproctitle python-ujson && \
                     dnf -y install python2-termcolor python2-numpy && \
                     dnf -y install supervisor && \
                     dnf -y install sudo vim bash procps-ng && \
                     dnf -y clean all

RUN mkdir -p /var/log/supervisor

RUN mkdir -p /var/run/alignak && chown -Rf nagios:nagios /var/run/alignak 

RUN useradd -m -g wheel -d /home/user user && sed -i -e 's/# %wheel/%wheel/g' /etc/sudoers                     

COPY alignak-*.ini /etc/supervisord.d/

USER user

WORKDIR /home/user

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf", "-n"]
