// const bmongoose = require('mongoose')
import mongoose from 'mongoose'
// const bSchema = bmongoose.Schema

const bookSchema = new mongoose.Schema({
    bookName:{
        type: String, 
        require: true,
    },
    bookDescription:{
        type: String,
        require: true,
    },
    bookPrice:{
        type: Number,
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

module.exports = mongoose.model('Book', bookSchema)