-- ==============================================================
-- INSTRUCTIONS: Open two database connections.
-- We will simulate a circular dependency.
-- ==============================================================

-- [SESSION A] Start transfer: Sheldon -> Leonard
BEGIN;
SELECT balance FROM accounts WHERE name = 'Sheldon' FOR UPDATE;

-- [SESSION B] Start transfer: Leonard -> Sheldon
BEGIN;
SELECT balance FROM accounts WHERE name = 'Leonard' FOR UPDATE;

-- [SESSION A] Try to lock Leonard to complete the transfer
SELECT balance FROM accounts WHERE name = 'Leonard' FOR UPDATE;
-- SESSION A Hangs (Waiting on Session B)

-- [SESSION B] Try to lock Sheldon to complete the transfer
SELECT balance FROM accounts WHERE name = 'Sheldon' FOR UPDATE;
-- SESSION B hangs (Waiting on Session A)

-- WAIT 1 SECOND...
-- Watch Session B crash with: "ERROR: deadlock detected"
-- Session B is rolled back automatically. Session A wakes up and can proceed.

-- [SESSION A] Clean up
COMMIT;
-- [SESSION B] Clean up
ROLLBACK;