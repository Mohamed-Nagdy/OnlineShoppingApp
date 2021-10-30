const mongoose = require("mongoose");

const categorySchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    image: {
        type: String,
        required: true,
    },
    // categories: [
    //     {
    //         type: mongoose.Types.ObjectId,
    //         ref: 'SubCategory',
    //     }
    // ]
}, {
    toJSON: {
        transform: function(doc, ret) {
            delete ret.__v;
        },
    },
});

const Category = mongoose.model("Category", categorySchema);

module.exports = Category;