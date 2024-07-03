const jwt = require('jsonwebtoken');


const generarJWT = ( uid ) => {

    return new Promise( (resolve, reject) => {

        const payload = { uid };

        jwt.sign( payload, process.env.JWT_KEY, {
            expiresIn: '24h'
        }, ( err, token ) => {

            if ( err ) {
                // no se pudo crear el token
                reject('No se pudo generar el JWT');

            } else {
                // TOKEN!
                resolve( token );
            }

        })

    });


}

const validationJWT = (token = '')=> {
    if ( !token ) {
        return res.status(401).json({
            ok: false,
            msg: 'No hay token en la petición'
        });
    }

    try {

        const { uid } = jwt.verify( token, process.env.JWT_KEY );
        
        return [true, uid];

    } catch (error) {
        return [false]
    }
}

module.exports = {
    generarJWT,
    validationJWT
}