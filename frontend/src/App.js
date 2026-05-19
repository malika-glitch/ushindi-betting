import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>🏆 Ushindi Betting Platform</h1>
        <p>Sports Betting & Casino Games</p>
      </header>
      
      <main className="App-main">
        <section className="hero">
          <h2>Welcome to Ushindi Betting</h2>
          <p>Your ultimate sports betting and casino gaming platform in Kenya</p>
        </section>

        <section className="features">
          <div className="feature-card">
            <h3>⚽ Sports Betting</h3>
            <p>Bet on football, basketball, tennis, cricket and more with live odds</p>
          </div>
          <div className="feature-card">
            <h3>🎰 Casino Games</h3>
            <p>Play slots, roulette, blackjack and dice games</p>
          </div>
          <div className="feature-card">
            <h3>💰 Secure Transactions</h3>
            <p>Safe deposits and withdrawals via M-Pesa and Stripe</p>
          </div>
          <div className="feature-card">
            <h3>🎁 Amazing Bonuses</h3>
            <p>Welcome bonuses, referral rewards and cashback offers</p>
          </div>
        </section>

        <section className="cta">
          <button className="btn-primary">Sign Up Now</button>
          <button className="btn-secondary">Login</button>
        </section>
      </main>

      <footer className="App-footer">
        <p>© 2024 Ushindi Betting. All rights reserved.</p>
        <p>Play responsibly. Must be 18+</p>
      </footer>
    </div>
  );
}

export default App;
