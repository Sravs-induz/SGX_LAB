# Get the sgx enabled hardware

## check the hardware support sgx
```sh
cat /proc/cpuinfo | grep sgx
ls /dev/sgx/enclave
git clone https://github.com/intel/sgx-software-enable.git
cd sgx-software-enable/
make
./sgx_enable 
```


```sh 
sudo apt update
sudo apt upgrade
```

## Install necessary tools
```sh
sudo apt install build-essential ocaml ocamlbuild make automake autoconf libtool libssl-dev debhelper cmake reprepro unzip
sudo apt install pkgconf libcurl4-openssl-dev python-is-python3 libboost-dev libboost-system-dev libboost-thread-dev protobuf-compiler libprotobuf-dev
sudo apt-get install libssl-dev libcurl4-openssl-dev libprotobuf-dev
sudo apt-get install build-essential python
sudo apt-get install build-essential python-is-python3
dpkg-query -s linux-headers-$(uname -r)
sudo apt-get install linux-headers-$(uname -r)
sudo apt-get install build-essential ocaml ocamlbuild automake autoconf libtool wget python-is-python3 libssl-dev git cmake perl
sudo apt-get install libssl-dev libcurl4-openssl-dev protobuf-compiler libprotobuf-dev debhelper cmake reprepro unzip pkgconf libboost-dev libboost-system-dev libboost-thread-dev lsb-release libsystemd0
sudo usermod -a -G sgx sravani
sudo apt-get install libssl-dev libcurl4-openssl-dev libprotobuf-dev
sudo apt-get install libsgx-urts
sudo apt-get install libsgx-quote-ex libsgx-urts
sudo apt-get install libsgx-dcap-ql
sudo apt install libsgx-urts libsgx-enclave-common
sudo apt-get install libsgx-dcap-ql-dev libsgx-dcap-default-qcnl-dev libsgx-dcap-quote-verify-dev
sudo apt-get install python3 cracklib-runtime
sudo apt install build-essential ocaml ocamlbuild make automake autoconf libtool libssl-dev debhelper cmake reprepro unzip
sudo apt install pkgconf libcurl4-openssl-dev python-is-python3 libboost-dev libboost-system-dev libboost-thread-dev protobuf-compiler libprotobuf-dev


# install node
sudo apt install -y curl
curl -fsSL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo apt install nodejs -y


```

## Clone linux sgx repo
```sh
git clone https://github.com/intel/confidential-computing.sgx.git reposgx
cd sgx-source/
./download_prebuilt.sh 
make preparation
make sdk
make sdk_install_pkg
make psw
sudo ./linux/installer/bin/sgx_linux_x64_sdk_2.29.100.1.bin --prefix /opt/intel
source /opt/intel/sgxsdk/environment
echo "source /opt/intel/sgxsdk/environment" >> ~/.bashrc

make deb_local_repo 
make deb_psw_pkg 
chmod o+x /home/sravani
chmod o+x /home/sravani/work
chmod o+x /home/sravani/work/reposgx
sudo apt update
sudo apt upgrade

# edit the file with the path /home/sravani/work/sgx-source/linux/installer/deb/sgx_debian_local_repo/
sudo vim /etc/apt/sources.list



sudo dpkg -i -R ./linux/installer/deb
#pccs setup 
cd work/sgx-source/external/dcap_source/QuoteGeneration/pccs/

sudo apt install sgx-dcap-pccs
sudo systemctl status pccs
node ../pccs_server.js
```

### Put the apikey, port, uri here sudo cat /opt/intel/sgx-dcap-pccs/config/default.json
### Put the pccs url and set the secure cert flag in thi sfile /etc/sgx


/home/sravani/work/reposgx/linux/installer/deb/sgx_debian_local_repo