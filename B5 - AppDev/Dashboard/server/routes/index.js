const express = require('express');
const router = express.Router();

router.get('/', (req, res) => res.send('Il n\'y rien à voir ici !'));

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