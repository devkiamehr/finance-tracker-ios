import express from 'express';
import User from '../models/User';

const budgetGetter = async (req: express.Request, res: express.Response) => {
    try {
        const user = await User.findOne({ email: "example@gmail.com" });
        return res.send(String(user?.budget));
    } catch (error) {
        console.error('Error getting budget:', error);
        return res.status(500).json({ error: 'Failed to get budget' });
    }
};

const budgetPoster = async (req: express.Request, res: express.Response) => {
    try {
        const { amount } = req.body;
        const user = await User.findOne({ email: "example@gmail.com" });

        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        user.budget -= amount;
        await user.save();

        return res.send(String(user.budget));
    } catch (error) {
        console.error('Error updating budget:', error);
        return res.status(500).json({ error: 'Failed to update budget' });
    }
};

export { budgetGetter, budgetPoster };