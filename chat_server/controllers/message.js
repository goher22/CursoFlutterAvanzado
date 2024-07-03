const { response, request } = require('express');

const getChat = async (req = request, res = response ) => {
    const Message = require('../models/mensaje');
    const uid = req.uid;
    const uidFrom = req.params.de;
    const message = await Message.find({
        $or: [
            {
                de: uid,
                para: uidFrom,
            },
            {
                de: uidFrom,
                para: uid
            },
        ]
    })
    .sort({
        createdAt: 'desc'
    })
    .limit(30);

    res.json({
        ok: true,
        message
    });
}

module.exports = {
    getChat,
}