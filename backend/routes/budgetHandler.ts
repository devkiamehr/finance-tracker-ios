import express from 'express';
import { budgetGetter, budgetPoster } from '../controllers/budgetHandler';

const router = express.Router();

router.get('/get', async (req, res) => {
    await budgetGetter(req, res);
})

router.patch('/patch', async (req, res) => {
    await budgetPoster(req, res);
})

export default router;