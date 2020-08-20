FROM node:alpine as builder

# set working directory
WORKDIR /app
# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install
RUN npm install react-scripts -g

# add app
COPY . ./
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
