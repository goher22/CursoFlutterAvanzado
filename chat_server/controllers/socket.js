const User = require('../models/usuario');

const userConnect = async  (uid = '') => {
    const user = await User.findById(uid);
    user.online = true;
    await user.save();
    return user;
}

const userDesConnect = async  (uid = '') => {
    const user = await User.findById(uid);
    user.online = false;
    await user.save();
    return user;
}

module.exports = {
    userConnect,
    userDesConnect,
}