#!/usr/bin/bash -xe
sudo -S yum install python -y
sudo -S yum install python-pip -y
sudo -S pip install ansible
ansible-playbook -i inventory.ini my_playbook.yml
