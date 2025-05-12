#!/bin/sh

LOGFILE="/var/log/finwait2.log"

while true; do
    COUNT=$(netstat -an | grep FIN_WAIT_2 | wc -l)
    echo "$(date '+%Y-%m-%d %H:%M:%S') FIN_WAIT_2 count: $COUNT" >> "$LOGFILE"
    sleep 60
done
