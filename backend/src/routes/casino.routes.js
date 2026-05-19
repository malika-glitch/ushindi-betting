const express = require('express');
const router = express.Router();

router.get('/games', (req, res) => {
  res.json({ message: 'Get casino games - to be implemented' });
});

router.post('/play', (req, res) => {
  res.json({ message: 'Start game session - to be implemented' });
});

router.post('/play/:sessionId/spin', (req, res) => {
  res.json({ message: 'Execute game action - to be implemented' });
});

router.get('/results/:sessionId', (req, res) => {
  res.json({ message: 'Get game results - to be implemented' });
});

module.exports = router;
