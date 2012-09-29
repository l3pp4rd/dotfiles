#!/bin/sh

IFS=$'\n' # override separator
NEW=0
MSG=""
ACC="$1" # accounts file to go through
for line in $(cat $1)
do
    MAILBOX=$(echo $line | cut -f1 -d '|')
    USERNAME=$(echo $line | cut -f2 -d '|')
    PASSWORD=$(echo $line | cut -f3 -d '|')

    COUNT=$(wget -q -O - https://mail.google.com/a/gmail.com/feed/atom --http-user=$USERNAME --http-password="$PASSWORD" --no-check-certificate | grep fullcount | sed 's/<[^0-9]*>//g')

    if [ -z "$COUNT" ]; then
        MSG="${MSG}Connection error for $MAILBOX mailbox !\n"
    else
        if [ "$COUNT" -gt 0 ]; then
            NEW=1
            MSG="${MSG}${COUNT} new email(s) in $MAILBOX mailbox !\n"
        else
            MSG="${MSG}no new emails in $MAILBOX mailbox !\n"
        fi
    fi
done
if [ "$NEW" -gt 0 ]; then
    notify-send "Mailbox info" "$MSG" --icon=new-messages-red
else
    notify-send "Mailbox info" "$MSG" --icon=email
fi
