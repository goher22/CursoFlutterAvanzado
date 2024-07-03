const { validationJWT } = require('../helpers/jwt');
const { io } = require('../index');
const { userConnect, userDesConnect } = require('../controllers/socket');


// Mensajes de Sockets
io.on('connection', client => {
    console.log('Cliente conectado');
    const token = client.handshake.headers['x-token']
    const [validation, uid] = validationJWT(token);

    if(!validation){
        return client.disconnect();
    }

    userConnect(uid);

    client.on('disconnect', () => {
        userDesConnect(uid);
    });


    
    // client.on('mensaje', ( payload ) => {
    //     console.log('Mensaje', payload);
    //     io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
    // });


});
