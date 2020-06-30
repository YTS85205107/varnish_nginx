#!/bin/bash
bool=0
echo "10.2.166.53       U6053" >> /etc/hosts
echo "10.2.166.54       U6054" >> /etc/hosts
echo "10.2.166.55       U6055" >> /etc/hosts
while [ $bool -ne 1 ]; do
    host=U60$(shuf -i 53-55 -n 1)
    echo $host
    ping -W 1 -c1 $host
    SUCCESS=$?
    if [[ $SUCCESS < 1 ]]; then
        mount -t glusterfs $host:/foto /var/www/html/
        ln -sf /dev/stdout /var/log/nginx/access.log
        ln -sf /dev/stderr /var/log/nginx/error.log
        varnishd -f /etc/varnish/default.vcl && /usr/sbin/nginx -g "daemon off;"
        bool=1
    fi
done
