FROM node:18.19.1
WORKDIR /opt
COPY package*.json ./
RUN npm install
COPY . .
ENTRYPOINT ["npm", "run", "start"]