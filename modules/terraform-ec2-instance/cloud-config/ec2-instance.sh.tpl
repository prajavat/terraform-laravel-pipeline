#!/bin/bash
#
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
    sudo yum -y update
    sudo yum install -y ruby
    sudo yum install -y aws-cli
    cd /home/ec2-user
    sudo aws s3 cp s3://aws-codedeploy-${region}/latest/install . --region ${region}
    sudo chmod +x ./install
    sudo ./install auto