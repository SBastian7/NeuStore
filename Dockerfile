# FROM node as build
# WORKDIR /build
# COPY package.json package-lock.jso[n] ./
# # Note that we're going to compile our project in the next command, so we need our development dependencies!
# ENV NODE_ENV=development
# RUN npm ci
# COPY . .
# RUN npm run start 

# FROM nginx
# COPY --from=build /build/artifact /usr/share/nginx/html

FROM node

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent

# add app
COPY . ./

# start app
CMD ["npm", "start"]