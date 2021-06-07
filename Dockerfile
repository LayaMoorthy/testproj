FROM ubuntu
WORKDIR /var/www/html
ADD index.html ./
EXPOSE 82
CMD ["index.html"]
