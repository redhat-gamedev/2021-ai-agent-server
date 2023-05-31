FROM registry.access.redhat.com/ubi8/nodejs-14 AS build

COPY --chown=1001:0 package.json package-lock.json* ./
RUN npm ci
COPY --chown=1001:0 . .
RUN npm run build

FROM registry.access.redhat.com/ubi8/nodejs-14-minimal

COPY --chown=1001:0 package.json package-lock.json* ./
RUN npm ci --omit=dev
COPY --chown=1001:0 --from=build /opt/app-root/src/build ./build

CMD ["node", "build/index.js"]