#!/bin/bash
#Remove java installed with install_java.sh

if [ $(whoami) != "root" ]; then
        echo "The script must be run as root!"
        exit 1
fi

#Remove Java section on /etc/profile
cat /etc/profile | grep -q "### Java installation by gius"
if [ $? -eq 0 ]; then 
	cat /etc/profile | grep -v -e "### Java installation by gius"\
				   -e "JAVA_HOME=/usr/local/java/.*"\
				   -e "PATH=\$PATH:\$HOME/bin:\$JAVA_HOME/bin"\
				   -e "export JAVA_HOME"\
				   -e "export PATH"\
				   -e "### End java section" > /etc/profile
fi


#Remove alternatives
update-alternatives --remove-all java
update-alternatives --remove-all javac
update-alternatives --remove-all javaws

#Remove java's directory
rm -rf /usr/local/java

echo "Java JDK successfully uninstalled"
echo "Please reboot your system now to make the uninstall effective"
#End
