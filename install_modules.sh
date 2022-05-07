#!/bin/bash

user=$(whoami)

if [[ "$user" != "root" ]]
then
        echo "Wrong user bud... run as root"
        exit
fi

# Repo https://github.com/mkubecek/vmware-host-modules
git clone https://github.com/mkubecek/vmware-host-modules.git --quiet

cd ./vmware-host-modules

branch_name=$(vmware -v | awk {'print tolower($2)"-"$3'})

if [ `git ls-remote | grep $branch_name | wc -l` -gt 0 ]
then
	git checkout $branch_name
	make
	sudo make install
else
    	echo "Branch named $branch_name does not exist, there are no modules yet for your vmware version"
fi

cd ..
sudo rm -r ./vmware-host-modules
