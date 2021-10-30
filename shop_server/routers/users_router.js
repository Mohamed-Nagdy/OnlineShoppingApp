const userRouter = require("express").Router();
const User = require("../schemas/user_schema");
const auth = require("../middleware/user_auth");

//////////////////////////////////////////////////////////////////////////////////////////////////////
/////////                                                                                   //////////
/////////                                 User Routes                                       //////////
/////////                                                                                   //////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

// login user
userRouter.post("/api/v1/users/login", async(req, res) => {
    try {
        const email = req.body.email.replace(' ', '').trim()
        const user = await User.findByCredintals(email.replace(' ', '').trim(), req.body.password);
        user.jwt = await user.generateAuthToken();
        if (!user) {
            res.status(400).json({ error: "Not Logged In" });
        }
        res.json(user);
    } catch (e) {
        res.status(400).json({ Error: e.toString() });
    }
});

// sign up new user
userRouter.post("/api/v1/users/signup", async(req, res) => {
    try {
        const user = new User(req.body);

        user.jwt = await user.generateAuthToken();
        const userr = await user.save();
        if (!userr) {
            res.status(400).json({ error: "Not Created" });
        }
        res.json(userr);
    } catch (e) {
        console.log(e);
        res.status(400).json({ Error: e });
    }
});

// edit user data
userRouter.patch("/api/v1/users/editUser", auth.auth, async(req, res) => {
    try {
        req.user.userName = req.body.userName;
        req.user.userEmail = req.body.email;
        req.user.phone = req.body.phone;
        req.user.password = req.body.password;
        req.user.deliverAddress = req.body.deliverAddress;
        req.user.address = req.body.address;

        const myUser = await req.user.save();
        res.json(myUser);
    } catch (e) {
        res.status(400).json({ error: e.toString() });
    }
});

//////////////////////////////////////////////////////////////////////////////////////////////////////
/////////                                                                                   //////////
/////////                                 Favourites Routes                                 //////////
/////////                                                                                   //////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

// get the specific user favourites
userRouter.post("/api/v1/users/getFav", auth.auth, async(req, res) => {
    try {
        // console.log(req.user.populate("favProducts"));
        const myUser = await User.findById({ _id: req.user._id }).populate(
            "favProducts"
        );
        // console.log(myUser.favProducts);
        res.json(myUser.favProducts);
    } catch (e) {
        res.status(400).json({ error: e.toString() });
    }
});

// add new favourite to a user
userRouter.post("/api/v1/users/addFav", auth.auth, async(req, res) => {
    try {
        var newfav = req.user.favProducts; // .push(mongoose.Types.ObjectId( req.body.id.toString() ));
        if (newfav.includes(req.body.id)) {
            res.json({ success: "OK" });
        } else {
            newfav.push(req.body.id);
            User.findByIdAndUpdate(
                req.user._id, {
                    favProducts: newfav,
                },
                function(err, affected, resp) {
                    if (err) {
                        res.status(400).json({ error: err });
                    } else {
                        res.json({ success: "OK" });
                    }
                }
            );
        }
    } catch (e) {
        res.status(400).json({ error: e.toString() });
    }
});

// remove item from user favourites
userRouter.post("/api/v1/users/removeFav", auth.auth, async(req, res) => {
    try {
        var newfav = req.user.favProducts;
        if (!newfav.includes(req.body.id)) {
            res.json({ success: "OK" });
        } else {
            newfav.pop(req.body.id);
            User.findByIdAndUpdate(
                req.user._id, {
                    favProducts: newfav,
                },
                function(err, affected, resp) {
                    if (err) {
                        res.status(400).json({ error: err });
                    } else {
                        res.json({ success: "OK" });
                    }
                }
            );
        }
    } catch (e) {
        res.status(400).json({ error: e.toString() });
    }
});

//////////////////////////////////////////////////////////////////////////////////////////////////////
/////////                                                                                   //////////
/////////                                 Cart Routes                                       //////////
/////////                                                                                   //////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

userRouter.post("/api/v1/addCart", auth.auth, async(req, res) => {
    try {
        var newCart = req.user.cartProducts; // .push(mongoose.Types.ObjectId( req.body.id.toString() ));
        newCart.push(req.body.item);
        User.findByIdAndUpdate(
            req.user._id, {
                cartProducts: newCart,
            },
            function(err, affected, resp) {
                if (err) {
                    res.status(400).json({ error: err });
                } else {
                    res.json({ success: "OK" });
                }
            }
        );
    } catch (e) {
        res.status(400).json({ error: e.toString() });
    }
});

userRouter.post("/api/v1/getCart", auth.auth, async(req, res) => {
    try {
        // console.log(req.user.populate("favProducts"));
        const myUser = await User.findById({ _id: req.user._id }).populate(
            "cartProducts.product"
        );
        res.json(myUser.cartProducts);
    } catch (e) {
        res.status(400).json({ error: e.toString() });
    }
});

userRouter.post("/api/v1/removeCartItem", auth.auth, async(req, res) => {
    try {
        var newCart = req.user.cartProducts;
        newCart.forEach(item => {
            if (item._id == req.body.id) {
                newCart.pop(item)

            }
        });
        User.findByIdAndUpdate(
            req.user._id, {
                cartProducts: newCart,
            },
            function(err, affected, resp) {
                if (err) {
                    res.status(400).json({ error: err });
                } else {
                    res.json({ success: "OK" });
                }
            }
        );
    } catch (e) {
        res.status(400).json({ error: e.toString() });
    }
});

userRouter.post("/api/v1/updateCount", auth.auth, async(req, res) => {
    try {
        var newCart = req.user.cartProducts;
        newCart.forEach(item => {
            if (item._id == req.body.id) {
                item.count = req.body.count
                item.price = req.body.price
            }
        });
        User.findByIdAndUpdate(
            req.user._id, {
                cartProducts: newCart,
            },
            function(err, affected, resp) {
                if (err) {
                    res.status(400).json({ error: err });
                } else {
                    res.json({ success: "OK" });
                }
            }
        );
    } catch (e) {
        res.status(400).json({ error: e.toString() });
    }
});

//////////////////////////////////////////////////////////////////////////////////////////////////////
/////////                                                                                   //////////
/////////                                 Order Routes                                      //////////
/////////                                                                                   //////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

userRouter.post('/api/v1/getOrders', auth.auth, async(req, res) => {
    try {
        const user = await User.findById({ _id: req.user._id }, { items: 0 });
        res.json(user.orders)
    } catch (e) {
        res.json({ error: e.toString() })
    }
})

userRouter.post('/api/v1/submitOrder', auth.auth, async(req, res) => {
    try {
        var orders = req.user.orders
        var cartProducts = []
        var totalPrice = 0
        var totalCount = 0

        req.user.cartProducts.forEach((item) => {
            totalCount += item.count
            totalPrice += item.price
        })

        totalPrice += req.body.deliverPrice

        orders.push({
            itemsCount: totalCount,
            totalPrice: totalPrice,
            items: req.user.cartProducts,
            phone: req.body.phone,
            name: req.body.name,
            address: req.body.address,
            deliverPrice: req.body.deliverPrice,
        })
        User.findByIdAndUpdate(
            req.user._id, {
                orders,
                cartProducts,
            },
            function(err, affected, resp) {
                if (err) {
                    res.status(400).json({ error: err });
                } else {
                    res.json({ success: "OK" });
                }
            }
        );
    } catch (e) {
        res.json({ error: e.toString() })
    }
})

userRouter.post('/api/v1/getSingleOrder', auth.auth, async(req, res) => {
    try {
        const user = await User.findById({ _id: req.user._id }).populate(
            "orders.items.product"
        );
        user.orders.forEach((order) => {
            if (order._id == req.body.id) {
                res.json(order)
                return
            }
        })
        res.status(400).json({ error: 'No Order Found' })
    } catch (error) {
        res.status(400).json(error.toString())
    }
})

userRouter.post('/api/v1/updateOrderState', auth.auth, async(req, res) => {
    try {
        const user = await User.findById({ _id: req.user._id });
        var orders = user.orders
        orders.forEach((order) => {
            if (order._id == req.body.id) {
                order.status = req.body.status
            }

        })
        await User.findByIdAndUpdate(
            req.user._id, {
                orders,
            },
            function(err, affected, resp) {
                if (err) {
                    res.status(400).json({ error: err });
                } else {
                    res.json({ success: "OK" });
                }
            }
        );
    } catch (error) {
        res.status(400).json(error.toString())
    }
})


//////////////////////////////////////////////////////////////////////////////////////////////////////
/////////                                                                                   //////////
/////////                                 Order Routes Admin                                //////////
/////////                                                                                   //////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

userRouter.get('/api/v1/admin/orders', async(req, res) => {
    try {
        const orders = await User.find({}).select("_id , orders , userName , email , phone , address").populate('orders.items.product')
        res.json(orders)
    } catch (error) {
        res.status(400).json(error.toString())
    }
})

userRouter.post('/api/v1/admin/updateOrderState', async(req, res) => {
    try {
        var user = await User.findOne({ _id: req.body.userId })
        var orders = user.orders

        orders.forEach((order) => {
            if (order._id == req.body.orderId) {
                order.status = req.body.status
            }

        })
        User.findByIdAndUpdate(
            req.body.userId, {
                orders,
            },
            function(err, affected, resp) {
                if (err) {
                    res.status(400).json({ error: err });
                } else {
                    res.json({ success: "OK" });
                }
            }
        );
    } catch (error) {
        res.status(400).json(error.toString())
    }
})

//////////////////////////////////////////////////////////////////////////////////////////////////////
/////////                                                                                   //////////
/////////                                 Messages Routes                                   //////////
/////////                                                                                   //////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

userRouter.get('/api/v1/messages/:userId', async(req, res) => {
    try {
        const user = await User.findOne({ _id: req.params.userId })
        res.json(user.userMessages)
    } catch (e) {
        res.json({ 'Error': e.toString() })
    }
})

userRouter.post('/api/v1/messages/:userId', async(req, res) => {
    try {
        var user = await User.findById(req.params.userId)

        var userMessages = user.userMessages
        var messages = userMessages.messages
        var lastMessageDate = user.lastMessageDate
        var lastMessage = user.lastMessage

        messages.push({ 'sender': req.body.sender, 'message': req.body.message, })

        userMessages.messages = messages

        lastMessageDate = Date.now().toString()
        lastMessage = req.body.message

        userMessages.isNewMessage = req.body.isNewMessage
        await User.findByIdAndUpdate(req.params.userId, { userMessages, lastMessageDate, lastMessage })
        res.json({ "success": "Ok" })
    } catch (error) {
        console.log(error);
        res.json({ 'Error': error.toString() })
    }
})

userRouter.get('/api/v1/messages', async(req, res) => {
    try {
        const messages = await User.find({}).select('_id , userName , lastMessage , userMessages ').sort({ lastMessageDate: -1 })
        const sentMessages = Array()
        messages.forEach((mm) => {
            if (mm.userMessages.messages.length != 0) {
                sentMessages.push({ _id: mm._id, userName: mm.userName, lastMessage: mm.lastMessage, isNewMessage: mm.userMessages.isNewMessage })
            }
        })
        res.json(sentMessages)
    } catch (e) {
        res.json({ 'Error': e.toString() })
    }
})

userRouter.delete('/api/v1/messages/:userId', async(req, res) => {
    try {
        const user = await User.findById(req.params.userId)
        const userMessages = user.userMessages
        userMessages.messages = []
        await User.findByIdAndUpdate(req.params.userId, { userMessages })
        res.json({ success: "OK" })
    } catch (error) {
        res.json({ 'Error': error.toString() })
    }
})

module.exports = userRouter;