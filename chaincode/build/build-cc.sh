#!/bin/bash

export FABRIC_PATH=${HOME}/projects/blockchain/fabric-samples

export PATH=${FABRIC_PATH}/bin:$PATH
export FABRIC_CFG_PATH=${FABRIC_PATH}/config/

CC_SRC_PATH=$PWD/../src/chaincode

packageChaincode() {
	#set -x
	mkdir -p package
	peer lifecycle chaincode package package/test.tar.gz --path ${CC_SRC_PATH} --lang node --label test_2
	#verifyResult $res "Chaincode packaging on peer0.org has failed"
	echo "===================== Chaincode is packaged on peer0.org===================== "
	echo
}

packageChaincode