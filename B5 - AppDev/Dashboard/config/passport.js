const link = "http://localhost:80";

const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const GitHubStrategy = require('passport-github').Strategy;
const TwitterStrategy = require('passport-twitter').Strategy;
const GoogleStrategy = require('passport-google-oauth20').Strategy;

const bcrypt = require('bcryptjs');
const mongoose = require('mongoose');

var GITHUB_CLIENT_ID = "Iv1.0c65f1bb20f41f4f";
var GOOGLE_CLI_SECRET = "06zKsz4D_VXPmBvJIgraAUoI";
var TWITTER_CONSUMER_KEY = "8ugmsNBY66k75Amqdhva8xfZb";
var GITHUB_CLIENT_SECRET = " 6ea3145f98d6a5956edbe7a5dae2fd44b598e3e9";
var TWITTER_CONSUMER_SECRET = "QoYsf4NdDn874r3ISdXNWSOiUpYr7xL2roUBXlRRyIZCtT2w9G";
var GOOGLE_CLI_ID = "890210747812-5prj40nsk5lod1sfvv53t2uhm9c1i51o.apps.googleusercontent.com";

const User = require('../models/User');

module.exports = function(passport) {
    passport.use(
        new LocalStrategy ({usernameField: 'email'}, (email, password, done) => {
            //Match User
            User.findOne({email: email}).then(user => {
                if (!user) {
                    return done(null, false, {msg: 'That email is not registred'});
                }
                // Match Password
                bcrypt.compare(password, user.password, (err, isMatch) => {
                    if (err) throw err;
                    if (isMatch) {
                        return done(null, user);
                    } else {
                        return done (null, false, {msg: 'Password incorrect'});
                    }
                });
            })
            .catch(err => console.log(err))
        })
    )
    passport.serializeUser(function(user, done) {done(null, user.id);});
    passport.deserializeUser(function(id, done) {User.findById(id, function(err, user) {done(err, user);});});

}
