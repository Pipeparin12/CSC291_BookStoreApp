import mongoose  from "mongoose"
import { ObjectId, Types } from "mongoose"


export const bookSchema = new mongoose.Schema({
    bookId:{
        type: Types.ObjectId,
        require: true
    },
    bookName:{
        type: String, 
        require: true,
    },
    bookDescription:{
        type: String,
        require: true,
    },
    bookPrice:{
        type: Number,
        require: true,
    },
    bookAmount:{
        type: Number,
        require: true
    },
    bookImage:{
        type: String,
        require: true
    }
})

export default mongoose.model('Book',bookSchema);