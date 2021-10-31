#/bin/sh
git pull && yarn build && cp -Rf /root/notes/.vuepress/dist /usr/share/nginx/html/notes
