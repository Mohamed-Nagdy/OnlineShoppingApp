const mongoose = require("mongoose");

const cartSchema = mongoose.Schema(
  {
    itemsCount: {
        type: Number,
        required: true,
    },
    totalPrice: {
        type: Number,
        required: true,
    },
    items: [{
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
      }],
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

const CartSchema = mongoose.model("Cart", cartSchema);

module.exports = CartSchema;
