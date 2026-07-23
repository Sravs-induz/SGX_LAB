#!/bin/bash

set -euo pipefail

LOG_FILE="sgx_validation_$(date +%Y%m%d_%H%M%S).log"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "============================================================"
echo "        SGX Platform Validation Tool"
echo "============================================================"
echo "Date : $(date)"
echo "Host : $(hostname)"
echo "Kernel : $(uname -r)"
echo

########################################
# Install Docker
########################################

echo "[1/6] Checking Docker installation..."

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker not found. Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm -f get-docker.sh
else
    echo "Docker is already installed."
fi

########################################
# Verify SGX Devices
########################################

echo
echo "[2/6] Checking SGX devices..."

if [[ -e /dev/sgx_enclave && -e /dev/sgx_provision ]]; then
    echo "PASS : SGX device nodes detected."
else
    echo "FAIL : SGX device nodes not found."
    exit 1
fi

########################################
# Verify CPU Support
########################################

echo
echo "[3/6] Checking SGX CPU capability..."

grep -i sgx /proc/cpuinfo || true

########################################
# SGX Hardware Compatibility
########################################

echo
echo "[4/6] Running Intel SGX compatibility tool..."

rm -rf sgx-software-enable

git clone https://github.com/intel/sgx-software-enable.git

pushd sgx-software-enable

make

sudo ./sgx_enable

popd

########################################
# Pull Docker Image
########################################

echo
echo "[5/6] Pulling SGX validation container..."

sudo docker pull ghcr.io/sravaniketha07/sgx-test-tool:v9

########################################
# Execute SGX Validation
########################################

echo
echo "[6/6] Running SGX quote generation test..."

mkdir -p output

docker run --rm \
    --network host \
    --device /dev/sgx_enclave \
    --device /dev/sgx_provision \
    ghcr.io/sravaniketha07/sgx-test-tool:v9

echo
echo "============================================================"
echo "SGX validation completed successfully."
echo "Log file : $LOG_FILE"
echo "============================================================"