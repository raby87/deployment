FROM nginx-php7:v1.0
WORKDIR /product-api
COPY . .

CMD ["/bin/sh","entrypoint.sh"]
