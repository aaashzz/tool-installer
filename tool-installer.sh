#!/bin/bash

#sec 1

read -p "Do you want to install blackarch [Y/N]: " x
if [[ "$x" == "y" || "$x" == "Y" ]]
then
	echo "it works"
	curl -O https://blackarch.org/strap.sh
	echo 5ea40d49ecd14c2e024deecf90605426db97ea0c strap.sh | sha1sum -c
	chmod +x strap.sh
	sudo ./strap.sh
	sudo pacman -Syy
else
	echo "okay!"
fi

#sec 2

declare -a array=("git","curl","wget","nmap" "vim" "whatweb" "gobuster" "binwalk" "wfuzz" "hydra" "john" "hashcat" "aircrack-ng" "evil-winrm" "steghide" "recon-ng" "whois" "twint" "reaver" "metasploit" "exploitdb" "nikto" "netdiscover" "seclists" "webshells" "openvpn")
#declare -a array=("nmap" "vim" "whatweb" "gobuster")
declare -a array2=()
for i in "${array[@]}"
do
app=`sudo pacman -Qe | grep $i | cut -d " " -f 1`

if [[ "$i" == "$app" ]]
then
echo "$i ----> Already Installed"
else
echo "$i ----> Not Installed"
array2+=($i)
fi
done
clear
echo "-------------------------------------"
echo "   Pakages which are not Installed   "
echo "-------------------------------------"
count1=
for j in "${array2[@]}"
do
count1=$(expr $count1 + 1)
echo "[${count1}] ${j}  "
done
echo " "

read -p "Do you want to install all these pakages? [Y/N]: " userin

if [[ "$userin" == "Y" || "$userin" == "y" ]]
then
for k in "${array2[@]}"
do
yes | sudo pacman -S $k
done
clear

#sec 3

count2=
declare -a array3=("linpeas" "pspy64" )
echo "Installing tools for priv esc!"
for m in "${array3[@]}"
do
count2=$(expr $count2 + 1)
echo "[${count2}] $m"
done
#linpeas
wget "https://github.com/carlospolop/PEASS-ng/releases/download/20220821/linpeas.sh"
#pspy64
wget "https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64"

clear
echo "Bye!"
else
echo "exiting..."
fi
