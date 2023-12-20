#!/bin/bash -x

#https://networkbuilders.intel.com/solutionslibrary/network-and-edge-reference-system-architectures-on-premises-edge-ai-box-quick-start-guide

VERSION=${1:-v23.10}

sudo apt update
sudo apt install -y python3 python3-pip openssh-client git build-essential python3-venv

# Download and Install
git clone -b ${VERSION} --depth 1 https://github.com/intel/container-experience-kits/ $HOME/container-experience-kits
cd $HOME/container-experience-kits
git submodule update --init
python3 -m venv venv
source venv/bin/activate
pip3 install --upgrade pip
pip3 install -r requirements.txt
ansible-galaxy install -r collections/requirements.yml

# Configure
export PROFILE=on_prem_aibox
make examples ARCH=core
cp examples/k8s/${PROFILE}/inventory.ini .
cp -r examples/k8s/${PROFILE}/group_vars examples/k8s/${PROFILE}/host_vars .
mv host_vars/node1.yml host_vars/localhost.yml
ansible-playbook -i inventory.ini playbooks/k8s/patch_kubespray.yml
ansible-playbook -i inventory.ini playbooks/preflight.yml
ansible -i inventory.ini -m setup all > all_system_facts.txt

# Deploy
ansible-playbook -i inventory.ini -b -K playbooks/on_prem_aibox.yml



