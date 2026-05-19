const express = require('express');
const router = express.Router();

router.get('/balance', (req, res) => {
  res.json({ message: 'Get wallet balance - to be implemented' });
});

router.post('/deposit', (req, res) => {
  res.json({ message: 'Make deposit - to be implemented' });
});

router.post('/withdraw', (req, res) => {
  res.json({ message: 'Request withdrawal - to be implemented' });
});

router.get('/transactions', (req, res) => {
  res.json({ message: 'Get transaction history - to be implemented' });
});

module.exports = router;
