const User = require('../models/usuario');
const Message = require('../models/mensaje');

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

const saveMessage = async (payload) => {
    try {
        const message = new Message(payload);
        await message.save();
        return true;
    } catch (error) {
        return false;
    }
}

module.exports = {
    userConnect,
    userDesConnect,
    saveMessage,
}