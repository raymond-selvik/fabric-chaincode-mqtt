# fabric-chaincode-mqtt
Project for integrating IoT into Hyperledger Fabric. A Client listening to sensor data from an MQTT broker, and is commiting the data to the Ledger. 

This solution consist of three subprojects:

- **Chaincode:** The smart contract that runs on the ledger. It contains code for updating the Digital Twin of the Sensor.
- **Fabric Client:** A gateway between the the MQTT-broker and ledger. Receives sensor data from the broker, and calls the smart contract for upating the values.
- **Sensor:** A simulated sensor for publishing messages on the MQTT-broker. 
