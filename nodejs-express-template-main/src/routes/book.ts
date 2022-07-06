import express from "express";
const book = require('../models/book')
const bookRoute = express.Router();

bookRoute.post('/addBook', (req,res)=> {
    if (book == null) {
        res.json({message:'Please enter book information'})
    } else {
        book({
            bookName: req.body.bookName,
            bookDescription: req.body.bookDescription,
            bookPrice: req.body.bookPrice,
            bookAmount: req.body.bookAmount,
            bookImage: req.body.bookImage
        })
        book.save().then((err) =>{
            if (err) {
                console.log(err)
                res.json(err)
            } else {
                console.log(book)
                res.json(book)
            }
        })
    }
})
export default bookRoute;