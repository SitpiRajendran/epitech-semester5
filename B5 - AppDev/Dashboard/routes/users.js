const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const passport = require('passport');
var nodemailer = require('nodemailer');

const User = require("../models/User")

//Login Page
router.get('/login', (req, res) => res.render('login'));

//Register Page
router.get('/register', (req, res) => res.render('register'));

// Register Handle
router.post('/register', (req, res) => {
    const {name, email, password, password2} = req.body;
    let errors = [];

    if (!name || !email || !password || !password2) {
        errors.push({msg: 'Please fill in all fields'});
    }

    if (password !== password2) {
        errors.push({msg: 'Passwords do not match'});
    }

    if (password.length < 6) {
        errors.push({msg: 'Passwords must be at least 6 characters'});
    }

    if (errors.length > 0) {
        res.render('register', {
            errors, name, email, password, password2
        });
    } else {
        const transporter = nodemailer.createTransport({
        service: 'hotmail',
        auth: {
            user: 'sitpi@hotmail.fr',
            pass: '28112000'
        }
        });

        // Validation passed
        User.findOne({email: email})
        .then(user => {
            // User Exists
            if (user) {
                errors.push({msg: 'Email is already registered'});
                res.render('register', {
                    errors,
                    name,
                    email,
                    password,
                    password2
                });
            } else {

                var mailOptions = {
                    from: 'EPIDASH 🤙',
                    to: email,
                    subject: 'Confirmation d\'inscription - EPIDASH',
                    html: '<h1>Welcome ' + name + '</h1><p>Bienvenue sur Epidash, votre service de dashboard personalisé en ligne.</p>'
                  }

                transporter.sendMail(mailOptions, function(error, info){
                    if (error) {
                      console.log(error);
                    } else {
                      console.log('Email sent: ' + info.response);
                    }
                  });

                const newUser = new User({
                    name,
                    email,
                    password
                });

                //Hash Password
                bcrypt.genSalt(10, (err, salt) =>
                bcrypt.hash(newUser.password, salt, (err, hash) => {
                    if (err) throw err;
                    newUser.password = hash;

                    //Saving DB
                    newUser.save()
                    .then(user => {res.redirect('/users/login')
                    })
                    .catch(err => {console.log(err)});
                }))
            }
        })
    }
});

//Login Handle
router.post('/login', (req, res, next) => {
    passport.authenticate('local', {
        successRedirect: '/dashboard',
        failureRedirect: '/users/login',
    })(req, res, next)
})

router.get('/logout', (req, res) => {
    req.logout();
    res.redirect('/users/login');
})

module.exports = router;