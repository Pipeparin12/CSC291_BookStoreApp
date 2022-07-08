import mongoose, { Mongoose }  from "mongoose"
import { ObjectId, Types } from "mongoose"

export const cartSchema = new mongoose.Schema({
    owner: {
        type: Types.ObjectId,
        required: true,
        ref: 'User'
    },
    bookId: {
        type: Types.ObjectId,
        ref: 'Book'
    },
    bookName:{
        type: String, 
    },
    amountInCart: {
        type: Number,
        required: true,
        min: 1
    },
},{
    timestamps: true
})

export default mongoose.model('Cart',cartSchema);