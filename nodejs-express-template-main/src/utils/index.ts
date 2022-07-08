import jwt from "jsonwebtoken";
import config from "@/config";

export function getcookie(req) {
	var cookie = req.headers.cookie;
	return cookie.split("; ");
}

export function generateJwtToken(_id, email: string) {
	const payload = {
		user_id: _id,
		email,
	};
	const token = jwt.sign(payload, config.JWT_SECRET, {
		algorithm: "HS256",
		expiresIn: "7d",
	});

	return token;
}
