const mongoose = require("mongoose");
const validator = require("validator");
const jwt = require("jsonwebtoken");
const constants = require("../constants");
const bcrypt = require("bcrypt");

const userSchema = mongoose.Schema({
    userName: {
        type: String,
        required: true,
        minlength: 6,
        maxlength: 50,
    },
    email: {
        type: String,
        required: true,
        unique: true,
        validate(value) {
            if (!validator.isEmail(value.replace(' ', '').trim())) {
                throw new Error("Email Is Not Correct ");
            }
        },
    },
    password: {
        type: String,
        required: true,
        minlength: 8,
        maxlength: 50,
    },
    phone: {
        type: String,
        required: true,
    },
    address: {
        type: String,
        required: true,
    },

    lastMessageDate: {
        type: String,
        default: Date.now,
    },

    lastMessage: {
        type: String,
    },

    userMessages: {
        isNewMessage: {
            type: Boolean,

        },
        messages: [{
            sender: {
                type: String,
                required: true,
            },
            message: {
                type: String,
                required: true,
            },
        }],
    },


    // list of the user favourites products
    favProducts: [{
        type: mongoose.Types.ObjectId,
        ref: 'Product',
    }],
    // the porducts will be in the user cart before order it
    cartProducts: [{
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
        option1: {
            type: String,
            required: true,
        },
        option2: {
            type: String,
            required: true,
        },
    }],
    //  all orders of user after submit it
    orders: [{
        itemsCount: {
            type: Number,
            required: true,
        },
        totalPrice: {
            type: Number,
            required: true,
        },
        phone: {
            type: String,
            required: true,
        },
        name: {
            type: String,
            required: true,
        },
        address: {
            type: String,
            required: true,
        },
        deliverPrice: {
            type: Number,
            required: true,
        },
        // will be one of four states [ in row , processing , canceled , waiting ]
        status: {
            type: String,
            required: true,
            default: 'in row',
        },

        createdAt: {
            type: Date,
            default: Date.now,
        },

        // list of the order items 
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
            option1: {
                type: String,
                required: true,
            },
            option2: {
                type: String,
                required: true,
            },
        }],
    }],

    // the user jwt
    jwt: {
        type: String,
    },
}, {
    toJSON: {
        transform: function(doc, ret) {
            delete ret.__v;
            delete ret.password;
        },
    },
});

// return user after insert email and password
userSchema.statics.findByCredintals = async(email, password) => {

    const user = await User.findOne({ email: email.replace(' ', '').trim() }, { "favProducts": 0, "cartProducts": 0, "orders": 0 });

    if (!user) {
        throw new Error("Email Not Correct");
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
        throw new Error("Password is Not Correct");
    }

    return user;
};

// generate the user jwt when we need
userSchema.methods.generateAuthToken = async function() {
    const user = this;
    const token = jwt.sign({ id: user._id.toString() }, constants.secret);
    return token;
};

// before saving the user we encrypt it's password and save it
userSchema.pre("save", async function(next) {
    user = this;
    if (user.isModified("password")) {
        user.password = await bcrypt.hash(user.password, 8);
    }
    if (user.isModified("email")) {
        user.email = user.email.replace(' ', '').trim();
    }
    next();
});

const User = mongoose.model("User", userSchema);

module.exports = User;