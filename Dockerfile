FROM browserless/chrome:latest

ENV BROWSER_EXECUTABLE_PATH=$CHROME_PATH
ENV PORT=9000

USER root

RUN apt update -y \
  && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
  && apt install -y fonts-dejavu ttf-mscorefonts-installer gnupg nodejs \
  && rm -rf /var/lib/apt/lists/*

ENV HOME=/home/node
ARG APP_HOME=/home/node/srv
WORKDIR $APP_HOME

RUN git clone --depth 1 https://github.com/alvarcarto/url-to-pdf-api . \
  && npm install --only=production

HEALTHCHECK CMD curl -I http://localhost:9000/

EXPOSE 9000
CMD [ "node", "." ]
