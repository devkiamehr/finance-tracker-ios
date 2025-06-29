import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    budget: { type: Number, default: 0 }
}, { 
    timestamps: true // This adds createdAt and updatedAt automatically
});

const User = mongoose.model('User', userSchema);

export default User;
export const UserSchema = userSchema;
