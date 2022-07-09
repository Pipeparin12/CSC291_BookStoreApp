import express from "express";
import multer from "multer";
import Book, { bookSchema } from '../models/book';
const bookRoute = express.Router();

const storage = multer.diskStorage({
	destination: function (req, file, cb) {
		cb(null, "./uploads/books");
	},
	filename: function (req, file, cb) {
        const fileName = `${(req as any).bookId}.jpg`;
        console.log(`Uploading...`, fileName);
		cb(null,fileName);
	},
});

const upload = multer({ storage });


async function createBook(req, res, next){
    const user_id = req.user.user_id;
    try {
        const newBook = await Book.create({
            'owner': user_id,
            'bookName': "",
            'bookDescription': "",
            'bookAmount': 0,
            'bookImage': "",
        });
        req.bookId = newBook._id;
        next();
    } catch (err) {
        return res.json({
            success: false,
            message: err
        })
    }
};

bookRoute.post('/add', createBook , upload.single('file'), async (req,res) => {
    const book_name = req.body.bookName;
	const book_des = req.body.bookDescription;
	const book_amount = req.body.bookAmount;
	const book_image = req.body.bookImage;
	const user_id = req.user.user_id;
    const bookId = (req as any).bookId;

    const newBook = await Book.updateOne(
		{ owner: user_id, _id: bookId },
		{
			bookName: book_name,
			bookDescription: book_des,
			bookAmount: book_amount,
			bookImage: `/books/${bookId}.jpg`,
		}
	);

    return res.json({
        success: true,
        message: "Already added book!",
        newBook
    })
});

bookRoute.get('/all-book', async (req, res) => {
    try{
        const book = await Book.find();
        console.log(book)
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

bookRoute.get("/user/yourbook",async (req,res) => {
    try {
        console.log('1');
        const user_id = req.user.user_id;
        console.log(user_id);
        
            const book = await Book.find({owner: user_id}).exec();
            console.log(book);
            return res.json({
                book,
                success: true,
                message: 'Get your book successfully'
            })
        } catch (err) {
            return res.json({
                success: false,
                message: err
            })
        }
})

bookRoute.get('/search/:key',async (req, res) => {
    try {
        let result = await Book.find({
            "$or": [{
                bookName: {$regex: req.params.key}
            }]
        })
        res.send(result);
    } catch (err) {
        return res.json({
            success: false,
            message: err
        })
    }
})
export default bookRoute;