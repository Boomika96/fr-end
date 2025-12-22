FROM node:18 AS build
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN node --max_old_space_size=4096 ./node_modules/@angular/cli/bin/ng build

FROM nginx:alpine
COPY --from=build /app/dist/angular-15-crud/ /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
