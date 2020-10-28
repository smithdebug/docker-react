####### implemeting multi-phase/step builds #######
#### phase 1 as builder ####
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

#### phase 2 which runs nginx ###

FROM nginx

#copy the files from the builder phase i.e container to the nginx container dir
COPY --from=builder /app/build /usr/share/nginx/html