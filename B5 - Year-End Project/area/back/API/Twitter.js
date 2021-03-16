var apiKey = "hOgRkgheN1MIARcx7R5rAidGM"
var secretKey = "96mB4w6321MmuRdWDGKTYXzk7o2yczE2BocRNpXZTJ2z7LLgup"

var accessToken = "754748945142865920-UG6QN2xSVTQWjA2MA2zX3GSwybjIcXC"
var accessSecretToken = "PNJKspT8QNp3PZeoCtWcZoUaYOL0ngf8kY9R0FKqa1Xmi"


const fetch = require("node-fetch");

var bearerToken = "Bearer AAAAAAAAAAAAAAAAAAAAALKJMAEAAAAAhA6Q%2B1mFiXFCU35679ATvwVehT4%3DoVVYb99CxlURTpsriX6GxG66tCZitKjSvgFAkvJTas4gFDqtOb"

function request(method_used, link, params) {
    fetch(link + params, {
        method: method_used,
        headers: {'Authorization': bearerToken, 'Content-Type': 'application/json'}
    }).then(res => res.json()).then(json => console.log(json)).catch(err => console.log(err))
}

class Twitter {
    getSearchTwitter(text) {
        var link = "https://api.twitter.com/2/tweets/search/recent";

        console.log(link);
        request('GET', link, "?query=" + text)
    }
}

var twitter = new Twitter()
twitter.getSearchTwitter("from:Epitech")