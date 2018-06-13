echo 'root:icam1234$$'|chpasswd

sysctl -w vm.max_map_count=262144

echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf

sysctl -w net.ipv4.ip_local_port_range="10240  60999"

echo 'net.ipv4.ip_local_port_range="10240 60999"' | sudo tee -a /etc/sysctl.conf

bash -c "test -e /usr/bin/python || (apt -qqy update && apt install -qy python-minimal)"
(
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo w # Write changes
) | sudo fdisk /dev/xvdc

mkfs.ext3 /dev/xvdc1

mkdir /home/icp

chmod 777 /home/icp

mount /dev/xvdc1 /home/icp

echo "/dev/xvdc1 /home/icp ext3 defaults 0 2" >> /etc/fstab

sudo apt-get remove -y docker docker-engine docker.io

sudo apt-get update -y

sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


sudo apt-get update -y


sudo apt-get install -y docker-ce=17.09.0~ce-0~ubuntu

docker rm -f $(docker ps -aq); docker rmi -f $(docker images -q)
systemctl stop docker
rm -rf /var/lib/docker

mkdir /home/icp/docker
mkdir  /var/lib/docker
mount --rbind /home/icp/docker /var/lib/docker

echo "/var/lib/docker /home/icp/docker ext3 defaults 0 2" >> /etc/fstab

systemctl start docker


