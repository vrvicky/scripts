echo 'root:icam1234$$'|chpasswd > out.log

sysctl -w vm.max_map_count=262144 >> out.log

echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf >> out.log


sysctl -w net.ipv4.ip_local_port_range="10240  60999" >> out.log


echo 'net.ipv4.ip_local_port_range="10240 60999"' | sudo tee -a /etc/sysctl.conf >> out.log


bash -c "test -e /usr/bin/python || (apt -qy update && apt install -qy python-minimal)" >> out.log


sudo dpkg --configure -a >> out.log


(
echo n # Add a new partition
echo p # Primary partition
echo 1 # Partition number
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo w # Write changes
) | sudo fdisk /dev/xvdc >> out.log


mkfs.ext3 /dev/xvdc1 >> out.log

mkdir /home/icp

chmod 777 /home/icp

mount /dev/xvdc1 /home/icp

echo "/dev/xvdc1 /home/icp ext3 defaults 0 2" >> /etc/fstab

echo "mounting done " >> out.log

mkdir /home/icp/docker
mkdir  /var/lib/docker
mount --rbind /home/icp/docker /var/lib/docker



echo "/var/lib/docker /home/icp/docker ext3 defaults 0 2" >> /etc/fstab


echo "docker storage reconfigured" >> out.log

sudo apt-get update  >> out.log
sudo apt-get update   >> out.log
sudo apt-get install -qy apt-transport-https ca-certificates curl software-properties-common >> out.log

sudo dpkg --configure -a >> out.log

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - >> out.log


#sudo apt-key fingerprint 0EBFCD88 >> out.log


sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" >> out.log



sudo apt-get update  >> out.log
sudo apt-get update  >> out.log

#sudo dpkg --configure -a >> out.log


sudo apt-get install -y docker-ce=17.09.0~ce-0~ubuntu

sudo dpkg --configure -a >> out.log

echo "docker configured" >> out.log

systemctl start docker
