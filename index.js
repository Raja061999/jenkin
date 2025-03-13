const express = require("express");
const app = express();

app.get("/", (req, res) => {
    res.send("hello world , this is from raja and we are going to learn jenkin and it automated");
});

const PORT = 3003;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
