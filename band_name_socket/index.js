
const express = require("express");
const path = require("path");
// App de express
const app = express(); 

//Node server
const server = require('http').createServer(app);
const io = require('socket.io')(server);

//Mensaje de socket
io.on('connection', client => {
    console.log("Cliente conectado")

    client.on('disconnect', () => {
        console.log("Cliente desconectado")
    });

    client.on('mensaje', (payload) => {
        console.log("Mensaje !!!!!", payload)

        io.emit("mensaje", {admin: "Nuevo Mensaje"});
    })
});

//path publico
const publicPath = path.resolve(__dirname, "public")

app.use(express.static(publicPath ))

server.listen(process.env.PORT, (err) => {
    if(err) throw new Error(err);

    console.log('Servidor corriendo en puerto', process.env.PORT);
});