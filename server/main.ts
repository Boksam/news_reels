import Express from "express";

const app = Express();

app.get("/", (req, res) => {
  res.send("Hi mom");
});

app.listen(3000, () => {
  console.log("Listening on port 3000");
});
