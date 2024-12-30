FROM node:18.19.1
WORKDIR /opt
ADD . /opt
RUN npm install
ENTRYPOINT npm run start