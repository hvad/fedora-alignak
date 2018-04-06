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

RUN sed -i -e 's/logfile/#logfile/g' /etc/supervisord.conf
RUN sed -i -e 's/loglevel/#loglevel/g' /etc/supervisord.conf
RUN sed -i -e 's/nodaemon=false/nodaemon=true/g' /etc/supervisord.conf

RUN mkdir -p /var/run/alignak && chown -Rf nagios:nagios /var/run/alignak 

#RUN useradd -m -g wheel -d /home/user user && sed -i -e 's/# %wheel/%wheel/g' /etc/sudoers                     

COPY alignak-*.ini /etc/supervisord.d/

USER root

WORKDIR /var/lib/alignak

CMD ["/usr/bin/supervisord"]
