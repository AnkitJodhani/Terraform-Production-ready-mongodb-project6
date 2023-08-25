#!/bin/bash

sudo apt update -y

sudo apt install software-properties-common -y

sudo add-apt-repository --yes --update ppa:ansible/ansible

sudo apt install ansible -y

sudo apt  install jq -y

sudo apt install zip unzip -y

sudo apt update -y

sudo apt install openssl -y

sudo apt update -y

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

sudo apt install python3-pip -y

sudo apt update -y


# This installs the CodeDeploy agent and its prerequisites on Ubuntu 22.04.  
sudo apt-get update 

sudo apt-get install ruby-full ruby-webrick wget -y 

cd /tmp 

wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/releases/codedeploy-agent_1.3.2-1902_all.deb 

mkdir codedeploy-agent_1.3.2-1902_ubuntu22 

dpkg-deb -R codedeploy-agent_1.3.2-1902_all.deb codedeploy-agent_1.3.2-1902_ubuntu22 

sed 's/Depends:.*/Depends:ruby3.0/' -i ./codedeploy-agent_1.3.2-1902_ubuntu22/DEBIAN/control 

dpkg-deb -b codedeploy-agent_1.3.2-1902_ubuntu22/ 

sudo dpkg -i codedeploy-agent_1.3.2-1902_ubuntu22.deb 

systemctl list-units --type=service | grep codedeploy 

sudo systemctl start codedeploy-agent

# installing cloudwatch agent

sudo apt update -y

sudo apt install wget -y

sudo wget https://amazoncloudwatch-agent.s3.us-east-1.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb

sudo dpkg -i ./amazon-cloudwatch-agent.deb

sudo apt update -y

sudo apt update -y


JSON_CONTENT='{
    "agent": {
            "run_as_user": "cwagent"
    },
    "logs": {
            "logs_collected": {
                    "files": {
                            "collect_list": [
                                    {
                                            "file_path": "/opt/codedeploy-agent/deployment-root/deployment-logs/codedeploy-agent-deployments.log",
                                            "log_group_name": "codedeploy-agent-deployments.log",
                                            "log_stream_name": "{instance_id}",
                                            "retention_in_days": -1,
                                            "timestamp_format": "[%Y-%m-%d %H:%M:%S.%f]"
                                    }
                            ]
                    }
            }
    }
}'


cat <<EOF > /opt/aws/amazon-cloudwatch-agent/bin/config.json
$JSON_CONTENT
EOF



sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s


sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s


