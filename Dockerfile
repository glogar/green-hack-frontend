###############################################################################
#-----------------------------    BUILD STAGE   ------------------------------#
###############################################################################

ARG NODE_VERSION_TAG
FROM node:$NODE_VERSION_TAG-alpine3.12 AS builder

ENV APP_ROOT /app

# update and install dependency
RUN set -ex \
        # && apk add --no-cache --virtual .build-deps \
        && apk add --no-cache --virtual .run-deps \
            git \
            bash \
        && apk upgrade \
        # && apk del .build-deps \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /var/cache/apk/* \
        && rm -rf /root/.cache

WORKDIR ${APP_ROOT}

COPY package.json package-lock.json[t] ./
RUN npm install

COPY . ./

###############################################################################
#--------------------------    DEVELOPMENT STAGE  ----------------------------#
###############################################################################
FROM builder AS devel

ARG NODE_ENV=development
ARG BROWSER_BASE_URL
ARG BASE_URL
ARG CROSSBAR_URL
ARG CROSSBAR_REALM

ENV NODE_ENV=$NODE_ENV \
    BROWSER_BASE_URL=$BROWSER_BASE_URL \
    BASE_URL=$BASE_URL \
    CROSSBAR_URL=$CROSSBAR_URL \
    CROSSBAR_REALM=$CROSSBAR_REALM

EXPOSE 3000
CMD ["npm", "run", "dev"]

###############################################################################
#--------------------------    PRODUCTION STAGE   ----------------------------#
###############################################################################
FROM builder AS bundle

ARG NODE_ENV=production
ARG BROWSER_BASE_URL
ARG BASE_URL
ARG CROSSBAR_URL
ARG CROSSBAR_REALM

ENV NODE_ENV=$NODE_ENV \
    BROWSER_BASE_URL=$BROWSER_BASE_URL \
    BASE_URL=$BASE_URL \
    CROSSBAR_URL=$CROSSBAR_URL \
    CROSSBAR_REALM=$CROSSBAR_REALM

RUN npm run generate
EXPOSE 3000
CMD ["npm", "run", "start"]

FROM nginx:stable-alpine AS prod
COPY --from=bundle /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
