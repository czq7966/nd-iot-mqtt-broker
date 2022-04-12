var aedes;

// mqtt broker
do {
    function onAuthenticate (client, username, password, callback) {
        let users = ["device", "cmdgate"]
        
        if (users.indexOf(username) < 0) {
            callback({ returnCode: 4 }, false);
            console.log("invalid user:" + username);
        }
        else {
            callback(null, true);
            console.log("user login:" + username);
        }
    }
  

    aedes = require('aedes')({
        authenticate: onAuthenticate
    })

    aedes.on("client", (client) => {
        console.log('on client event ');
    })
    
    aedes.on("clientReady", (client) => {
        console.log('on clientReady event ');
    })
    
    
    aedes.on("subscribe", (subscriptions, client) => {
        console.log('on subscribe event: ', subscriptions);
    })
    
    aedes.on("publish", (AedesPublishPacket, client) => {
        console.log('on publish event: ', AedesPublishPacket);
    })    
}while(0)


// tcp server
do {
    const port = 1883
    const tcpServer = require('net').createServer(aedes.handle)

    tcpServer.listen(port, function () {
        console.log('mqtt server started and listening on port ', port)
    })


    tcpServer.addListener("connection", (socket) => {
        console.log('mqtt tcp on connection ');
    })
} while(0)


// websocket server
do{
    const port = 1884
    const httpServer = require('http').createServer()
    const wsStream = require('websocket-stream')

    const wsServer = wsStream.createServer({ server: httpServer }, aedes.handle)

    httpServer.listen(port, function () {
        console.log('mqtt websocket server listening on port ', port)
    })

    wsServer.on("connection", (socket) => {
        console.log('mqtt websocket on connection ');
    })
} while(0)


