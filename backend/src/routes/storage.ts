import express from 'express';
import multer from 'multer';
import fs from 'fs';
import Profile from '@/models/profile';

const storage = multer.diskStorage({
	destination: function (req, file, cb) {
		cb(null, "./uploads/avatars");
	},
	filename: function (req, file, cb) {
        const fileName = `${req.user.user_id}.jpg`;
        console.log(`Uploading...`, fileName);

		cb(null,fileName);
	},
});

const upload = multer({ storage });

const storageRoute = express.Router();

storageRoute.post('/', upload.single('file'), async (req, res, next) => {
    // req.file is the `avatar` file
    // req.body will hold the text fields, if there were any
    // console.log(req.file);

    await Profile.updateOne({ user: req.user.user_id }, { imageUrl: `/avatars/${req.file.filename}` })
    .catch(err => console.log(err));

    return res.json({
        success: true,
        message: "File uploaded successfully"
    });
});


// /storage/avatars/:id
storageRoute.get('/avatars/:user_id', (req, res) => {
    try{
    const fileStream = fs.createReadStream(
		`./uploads/avatars/${req.params.user_id}`
	);
    return fileStream.pipe(res);
    }catch(err){
        return res.status(404);
    }
});


export default storageRoute;