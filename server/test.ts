import express from 'express';
import cors from 'cors';

const app = express();
const PORT = 5001;

app.use(cors({
  origin: 'http://192.168.2.114:8081'
}));
app.use(express.json());

app.post('/api/auth/register', (req, res) => {
  console.log('Received registration request:', req.body);
  res.json({ message: 'Test registration successful' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Test server running on port ${PORT}`);
}); 