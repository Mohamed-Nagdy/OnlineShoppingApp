const categoryRouter = require("express").Router();
const Category = require("../schemas/category_schema");
const decodeBase64Image = require('../middleware/saveImage')


categoryRouter.get("/api/v1/category", async(req, res) => {
    try {
        const categories = await Category.find({});
        res.json(categories);
    } catch (e) {
        res.json({ Error: e.toString() });
    }
});

categoryRouter.get("/api/v1/category/:id", async(req, res) => {
    try {
        const category = await Category.findById(req.params.id);
        res.json(category);
    } catch (e) {
        res.json({ Error: e.toString() });
    }
});

categoryRouter.post("/api/v1/category", async(req, res) => {
    try {

        const response = await decodeBase64Image(req.body.image)


        const category = Category({
            name: req.body.name,
            image: response.name,
        });
        const newCat = await category.save();
        res.json(newCat);
    } catch (e) {
        res.json({ Error: e.toString() });
    }
});

categoryRouter.patch("/api/v1/category/:id", async(req, res) => {
    try {

        if (req.body.image === '') {
            const category = await Category.findByIdAndUpdate(req.params.id, {
                name: req.body.name,
            });
            res.json(category);
        } else {
            const response = await decodeBase64Image(req.body.image)
            const category = await Category.findByIdAndUpdate(req.params.id, {
                name: req.body.name,
                image: response.name,
            });
            res.json(category);
        }

    } catch (e) {
        res.json({ Error: e.toString() });
    }
});

categoryRouter.delete("/api/v1/category/:id", async(req, res) => {
    try {
        const category = await Category.findByIdAndDelete(req.params.id);
        res.json(category);
    } catch (e) {
        res.json({ Error: e.toString() });
    }
});

module.exports = categoryRouter;