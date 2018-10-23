#!/bin/bash

sudo yum install html2text -y &>/dev/null
URL=$(curl https://downloads.chef.io/chef-server/12.18.14 | html2text | grep el7.x86_64.rpm$ | awk '{print $NF}')
sudo yum install $URL -y 
sudo chef-server-ctl reconfigure
sudo chef-server-ctl user-create admin Admin User admin@local.com 'PASSWORD' --filename /opt/admin.pem 
sudo chef-server-ctl org-create student 'Student App' --association_user admin --filename /opt/student.pem 
sudo chef-server-ctl install chef-manage
sudo chef-server-ctl reconfigure
sudo chef-manage-ctl reconfigure --accept-license
