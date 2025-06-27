import mongoose from 'mongoose';

// Define the expense subdocument schema
const expenseSchema = new mongoose.Schema({
    amount: { type: Number, required: true }, // How much was spent
    vendor: { type: String, required: true }, // Where the money was spent
    date: { type: Date, default: Date.now },
}, { 
    timestamps: true // This adds createdAt and updatedAt automatically
});

const userSchema = new mongoose.Schema({
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    monthlyBudget: { type: Number, default: 0 }, // Monthly budget limit
    expenses: [expenseSchema] // Array of expense subdocuments
});

const User = mongoose.model('User', userSchema);

export default User;
export const UserSchema = userSchema;
export const ExpenseSchema = expenseSchema;