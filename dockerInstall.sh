sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common >> out.log

sudo dpkg --configure -a >> out.log

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - >> out.log


sudo apt-key fingerprint 0EBFCD88 >> out.log


sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" >> out.log



sudo apt-get update -y >> out.log

sudo dpkg --configure -a >> out.log


sudo apt-get install -y docker-ce=17.09.0~ce-0~ubuntu

sudo dpkg --configure -a >> out.log

echo "docker configured" >> out.log

systemctl start docker
