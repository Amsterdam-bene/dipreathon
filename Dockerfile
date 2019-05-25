FROM perl

WORKDIR /usr/src/app

# YOLO
RUN cpanm --notest App::Pocoirc
RUN cpanm --notest POE::Component::IRC::Plugin::Hailo

COPY poe-component-irc-plugin-rekarma poe-component-irc-plugin-rekarma 
COPY config.yaml config.yaml

USER nobody

CMD ["pocoirc", "--verbose", "--config", "config.yaml"]
