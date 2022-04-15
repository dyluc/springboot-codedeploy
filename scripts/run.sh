#!/bin/sh
HOME='/home/ec2-user'
JAR_FILE='/home/ec2-user/springboot-codedeploy-0.0.1-SNAPSHOT.jar'
echo "========== new run ==========" >> $HOME/logs/run-log.txt
echo $(date) >> $HOME/logs/run-log.txt
APP_SECRET=`echo $(aws ssm get-parameters --region eu-west-2 --names APP_SECRET --with-decryption --query Parameters[0].Value) | sed -e 's/^"//' -e 's/"$//'`
if [ $? -eq 0 ];
then
    echo "Fetched app secret." >> $HOME/logs/run-log.txt

    # create service
    cd /etc/systemd/system/
    cat <<EOT >> myapp.service
    [Unit]
    Description=MyApp Service

    [Service]
    Restart=always
    User=root
    ExecStart=/usr/bin/java -jar $JAR_FILE \
      --APP_SECRET=$APP_SECRET

    [Install]
    WantedBy=multi-user.target
EOT
    systemctl start myapp.service &>> $HOME/logs/run-log.txt
    echo "Started service." >> $HOME/logs/run-log.txt
else
    echo "Failed to fetch app secret." >> $HOME/logs/run-log.txt
fi
echo "=============================" >> $HOME/logs/run-log.txt