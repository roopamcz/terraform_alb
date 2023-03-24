const express = require('express');
const app = express();

app.get('/', (request, response) => {
  response.send("Hello World!");
})

const PORT = process.env.PORT || 3000;

app.listen(PORT, function() {
  console.log(`Example app listening at http://localhost:${PORT}`);
})