FROM dockerhub.nmdp.org:8443/nmdp-shiny-base:3.6.1

MAINTAINER Stephanie Fingerson “sdiprima@nmdp.org"

RUN apt-get update && apt-get install -y openjdk-8-jdk libssl-dev && apt-get autoremove

RUN R CMD javareconf

RUN install2.r ggplot2 ggforce gridExtra shinydashboard

COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
COPY /mds-plots /srv/shiny-server/
RUN chown -R shiny:shiny /srv/shiny-server/

EXPOSE 80

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]
