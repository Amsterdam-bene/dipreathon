FROM perl

WORKDIR /usr/src/app

# YOLO
RUN cpanm --notest App::Pocoirc
RUN cpanm --notest POE::Component::IRC::Plugin::Hailo
RUN cpanm --notest Net::Twitter::Lite::WithAPIv1_1
RUN cpanm --notest Hailo
RUN cpanm --notest Hijk

COPY poe-component-irc-plugin-rekarma poe-component-irc-plugin-rekarma
COPY poe-component-irc-plugin-recallback poe-component-irc-plugin-recallback
COPY config.yaml config.yaml

RUN chown -R nobody: /usr/src/app
USER nobody

CMD ["pocoirc", "--verbose", "--config", "config.yaml"]
