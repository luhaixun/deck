FROM node:10

COPY . deck/

# hadolint ignore=DL3000
WORKDIR deck

# hadolint ignore=DL3001,DL3003
RUN free -h && \
  docker/setup-apache2.sh && \
  npm i -g yarn && \
  yarn && \
  yarn build && \
  mkdir -p /opt/deck/html/ && \
  cp build/webpack/* /opt/deck/html/ && \
  cd .. && \
  rm -rf deck

COPY docker /opt/deck/docker

WORKDIR /opt/deck
# hadolint ignore=DL3025
CMD /opt/deck/docker/run-apache2.sh
