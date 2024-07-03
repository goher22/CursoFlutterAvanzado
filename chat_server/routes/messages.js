/*
    path: api/user

*/
const { Router } = require('express');
const { validarJWT } = require('../middlewares/validar-jwt');
const { getChat } = require('../controllers/message');

const router = Router();

router.get('/:de', validarJWT, getChat)

module.exports = router;