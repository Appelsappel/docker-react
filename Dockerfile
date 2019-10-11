# builder is de naam van de stage
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <---- has all the files we need for prod
FROM nginx

# copies something from other fase
# for nginx to work copy everything to /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html

# nginx start zich vanzelf (default cmd in container)
