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
bookRoute.get('/all-book', async (req, res) => {
    try{
        const book = await Book.find();
        return res.json({
            book,
            success: true,
            message: 'Get book successfully!'
        });
    }catch(err){
        return res.json({
            success: false,
            message: err
        });
    }
});

bookRoute.get('/:id', async (req, res) => {
    try{
        const book = await Book.findById(req.params.id);

        return res.json({
            book,
            success: true,
            message: 'Get detail successfully!'
        });
    }catch(err){
        return res.json({
            success: false,
            message: err
        });
    }
});

bookRoute.patch('/:id', async (req, res) => {
    const book = await Book.findById(req.params.id);
    if(!book) return res.json({message: "No Data Found"});
    try{
        const updateBook = await Book.updateOne({_id: req.params.id}, {$set: req.body});
        return res.json({
            updateBook,
            success: true,
            message: 'Update book successfully!'
        });
    }catch(err){
        return res.json({
            success: false,
            message: err
        });
    }
})

bookRoute.delete('/:id',async (req, res) => {
    const book = await Book.findById(req.params.id);
    if (!book) return res.json({message: "No Data Found"});
    try {
        const deletedBook = await Book.deleteOne({_id: req.params.id});
        return res.json({
            success: true,
            message: 'Delete book successfully'
        })
    } catch (err) {
        return res.json({
            success: false,
            message: err
        })
    }
})
export default bookRoute;