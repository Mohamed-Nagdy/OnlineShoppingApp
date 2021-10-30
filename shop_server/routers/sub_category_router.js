const subCategoryRouter = require("express").Router();
const Category = require("../schemas/category_schema");
const SubCategory = require("../schemas/sub_category_schema");

subCategoryRouter.get("/api/v1/subCategory", async (req, res) => {
  try {
    const subCategories = await SubCategory.find({});
    res.json(subCategories);
  } catch (e) {
    res.json({ Error: e.toString() });
  }
});

subCategoryRouter.get("/api/v1/subCategory/:id", async (req, res) => {
  try {
    const subCategory = await SubCategory.findById(req.params.id);
    res.json(subCategory);
  } catch (e) {
    res.json({ Error: e.toString() });
  }
});


// get all sub categories with main category id
subCategoryRouter.get("/api/v1/subCategory/category/:id", async (req, res) => {
  try {
    const subCategory = await SubCategory.find({category: req.params.id});
    res.json(subCategory);
  } catch (e) {
    res.json({ Error: e.toString() });
  }
});

// create new sub category
subCategoryRouter.post("/api/v1/subCategory", async (req, res) => {
  try {
    const subCategory = SubCategory(req.body);
    const newCat = await subCategory.save();

    const category = await Category.findById(req.body.category);
    category.categories.push(subCategory._id);
    await category.save();

    res.json(newCat);
  } catch (e) {
    res.json({ Error: e.toString() });
  }
});

// update sub category
subCategoryRouter.patch("/api/v1/subCategory/:id", async (req, res) => {
  try {
    const subCategory = await SubCategory.findByIdAndUpdate(
      req.params.id,
      req.body
    );
    res.json(subCategory);
  } catch (e) {
    res.json({ Error: e.toString() });
  }
});

// delete the sub category
subCategoryRouter.delete("/api/v1/subCategory/:id", async (req, res) => {
  try {
    const subCategory = await SubCategory.findByIdAndDelete(req.params.id);
    res.json(subCategory);
  } catch (e) {
    res.json({ Error: e.toString() });
  }
});

module.exports = subCategoryRouter;
