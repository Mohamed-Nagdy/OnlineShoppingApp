const mongoose = require("mongoose");

const subCategorySchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  image: {
    type: String,
    required: true,
  },
  category: {
      type: mongoose.Types.ObjectId,
      ref: 'Category',
  }
}, {
  toJSON: {
    transform: function (doc, ret) {
      delete ret.__v;
    },
  },
});

const SubCategory = mongoose.model("SubCategory", subCategorySchema);

module.exports = SubCategory;
