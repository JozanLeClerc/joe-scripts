#!/bin/sh -e

logfile='/var/log/nginx/access.log'
destfile='/usr/local/www/jozan/index.html'
foretext='Unique visitors: '
#botlist='petalbot|googlebot|adsbot-google|ahrefs\.com|pingbot|robots\.txt|pandalytics|serpstatbot|zoombot|semrush.com\/bot|archive\.org_bot|bingbot|vuhuvbot|neevabot|botaflatoon|botfnetowrksx|zaldamosearchbot|facebookexternalhit|mj12bot|polaris botnet|turnitinbot'

[ -e $logfile ]  || exit 1
[ -e $destfile ] || exit 1
# sed -i '' "s/$foretext.*$/$foretext<b>$(grep -E -v -i "$botlist" $logfile | awk '{print $1}' | sort | uniq | wc -l | tr -d ' ')<\/b>/" $destfile
sed -i '' "s/$foretext.*$/$foretext<b>$(awk '{print $1}' $logfile | sort | uniq | wc -l | tr -d ' ')<\/b>/" $destfile
