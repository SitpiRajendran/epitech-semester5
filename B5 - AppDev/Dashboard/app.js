const cors = require('cors');
// const Twitter = require('twitter');
const express = require('express');
const session = require('express-session');
const mongoose = require('mongoose');
const passport = require('passport');
const cookieParser = require('cookie-parser');
const expressLayouts = require('express-ejs-layouts');

const app = express();

//Passport config
require('./config/passport')(passport);

//DB Config
const db = require('./config/keys').MongoURI;


//Connect to Mongo
mongoose.connect(db, { useNewUrlParser : true, useUnifiedTopology: true })
.then(() => console.log('MongoDB connected'))
.catch(() => console.log('MongoDB ERROR'));


//EJS
app.set('views', './views')
app.set('view engine', 'ejs');

// Bodyparser
app.use(express.urlencoded({ extended: false}));
app.use(express.static('public'))

app.use('/css', express.static(__dirname + 'public/css'))
app.use('/img', express.static(__dirname + 'public/img'))
app.use('/js', express.static(__dirname + 'public/js'))
app.use('/doc', express.static(__dirname + 'public/Documentations'))
app.use('/models', express.static(__dirname + 'models'))

// app.use(cors())
app.use(cors({origin: 'http://localhost:80', credentials: true}));

// Express session
app.use(cookieParser())
app.use(session({secret: 'MySecret'}));

//Passport
app.use(passport.initialize());
app.use(passport.session());


// Routes
app.use('/', require('./routes/index'));
app.use('/users', require('./routes/users'));

const PORT = 80;

app.listen(PORT, console.log(`Server started on port ${PORT}`));
