import express from "express";
import Book, { bookSchema } from '../models/book';
const bookRoute = express.Router();

bookRoute.post('/add', async (req,res)=> {
    const book = new Book(req.body);
    console.log(book)
    try {
        const savedBook = await book.save()
            //Send it back to flutter
            return res.json({
                success: true,
                message: 'Create book product success'
            })
            
    } catch (err) {
        return res.json({
            success: false,
            message: err
        })
    }
})
export default bookRoute;