-- ==============================================================
-- The Deadlock Fix: Sorting resources before locking them.
-- INSTRUCTIONS: Open two database connections (Session A and Session B).
-- Alphabetical order: 'Leonard' always comes before 'Sheldon'.
-- ==============================================================

-- [SESSION A] Transfer: Sheldon -> Leonard
-- Application sorts names: 'Leonard', 'Sheldon'
BEGIN;
SELECT balance FROM accounts WHERE name = 'Leonard' FOR UPDATE;

-- [SESSION B] Transfer: Leonard -> Sheldon
-- Application sorts names: 'Leonard', 'Sheldon'
BEGIN;
SELECT balance FROM accounts WHERE name = 'Leonard' FOR UPDATE;
-- SESSION B hangs (waiting in line)

-- [SESSION A] Locks the second resource
SELECT balance FROM accounts WHERE name = 'Sheldon' FOR UPDATE;
-- Success. Session A holds both locks.

-- [SESSION A] Update both and commit
UPDATE accounts SET balance = balance + 100 WHERE name = 'Leonard';
UPDATE accounts SET balance = balance - 100 WHERE name = 'Sheldon';
COMMIT;

-- [SESSION B] Wakes up
-- Instantly gets the lock on Leonard.
-- Now it locks the second resource
SELECT balance FROM accounts WHERE name = 'Sheldon' FOR UPDATE;

-- [SESSION B] Update both and commit
UPDATE accounts SET balance = balance - 50 WHERE name = 'Leonard';
UPDATE accounts SET balance = balance + 50 WHERE name = 'Sheldon';
COMMIT;

-- NO DEADLOCKS. Perfect execution.
-- Check Balances
SELECT balance FROM accounts WHERE name = 'Leonard';
SELECT balance FROM accounts WHERE name = 'Sheldon';