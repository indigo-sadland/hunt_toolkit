#!/bin/bash

On_Black='\033[40m'
NC='\033[0m'

# Dependencies
echo -e "${On_Black}INSTALLING DEPENDENCIES${NC}"
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt -y update
sudo apt -y install build-essential libreadline-dev libssl-dev libpq5 libpq-dev libreadline5 libsqlite3-dev libpcap-dev git-core autoconf postgresql pgadmin3 curl zlib1g-dev libxml2-dev libxslt1-dev libyaml-dev curl zlib1g-dev gawk bison libffi-dev libgdbm-dev libncurses5-dev libtool sqlite3 libgmp-dev gnupg2 dirmngr
sudo apt -y install sed
sudo apt -y install git
sudo apt -y install ruby-full
sudo apt -y install python3-pip
sudo apt -y install nmap
sudo apt -y install chromium-browser
sudo apt -y install john -y
sudo apt -y install exiftool
sudo apt -y install cython3

# Create main dir
main=$HOME/hunt
mkdir $main

echo -e ""
echo -e "${On_Black}---MANAGING RECON TOOLS---${NC}"

# Recon
recon=$main/recon
mkdir $recon

wrds=$recon/wrds
mkdir $wrds

content_lists=$wrds/content_lists
mkdir content_lists

dns_lists=$wrds/dns_lists
mkdir dns_lists

cd $recon

wrdlst=$recon/WRDLST
mkdir $wrdlst

# Amass
echo -e ""
echo -e "${On_Black}INSTALLING AMASS${NC}"
git clone https://github.com/OWASP/Amass && cd Amass && go get ./... && go build ./cmd/amass -o amass
echo -e ""
echo -e "${On_Black}COPYING BINARY TO /usr/local/bin${NC}"
sudo cp amass /usr/local/bin
echo -e ""

cd $recon

# Ffuf
echo -e "${On_Black}INSTALLING FFUF${NC}"
echo -e ""
git clone https://github.com/ffuf/ffuf && cd ffuf && go get && go build
echo -e ""
echo -e "${On_Black}COPYING BINARY TO /usr/local/bin${NC}"
sudo cp ffuf /usr/local/bin
echo -e ""

cd $recon

# Pymeta
echo -e "${On_Black}INSTALLING PYMETA${NC}"
git clone https://github.com/m8r0wn/pymeta && cd pymeta && pip3 install -r requirements.txt
sudo python3 setup.py install
echo -e ""

cd $recon

# Gobuster
echo -e ""
echo -e "${On_Black}INSTALLING GOBUSTER${NC}"
git clone https://github.com/OJ/gobuster && cd gobuster && go get && go build
echo -e ""
echo -e "${On_Black}COPYING BINARY TO /ust/loca/bin${NC}"
sudo cp gobuster /usr/local/bin

cd $wrds

# SecLists
cd $wrdlst
echo -e ""
echo -e "${On_Black}CLONNING SECLISTS${NC}"
git clone https://github.com/danielmiessler/SecLists.git
echo -e ""

cd $wrds

# Wordlists
echo -e "${On_Black}CLONNING WORDLISTS${NC}"
git clone https://github.com/kkrypt0nn/Wordlists
echo -e ""

cd $content_lists

# content_discovery_all.txt
cd $wrdlst
echo -e "${On_Black}DOWNLOADING CONTENT_DISCOVERY_ALL.TXT${NC}"
wget https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt
echo -e ""

cd $recon

# rockyou
cd $wrdlst
echo -e "${On_Black}DOWNLOADING ROCKYOU.TXT${NC}"
wget https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
echo -e ""

cd $dns_lists

# dns wordlist
cd $wrdlst
echo -e "${On_Black}DOWNLOAD DNS_WORDLIST.TXT${NC}"
wget https://gist.githubusercontent.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt -O dns_wordlist.txt
echo -e ""

cd $recon

# SpiderFoot
echo "${On_Black}INSTALLING SPIDERFOOT${NC}"
git clone https://github.com/smicallef/spiderfoot.git && cd spiderfoot 
pip3 install -r requirements.txt
echo -e ""

cd $recon

# Gowitness
echo "${On_Black}INSTALLING GOWITNESS${NC}"
git clone https://github.com/sensepost/gowitness && cd gowitness && go get && go build -o gowitness main.go
echo "${On_Black}COPYING BINARY TO /usr/local/bin${NC}"
sudo cp gowitness /usr/local/bin
echo ""

# Feroxbuster
echo -e "${On_Black}DOWNLOADING FEROXBUSTER${NC}"
arch=$(dpkg --print-architecture)
if [ $arch == "arm64" ]; then
	wget https://github.com/epi052/feroxbuster/releases/download/v2.4.0/aarch64-feroxbuster.zip && unzip aarch64-feroxbuster.zip
	chmod +x feroxbuster
	rm aarch64-feroxbuster.zip
	"${On_Black}COPYING BINARY TO /usr/local/bin${NC}"
	sudo cp feroxbuster /usr/local/bin
	rm feroxbuster
elif [ $arch == "amd64" ]; then
	wget https://github.com/epi052/feroxbuster/releases/download/v2.4.0/x86_64-linux-feroxbuster.zip && unzip x86_64-linux-feroxbuster.zip
	chmod +x feroxbuster
	rm x86_64-linux-feroxbuster.zip
        "${On_Black}COPYING BINARY TO /usr/local/bin${NC}"
        sudo cp feroxbuster /usr/local/bin
	rm feroxbuster
else
	echo -e "${On_Black}I only consider arm64 and amd64 system architectures.${NC}" 
	"${On_Black}Check othere arch manualy https://github.com/epi052/feroxbuster/releases${NC}"
fi

# Holehe
echo -e  ""
echo -e "${On_Black}CLONNING HOLEHE${NC}"
git clone https://github.com/megadose/holehe.git && cd holehe && sudo python3 setup.py install
echo -e ""

cd $recon

# BFAC
echo -e ""
echo -e "${On_Black}CLONNING BFAC${NC}"
git clone https://github.com/mazen160/bfac && cd bfac && pip3 install -r requirements.txt
echo -e "${On_Black}COPYING BINARY TO /usr/local/bin${NC}"
sudo cp bfac /usr/local/bin
echo -e ""

cd $recon

# goaltdns
echo -e "${On_Black}INSTALLING GOALTDNS${NC}"
git clone https://github.com/subfinder/goaltdns && cd goaltdns && go get; go build -o goaltdns
echo -e "${On_Black}COPYING BINARY TO /usr/local/bin${NC}"
sudo cp goaltdns /usr/local/bin
echo -e ""

cd $recon

# JSFScan
echo -e "${On_Black}INSTALLING JSFSCAN${NC}"
git clone https://github.com/KathanP19/JSFScan.sh && cd JSFScan.sh && sudo chmod +x install.sh
./install.sh
echo -e ""

cd $recon

# httprobe
echo -e "${On_Black}INSTALLING HTTPROBE${NC}"
git clone https://github.com/tomnomnom/httprobe && cd httprobe && go get; go build -o httprobe
echo -e "${On_Black}COPYING BINARY TO /usr/loca/bin${NC}"
sudo cp httprobe /usr/local/bin
echo -e ""

cd $recon

# git-hound
echo -e "${On_Black}DOWNLOADING GIT-HOUND${NC}"
mkdir git-hound && cd git-hound && wget https://github.com/tillson/git-hound/releases/download/v1.3/git-hound_1.3_Linux_x86_64.tar.gz
tar -xzf git-hound_1.3_Linux_x86_64.tar.gz && rm git-hound_1.3_Linux_x86_64.tar.gz
wget https://raw.githubusercontent.com/tillson/git-hound/master/config.example.yml
echo -e ""

cd $recon

# GitTools
echo -e "${On_Black}CLONNING GITTOOLS${NC}"
git clone https://github.com/internetwache/GitTools && cd GitTools/Finder && pip3 install -r requirements.txt
echo -e ""

echo -e "------"
echo ""

echo -e "${On_Black}---MANAGING SCANNERS---${NC}"
echo -e ""

scanners=$main/scanners
mkdir $scanners

cd $scanners

# sqlmap
echo -e "${On_Black}CLONNING SQLMAP${NC}"
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
echo -e ""

# wpscan
echo -e "${On_Black}INSTALLING WPSCAN${NC}"
sudo gem install wpscan
echo -e ""

# log4j-scan
echo -e "${On_Black}CLONNING LOG4J-SCAN${NC}"
git clone https://github.com/fullhunt/log4j-scan && cd log4j-scan && pip3 install -r requirements.txt
echo -e ""

cd $scanners

# dalfox
echo -e "${On_Black}INSTALLING DALFOX${NC}"
git clone https://github.com/hahwul/dalfox/ && cd dalfox && go get; go build -o dalfox dalfox.go
echo -e "${On_Black}COPYING BINARY TO /usr/local/bin${NC}"
sudo cp dalfox /usr/local/bin
echo -e ""

cd $scanners

# metasploit
echo -e "${On_Black}DOWNLOADING METASPLOIT${NC}"
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
echo -e "${On_Black}INSTALING METASPLOIT${NC}"
chmod +x msfinstall
sudo ./msfinstall
sudo msfdb init
sudo msfupdate
rm msfinstall
echo -e ""

# CORScanner
echo -e "${On_Black}CLONNING CORSCANNER${NC}"
git clone https://github.com/chenjj/CORScanner && cd CORScanner && pip3 install -r requirements.txt
echo -e ""

cd $scanners

# cariddi
echo -e "${On_Black}CLONNING CARIDDI${NC}"
git clone https://github.com/edoardottt/cariddi && cd cariddi && go get
sudo make linux
echo -e ""

cd $scanners

# crlfuzz
echo -e "${On_Black}CLONNING CRLFUZZ${NC}"
git clone https://github.com/dwisiswant0/crlfuzz && cd crlfuzz/cmd/crlfuzz && go build .
echo -e "${On_Black}COPYING BINARY TO /usr/local/bin${NC}"
sudo cp crlfuzz /usr/local/bin
echo -e ""

cd $scanners

echo -e "------"
echo ""

echo -e "${On_Black}---MANAGING ENUM/PRIVESC TOOLS---${NC}"

enumesc=$main/enumesc
mkdir $enumesc

cd $enumesc

# PEAS-ng
echo -e "${On_Black}CLONNING PEAS-ng${NC}"
git clone https://github.com/carlospolop/PEASS-ng
echo -e ""

# enum4linux-ng
echo -e "${On_Black}CLONNING ENUM4LINUX-NG${NC}"
git clone https://github.com/cddmp/enum4linux-ng && cd enum4linux-ng && pip3 install -r requirements.txt
echo -e ""

cd $enumesc

# impacket
echo -e "${On_Black}CLONNING IMPACKET${NC}"
git clone https://github.com/SecureAuthCorp/impacket && cd impacket && sudo pip3 install -r requirements.txt
echo -e ""

cd $enumesc

# nishang
echo -e "${On_Black}CLONNING NISHANG${NC}"
git clone https://github.com/samratashok/nishang
echo -e ""

echo -e "------"
echo ""

echo -e "${On_Black}---MANAGING UNCATECORIZED TOOLS---${NC}"

other=$main/other
mkdir $other

cd $other

# CeWL
echo -e "${On_Black}CLONNING CEWL${NC}"
git clone https://github.com/digininja/CeWL && cd CeWL
echo -e "${On_Black}INSTALLING CEWL DEPENDENCIES${NC}"
sudo gem install bundler
bundle install
echo -e ""

cd $other

# evil-winrm
echo -e "${On_Black}INSTALLING EVIL-WINRM${NC}"
sudo gem install evil-winrm
echo -e ""

cd $other

# torghost
echo -e "${On_Black}CLONNING TORGHOST${NC}"
git clone https://github.com/SusmithKrishnan/torghost.git && cd torghost && sudo pip3 install -r requirements.txt
chmod +x build.sh
./build.sh
echo ""

echo -e "------"
