// server/server.js
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();
const port = 8000;
var cp = require('child_process');

app.use(bodyParser.json());
app.use(cors());
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.send(`Hi! Server is listening on port ${port}`)
});

app.post('/create-product', (req, res) => {
    cp.exec("npm run build", function (err, stdout, stderr) {
        if (err) {
            console.log(err);
            // handle error
        }
        console.log(stdout, stderr);
        res.send(`Created ${port}`)
    });
    // process.exit(1);
});


// listen on the port
app.listen(port);