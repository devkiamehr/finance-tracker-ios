import express from 'express';
import dotenv from 'dotenv';
import signupRouter from './routes/signup';
import mongoose from 'mongoose';
import loginRouter from './routes/login';
import deleteAccountRouter from './routes/deleteAccount'
import budgetHandler from './routes/budgetHandler';

dotenv.config();

const PORT = process.env.PORT || 3000;

const MONGOURI = process.env.MONGO_URI;

if (!MONGOURI) {
    throw new Error('MONGO_URI is not defined');
}

mongoose
    .connect(MONGOURI)
    .then((res) => console.log('Connected to MongoDB'))
    .catch((err) => console.log(err));

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/api/signup', signupRouter);
app.use('/api/login', loginRouter);
app.use('/api/delete', deleteAccountRouter)
app.use('/api/budget', budgetHandler);

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});