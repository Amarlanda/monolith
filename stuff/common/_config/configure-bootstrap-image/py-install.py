
echo "Setting  ENVS"
                                                                      #work {}
 #$AWS_ENV_Dev =  "eu-west-3"
 #$AWSProfile = "AWS-HO"
 region="eu-west-1"
 AccessKey="AKIAI7P24XLNOKUZKO3A"
 SecretKey="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"


import os
os.system("which gcc")
os.system("which neovim")


# mout tools from iso ; cd
mkdir ~/tmp; cp 'VMware Tools'/ ~/tmp/'VMware Tools'
echo 'hello' >> ~/tmp/hello.txt # test data for bukcet

  #install vmawre tools

    #chmod -x ./run_upgrader.sh ;sudo ./run_upgrader.sh
    #/home/amar/Desktop/vmware-tools-distrib/vmware-install.pl

    echo -e "\e[1mChecking \e[92mVMwware tools versions" ;echo -e "\e[97m"

    vmware-toolbox-cmd -v

echo -e "\e[1mInstalling \e[92mnodejs";echo -e "\e[97m"
    sudo apt install nodejs

    echo -e "\e[1mInstalling \e[92mDont use aws!";echo -e "\e[97m"

    #sudo apt  install awscli -y


echo -e "\e[1mInstalling \e[92msnapd";echo -e "\e[97m"

    sudo apt install snapd -y


echo -e "\e[1mInstalling \e[92mNeo VIM";echo -e "\e[97m"

sudo apt install neovim -y


echo -e "\e[1mInstalling \e[92mOpenSSH";echo -e "\e[97m"
sudo snap install openssh-server -y


echo -e "\e[1mInstalling \e[92mterraform";echo -e "\e[97m"
sudo snap install terraform


echo -e "\e[1mInstalling \e[92mTmux";echo -e "\e[97m"
sudo snap install tmux


echo -e "\e[1mInstalling \e[92mGit";echo -e "\e[97m"
sudo apt install git


ip -a address |grep 'inet 192.'
# "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo -e "\e[1mInstalling \e[92m Configuring Git and pushing";echo -e "\e[97m"


mkdir  ~/linux-priv
git init ~/linux-priv/
cd ~/linux-priv/
git config --global user.name "amarlanda"
git config --global user.email "al@amarlanda.com"
ssh -T git@github.com

git remote set-url origin git@github.com:Amarlanda/linux-priv.git
git add .
git commit -m "auto commit $(date)"

#git remote add origin https://github.com/Amarlanda/linux-priv.git

git push -u origin master

git config --list

### vanity stuff
#do this at the end!
#screen -t "main shell"
#screen -t "tmux"
###

###
echo -e "\e[1mconfiguring \e[92m AWS & pip" ;echo -e "\e[97m"
#AWS Stuffy now ;)

echo -e "\e[1mconfiguring \e[92m update symlink to python 3" ;echo -e "\e[97m"
#update-alternatives --install /usr/bin/python python /usr/bin/python3 10


##
#LEAVE THIS ALONEEEE

  #FUN WITH AWS CLI =/
#

#old verions of PIP installer
#curl -O https://bootstrap.pypa.io/get-pip.py
#sudo python get-pip.py --user
#sudo pip install awscli --upgrade --user

#remove old version of AWS cli
#sudo apt-get remove --auto-remove awscli
#sudo rm -rf /usr/local/aws
#sudo rm /usr/local/bin/aws

#sudo pip3 install boto3
#sudo pip3 install botocore

#sudo apt-get install python3-pip -y
#sudo apt install python3-pip -y
#sudo pip3 install --upgrade setuptools
# sudo pip3 install awscli --upgrade

##
# if all else fails pip install awscli --force-reinstall --upgrade
##
  aws configure set aws_access_key_id $AccessKey
  aws configure set aws_secret_access_key $SecretKey
  aws configure set default.region $region

aws eks list-clusters
