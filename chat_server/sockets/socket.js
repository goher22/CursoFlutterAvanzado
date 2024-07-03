const { validationJWT } = require('../helpers/jwt');
const { io } = require('../index');
const { userConnect, userDesConnect, saveMessage } = require('../controllers/socket');


// Mensajes de Sockets
io.on('connection', client => {
    console.log('Cliente conectado');
    const token = client.handshake.headers['x-token']
    const [validation, uid] = validationJWT(token);

    if(!validation){
        return client.disconnect();
    }

    userConnect(uid);

    client.join(uid);

    client.on('mensaje-personal', async (payload) => {
        await saveMessage(payload);
        io.to(payload.para).emit('mensaje-personal', payload);
    });

    client.on('disconnect', () => {
        userDesConnect(uid);
    });


    
    // client.on('mensaje', ( payload ) => {
    //     console.log('Mensaje', payload);
    //     io.emit( 'mensaje', { admin: 'Nuevo mensaje' } );
    // });


});
