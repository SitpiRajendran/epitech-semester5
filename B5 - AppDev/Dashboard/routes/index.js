const express = require('express');
const passport = require('passport');
const router = express.Router();
const { ensureAuthenticated } = require('../config/auth');
const UWidget = require("../models/UserWidget")
const User = require("../models/User")


router.get('/', (req, res) => res.render('welcome'));

router.get('/google', passport.authenticate('google', { scope: ['profile', 'email'] }));
router.get('/google/callback', passport.authenticate('google', { successRedirect: '/dashboard', failureRedirect: '/users/register' }));

router.get('/twitter', passport.authenticate('twitter', { scope: ['profile', 'email'] }));
router.get('/twitter/callback', passport.authenticate('twitter', { successRedirect: '/dashboard', failureRedirect: '/users/register' }));

router.get('/github', passport.authenticate('github'));
router.get('/github/callback', passport.authenticate('github', { successRedirect: '/dashboard', failureRedirect: '/users/register' }));

router.get('/dashboard', ensureAuthenticated, function (req, res) {
    UWidget.find({ "username": req.user.name }, (err, resultArray) => {
        res.render('dashboard', {
            user: req.user,
            widgets: resultArray
        })
    })
});

router.get('/settings', ensureAuthenticated, function (req, res) {
    UWidget.find({ "username": req.user.name }, (err, resultArray) => {
        res.render('settings', {
            user: req.user,
            widgets: resultArray
        })
    })
});

router.get('/widgets', ensureAuthenticated, function (req, res) {
    UWidget.find({ "username": req.user.name }, (err, resultArray) => {
        res.render('widgets', {
            user: req.user,
            widgets: resultArray
        })
    })
});

router.get('/remove', ensureAuthenticated, function (req, res) {
    UWidget.deleteOne({ "widgetname": req.query.widgetname, username: req.user.name, "position": req.query.number }, function (err, result) {
        if (err) {
            console.err(err);
        } else {
            res.redirect('/settings')
        }
    })
})

router.get('/add', ensureAuthenticated, function (req, res) {
    const newWidget = new UWidget({
        "widgetname": req.query.widgetname,
        "username": req.user.name,
        "position": (req.user.widgetnumber + 1),
        "param1": "30000",
    });
    newWidget.save().catch(err => { console.log(err) });
    User.findOne({ email: req.user.email })
        .then(user => {
            if (user) {
                user.widgetnumber += 1;
                user.save()
                    .then(user => {
                        res.redirect('/edit?of=' + req.query.widgetname + '&number=' + (req.user.widgetnumber + 1))
                    })
                    .catch(err => { console.log(err) });
            }
        })
})

router.get('/edit', ensureAuthenticated, function (req, res) {
    UWidget.findOne({ "username": req.user.name, "widgetname": req.query.of, "position": req.query.number }, (err, widget) => {
        res.render('edit', {
            name: req.user.name,
            wname: req.query.of,
            position: req.query.number,
            widget: widget
        })
    })
})

router.get('/up', ensureAuthenticated, function (req, res) {
    var last = undefined;
    UWidget.find({ "username": req.user.name }, (err, ArrayWidget) => {
        ArrayWidget.sort(function (a, b) {
            return a.position - b.position;
        })
        ArrayWidget.forEach(function (widget) {
            if (widget.widgetname == req.query.of && widget.position == req.query.number) {
                if (last == undefined) {
                    res.redirect('settings')
                } else {
                    var temp1 = last.position
                    var temp2 = widget.position
                    UWidget.findOneAndUpdate({ "username": req.user.name, "widgetname": last.widgetname, "position": last.position }, { "position": temp2 }, (err, upwid) => {
                        UWidget.findOneAndUpdate({ "username": req.user.name, "widgetname": widget.widgetname, "position": widget.position }, { "position": temp1 }, (err, downwid) => {
                            res.redirect('settings')
                        }).catch(err => { console.log(err) });
                    }).catch(err => { console.log(err) });
                    return;
                }
            } else {
                last = widget;
            }
        })
    })
})

router.get('/down', ensureAuthenticated, function (req, res) {
    var old = undefined;
    UWidget.find({ "username": req.user.name }, (err, ArrayWidget) => {
        ArrayWidget.sort(function (a, b) {
            return a.position - b.position;
        })
        ArrayWidget.every(function (widget) {
            if (old == undefined) {
                console.log("first")
                old = widget;
                return true;
            } else if (old.widgetname == req.query.of && old.position == req.query.number) {
                console.log("I FOUND IT")
                console.log(old)
                var temp1 = old.position
                var temp2 = widget.position
                UWidget.findOneAndUpdate({ "username": req.user.name, "widgetname": old.widgetname, "position": old.position }, { "position": temp2 }, (err, upwid) => {
                    UWidget.findOneAndUpdate({ "username": req.user.name, "widgetname": widget.widgetname, "position": widget.position }, { "position": temp1 }).catch(err => { console.log(err) });
                }).catch(err => { console.log(err) });
                old = widget
                return false;
            } else {
                console.log("C'est pas ça")
                old = widget;
                return true;
            }
        })
    }).catch(err => { console.log(err) });
    res.redirect('settings')
})

router.post('/edit', ensureAuthenticated, function (req, res) {
    UWidget.findOneAndUpdate({ "username": req.user.name, "widgetname": req.query.of, "position": req.query.number }, { "param1": req.body.param1, "param2": req.body.param2, "param3": req.body.param3 }, (err, widget) => {
        res.redirect('settings')
    })
})

//About.json page
router.get('/about.json', (req, res) => {
    res.send({
        "customer": { "host": String(req.ip).split(":")[3] },
        "server": {
            "current_time": Math.floor(Date.now()),
            "services": [
                {
                    "name": "Bourses",
                    "widgets": [
                        {
                            "name": "Cours Boursier",
                            "description": "Montre le cours de l'action, jusqu'à 2 entreprises en même temps !",
                            "params": []
                        }, {
                            "name": "Cours Devise",
                            "description": "Montre la valeur d'une devise dans une autre (Ex: Euro en Dollars)",
                            "params": []
                        }
                    ]
                }, {
                    "name": "Cinéma",
                    "widgets": [
                        {
                            "name": "Movie Finder",
                            "description": "Affiche les informations sur un film",
                            "params": [
                                { "name": "Taux de rafraichissement", "type": "curseur" },
                                { "name": "Type (film ou série)", "type": "Scrolling list" },
                                { "name": "Description", "type": "checkboxe" },
                                { "name": "Release Date", "type": "checkboxe" },
                                { "name": "Client Rate", "type": "checkboxe" }
                            ]
                        }, {
                            "name": "Cinema List",
                            "description": "Affiche les la liste des films au cinéma en ce moment",
                            "params": [
                                { "name": "Taux de rafraichissement", "type": "curseur" },
                                { "name": "Comédie", "type": "checkboxe" },
                                { "name": "Drama", "type": "checkboxe" },
                                { "name": "Horror", "type": "checkboxe" },
                                { "name": "Thriller", "type": "checkboxe" }
                            ]
                        }
                    ]
                }, {
                    "name": "Epitech",
                    "widgets": [
                        {
                            "name": "Epitech Infos",
                            "description": "Affiche les informations de votre compte Epitech",
                            "params": [
                                { "name": "Taux de rafraichissement", "type": "curseur" },
                                { "name": "autologin", "type": "string" },
                                { "name": "mail Epitech", "type": "string" }
                            ]
                        }
                    ]
                }, {
                    "name": "Github",
                    "widgets": [
                        {
                            "name": "Github Account Infos",
                            "description": "Affiche les informations d'un compte Github",
                            "params": [
                                { "name": "Taux de rafraichissement", "type": "curseur" },
                                { "name": "Profile Recherché", "type": "string" }
                            ]
                        }
                    ]
                }, {
                    "name": "Google",
                    "widgets": [
                        {
                            "name": "Google News",
                            "description": "Affiche les News relative au sujet demandé",
                            "params": [
                                { "name": "Taux de rafraichissement", "type": "curseur" },
                                { "name": "Langue", "type": "Scrolling list" },
                                { "name": "Type de trie", "type": "Scrolling list" },
                            ]
                        }
                    ]
                }, {
                    "name": "Horloge",
                    "widgets": [
                        {
                            "name": "Horloge Numérique",
                            "description": "Display temperature for a city",
                            "params": [{ "name": "12 or 24h", "type": "scrolling menu" }]
                        }, {
                            "name": "Horloge Analogique",
                            "description": "Display temperature for two city",
                            "params": []
                        }
                    ]
                }, {
                    "name": "Medical",
                    "widgets": [
                        {
                            "name": "Sickness (Suivi du covid)",
                            "description": "Affiche le suivi des infecté, soigné et mort du Covid",
                            "params": [
                                { "name": "Taux de rafraichissement", "type": "curseur" },
                                { "name": "Pays", "type": "String" }
                            ]
                        }
                    ]
                }, {
                    "name": "Weather",
                    "widgets": [
                        {
                            "name": "Liveweather",
                            "description": "Display temperature for a city",
                            "params": [{ "name": "city", "type": "string" }]
                        }, {
                            "name": "doubleweather",
                            "description": "Display temperature for two city",
                            "params": [{ "name": "city", "type": "string" }]
                        }, {
                            "name": "weekweather",
                            "description": "Display temperature for a week",
                            "params": [{ "name": "city", "type": "string" }]
                        }
                    ]
                }, {
                    "name": "Server",
                    "widgets": [
                        {
                            "name": "Server Status",
                            "description": "Affiche le status d'un server",
                            "params": [
                                { "name": "Taux de rafraichissement", "type": "curseur" },
                                { "name": "lien", "type": "String" }
                            ]
                        }
                    ]
                }, {
                    "name": "Twitter",
                    "widgets": [
                        {
                            "name": "Twitter Account",
                            "description": "Affiche les informations de votre compte Twitter",
                            "params": [
                                { "name": "Taux de rafraichissement", "type": "curseur" }
                            ]
                        }
                    ]
                }
            ]
        }
    });
});

module.exports = router;