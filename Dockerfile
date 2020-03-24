# THIS SPECIFIC FILE IS DISTRIBUTED UNDER THE UNLICENSE: http://unlicense.org.
# 
# YOU CAN FREELY USE THIS CODE EXAMPLE TO KICKSTART A PROJECT OF YOUR OWN.
# FEEL FREE TO REPLACE OR REMOVE THIS HEADER.
FROM ruby:2.6.5-alpine as base
RUN apk update && \
    apk add --update build-base postgresql-dev tzdata git

FROM scratch as user
COPY --from=base . .
ARG HOST_UID=${HOST_UID:-4000}
ARG HOST_USER=${HOST_USER:-nodummy}
ARG PROJECT_NAME=${PROJECT_NAME}
ARG PORT=${PORT:-3333}
RUN [ "${HOST_USER}" == "root" ] || \
    (adduser -h /home/${HOST_USER} -D -u ${HOST_UID} ${HOST_USER} \
    && chown -R "${HOST_UID}:${HOST_UID}" /home/${HOST_USER})

ENV GEM_HOME /home/${HOST_USER}/bundle
ENV PATH $GEM_HOME/bin:$PATH
RUN mkdir -p "$GEM_HOME" && chmod 777 "$GEM_HOME"

USER ${HOST_USER}
WORKDIR /home/${HOST_USER}

RUN gem install rails:6.0.2
RUN gem install bundler:2.1.4
RUN mkdir -p /home/${HOST_USER}/${PROJECT_NAME}
WORKDIR /home/${HOST_USER}/${PROJECT_NAME}
ADD Gemfile Gemfile.lock /home/${HOST_USER}/${PROJECT_NAME}/
RUN bundle install
EXPOSE ${PORT}