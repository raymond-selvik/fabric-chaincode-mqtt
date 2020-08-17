'use strict';

const { Contract } = require('fabric-contract-api');
const { FabricClient } = require('.');

class SensorCC extends Contract {

    constructor(){
        super('Sensor');
    } 
    

    async initSensor(ctx){
        console.info('============= START : Initialize Ledger ===========');
        const sensor =
        {
            id: "1",
            value: 33
        };

        await ctx.stub.putState(sensor.id, Buffer.from(JSON.stringify(sensor)));
        console.info('Added <--> ', sensor);
    } 

    async updateValue(ctx, id, val){
        console.log('Try updating value');
        const sensorBytes = await ctx.stub.getState(id);
        
        if(!sensorBytes || sensorBytes.length === 0){
            throw new Error("Sensor does not exsist");
        } 

        const sensor = JSON.parse(sensorBytes.toString());
        sensor.value = val;

        await ctx.stub.putState(id, Buffer.from(JSON.stringify(sensor)));
    }

    async querySensor(ctx, id) {
        const sensorBytes = await ctx.stub.getState(id); // get the car from chaincode state
        if (!sensorBytes || sensorBytes.length === 0) {
            throw new Error(`${id} does not exist`);
        }
        console.log(sensorBytes.toString());
        return sensorBytes.toString();
    }

    async queryAllSensors(ctx) {
        console.log("Query all sensors");
        const startKey = '';
        const endKey = '';
        const allResults = [];
        for await (const {key, value} of ctx.stub.getStateByRange(startKey, endKey)) {
            const strValue = Buffer.from(value).toString('utf8');
            let record;
            try {
                record = JSON.parse(strValue);
            } catch (err) {
                console.log(err);
                record = strValue;
            }
            allResults.push({ Key: key, Record: record });
        }
        console.log(allResults);
        return JSON.stringify(allResults);
    }
}  

module.exports = SensorCC;


