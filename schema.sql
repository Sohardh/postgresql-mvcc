-- ==============================================================
-- Sets up the Bank Transfer schema and demonstrates MVCC hidden columns
-- ==============================================================

DROP TABLE IF EXISTS accounts CASCADE;

CREATE TABLE accounts
(
    id      BIGSERIAL PRIMARY KEY,
    name    TEXT           NOT NULL,
    balance DECIMAL(10, 2) NOT NULL
);

INSERT INTO accounts (name, balance)
VALUES ('Sheldon', 1000.00),
       ('Leonard', 1000.00);

-- 1. View the hidden MVCC columns
-- xmin is the transaction that created the row.
-- xmax is the transaction that deleted/updated it (0 means it's alive).
SELECT xmin, xmax, *
FROM accounts;

-- 2. Let's do a simple update and see how xmin/xmax change
UPDATE accounts
SET balance = 900.00
WHERE name = 'Sheldon';

-- 3. View the columns again.
-- Notice Sheldon's xmin has changed
SELECT xmin, xmax, *
FROM accounts;

-- Reset
UPDATE accounts
SET balance = 1000.00
WHERE name = 'Sheldon';