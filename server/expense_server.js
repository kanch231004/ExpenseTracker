const jsonServer = require('json-server');
const cors = require('cors');

const server = jsonServer.create();
const router = jsonServer.router('expense_db.json');
const middlewares = jsonServer.defaults();

// Enable CORS for all routes
server.use(cors({
  origin: '*',
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));

server.use(middlewares);

// Custom middleware for logging
server.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
});

// Use /api prefix for all routes
server.use('/api', router);

// Start server
const PORT = 3000;
server.listen(PORT, '0.0.0.0', () => {
  console.log('🚀 Expense Tracker API Server Started!');
  console.log(`📡 Server running at: http://localhost:${PORT}`);
  console.log(`📊 Expenses API: http://localhost:${PORT}/api/expenses`);
  console.log('📝 Available endpoints:');
  console.log('   GET    /api/expenses     - Get all expenses');
  console.log('   POST   /api/expenses     - Add new expense');
  console.log('   PUT    /api/expenses/:id - Update expense');
  console.log('   DELETE /api/expenses/:id - Delete expense');
  console.log('\n💡 To stop server: Ctrl+C');
});