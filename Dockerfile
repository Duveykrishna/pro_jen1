FROM nginx:latest
MAINTAINER Aman Singh
COPY ./index.html /usr/share/nginx/html/index.html
EXPOSE "80"


