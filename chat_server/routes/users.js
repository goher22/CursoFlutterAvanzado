/*
    path: api/user

*/
const { Router } = require('express');
const { validarJWT } = require('../middlewares/validar-jwt');
const { getUser } = require('../controllers/users');

const router = Router();

router.get('/', validarJWT, getUser)

module.exports = router;