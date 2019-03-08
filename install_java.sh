#!/bin/bash
# Download JDK's tar.gz archive and put it in the same folder of the script
# then run the script.
if [ $(whoami) != "root" ]; then
	echo "The script must be run as root!"
	exit 1
fi
if [ $# -ne 1 ]; then 
	echo -e "\nUsage:    install_java.sh FILE"
	echo -e "          FILE Java's JDK tar file\n"
	exit 1 
fi

if [ ! -f $1 ]; then
	echo "Error - File $1 not found"
	exit 1
fi

tar xf $1
if [ $? -ne 0 ]; then
	echo "Error - Cannot extract java from the archive"
	exit 1
fi

jdk_folder=$(ls | grep -m1 jdk)
if [ $? -ne 0 ]; then
	echo "Error - Cannot find the jdk archive"
	exit 1
fi

if [ ! -d /usr/local/java ]; then
	mkdir /usr/local/java
fi

mv $jdk_folder /usr/local/java/


echo -e "\n\n### Java installation by gius
JAVA_HOME=/usr/local/java/$jdk_folder
PATH=\$PATH:\$HOME/bin:\$JAVA_HOME/bin
export JAVA_HOME\nexport PATH
### End java section\n" >> /etc/profile

update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/$jdk_folder/bin/java" 1
update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/$jdk_folder/bin/javac" 1
update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/local/java/$jdk_folder/bin/javaws" 1

update-alternatives --set java /usr/local/java/$jdk_folder/bin/java
update-alternatives --set javac /usr/local/java/$jdk_folder/bin/javac
update-alternatives --set javaws /usr/local/java/$jdk_folder/bin/javaws

echo "Java JDK successfully installed"
echo "Please reboot your system now to make the installation effective"
#End
