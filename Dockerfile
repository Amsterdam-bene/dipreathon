FROM perl

RUN cpanm App::Pocoirc
RUN cpanm --notest POE::Component::IRC::Plugin::Hailo

COPY poe-component-irc-plugin-rekarma poe-component-irc-plugin-rekarma 
COPY test.yaml test.yaml

CMD ["pocoirc", "--verbose", "--config", "test.yaml"]

