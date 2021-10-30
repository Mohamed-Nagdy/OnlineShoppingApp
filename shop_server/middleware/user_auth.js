const jsonwebtoken = require('jsonwebtoken')
const User = require('../schemas/user_schema')
const constants = require('../constants')
const userAuth = {
    auth: async (req, res, next)=>{
        try{
            // const token = req.body.jwt
            const decoded = jsonwebtoken.verify(req.body.jwt, constants.secret)
            const user = await User.findOne({_id: decoded.id})
            if(!user){
                res.status(400).json({"error": 'Cant Do Any Thing Check JWT'})
            }
            req.user = user
            next()
        }catch(e){
            res.status(400).json({"error": e.toString()})
        }
    }
}

module.exports = userAuth