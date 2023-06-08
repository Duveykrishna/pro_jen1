FROM nginx:latest
MAINTAINER krishna
COPY ./index.html /usr/share/nginx/html/index.html
EXPOSE "80"


