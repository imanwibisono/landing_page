FROM nginx:1.16.1
EXPOSE 80
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#CMD service nginx start
ADD landing-page-master /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
