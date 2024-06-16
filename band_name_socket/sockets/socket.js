const {io} =  require("../index")
const Band = require("../models/bands")

const bands = new Bands();

bands.addBand(new Band('Queen'));
bands.addBand(new Band('Bon Jovi'));
bands.addBand(new Band('Heroes del Silencio'));
bands.addBand(new Band('Metallica'));

console.log(bands);

//Mensaje de socket
io.on('connection', client => {
    console.log("Cliente conectado")

    client.emit('active-bands', bands.getBands());

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

    client.on('vote-band', (payload) => {
        bands.voteBand(payload.id ?? "");
        io.emit('active-bands', bands.getBands());
    })

});