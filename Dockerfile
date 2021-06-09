FROM ubuntu
WORKDIR /var/www/html
ADD index.html ./
EXPOSE 3000
CMD ["index.html"]
