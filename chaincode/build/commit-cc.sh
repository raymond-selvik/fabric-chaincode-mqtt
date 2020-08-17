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

commitChaincodeDefinition() {
    set -x
	peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name ${CC_NAME} --version ${CC_VERSION} --sequence 1 --tls --cafile ${FABRIC_PATH}/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem --peerAddresses localhost:${PEER_PORT} --tlsRootCertFiles ${FABRIC_PATH}/test-network/organizations/peerOrganizations/org${ORG}.example.com/peers/peer0.org${ORG}.example.com/tls/ca.crt --peerAddresses localhost:9051 --tlsRootCertFiles ${FABRIC_PATH}/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt >&log.txt
	peer lifecycle chaincode querycommitted --channelID mychannel --name ${CC_NAME} --cafile ${FABRIC_PATH}/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem  >&log.txt
    res=$?
	set +x
	cat log.txt
	echo "===================== Chaincode commited  on peer0.org${ORG} on channel  ===================== "
	echo
}

commitChaincodeDefinition