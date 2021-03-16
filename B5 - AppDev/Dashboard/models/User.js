const { json } = require('express');
const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
    //Profile Info.
    name: {
        type: String,
        required: true
    }, email: {
        type: String,
        required: true
    }, password: {
        type: String,
        required: true
    },

    //Twitter Token
    twittertoken: {
        type: String,
        default: ""
    }, twittersecret: {
        type: String,
        default: ""
    }, twitterjson: {
        type: JSON,
        default: {}
    },

    //Google Token
    googletoken: {
        type: String,
        default: ""
    }, googlesecret: {
        type: String,
        default: ""
    },

    //Widget Token
    widgetnumber: {
        type: Number,
        default: 0
    }, date: {
        type: Date,
        default: Date.now
    }
});

const User = mongoose.model('User', UserSchema);

module.exports = User;