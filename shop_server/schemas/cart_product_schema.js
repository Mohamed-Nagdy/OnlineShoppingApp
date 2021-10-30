const mongoose = require("mongoose");

const cartProductSchema = mongoose.Schema(
  {
    product: {
        type: mongoose.Types.ObjectId,
        ref: "Product",
    },
    count: {
        type: Number,
        required: true,
        default: 1,
    },
    price: {
        type: Number,
        required: true,
        default: 0.0,
    },
  },
  {
    toJSON: {
      transform: function (doc, ret) {
        delete ret.__v;
      },
    },
    timestamps: true,
  }
);

const CartProduct = mongoose.model("CartProduct", cartProductSchema);

module.exports = CartProduct;
