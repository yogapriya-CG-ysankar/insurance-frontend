FROM us-east1-docker.pkg.dev/core-workshop/workshop-registry/pnpm:6 as BUILDER
WORKDIR /app
COPY package.json pnpm-lock.yaml /app/
RUN pnpm install
COPY . .
RUN pnpm build

FROM us-east1-docker.pkg.dev/core-workshop/workshop-registry/nginx:1.21.6-alpine
COPY variableReplace.sh /docker-entrypoint.d/
COPY --from=BUILDER /app/dist /usr/share/nginx/html
COPY .env /usr/share/nginx/html

