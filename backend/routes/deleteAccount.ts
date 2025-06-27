import express from "express";
import deleteAccountController from '../controllers/deleteUser';

const router = express.Router();

router.delete('', async (req, res) => {
    await deleteAccountController(req, res);
});

export default router