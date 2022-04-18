#!/bin/sh -e

logfile='/var/log/nginx/access.log'
destfile='/usr/local/www/jozan/index.html'
foretext='Unique visitors: '
tmp=$(mktemp)

sed "s/$foretext.*$/$foretext$(awk '{print $1}' $logfile | sort | uniq | wc -l | tr -d ' ')/" $destfile >"$tmp"
cat "$tmp" >$destfile
rm "$tmp"
