#!/bin/sh -e

logfile='/var/log/nginx/access.log'
destfile='/usr/local/www/jozan/index.html'
foretext='Unique visitors: '

[ -e $logfile ]  || exit 1
[ -e $destfile ] || exit 1
sed -i '' "s/$foretext.*$/$foretext<b>$(awk '{print $1}' $logfile | sort | uniq | wc -l | tr -d ' ')<\/b>/" $destfile
