const umongoose = require('mongoose')
const uSchema = umongoose.Schema

const userSchema = new uSchema({
    email:{
        type: String, 
        require: true,
    },
    password:{
        type: String,
        require: true,
    }
})



module.exports = umongoose.model('User',userSchema)