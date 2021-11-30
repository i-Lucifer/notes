#/bin/sh
git pull && yarn build && rm -rf /usr/share/nginx/html/notes/* && cp -Rf /root/notes/.vuepress/dist/* /usr/share/nginx/html/notes
