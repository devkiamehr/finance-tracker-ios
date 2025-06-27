import express from 'express';
import loginController from '../controllers/login';

const router = express.Router();

router.get('/', async (req, res) => {
    await loginController(req, res);
});


export default router;