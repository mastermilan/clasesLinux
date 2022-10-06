#!/bin/bash

instalarBase(){

    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get upgrade -y -qq \
    apt-get install -y jq \
    python-pip \
    python3-pip \
    git \
    python-boto3 \
    awscli \
    curl \
    htop \
    vim \
    strace \
    tcpdump \
    emacs-nox \
    iftop \
    rsync \
    nfs-common \
    unzip \
    lsof \
    telnet \
    acl \
    iotop \
    libffi-dev
}

instalarDocker()
{
  echo "### INSTALL DOCKER ###"
  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

  curl -fsSL https://download.docker.com/linux/debian/gpg | \
    gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  apt-get update
  apt-get install -y docker-ce=18.06.3~ce~3-0~debian  
  apt-get install -y docker-ce-cli=5:18.09.9~3-0~debian-buster
  apt-get install -y containerd.io
}

configDocker()
{
  mkdir -p /etc/docker/
  cat > /etc/docker/daemon.json << EOFCONF
{
  "default-address-pools":[
    {"base":"172.16.0.0/12","size":25},
    {"base":"192.168.0.0/16","size":25}
  ]
}
EOFCONF
}

instalarDockerCompose()
{
  apt install -y python3-docker python3-dockerpty python3-dockerpycreds
  curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
}

pipInstall()
{
  pip install --upgrade pip
  pip3 install --upgrade pip
  pip3 install ansible-base
  pip install pyrsistent==0.16.0
  pip install docker-compose==1.26.2
  pip3 install docker-compose==1.26.2
  pip install cryptography==2.7
}

llaveAWS()
{
echo "### llave para el punto de montaje del efs ###"
mkdir -p /root/.aws/
cat > /root/.aws/credentials << EOFCRED
[default]
aws_access_key_id = XXXXXXX
aws_secret_access_key = XXXXXXXXXX
EOFCRED
cat > /root/.aws/config << EOFCFG
[default]
region = us-east-1
output = json
EOFCFG
}

montarSites()
{
  mkdir -p /srv/sites
  mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-XXXXXXXX.efs.us-east-1.amazonaws.com:/  /srv/sites
}

agregarSG()
{
  echo "### Agregar el Security Group a la instancia ###"
  bash /tmp/infra/addSecurityGroup.sh $ROLE '"Inet"|"default"'
}

agregarRepoGIT()
{
  ssh-keyscan git.XXXX.XXXX >> ~/.ssh/known_hosts
  ssh-agent bash -c 'echo -e "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAMwAAAAtzc2gtZW\+\ngwAAAAtzc2gtZWQyNTUxOQAAACD8lVHTZmD1pBKgVr7QLMlQB2VUAT8SH3ONa4G65Zq+Tg\nAAAEBrhi51AGBK03dbCZTy61jEP3JoyRhZ0nvsbXkuuJUoa/yVUdNmYPWkEqBWvtAsyVAH\\n-----END OPENSSH PRIVATE KEY-----" | ssh-add - ; git clone git@git.XXXXXX.XXXb:infra/ansible.git /tmp/infra/'
}

ejecutarAnsible()
{
  echo "### ANSIBLE ###"
  ansible-galaxy collection install amazon.aws
  ansible-galaxy collection install ansible.posix
  ansible-galaxy collection install community.docker
  export AWS_PROFILE=default
  ROLE=`aws \
          --region="$(curl -s http://169.XXX.XXX.254/latest/dynamic/instance-identity/document | \
                    jq -r '.region')" ec2 describe-tags \
          --filters "Name=resource-id,Values=$(ec2metadata --instance-id)" \
                    "Name=key,Values=ROLE" | jq -r '.Tags[0].Value'`
  cd /tmp/infra/ansible-infra/
  git checkout to-ansible-base
  ENV=test ansible-playbook -e @vars/generic.yml -e ROLE=$ROLE localhost.yml
}

configFinal()
{
  cd /usr/bin/
  ln -sf python3 python
  cd /tmp/infra/
  bash config.sh
}

instalarBase
instalarDocker
configDocker
pipInstall
instalarDockerCompose
llaveAWS
montarSites
agregarRepoGIT
ejecutarAnsible
configFinal

