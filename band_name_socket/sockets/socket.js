const {io} =  require("../index")

//Mensaje de socket
io.on('connection', client => {
    console.log("Cliente conectado")

    client.on('disconnect', () => {
        console.log("Cliente desconectado")
    });

    client.on('mensaje', (payload) => {
        console.log("Mensaje !!!!!", payload)

        io.emit("mensaje", {admin: "Nuevo Mensaje"});
    });

    client.on('nuevo-mensaje', (payload) => {
        io.emit('nuevo-mensaje', payload);
    })

    client.on('emitir-mensaje', (payload) => {
        console.log(payload);
    })

});