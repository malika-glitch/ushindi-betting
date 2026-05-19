const jwt = require('jsonwebtoken');

const generateToken = (userId, email, role = 'user') => {
  return jwt.sign(
    { userId, email, role },
    process.env.JWT_SECRET || 'your_secret_key',
    { expiresIn: process.env.JWT_EXPIRE || '7d' }
  );
};

const verifyToken = (token) => {
  try {
    return jwt.verify(token, process.env.JWT_SECRET || 'your_secret_key');
  } catch (err) {
    throw new Error('Invalid or expired token');
  }
};

const decodeToken = (token) => {
  return jwt.decode(token);
};

module.exports = {
  generateToken,
  verifyToken,
  decodeToken
};
