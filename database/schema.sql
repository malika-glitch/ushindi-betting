-- Ushindi Betting Platform Database Schema

CREATE DATABASE IF NOT EXISTS ushindi_betting;
USE ushindi_betting;

-- Users Table
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  phone VARCHAR(20),
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  date_of_birth DATE,
  national_id VARCHAR(50) UNIQUE,
  kyc_status ENUM('pending', 'verified', 'rejected') DEFAULT 'pending',
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX (email),
  INDEX (username)
);

-- User Wallets
CREATE TABLE wallets (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL UNIQUE,
  balance DECIMAL(15, 2) DEFAULT 0,
  bonus_balance DECIMAL(15, 2) DEFAULT 0,
  total_wagered DECIMAL(15, 2) DEFAULT 0,
  total_winnings DECIMAL(15, 2) DEFAULT 0,
  currency VARCHAR(3) DEFAULT 'KES',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Transactions
CREATE TABLE transactions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  wallet_id INT NOT NULL,
  type ENUM('deposit', 'withdrawal', 'bet', 'winning', 'bonus', 'refund') NOT NULL,
  amount DECIMAL(15, 2) NOT NULL,
  balance_before DECIMAL(15, 2),
  balance_after DECIMAL(15, 2),
  payment_method VARCHAR(50),
  status ENUM('pending', 'completed', 'failed', 'cancelled') DEFAULT 'pending',
  description TEXT,
  reference_number VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (wallet_id) REFERENCES wallets(id),
  INDEX (user_id),
  INDEX (created_at)
);

-- Sports Events
CREATE TABLE sports_events (
  id INT PRIMARY KEY AUTO_INCREMENT,
  sport VARCHAR(50) NOT NULL,
  league VARCHAR(100),
  home_team VARCHAR(100),
  away_team VARCHAR(100),
  event_date DATETIME,
  status ENUM('scheduled', 'live', 'completed', 'cancelled') DEFAULT 'scheduled',
  home_odds DECIMAL(5, 2),
  draw_odds DECIMAL(5, 2),
  away_odds DECIMAL(5, 2),
  total_odds DECIMAL(5, 2),
  over_under_odds DECIMAL(5, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX (event_date),
  INDEX (status)
);

-- Single Bets
CREATE TABLE single_bets (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  event_id INT NOT NULL,
  bet_type VARCHAR(50),
  stake DECIMAL(15, 2) NOT NULL,
  odds DECIMAL(5, 2) NOT NULL,
  potential_winning DECIMAL(15, 2),
  status ENUM('pending', 'won', 'lost', 'cancelled', 'voided') DEFAULT 'pending',
  result_prediction VARCHAR(50),
  actual_result VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (event_id) REFERENCES sports_events(id),
  INDEX (user_id),
  INDEX (status)
);

-- Parlay Bets (Multi-event bets)
CREATE TABLE parlay_bets (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  stake DECIMAL(15, 2) NOT NULL,
  total_odds DECIMAL(10, 4) NOT NULL,
  potential_winning DECIMAL(15, 2),
  status ENUM('pending', 'won', 'lost', 'cancelled', 'partial') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  INDEX (user_id),
  INDEX (status)
);

-- Parlay Legs (Individual bets in a parlay)
CREATE TABLE parlay_legs (
  id INT PRIMARY KEY AUTO_INCREMENT,
  parlay_id INT NOT NULL,
  event_id INT NOT NULL,
  bet_type VARCHAR(50),
  odds DECIMAL(5, 2),
  status ENUM('pending', 'won', 'lost', 'voided') DEFAULT 'pending',
  FOREIGN KEY (parlay_id) REFERENCES parlay_bets(id) ON DELETE CASCADE,
  FOREIGN KEY (event_id) REFERENCES sports_events(id)
);

-- Casino Games
CREATE TABLE casino_games (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  type ENUM('slots', 'roulette', 'blackjack', 'dice', 'poker') NOT NULL,
  min_bet DECIMAL(10, 2),
  max_bet DECIMAL(10, 2),
  rtp DECIMAL(5, 2),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Casino Game Sessions
CREATE TABLE game_sessions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  game_id INT NOT NULL,
  initial_balance DECIMAL(15, 2),
  current_balance DECIMAL(15, 2),
  status ENUM('active', 'completed', 'cancelled') DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  completed_at TIMESTAMP NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (game_id) REFERENCES casino_games(id),
  INDEX (user_id)
);

-- Game Rounds
CREATE TABLE game_rounds (
  id INT PRIMARY KEY AUTO_INCREMENT,
  session_id INT NOT NULL,
  round_number INT,
  bet_amount DECIMAL(15, 2),
  winnings DECIMAL(15, 2),
  multiplier DECIMAL(5, 2),
  game_data JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (session_id) REFERENCES game_sessions(id) ON DELETE CASCADE,
  INDEX (session_id)
);

-- Promotions
CREATE TABLE promotions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  promotion_type ENUM('welcome_bonus', 'deposit_match', 'cashback', 'free_bet', 'referral') NOT NULL,
  bonus_amount DECIMAL(15, 2),
  bonus_percentage INT,
  min_deposit DECIMAL(15, 2),
  max_bonus DECIMAL(15, 2),
  wagering_requirement INT DEFAULT 5,
  start_date DATE,
  end_date DATE,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User Promotions
CREATE TABLE user_promotions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  promotion_id INT NOT NULL,
  bonus_amount DECIMAL(15, 2),
  wagered_amount DECIMAL(15, 2) DEFAULT 0,
  status ENUM('active', 'completed', 'expired', 'cancelled') DEFAULT 'active',
  claimed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (promotion_id) REFERENCES promotions(id),
  INDEX (user_id)
);

-- Audit Logs
CREATE TABLE audit_logs (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  action VARCHAR(100),
  entity_type VARCHAR(50),
  entity_id INT,
  changes JSON,
  ip_address VARCHAR(45),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX (user_id),
  INDEX (created_at)
);

-- Insert Sample Casino Games
INSERT INTO casino_games (name, description, type, min_bet, max_bet, rtp) VALUES
('Lucky Sevens', 'Classic slots game with 3 reels', 'slots', 10, 10000, 96.5),
('Fruit Paradise', 'Colorful fruit-themed slots', 'slots', 10, 10000, 95.8),
('European Roulette', '37-pocket roulette wheel', 'roulette', 10, 50000, 97.3),
('Blackjack Pro', 'Professional blackjack game', 'blackjack', 20, 20000, 99.5),
('Lucky Dice', 'Roll the dice to win', 'dice', 10, 50000, 97.0);
