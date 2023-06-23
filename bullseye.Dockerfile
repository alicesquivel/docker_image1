FROM node:19.0.0-bullseye

ADD . /app
WORKDIR /app/react
RUN npm install
RUN npm run build

WORKDIR /app/express
RUN npm install

EXPOSE 3000
CMD ["node", "index.js"]

version: '2.1'
networks: {}
volumes:
  resin-data: {}
services:
  main:
    build:
      context: .
    privileged: true
    restart: always
    network_mode: host
    volumes:
      - 'resin-data:/data'
    labels:
      io.balena.features.kernel-modules: '1'
      io.balena.features.firmware: '1'
      io.balena.features.dbus: '1'
      io.balena.features.supervisor-api: '1'
      io.balena.features.balena-api: '1'
