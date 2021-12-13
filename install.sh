#! /bin/bash

# Dependencies
echo "INSTALLING DEPENDENCIES"
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt update
sudo apt install build-essential libreadline-dev libssl-dev libpq5 libpq-dev libreadline5 libsqlite3-dev libpcap-dev git-core autoconf postgresql pgadmin3 curl zlib1g-dev libxml2-dev libxslt1-dev libyaml-dev curl zlib1g-dev gawk bison libffi-dev libgdbm-dev libncurses5-dev libtool sqlite3 libgmp-dev gnupg2 dirmngr
sudo apt install sed
sudo apt install git
sudo apt install ruby-full
sudo apt install python3-pip
sudo apt install nmap
sudo apt install chromium-browser
sudo apt install john -y

# Create main dir
main=$HOME/hunt
mkdir $main

echo "---MANAGING RECON TOOLS---"

# Recon
recon=$main/recon
mkdir $recon
cd $recon

# Amass
echo ""
echo "INSTALLING AMASS"
git clone https://github.com/OWASP/Amass && cd Amass && go get ./... && go build ./cmd/amass -o amass
echo ""
echo "COPYING BINARY TO /usr/local/bin"
sudo cp amass /usr/local/bin
echo ""

cd $recon

# Ffuf
echo "INSTALLING FFUF"
echo ""
git clone https://github.com/ffuf/ffuf && cd ffuf && go get && go build
echo ""
echo "COPYING BINARY TO /usr/local/bin"
sudo cp ffuf /usr/local/bin

cd $recon

# Gobuster
echo ""
echo "INSTALLING GOBUSTER"
git clone https://github.com/OJ/gobuster && cd gobuster && go get && go build
echo ""
echo "COPYING BINARY TO /ust/loca/bin"
sudo cp gobuster /usr/loca/bin

cd $recon

# SecLists
echo ""
echo "CLONNING SECLISTS"
git clone https://github.com/danielmiessler/SecLists.git
echo ""

cd $recon

# Wordlists
echo "CLONNING WORDLISTS"
git clone https://github.com/kkrypt0nn/Wordlists
echo ""

cd $recon

# content_discovery_all.txt
echo "DOWNLOADING CONTENT_DISCOVERY_ALL.TXT"
wget https://gist.githubusercontent.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt
echo ""

cd $recon

# rockyou
echo "DOWNLOADING ROCKYOU.TXT"
wget https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt
echo ""

cd $recon

# dns wordlist
echo "DOWNLOAD DNS_WORDLIST.TXT"
wget https://gist.githubusercontent.com/jhaddix/86a06c5dc309d08580a018c66354a056/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt -O dns_wordlist.txt
echo ""

cd $recon

# SpiderFoot
echo "ISNTALLING SPIDERFOOT"
git clone https://github.com/smicallef/spiderfoot.git && cd spiderfoot 
pip3 install -r requirements.txt
echo ""

cd $recon

# Aquatone
echo "DOWNLOADING AQUATONE"
arch=$(dpkg --print-architecture)
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_${arch}_1.7.0.zip && unzip aquatone_linux_${arch}_1.7.0.zip
rm aquatone_linux_${arch}_1.7.0.zip
echo "COPYING BINARY TO /usr/local/bin"
sudo cp aquatone /usr/local/bin

# BFAC
echo ""
echo "CLONNING BFAC"
git clone https://github.com/mazen160/bfac && cd bfac && pip3 install -r requirments.txt
echo "COPYING BINARY TO /usr/local/bin"
sudo cp bfac /usr/local/bin
echo ""

cd $recon

# goaltdns
echo "INSTALLING GOALTDNS"
git clone https://github.com/subfinder/goaltdns && cd goaltdns && go get; go build -o goaltdns
echo "COPYING BINARY TO /usr/local/bin"
sudo cp goaltdns /usr/local/bin
echo ""

cd $recon

# JSFScan
echo "INSTALLING JSFSCAN"
git clone https://github.com/KathanP19/JSFScan.sh && cd JSFScan.sh && sudo chmod +x install.sh
./install.sh
echo ""

cd $recon

# httprobe
echo "INSTALLING HTTPROBE"
git clone https://github.com/tomnomnom/httprobe && cd httprobe && go get; go build -o httprobe
echo "COPYING BINARY TO /usr/loca/bin"
sudo cp httprobe /usr/local/bin
echo ""

cd $recon

# git-hound
echo "DOWNLOADING GIT-HOUND"
mkdir git-hound && cd git-hound && wget https://github.com/tillson/git-hound/releases/download/v1.3/git-hound_1.3_Linux_x86_64.tar.gz
tar -xzf git-hound_1.3_Linux_x86_64.tar.gz && rm git-hound_1.3_Linux_x86_64.tar.gz
wget https://raw.githubusercontent.com/tillson/git-hound/master/config.example.yml
echo ""

cd $recon

# GitTools
echo "CLONNING GITTOOLS"
git clone https://github.com/internetwache/GitTools && cd Finder && pip3 install -r requirements.txt
echo ""

echo "------"



echo "---MANAGING SCANNERS---"

scanners=$main/scanners
mkdir $scanners

cd $scanners

# sqlmap
echo "CLONNING SQLMAP"
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
echo ""

# wpscan
echo "INSTALLING WPSCAN"
sudo gem install wpscan
echo ""


# dalfox
echo "INSTALLING DALFOX"
git clone https://github.com/hahwul/dalfox/ && cd dalfox && go get; go build -o dalfox dalfox.go
echo "COPYING BINARY TO /usr/local/bin"
sudo cp dalfox /usr/local/bin
echo ""

cd $scanners

# metasploit
echo "DOWNLOADING METASPLOIT"
wget http://downloads.metasploit.com/data/releases/metasploit-latest-linux-installer.run 
echo "INSTALING METASPLOIT"
chmod +x metasploit-latest-linux-installer.run
sudo ./metasploit-latest-linux-installer.run
sudo msfupdate
rm metasploit-latest-linux-installer.run
echo ""

# CORScanner
echo "CLONNING CORSCANNER"
git clone https://github.com/chenjj/CORScanner && cd CORScanner && pip3 install -r requirements.txt
echo ""

cd $scanners

# cariddi
echo "CLONNING CARIDDI"
git clone https://github.com/edoardottt/cariddi; cd cariddi; go get; sudo make linux
echo ""

cd $scanners

# crlfuzz
echo "CLONNING CRLFUZZ
git clone https://github.com/dwisiswant0/crlfuzz && cd crlfuzz/cmd/crlfuzz && go build .
echo "COPYING BINARY TO /usr/local/bin"
sudo cp crlfuzz /usr/local/bin
echo ""

cd $scanners

echo "------"


echo "---MANAGING ENUM/PRIVESC TOOLS---"

enumesc=$HOME/enumesc
mkdir $enumesc

cd $enumesc

# PEAS-ng
echo "CLONNING PEAS-ng"
git clone https://github.com/carlospolop/PEASS-ng
echo ""

# enum4linux-ng
echo "CLONNING ENUM4LINUX-NG"
git clone https://github.com/cddmp/enum4linux-ng && cd enum4linux-ng && pip3 install -r requirements.txt
echo ""

cd $enumesc

# impacket
echo "CLONNING IMPACKET"
git clone https://github.com/SecureAuthCorp/impacket && cd impacket && sudo pip3 install -r requirements.txt
echo ""

cd $enumesc

echo "------"


echo "---MANAGING UNCATECORIZED TOOLS---"

other=$HOME/other
mdkrid $other

cd $other

# CeWL
echo "CLONNING CEWL"
git clone https://github.com/digininja/CeWL && cd CeWL
echo "INSTALLING CEWL DEPENDENCIES"
sudo gem install bundler
sudo bundle install
echo ""

cd $other

# evil-winrm
echo "INSTALLING EVIL-WINRM"
sudo gem install evil-winrm
echo ""


echo "------"
