import express from 'express';
import User from '../models/User';

const signupController = async (req: express.Request, res: express.Response) => {
    try {    
        const { name, email, password, budget } = req.body;

        if (!name || !email || !password) {
            return res.status(400).json({ message: 'Name, email, and password are required' });
        }

        const userCheck = await User.findOne({ email });

        if (userCheck) {
            return res.status(401).json({ message: "User already exists "});
        }

        const user = await User.create({ name, email, password, budget });

        return res.status(201).json({
            message: 'User created successfully',
            user,
        });
    } catch(error) {
        console.error(error)
    }
};

export default signupController;