import express from 'express';
import User from '../models/User';

const deleteAccountController = async (req: express.Request, res: express.Response) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).json({ message: "All fields are required" });
        }

        const user = await User.deleteOne({ email: email });

        if (!user) {
            return res.status(401).json({ message: "Invalid email."});
        }

        res.status(201).json({ message: "Account deleted. "});
    } catch (error) {
        console.error('Error in delete account:', error);
        return res.status(500).json({ error: 'Failed to delete account' });
    }
}

export default deleteAccountController;