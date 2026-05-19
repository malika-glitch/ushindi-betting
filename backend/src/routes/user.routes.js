const express = require('express');
const router = express.Router();

router.get('/profile', (req, res) => {
  res.json({ message: 'Get profile - to be implemented' });
});

router.put('/profile', (req, res) => {
  res.json({ message: 'Update profile - to be implemented' });
});

router.get('/kyc-status', (req, res) => {
  res.json({ message: 'Get KYC status - to be implemented' });
});

router.post('/kyc-verify', (req, res) => {
  res.json({ message: 'Submit KYC - to be implemented' });
});

module.exports = router;
