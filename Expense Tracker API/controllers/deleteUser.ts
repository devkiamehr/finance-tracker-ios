import express from 'express';
import User from '../models/Users';

const deleteAccountController = async (req: express.Request, res: express.Response) => {
    const { email, password } = req.body;

    if (!email || !password) {
        throw new Error("All fields are required");
    }

    const user = await User.deleteOne({ email: email });

    if (!user) {
        return res.status(401).json({ message: "Invalid email."});
    }

    res.status(201).json({ message: "Account deleted. "});
}

export default deleteAccountController;