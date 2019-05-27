FROM perl


RUN apt-get update && apt-get install -y runit parallel && apt-get clean

ADD overlay /
RUN chmod +x /etc/service/*/run /usr/bin/bot

# YOLO
WORKDIR /usr/src/bot
ADD bot/* .
RUN cpanm --notest App::Pocoirc
RUN cpanm --notest POE::Component::IRC::Plugin::Hailo
RUN cpanm --notest Net::Twitter::Lite::WithAPIv1_1
RUN cpanm --notest Hailo
RUN cpanm --notest Hijk

# Add here your servizietto
# WORKDIR /usr/src/servizietto
# ADD servizietto/* .
# make sure /etc/service/servizietto/run brings your servizietto up

RUN chown -R nobody: /usr/src /etc/service/

USER nobody

#CMD ["pocoirc", "--verbose", "--config", "config.yaml"]
CMD ["/usr/bin/bot"]
