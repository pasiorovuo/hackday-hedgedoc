#!/bin/sh

apk update
apk add python3

# Start cron
crond -b -L /var/log/crond

# Deploy initial config of nginx
server_names=`echo $CERTBOT_DOMAINS | tr ',' ' '`
cp /etc/nginx-default.conf /etc/nginx/conf.d/default.conf
sed -i "s/server_name.*/server_name ${server_names};/g" /etc/nginx/conf.d/default.conf

# Install certbot
python3 -m venv /opt/certbot/
/opt/certbot/bin/pip install --upgrade pip
/opt/certbot/bin/pip install certbot certbot-nginx

# Acquire a certificate one or two minutes from now. Certbot will reconfigure nginx.
certbot_date=`python3 -c 'import datetime; n=datetime.datetime.now() + datetime.timedelta(minutes=1 if datetime.datetime.now().second < 40 else 2); print(n.minute, n.hour, n.day, n.month, "*")'`
echo "${certbot_date} /opt/certbot/bin/certbot -n -d "${CERTBOT_DOMAINS}" -m "${CERTBOT_EMAIL}" --nginx --agree-tos" | tee -a /etc/crontabs/root > /dev/null

# Set up certificate renewal
echo "0 0,12 * * * /opt/certbot/bin/python -c 'import random; import time; time.sleep(random.random() * 3600)' && /opt/certbot/bin/certbot renew -q" | tee -a /etc/crontabs/root > /dev/null
