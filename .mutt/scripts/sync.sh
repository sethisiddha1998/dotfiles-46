#!/usr/bin/env bash
# Syncs from imap and sends notification over ssh when there is a new mail
# This is runned as a cron job
# based on LukeSmithxyz:s script
# mjturt

offlineimap -o -u ttyui "$@"

for account in $(ls ~/mail)
do
   newcount=$(find ~/mail/$account/INBOX/new/ -type f -newer ~/.mutt/lastsync 2> /dev/null | wc -l)
   if [ "$newcount" -gt "0" ]
   then
      #ssh mjt@r5.turtia.org "DISPLAY=:0 notify-send \"$newcount new mail(s) in $account\" && mpv --quiet /home/mjt/.notify.opus"
      ssh mjt@r5.turtia.org "tmux splitw 'zsh -c '\'' notify-send \"mutt\" \"$newcount new mail(s) in $account\" '\''  &&  mpv --quiet /home/mjt/.notify.opus'"
      notmuch new
   fi
done

touch ~/.mutt/lastsync
