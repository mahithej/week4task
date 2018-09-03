#!/bin/bash
ansible-playbook /etc/ansible/jenkins
#if [[ $? -ne 0]]
sleep 30s
ssh ws1 'sudo chmod -R 744 /var/lib/jenkins/secrets'
JPWD=$(ssh ws1 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword')
curl -u admin:$JPWD http://192.168.135.111:9090/jnlpJars/jenkins-cli.jar -o jenkins-cli.jar
java -jar jenkins-cli.jar -s http://192.168.135.111:9090 -auth admin:$JPWD build trymaven