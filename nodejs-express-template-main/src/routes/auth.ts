import express from "express";
// eslint-disable-next-line new-cap
import User, { userSchema } from '../models/user';
import jwt from 'jsonwebtoken';
// const User = require('../models/user')

const book = require('../models/book')
const authRoute = express.Router();

import AppConfig from '@/config';

authRoute.post('/signup', async (req,res)=>{
    try{
        // Find one user!
        let newUser = await User.findOne({email:req.body.email});

        // Check if user exists? If it doesn't...
        if(newUser == null){
            // Create new user
            newUser = new User({
                    email:req.body.email,
                    password:req.body.password
                });
            // Save into a database.
            await newUser.save();

            // Send it back to flutter
            return res.json({
                success: true,
                message:'Signed up successfully!'
            });
        }

        // Otherwise, do this...
        return res.json({
            success: false,
            message:'email is not available'
        });

    }catch(err){
        // In case there's an error..
        return res.json({
            success: false,
            message: err
        });
    }
    
    // User.findOne({email:req.body.email},(err,user)=>{
    //     if(err){
    //         console.log(err)
    //         res.json(err)
    //     }else{
    //         if(user==null){
    //             user = new User({
    //                 email:req.body.email,
    //                 password:req.body.password
    //             })
    //             user.save()
    //             .then((err)=>{
    //                 if(err){
    //                     console.log(err)
    //                     res.json(err)
    //                 }else{
    //                     console.log(user)
    //                     res.json(user)
    //                 }
                    
    //             })
    //         }else{

    //         res.json({
    //             message:'email is not avilable'
    //         })   
    //         }
    //     }
    // })
    
})

authRoute.post('/signin',async (req,res)=>{
    try{
        const user = await User.findOne({email:req.body.email,password:req.body.password});

        if(user){
            // TODO: ...
            delete user["password"];

            return res.json({
                success: true,
                message: "Logged In successfully!",
                token: jwt.sign({ user_id: user._id, email: user.email }, AppConfig.JWT_SECRET)
            });
        }

        return res.json({
            success: false,
            message: "Authentication error!"
        });

    }catch(err){
        return res.json({
            success: false,
            message: err
        });
    }
})

authRoute.post('/add-book', (req,res)=> {
        var newBook = new book({
            bookName: req.body.bookName,
            bookDescription: req.body.bookDescription,
            bookPrice: req.body.bookPrice,
            bookAmount: req.body.bookAmount,
            bookImage: req.body.bookImage
        })
        newBook.save()
        res.json(newBook)
})

// Service Book Restful API
// TOKEN   ->   sdfsdfkxclvokxlcvklsdkflsdkflsdklfksdlf
//C   POST  /book   body -> { name: 'sirawit', count: 2 }
// C  POST  /book/add-favourite/:id   ->   
//R   GET   /book
//F   GET  /book/:id   /book/1   /book/d121er12dfer12
//U   PATCH /book/:id      body -> { name: 'sirawit', count: 2 }
//D   DELETE /book/:id   



authRoute.get("/", (req, res) => {
	// return res.send(`Auth route ${nanoid(64)}`);
	return res.json(req.user);
});

export default authRoute;
