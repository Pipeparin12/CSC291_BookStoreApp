// const umongoose = require('mongoose')
import mongoose from 'mongoose'
// const uSchema = umongoose.Schema

export const userSchema = new mongoose.Schema({
    email:{
        type: String, 
        require: true,
    },
    password:{
        type: String,
        require: true,
    }
})

export default mongoose.model('User',userSchema);