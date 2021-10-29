#/bin/sh
git pull && yarn build && cp -R /root/notes/.vuepress/dist /usr/share/nginx/html/notes
