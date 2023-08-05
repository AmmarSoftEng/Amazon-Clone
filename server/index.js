const espress = require("express");
const mongoose = require("mongoose");
const authRout = require("./routes/auth");
const adminRout = require("./routes/admin");
const productRout = require("./routes/product");
const userRouter = require("./routes/user");

const PORT = process.env.PORT || 3000;
const app = espress();
const DB =
  "mongodb+srv://ammar:ammar@cluster0.altki0r.mongodb.net/?retryWrites=true&w=majority";

app.use(espress.json());
app.use(authRout);
app.use(adminRout);
app.use(productRout);
app.use(userRouter);

mongoose
  .connect(DB)
  .then(() => {
    console.log("connection Successful");
  })
  .catch((e) => {
    console.log(e);
    console.log("hello fuck you");
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`port connected at ${PORT}`);
});
