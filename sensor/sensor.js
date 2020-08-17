var mqtt = require('mqtt');
var sleep = require('sleep'); 

var client  = mqtt.connect("mqtt://localhost:1883",{clientId:"device"});

console.log("connected flag  "+client.connected);


client.on("connect",function(){	
    console.log("connected  "+client.connected);

})

setInterval(function(){ 
    var data = {id: "1",  value: Math.random(100)};
    var json = JSON.stringify(data);

    console.log("Publishing", json);
    client.publish('testtopic', json);   
}, 10000);


