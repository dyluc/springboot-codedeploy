#!/bin/sh
HOME='/home/ec2-user'
echo "========== stopping process ==========" >> $HOME/logs/stop-log.txt
echo $(date) >> $HOME/logs/stop-log.txt

if [[ -f /etc/systemd/system/myapp.service ]]
then
  systemctl stop myapp.service &>> $HOME/logs/stop-log.txt
  rm /etc/systemd/system/myapp.service &>> $HOME/logs/stop-log.txt
  systemctl daemon-reload &>> $HOME/logs/stop-log.txt
  systemctl reset-failed &>> $HOME/logs/stop-log.txt
else
  echo "No service file exists." >> $HOME/logs/stop-log.txt
fi
echo "======================================" >> $HOME/logs/stop-log.txt