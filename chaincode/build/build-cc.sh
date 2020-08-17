#!/bin/bash

export FABRIC_PATH=${HOME}/projects/blockchain/fabric-samples

export PATH=${FABRIC_PATH}/bin:$PATH
export FABRIC_CFG_PATH=${FABRIC_PATH}/config/

CC_SRC_PATH=$PWD/../src

CC_NAME=$1
CC_VERSION=$2

packageChaincode() {
	#set -x
	mkdir -p package
	peer lifecycle chaincode package package/${CC_NAME}.tar.gz --path ${CC_SRC_PATH} --lang node --label ${CC_NAME}_${CC_VERSION} >&log.txt
	res=$?
	set +x
	cat log.txt
	echo "===================== Chaincode is packaged on peer0.org===================== "
	echo
}

packageChaincode