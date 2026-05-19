const express = require('express');
const router = express.Router();

router.post('/place', (req, res) => {
  res.json({ message: 'Place bet - to be implemented' });
});

router.get('/my-bets', (req, res) => {
  res.json({ message: 'Get my bets - to be implemented' });
});

router.get('/:id', (req, res) => {
  res.json({ message: 'Get bet details - to be implemented' });
});

router.post('/:id/cancel', (req, res) => {
  res.json({ message: 'Cancel bet - to be implemented' });
});

module.exports = router;
