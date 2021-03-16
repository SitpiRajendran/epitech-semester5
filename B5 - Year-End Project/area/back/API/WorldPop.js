var axios = require("axios");

function printNumber(nbr) {
    var resp = ""

    for (var i = 0; i < String(nbr).length; i ++) {
        if ((String(nbr).length - i) % 3 == 0 && i != 0)
            resp += " "
        resp += String(nbr)[i]
    }
    return resp
}

class WorldPop {
    getWorld() {
        var options = {
            method: 'GET',
            url: 'https://world-population.p.rapidapi.com/worldpopulation',
            headers: {
              'x-rapidapi-key': '994d015a26mshaa8d62e1ffffdedp1958f3jsn712e242ce36d',
              'x-rapidapi-host': 'world-population.p.rapidapi.com'
            }
        };

        var parserep = axios.request(options).then(function (response) {
            return {'world_population': response.data.body.world_population, 'total_countries': response.data.body.total_countries}
        }).catch({});

        return parserep;
    }

    getByCountry(country) {
        var options = {
            method: 'GET',
            url: 'https://world-population.p.rapidapi.com/population',
            params: {country_name: country},
            headers: {
                'x-rapidapi-key': '994d015a26mshaa8d62e1ffffdedp1958f3jsn712e242ce36d',
                'x-rapidapi-host': 'world-population.p.rapidapi.com'
            }
        };

        var parserep = axios.request(options).then(function (response) {
            return {
                "ranking:": response.data.body.ranking,
                "world_share:": response.data.body.world_share,
                "country_name:": response.data.body.country_name,
                "Population:": response.data.body.population,
            }
        }).catch({});

        return parserep;
    }
}

new WorldPop().getWorld().then(function(data) {console.log(data);});
new WorldPop().getByCountry('China').then(function(data) {console.log(data);});