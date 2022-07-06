const bmongoose = require('mongoose')
import { ObjectId, Types } from "mongoose"
const bSchema = bmongoose.Schema

const bookSchema = new bSchema({
    bookId:{
        type: Types.ObjectId,
        require: true
    },
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

module.exports = bmongoose.model('Book', bookSchema)