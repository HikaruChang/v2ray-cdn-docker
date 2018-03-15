#!/bin/bash
while getopts ":u:vp:vp:sp:m:k:d:" opt; do
  case $opt in
    u) UUID="$OPTARG"
    ;;
    vp) VPORT="$OPTARG"
    ;;
    sp) SPORT="$OPTARG"
    ;;
    m) METHOD="$OPTARG"
    ;;
    k) PASSWORD="$OPTARG"
    ;;
    d) DOMAIN="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

sed -ri 's/00000000-0000-0000-0000-000000000000/'$UUID'/g' /etc/v2ray/config.json
sed -ri 's/6868/'$VPORT'/g' /etc/v2ray/config.json
sed -ri 's/6969/'$SPORT'/g' /etc/v2ray/config.json
sed -ri 's/chacha20-ietf-poly1305/'$METHOD'/g' /etc/v2ray/config.json
sed -ri 's/hahahaha/'$PASSWORD'/g' /etc/v2ray/config.json

source /etc/bash_completion.d/ee_auto.rc
ee site create $DOMAIN --html --letsencrypt
echo "y"|ee site create rua.moe --html --letsencrypt
rm -rf /var/www/$DOMAIN/conf/nginx/v2ray.conf
cp /root/v2ray.conf /var/www/$DOMAIN/conf/nginx/
rm -rf /etc/nginx/nginx.conf
cp /root/nginx.conf /etc/nginx/
rm -rf /root/nginx.conf && rm -rf /root/v2ray.conf
sed -ri 's/6868/'$VPORT'/g' /var/www/$DOMAIN/conf/nginx/v2ray.conf
cp /var/www/html/index.nginx-debian.html /var/www/$DOMAIN/htdocs/index.html && chown www-data: /var/www/$DOMAIN/htdocs/index.html
service nginx restart