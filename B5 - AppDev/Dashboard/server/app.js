const express = require('express');
const app = express();

// Routes
app.use('/', require('./routes/index'));

const PORT = 8080;

app.listen(PORT, console.log(`Server started on port ${PORT}`));
