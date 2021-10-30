const mongoose = require("mongoose");

const productSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    description: {
        type: String,
    },
    image: {
        type: String,
        required: true,
    },
    price: {
        type: Number,
        required: true,
    },
    category: {
        type: mongoose.Types.ObjectId,
    },
    optionOne: {
        title: String,
        options: [{
            type: String,
        }],
    },
    optionTwo: {
        title: String,
        options: [{
            type: String,
        }],
    },
}, {
    toJSON: {
        transform: function(doc, ret) {
            delete ret.__v;
        },
    },
});

productSchema.index({ '$**': 'text' });

const Product = mongoose.model("Product", productSchema);

module.exports = Product;