import express from "express";
import Cart, { cartSchema } from '../models/cart';
import Book, { bookSchema } from '../models/book';
import { User } from "@/database/models";
import book from "../models/book";
const cartRoute = express.Router();

cartRoute.post('/add-cart/:id', async (req,res) => {
    const amount = req.body.amountInCart;
    const user_id = req.user.user_id;
    
    
    try {
        const book_id = req.params.id;
        const name = req.body.bookName;
        
        await Cart.create({
            'owner': user_id,
            "bookId":book_id, 
            "amountInCart":amount, 
            "bookName":name
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

cartRoute.patch('/checkout', async (req, res) => {
    const amount = req.body.amountInCart;
    const book_id = req.body.bookId;
    const thisBook = await Book.findById(book_id);

    try {
        const updatedAmount = await Book.updateOne({ _id : book_id }, { $set : { bookAmount : thisBook.bookAmount-amount }})
        return res.json({
            updatedAmount,
            success: true,
            message: 'Check out successfully!'
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
        const book = await Book.find({_id: {$in: cart.map((e) => e.bookId)}}).exec();

        let serializedCart = JSON.parse(JSON.stringify(cart));
        let serializedBook = JSON.parse(JSON.stringify(book));

        const carts = serializedCart.map(bm => ({ ...bm, book: serializedBook.find(b => b._id === bm.bookId)}));
        console.log(book);
        return res.json({
            carts,
            success: true,
            message: 'Get cart successfully!'
        });
    } catch (err) {
        return res.json({
            success: false,
            message: err
        });
    }
})

cartRoute.delete('/remove/:id', async (req,res) => {
    try {
        const cart = await Cart.findByIdAndDelete(req.params.id);
        return res.json({
            success: true,
            message: 'Delete cart successfully'
        })
    } catch (err) {
        return res.json({
            success: false,
            message: err
        })
    }
})

export default cartRoute;