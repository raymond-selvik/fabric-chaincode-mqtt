#!/bin/bash
ORG=$1
CC_NAME=$2
CC_VERSION=$3
PEER_PORT=$4

export FABRIC_PATH=${HOME}/projects/blockchain/fabric-samples
export PATH=${FABRIC_PATH}/bin:$PATH
export FABRIC_CFG_PATH=${FABRIC_PATH}/config

export CORE_PEER_LOCALMSPID="Org${ORG}MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${FABRIC_PATH}/test-network/organizations/peerOrganizations/org${ORG}.example.com/peers/peer0.org${ORG}.example.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE=${FABRIC_PATH}/test-network/organizations/peerOrganizations/org${ORG}.example.com/peers/peer0.org${ORG}.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${FABRIC_PATH}/test-network/organizations/peerOrganizations/org${ORG}.example.com/users/Admin@org${ORG}.example.com/msp
export CORE_PEER_ADDRESS=localhost:${PEER_PORT}

installChaincode() {
    set -x
	peer lifecycle chaincode install package/${CC_NAME}.tar.gz >&log.txt
	res=$?
	set +x
	cat log.txt
	echo
}

queryInstalled() {
	set -x
	peer lifecycle chaincode queryinstalled >&log.txt
	res=$?
	set +x
	cat log.txt
    CC_PACKAGE_ID=$(sed -n "/${CC_NAME}_${CC_VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
	echo "===================== Query installed successful on peer0.org${ORG} on channel ===================== "
	echo
}

approveForMyOrg() {
	set -x
	peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name ${CC_NAME} --version ${CC_VERSION} --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile ${FABRIC_PATH}/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem >&log.txt
	res=$?
	set +x
	cat log.txt
	echo "===================== Chaincode definition approved on peer0.org${ORG} on channel  ===================== "
	echo
}

checkCommitReadiness() {
    set -x
	peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name ${CC_NAME} --version ${CC_VERSION} --sequence 1 --tls --cafile ${FABRIC_PATH}/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem --output json >&log.txt
	res=$?
	set +x
	cat log.txt
	echo "===================== Chaincode definition approved on peer0.org${ORG} on channel  ===================== "
	echo
}


installChaincode
queryInstalled
approveForMyOrg
checkCommitReadiness