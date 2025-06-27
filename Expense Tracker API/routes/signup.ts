import express from 'express';
import signupController from '../controllers/signup';

const router = express.Router();

router.post('/', async (req, res) => {
    await signupController(req, res);
});

export default router;