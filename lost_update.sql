-- ==============================================================
-- INSTRUCTIONS: Open two database connections (Session A and Session B).
-- Run these commands step-by-step in the exact order shown.
-- ==============================================================

-- [SESSION A] Start transaction and read balance
BEGIN;
SELECT balance FROM accounts WHERE name = 'Sheldon';
-- Result: 1000.00

-- [SESSION B] Start transaction and read balance at the exact same time
BEGIN;
SELECT balance FROM accounts WHERE name = 'Sheldon';
-- Result: 1000.00

-- [SESSION A] Process $100 purchase (1000 - 100) and commit
UPDATE accounts SET balance = 900.00 WHERE name = 'Sheldon';
COMMIT;

-- [SESSION B] Process $50 purchase (1000 - 50) and commit
UPDATE accounts SET balance = 950.00 WHERE name = 'Sheldon';
COMMIT;

-- [EITHER SESSION] Check the final balance
SELECT * FROM accounts WHERE name = 'Sheldon';
-- The balance is 950.00.
-- Session A's $100 deduction was completely overwritten (Lost Update)

-- Reset
UPDATE accounts SET balance = 1000.00 WHERE name = 'Sheldon';