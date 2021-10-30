const express = require("express");
const app = express();
const mongoose = require("mongoose");
var cors = require("cors");
const userRouter = require("./routers/users_router");
const productsRouter = require('./routers/product_router')
const categoriesRouter = require('./routers/category_router')
const subCategoriesRouter = require('./routers/sub_category_router')
const contactUsRouter = require('./routers/contact_us_router');
const port = process.env.PORT || 3600;

require('dotenv').config()
app.use(cors());

mongoose.connect(
    "mmongodb+srv://mohamednagdy:mohamednagdy@cluster0.1crwk.mongodb.net/open_source_shop_db?retryWrites=true&w=majority", {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        useFindAndModify: false,
        useCreateIndex: true,
    },
    (err) => {
        if (err) {
            console.log("There Is An Error");
            console.log(err);
        } else {
            console.log("Success To Connect");
        }
    }
);

app.get('/:image', (req, res) => {
    let name = req.params.image;
    res.status(200).sendFile(
        __dirname + '/images/' + name
    )
})


app.use(express.json({ limit: '50mb' }));
app.use(userRouter);
app.use(productsRouter);
app.use(categoriesRouter);
app.use(subCategoriesRouter);
app.use(contactUsRouter);


app.get('/', (req, res) => {
    res.send('hi')
})

app.listen(port, () => {
    console.log("Listen On Port ", port);
});