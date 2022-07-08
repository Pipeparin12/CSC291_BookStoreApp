import express from "express";
import Bookmark, { bookmarkSchema } from '../models/bookmark';
import Book, { bookSchema } from '../models/book';
import { User } from "@/database/models";
const bookmarkRoute = express.Router();

bookmarkRoute.post('/add-bookmark/:id', async (req,res) => {
    const user_id = req.user.user_id;
    
    try {
        const book_id = req.params.id;
        await Bookmark.create({
            'owner': user_id,
            'books': {"bookId":book_id}
        });        
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

bookmarkRoute.get('/get-bookmark', async (req,res) => {
    try {
        const user = await req.user.user_id;       
        const bookmark = await Bookmark.find({ 'owner': user}).exec();
        const book = await Book.find({_id: {$in: bookmark.map((e) => e.books[0]['bookId'])}}).exec();
        console.log(book);
        return res.json({
            book,
            success: true,
            message: 'Get bookmark successfully!'
        });
    } catch (err) {
        return res.json({
            success: false,
            message: err
        });
    }
})

export default bookmarkRoute;