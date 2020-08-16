FROM perl

RUN apt-get update && apt-get install -y runit parallel git && apt-get clean

# YOLO
WORKDIR /usr/src/bot
RUN cpanm --notest App::Pocoirc
RUN cpanm --notest POE::Component::IRC::Plugin::Hailo
RUN cpanm --notest Net::Twitter::Lite::WithAPIv1_1
RUN cpanm --notest Net::OAuth::Client
RUN cpanm --notest WWW::Tumblr
RUN cpanm --notest Hijk

ADD bot /usr/src/bot

# Add here your servizietto
# ADD servizietto /usr/src/servizietto
# WORKDIR /usr/src/servizietto
# make sure /etc/service/servizietto/run brings your servizietto up

ADD overlay /
RUN chmod +x /etc/service/*/run /usr/bin/bot

RUN chown -R nobody: /usr/src /etc/service/

USER nobody

CMD ["/usr/bin/bot"]
