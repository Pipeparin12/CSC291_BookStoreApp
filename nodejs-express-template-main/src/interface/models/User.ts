import { UserType } from "@/database/models/schema";

export default interface User {
	email: string;
	password: string;
	address: string;
	tel: string;
	type: UserType;
}
