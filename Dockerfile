ARG BASE_IMAGE_TAG=1.20.1
FROM us-east1-docker.pkg.dev/core-workshop/workshop-registry/node:17-alpine as BUILDER
WORKDIR /app
COPY package.json pnpm-lock.yaml /app/
RUN npm install
COPY . .
RUN npm run build

FROM us-east1-docker.pkg.dev/core-workshop/workshop-registry/nginx:$BASE_IMAGE_TAG
COPY variableReplace.sh /docker-entrypoint.d/
COPY --from=BUILDER /app/dist /usr/share/nginx/html
COPY .env /usr/share/nginx/html
