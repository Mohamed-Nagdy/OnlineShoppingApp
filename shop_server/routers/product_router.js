const productRouter = require('express').Router()
const Product = require('../schemas/product_schema')
const decodeBase64Image = require('../middleware/saveImage')

productRouter.get('/api/v1/products', async(req, res) => {
    try {
        const products = await Product.find({})
        res.json(products)
    } catch (e) {
        res.json({ 'Error': e.toString() })
    }
})

productRouter.get('/api/v1/products/category/:id', async(req, res) => {
    try {
        const products = await Product.find({ category: req.params.id })
        res.json(products)
    } catch (error) {
        res.status(400).json(error.toString())
    }
})

productRouter.get('/api/v1/products/:id', async(req, res) => {
    try {
        const product = await Product.findOne({ _id: req.params.id })
        res.json(product)
    } catch (e) {
        res.json({ 'Error': e.toString() })
    }
})


productRouter.patch('/api/v1/products/:id', async(req, res) => {
    try {
        // if image is not updated we just update data only
        if (req.body.image === '') {
            const myOne = await Product.findByIdAndUpdate(req.params.id, {
                name: req.body.name,
                description: req.body.description,
                price: req.body.price,
                category: req.body.category,
                optionOne: req.body.optionOne,
                optionTwo: req.body.optionTwo,
            })
            const pro = await myOne.save()
            res.json(pro)
        } else {
            const response = await decodeBase64Image(req.body.image);
            const myOne = await Product.findByIdAndUpdate(req.params.id, {
                name: req.body.name,
                description: req.body.description,
                image: response.name,
                price: req.body.price,
                category: req.body.category,
                optionOne: req.body.optionOne,
                optionTwo: req.body.optionTwo,
            })
            const pro = await myOne.save()
            res.json(pro)
        }
    } catch (e) {
        res.json({ 'Error': e.toString() })
    }
})



productRouter.post('/api/v1/products', async(req, res) => {
    try {
        const response = await decodeBase64Image(req.body.image);
        const myOne = Product({
            name: req.body.name,
            description: req.body.description,
            image: response.name,
            price: req.body.price,
            category: req.body.category,
            optionOne: req.body.optionOne,
            optionTwo: req.body.optionTwo,
        })
        const pro = await myOne.save()
        res.json(pro)
    } catch (e) {
        res.json({ 'Error': e.toString() })
    }
})

productRouter.delete('/api/v1/products/:id', async(req, res) => {
    try {
        const myOne = await Product.findByIdAndRemove(req.params.id)
        res.json(myOne)
    } catch (e) {
        res.json({ 'Error': e.toString() })
    }
})

productRouter.post('/api/v1/products/search', async(req, res) => {
    try {
        searchString = req.body.searchString
        const products = await Product.find({ $text: { $search: searchString } });
        res.json(products)
    } catch (error) {
        res.status(400).json(error.toString())
    }
})

module.exports = productRouter