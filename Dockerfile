FROM debian:latest

WORKDIR /drawio

ENV DRAWIO_VERSION "13.7.3"
RUN set -e; \
  apt-get update && apt-get install -y \
  libappindicator3-1 \
  libatspi2.0-0 \
  libasound2 \
  libgconf-2-4 \
  libgtk-3-0 \
  libnotify4 \
  libnss3 \
  libsecret-1-0 \
  libxss1 \
  libxtst6 \
  libgbm-dev \
  sgrep \
  wget \
  xdg-utils \
  xvfb; \
  wget -q https://github.com/jgraph/drawio-desktop/releases/download/v${DRAWIO_VERSION}/draw.io-amd64-${DRAWIO_VERSION}.deb \
  && apt-get install /drawio/draw.io-amd64-${DRAWIO_VERSION}.deb \
  && rm -f /drawio/draw.io-amd64-${DRAWIO_VERSION}.deb; \
  rm -rf /var/lib/apt/lists/*;

ENV DRAWIO_CLI "/opt/draw.io/drawio"

COPY entrypoint.sh .
COPY runner.sh .

ENTRYPOINT [ "/drawio/entrypoint.sh" ]
CMD [ "--help" ]
