import express from "express";
import Cart, { cartSchema } from '../models/cart';
import Book, { bookSchema } from '../models/book';
import { User } from "@/database/models";
const cartRoute = express.Router();

cartRoute.post('/add/:id', async (req,res) => {
    const amount = req.body.amountInCart;
    const user_id = req.user.user_id;
    
    try {
        const book_id = req.params.id;
        await Cart.create({
            'owner': user_id,
            'books': {"bookId":book_id, "amountInCart":amount}
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

export default cartRoute;