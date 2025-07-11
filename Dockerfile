FROM alpine:3.18

# install dependencies
RUN apk add --no-cache bash curl jq sed

# copy the update script
COPY check_and_update_env.sh /usr/local/bin/check_and_update_env.sh
RUN chmod +x /usr/local/bin/check_and_update_env.sh

CMD ["/usr/local/bin/check_and_update_env.sh"]