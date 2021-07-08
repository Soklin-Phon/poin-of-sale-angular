FROM node:10.15.0-alpine As builder

# RUN npm config set unsafe-perm true
RUN npm install -g @angular/cli@8.1.2
COPY . /usr
WORKDIR /usr
RUN npm install
#RUN npm install typescript@'>=2.4.2 <2.7.0'

#RUN npm rebuild node-sass
RUN  ng build --prod
RUN ls -la
RUN pwd

FROM nginx:1.15.8-alpine

COPY --from=builder /usr/dist/* /usr/share/nginx/html
WORKDIR /usr/share/nginx/html

EXPOSE 80

