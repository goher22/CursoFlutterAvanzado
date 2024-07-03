const { response, request } = require('express');
const User = require('../models/usuario');

const getUser = async (req = request, res = response ) => {

    const desde = Number(req.query.desde) || 0;

    const users = await User
        .find({_id: {$ne: req.uid}})
        .sort('-online')
        .skip(desde)
        .limit(20)

    res.json({
        ok: true,
        users
    });
}

module.exports = {
    getUser,
}