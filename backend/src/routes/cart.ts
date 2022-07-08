import express from "express";
import Cart, { cartSchema } from '../models/cart';
import Book, { bookSchema } from '../models/book';
import { User } from "@/database/models";
const cartRoute = express.Router();

cartRoute.post('/add-cart/:id', async (req,res) => {
    const amount = req.body.amountInCart;
    const user_id = req.user.user_id;
    
    
    try {
        const book_id = req.params.id;
        const name = req.body.bookName;
        await Cart.create({
            'owner': user_id,
            'books': {"bookId":book_id, "amountInCart":amount, "bookName":name}
        });        
        return res.json({
            success: true,
            message: 'Create cart success'
        })
    } catch (err) {
        return res.json({
            success: false,
            message: err
        })
    }
})

cartRoute.get('/get-cart', async (req,res) => {
    try {
        const user = await req.user.user_id; 
        const name = await req.body.bookName;
        const amount = await req.body.amountInCart;     
        const cart = await Cart.find({ 'owner': user}).exec();
        const book = await Book.find({_id: {$in: cart.map((e) => e.books[0]['bookId'])}}).exec();
        console.log(book);
        return res.json({
            cart,
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

export default cartRoute;