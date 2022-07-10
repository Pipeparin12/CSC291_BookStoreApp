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
            'bookId': book_id
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
        const book = await Book.find({_id: {$in: bookmark.map((e) => e.bookId)}}).exec();

        let serializedBookmark = JSON.parse(JSON.stringify(bookmark));
        let serializedBook = JSON.parse(JSON.stringify(book));

        // console.log(JSON.stringify(book), JSON.stringify(bookmark))
        const bookmarks = serializedBookmark.map(bm => ({ ...bm, book: serializedBook.find(b => b._id === bm.bookId)}));
        return res.json({
            bookmarks,
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

bookmarkRoute.delete('/unbookmark/:id', async (req,res) => {
    try {
        const bookmark = await Bookmark.findByIdAndDelete(req.params.id);
        console.log(bookmark);
        return res.json({
            success: true,
            message: 'Delete bookmark successfully'
        })
    } catch (err) {
        return res.json({
            success: false,
            message: err
        })
    }
})

export default bookmarkRoute;