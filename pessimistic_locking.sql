-- ==============================================================
-- INSTRUCTIONS: Open two database connections (Session A and Session B).
-- Run these commands step-by-step to see the lock queue in action.
-- ==============================================================

-- [SESSION A] Start transaction and lock Sheldon's row
BEGIN;
SELECT balance FROM accounts WHERE name = 'Sheldon' FOR UPDATE;
-- Result: 1000.00. Session A now holds a RowExclusiveLock.

-- [SESSION B] Try to lock Sheldon's row
BEGIN;
SELECT balance FROM accounts WHERE name = 'Sheldon' FOR UPDATE;
-- SESSION B will hang here.

-- [SESSION A] Do the math (1000 - 100 = 900), update, and commit
UPDATE accounts SET balance = 900.00 WHERE name = 'Sheldon';
COMMIT;

-- [SESSION B] Wakes up Instantly!
-- It now returns the *new* committed value: 900.00.
-- Do the math (900 - 50 = 850), update, and commit
UPDATE accounts SET balance = 850.00 WHERE name = 'Sheldon';
COMMIT;

-- [EITHER SESSION] Check the final balance
SELECT * FROM accounts WHERE name = 'Sheldon';
-- The balance is 850.00. Perfect accounting.

-- Reset
UPDATE accounts SET balance = 1000.00 WHERE name = 'Sheldon';