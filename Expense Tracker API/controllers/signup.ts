import express from 'express';
import User from '../models/Users';

const signupController = async (req: express.Request, res: express.Response) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: 'Email and password are required' });
    }

    const userCheck = await User.findOne({ email });

    if (userCheck) {
        return res.status(401).json({ message: "User already exists "});
    }

    const user = await User.create({ email, password });

    res.status(201).json({
        message: 'User created successfully',
        user,
    });
};

export default signupController;