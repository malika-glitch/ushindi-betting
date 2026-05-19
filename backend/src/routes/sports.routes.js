const express = require('express');
const router = express.Router();

router.get('/events', (req, res) => {
  res.json({ message: 'Get sports events - to be implemented' });
});

router.get('/events/:id', (req, res) => {
  res.json({ message: 'Get event details - to be implemented' });
});

router.get('/odds', (req, res) => {
  res.json({ message: 'Get live odds - to be implemented' });
});

router.get('/sports-list', (req, res) => {
  res.json({
    sports: ['Football', 'Basketball', 'Tennis', 'Cricket', 'Boxing', 'Volleyball']
  });
});

module.exports = router;
