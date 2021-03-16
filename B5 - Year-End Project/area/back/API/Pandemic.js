const fetch = require('node-fetch')

function getFetch(link) {return fetch(link).then(function(response) {return response.status != 200 ? null : response.json();});}

function printNumber(nbr) {
    var resp = ""

    for (var i = 0; i < String(nbr).length; i ++) {
        if ((String(nbr).length - i) % 3 == 0 && i != 0)
            resp += " "
        resp += String(nbr)[i]
    }
    return resp
}

class Pandemic {
    getCovid(country = undefined) {
        var link = country == undefined ? "https://covid-api.com/api/reports/total" : "https://covid-api.com/api/reports?q=" + country;
        var resp = getFetch(link).then(function(data) {
            var deaths = 0
            var d_rate = 0.0
            var confirmed = 0
            var recovered = 0

            if (country == undefined) {
                return {"deaths": data.data.deaths, "confirmed": data.data.confirmed, "recovered": data.data.recovered, "fatality_rate": data.data.fatality_rate}
            } else {
                for (var i = 0; i < data.data.length; i ++) {
                    deaths += data.data[i].deaths;
                    confirmed += data.data[i].confirmed;
                    recovered += data.data[i].recovered;
                    d_rate += data.data[i].fatality_rate;
                }
                
                d_rate = d_rate / data.data.length;
                return {"deaths": deaths, "confirmed": confirmed, "recovered": recovered, "fatality_rate": d_rate}
            }
        })
        return resp
    }
}

new Pandemic().getCovid("France").then(function(data) {console.log(data);})
new Pandemic().getCovid().then(function(data) {console.log(data);})