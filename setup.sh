ip_address=$1
hostname=$2
mongodb_version=$3
repl_set_name=$4
config_server=$5
mongodb_minor_point_version=$6

printf "mongodb_version: %s for %s at address %s" $mongodb_version $hostname $ip_address
YUM_REPO_CONFIG_PATH="/etc/yum.repos.d/mongodb-org-${mongodb_version}.repo"

# Create the yum repo for the version of MongoDB
printf "[mongodb-org-${mongodb_version}]\n" > $YUM_REPO_CONFIG_PATH
printf "name=MongoDB Repository\n" >> $YUM_REPO_CONFIG_PATH
printf "baseurl=https://repo.mongodb.org/yum/redhat/7Server/mongodb-org/${mongodb_version}/x86_64/\n" >> $YUM_REPO_CONFIG_PATH
printf "gpgcheck=0\n" >> $YUM_REPO_CONFIG_PATH
printf "enabled=1\n" >> $YUM_REPO_CONFIG_PATH
printf "gpgkey=https://www.mongodb.org/static/pgp/server-${mongodb_version}.asc\n" >> $YUM_REPO_CONFIG_PATH

# Add mongod to sudoers list, so we do not have to prefix every command with sudo.
echo "%mongod  ALL=(ALL)       ALL\n" >> /etc/sudoers

date > /etc/vagrant_provisioned_at

# Add the mongod user account
useradd -m -s /bin/bash -U mongod -u 676
# Remove password from mongod so we can stop/start mongo without sudo or password
passwd -d mongod
# Add mongod account to wheel group
usermod -aG wheel mongod
cp -pr /home/vagrant/.ssh /home/mongod/
chown -R mongod:mongod /home/mongod

# Install MongoDB
yum -y install mongodb-org-${mongodb_version}.${mongodb_minor_point_version} --nogpgcheck

# Install wget
yum -y install wget

# Setting the hostname allows me to see what machine I am on from the prompt
hostnamectl set-hostname ${hostname}

# Reload the changes to the .service files
systemctl daemon-reload

echo Provisioning completed...

