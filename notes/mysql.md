# MYSQL

## Data Types

- **Numeric**:

  - **INT**, **TINYINT**, **SMALLINT**, **MEDIUMINT**, **BIGINT**
  - **FLOAT**, **DOUBLE**, **DECIMAL(m, d)**

- **String**:

  - **CHAR(n)**, **VARCHAR(n)**, **TEXT**, **BLOB**

- **Date and Time**:

  - **DATE**, **TIME**, **DATETIME**, **TIMESTAMP**, **YEAR**

- **JSON**:
  - **JSON**: Stores JSON formatted data.

### Differences Between CHAR(n), VARCHAR(n), TEXT, and BLOB

| **Data Type**  | **Storage**          | **Use Case**                                     |
| -------------- | -------------------- | ------------------------------------------------ |
| **CHAR(n)**    | Fixed size (n bytes) | Consistent-length strings (e.g., country codes). |
| **VARCHAR(n)** | Variable size        | Variable-length strings (e.g., names).           |
| **TEXT**       | Variable size        | Large text data (e.g., descriptions).            |
| **BLOB**       | Variable size        | Images, audio, or binary files.                  |

### JSON Support in MySQL

- **JSON**: Supported since **MySQL 5.7** (October 2015), allowing storage and manipulation of JSON data.

### DECIMAL

DECIMAL(m, d): Fixed-point number; m is total digits, d is digits after the decimal point.

## DDL (Data Definition Language)

- **CREATE**: Creates a new database or table.

  ```sql
  CREATE DATABASE database_name;

  CREATE TABLE table_name (
      column1 datatype,
      column2 datatype,
      ...
      columnn datatype
  );
  ```

- **ALTER**: Modifies an existing database or table.

  ```sql
  ALTER TABLE table_name ADD column_name datatype;  -- Add a column
  ALTER TABLE table_name DROP COLUMN column_name;   -- Drop a column
  ALTER TABLE table_name MODIFY column_name new_datatype;  -- Change datatype
  ```

- **DROP**: Deletes a database or table.

  ```sql
  DROP DATABASE database_name;
  DROP TABLE table_name;
  ```

- **TRUNCATE**: Deletes all records from a table but keeps the structure.
  ```sql
  TRUNCATE TABLE table_name;
  ```

## DML (Data Manipulation Language)

- **SELECT**: Retrieves data from tables.

  ```sql
  SELECT column1, column2 FROM table_name WHERE condition;
  ```

- **INSERT**: Adds new rows to a table.

  ```sql
  INSERT INTO table_name (column1, column2) VALUES (value1, value2);
  ```

- **UPDATE**: Modifies existing records.

  ```sql
  UPDATE table_name SET column1 = value1 WHERE condition;
  ```

- **DELETE**: Removes records from a table.
  ```sql
  DELETE FROM table_name WHERE condition;
  ```

## Data Control Language

```sql
  GRANT privileges_names ON object TO user;
```

- **GRANT**: Assigns specific privileges to users.

  ```sql
  GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'host';
  ```

- **REVOKE**: Removes specific privileges from users.

  ```sql
  REVOKE ALL PRIVILEGES ON database_name.* FROM 'username'@'host';
  ```

- **SHOW GRANTS**: Displays the privileges for a user.
  ```sql
  SHOW GRANTS FOR 'username'@'host';
  ```

#### Indexing

- **CREATE INDEX**: Creates an index on a table.

  ```sql
  CREATE INDEX index_name ON table_name (column_name);
  ```

- **DROP INDEX**: Deletes an index.
  ```sql
  DROP INDEX index_name ON table_name;
  ```

#### Backups with `mysqldump`

- **Basic usage**:

  ```bash
  mysqldump -u username -p database_name > backup.sql
  ```

- **Backing up multiple databases**:

  ```bash
  mysqldump -u username -p --databases db1 db2 > backup.sql
  ```

- **Restoring from a backup**:
  ```bash
  mysql -u username -p database_name < backup.sql
  ```

## Transaction Control

- **BEGIN**: Starts a transaction.

  ```sql
  START TRANSACTION;
  ```

- **COMMIT**: Saves changes made in the transaction.

  ```sql
  COMMIT;
  ```

- **ROLLBACK**: Reverts changes made during the transaction.
  ```sql
  ROLLBACK;
  ```

### Example: Simple Money Transfer

#### Step 1: Create the Tables

```sql
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    balance DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO accounts (account_id, balance) VALUES (1, 500.00);
INSERT INTO accounts (account_id, balance) VALUES (2, 300.00);
```

#### Step 2: Transaction for Money Transfer

Now, let’s perform a transaction to transfer money from account 1 to account 2.

```sql
-- Start the transaction
START TRANSACTION;

-- Variables for the transfer
SET @amount := 100.00;
SET @from_account := 1;
SET @to_account := 2;

-- Step 1: Deduct from the source account
UPDATE accounts
SET balance = balance - @amount
WHERE account_id = @from_account;

-- Check for sufficient funds
IF (SELECT balance FROM accounts WHERE account_id = @from_account) < 0 THEN
    -- Rollback if insufficient funds
    ROLLBACK;
    SELECT 'Transaction failed: Insufficient funds' AS status;
ELSE
    -- Step 2: Add to the target account
    UPDATE accounts
    SET balance = balance + @amount
    WHERE account_id = @to_account;

    -- Commit the transaction
    COMMIT;
    SELECT 'Transaction successful' AS status;
END IF;
```

### Step 3: Verify the Result

After the transaction, check the balances:

```sql
SELECT * FROM accounts;
```

## Conditional Operators

### 1. **IF() Function**

The `IF()` function evaluates a condition and returns one value if the condition is true and another value if it is false.

**Syntax:**

```sql
IF(condition, value_if_true, value_if_false)
```

**Example:**

```sql
SELECT IF(400 < 2000, "YES", "NO") AS result;
```

### 2. **CASE Statement**

The `CASE` statement allows you to evaluate multiple conditions and return different results based on those conditions.

**Syntax:**

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE result_default
END
```

**Example:**

```sql
SELECT
    CASE
        WHEN 400 < 200 THEN 'Condition 1 is true'
        WHEN 400 < 600 THEN 'Condition 2 is true'
        ELSE 'No conditions are true'
    END AS result;
```

### 3. **COALESCE() Function**

The `COALESCE()` function returns the first non-null value from a list of expressions.

**Syntax:**

```sql
COALESCE(value1, value2, ..., valueN)
```

**Example:**

```sql
SELECT COALESCE(NULL, NULL, NULL, 'W3Schools.com', NULL, 'Example.com') AS first_non_null;
```

## JOINS mysql

**INNER JOIN:** Returns records that have matching values in both tables
**LEFT JOIN:** Returns all records from the left table, and the matched records from the right table
**RIGHT JOIN:** Returns all records from the right table, and the matched records from the left table
**FULL OUTER JOIN / CROSS JOIN:** Returns all records from both tables

### Full Outer Joins

```sql
SELECT * FROM t1
LEFT JOIN t2 ON t1.id = t2.id
UNION
SELECT * FROM t1
RIGHT JOIN t2 ON t1.id = t2.id
```


---
### Note on `NOT IN` and NULL Values

If any of the values in the list are `NULL`, the whole expression will evaluate to `NULL`, resulting in no records being returned. 

> **Source:** [Stack Overflow](https://stackoverflow.com/a/129151)

**Key Point:**  
`NOT IN` will return 0 records when compared against an unknown value. Since `NULL` is considered an unknown, a `NOT IN` query that includes `NULL` (or any `NULL` values in the list) will always return 0 records. This is because there is no way to be sure that the `NULL` value is not the value being tested.

--- 

## ??

custom var
ACID

```

```
https://leetcode.com/discuss/interview-question/4546470/MySQL-Cheatsheet/
