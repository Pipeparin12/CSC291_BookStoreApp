const bmongoose = require('mongoose')
const bSchema = bmongoose.Schema

const bookSchema = new bSchema({
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