const { validationJWT } = require('../helpers/jwt');
const { io } = require('../index');


// Mensajes de Sockets
io.on('connection', client => {
    console.log('Cliente conectado');
    const token = client.handshake.headers['x-token']
    const [validation, uid] = validationJWT(token);

    if(!validation){
        return client.disconnect();
    }

    console.log('Cliente Autenticado');

    client.on('disconnect', () => {
        console.log('Cliente desconectado');
    });


    
    // client.on('mensaje', ( payload ) => {
    //     console.log('Mensaje', payload);
    //     io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
    // });


});
