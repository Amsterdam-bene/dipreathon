FROM perl

RUN apt-get update && apt-get install -y runit parallel && apt-get clean

# YOLO
ADD bot /usr/src/bot
WORKDIR /usr/src/bot
RUN cpanm --notest App::Pocoirc
RUN cpanm --notest POE::Component::IRC::Plugin::Hailo
RUN cpanm --notest Net::Twitter::Lite::WithAPIv1_1
RUN cpanm --notest Hailo
RUN cpanm --notest Hijk

# Add here your servizietto
# ADD servizietto /usr/src/servizietto
# WORKDIR /usr/src/servizietto
# make sure /etc/service/servizietto/run brings your servizietto up

ADD overlay /
RUN chmod +x /etc/service/*/run /usr/bin/bot

RUN chown -R nobody: /usr/src /etc/service/

USER nobody

CMD ["/usr/bin/bot"]
