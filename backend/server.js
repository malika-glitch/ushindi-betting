const app = require('./src/app');
const db = require('./src/config/database');

const PORT = process.env.PORT || 5000;

// Test database connection
db.getConnection((err, connection) => {
  if (err) {
    console.error('Database connection failed:', err);
    process.exit(1);
  }
  connection.release();
  console.log('✓ Database connected successfully');
});

app.listen(PORT, () => {
  console.log(`🚀 Ushindi Betting Server running on http://localhost:${PORT}`);
  console.log(`📊 API Documentation: http://localhost:${PORT}/api-docs`);
});
