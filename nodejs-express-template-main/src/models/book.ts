// const bmongoose = require('mongoose')
import mongoose from 'mongoose'
// const bSchema = bmongoose.Schema

export const bookSchema = new mongoose.Schema({
    bookName:{
        type: String, 
        require: true,
    },
    bookDescription:{
        type: String,
        require: true,
    },
    bookAmount:{
        type: Number,
        require: true
    },
    bookImage:{
        type: String,
        require: true
    }
})

export default mongoose.model('Book', bookSchema)