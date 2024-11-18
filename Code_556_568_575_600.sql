--3
CREATE TABLE Investor (
    investor_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    address TEXT,
    risk_tolerance ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Portfolio (
    portfolio_id INT AUTO_INCREMENT PRIMARY KEY,
    investor_id INT NOT NULL,
    portfolio_name VARCHAR(100) NOT NULL,
    initial_investment DECIMAL(15, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Active', 'Inactive') DEFAULT 'Active',
    FOREIGN KEY (investor_id) REFERENCES Investor(investor_id) ON DELETE CASCADE
);
CREATE TABLE PORTFOLIO_3 (
    portfolio_id INT AUTO_INCREMENT PRIMARY KEY, 
    investor_id INT NOT NULL,                     
    portfolio_name VARCHAR(255) NOT NULL,        
    creation_date DATE,                           
    total_value DECIMAL(18, 2),                   
    risk_level VARCHAR(100),                      
    FOREIGN KEY (investor_id) REFERENCES INVESTOR(investor_id) ON DELETE CASCADE  
);
CREATE TABLE Asset (
    asset_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_name VARCHAR(100) NOT NULL,
    asset_type ENUM('Stock', 'Bond', 'ETF', 'Real Estate', 'Cryptocurrency') NOT NULL,
    market_value DECIMAL(15, 2) NOT NULL,
    risk_level ENUM('Low', 'Medium', 'High') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Portfolio_Asset (
    portfolio_id INT NOT NULL,
    asset_id INT NOT NULL,
    units_owned DECIMAL(12, 4) NOT NULL,
    purchase_price DECIMAL(15, 2) NOT NULL,
    current_value DECIMAL(15, 2) NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (portfolio_id, asset_id),
    FOREIGN KEY (portfolio_id) REFERENCES Portfolio(portfolio_id) ON DELETE CASCADE,
    FOREIGN KEY (asset_id) REFERENCES Asset(asset_id) ON DELETE CASCADE
);

CREATE TABLE Transaction (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    portfolio_id INT NOT NULL,
    asset_id INT NOT NULL,
    transaction_type ENUM('Buy', 'Sell') NOT NULL,
    transaction_date DATE NOT NULL,
    units DECIMAL(12, 4) NOT NULL,
    price_per_unit DECIMAL(15, 2) NOT NULL,
    total_value DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (portfolio_id) REFERENCES Portfolio(portfolio_id) ON DELETE CASCADE,
    FOREIGN KEY (asset_id) REFERENCES Asset(asset_id) ON DELETE CASCADE
);

CREATE TABLE Market_History (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    asset_id INT NOT NULL,
    date DATE NOT NULL,
    market_value DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (asset_id) REFERENCES Asset(asset_id) ON DELETE CASCADE
);

INSERT INTO Investor (full_name, email, phone_number, address, risk_tolerance) VALUES
('Alice Johnson', 'alice.johnson@example.com', '1234567890', '123 Elm Street, NY', 'Low'),
('Bob Smith', 'bob.smith@example.com', '0987654321', '456 Oak Avenue, CA', 'Medium'),
('Charlie Brown', 'charlie.brown@example.com', '1122334455', '789 Pine Lane, TX', 'High'),
('Diana Prince', 'diana.prince@example.com', '2233445566', '101 Maple Drive, FL', 'Medium'),
('Edward Stark', 'edward.stark@example.com', '3344556677', '202 Birch Boulevard, WA', 'High');

INSERT INTO Portfolio (investor_id, portfolio_name, initial_investment) VALUES
(1, 'Retirement Fund', 50000.00),
(2, 'Growth Portfolio', 75000.00),
(3, 'High-Risk Portfolio', 100000.00),
(4, 'Diversified Portfolio', 60000.00),
(5, 'Crypto Focus', 45000.00);

INSERT INTO Asset (asset_name, asset_type, market_value, risk_level) VALUES
('Apple Inc.', 'Stock', 150.50, 'Low'),
('US Treasury Bond', 'Bond', 102.75, 'Low'),
('S&P 500 ETF', 'ETF', 420.30, 'Medium'),
('Downtown Office', 'Real Estate', 500000.00, 'High'),
('Bitcoin', 'Cryptocurrency', 27000.00, 'High');

INSERT INTO Portfolio_Asset (portfolio_id, asset_id, units_owned, purchase_price, current_value) VALUES
(1, 1, 100.00, 145.00, 150.50),
(1, 2, 50.00, 100.00, 102.75),
(2, 3, 75.00, 400.00, 420.30),
(3, 5, 1.50, 20000.00, 27000.00),
(4, 4, 0.10, 450000.00, 500000.00);
-- Inserting portfolios for investor_id = 1
INSERT INTO PORTFOLIO_3 (investor_id, portfolio_name, creation_date, total_value, risk_level)
VALUES 
(1, 'Green Energy Fund', CURDATE(), 120000.00, 'Medium'),
(1, 'Sustainable Growth Fund', CURDATE(), 150000.00, 'High'),
(1, 'Tech Growth Portfolio', CURDATE(), 200000.00, 'Low');

-- Inserting portfolios for investor_id = 2
INSERT INTO PORTFOLIO_3 (investor_id, portfolio_name, creation_date, total_value, risk_level)
VALUES 
(2, 'Global Markets Fund', CURDATE(), 180000.00, 'High'),
(2, 'Dividend Income Portfolio', CURDATE(), 110000.00, 'Medium');

-- Inserting portfolios for investor_id = 3
INSERT INTO PORTFOLIO_3 (investor_id, portfolio_name, creation_date, total_value, risk_level)
VALUES 
(3, 'Emerging Markets Fund', CURDATE(), 130000.00, 'Medium'),
(3, 'Conservative Bond Portfolio', CURDATE(), 90000.00, 'Low');
INSERT INTO Transaction (portfolio_id, asset_id, transaction_type, transaction_date, units, price_per_unit, total_value) VALUES
(1, 1, 'Buy', '2024-11-01', 100.00, 145.00, 14500.00),
(1, 2, 'Buy', '2024-11-02', 50.00, 100.00, 5000.00),
(2, 3, 'Buy', '2024-11-03', 75.00, 400.00, 30000.00),
(3, 5, 'Buy', '2024-11-04', 1.50, 20000.00, 30000.00),
(4, 4, 'Buy', '2024-11-05', 0.10, 450000.00, 45000.00);

INSERT INTO Market_History (asset_id, date, market_value) VALUES
(1, '2024-11-01', 145.00),
(1, '2024-11-15', 150.50),
(5, '2024-11-01', 20000.00),
(5, '2024-11-15', 27000.00),
(4, '2024-11-01', 450000.00);

--4

-- Federated INVESTOR Table
CREATE TABLE INVESTOR (
    investor_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20),
    dob DATE,
    risk_preference VARCHAR(100),
    investment_preferences TEXT
) ENGINE=FEDERATED
CONNECTION='mysql://fed-user:fed-pswd@10.1.18.48:3306/dbmshack/INVESTOR';

-- Federated PORTFOLIO Table
CREATE TABLE PORTFOLIO (
    portfolio_id INT PRIMARY KEY,
    investor_id INT,
    portfolio_name VARCHAR(255),
    creation_date DATE,
    total_value DECIMAL(18, 2),
    risk_level VARCHAR(100)
) ENGINE=FEDERATED
CONNECTION='mysql://fed-user:fed-pswd@10.1.18.48:3306/dbmshack/PORTFOLIO';

-- Federated ASSET Table
CREATE TABLE ASSET (
    asset_id INT PRIMARY KEY,
    asset_name VARCHAR(255),
    asset_type VARCHAR(100),
    sustainability_rating VARCHAR(100),
    current_price DECIMAL(18, 2),
    risk_rating VARCHAR(100),
    description TEXT
) ENGINE=FEDERATED
CONNECTION='mysql://fed-user:fed-pswd@10.1.18.48:3306/dbmshack/ASSET';

-- Federated ASSET_PRICE_HISTORY Table
CREATE TABLE ASSET_PRICE_HISTORY (
    history_id INT PRIMARY KEY,
    asset_id INT,
    price DECIMAL(18, 2),
    recorded_date DATE,
    recorded_time TIME
) ENGINE=FEDERATED
CONNECTION='mysql://fed-user:fed-pswd@10.1.18.48:3306/dbmshack/ASSET_PRICE_HISTORY';
-- PORTFOLIO_ASSET Table (Join table for Portfolio and Asset)
CREATE TABLE PORTFOLIO_ASSET (
    portfolio_id INT,
    asset_id INT,
    units_held DECIMAL(18, 2),
    current_value DECIMAL(18, 2),
    last_updated DATE,
    PRIMARY KEY (portfolio_id, asset_id),
    FOREIGN KEY (portfolio_id) REFERENCES PORTFOLIO(portfolio_id) ON DELETE CASCADE,
    FOREIGN KEY (asset_id) REFERENCES ASSET(asset_id) ON DELETE CASCADE
)ENGINE=FEDERATED
CONNECTION='mysql://fed-user:fed-pswd@10.1.18.48:3306/dbmshack/PORTFOLIO_ASSET';

-- TRANSACTION Table
CREATE TABLE TRANSACTION (
    transaction_id INT PRIMARY KEY,
    portfolio_id INT NOT NULL,
    asset_id INT NOT NULL,
    transaction_type VARCHAR(50) CHECK (transaction_type IN ('BUY', 'SELL')),
    units DECIMAL(18, 2),
    price_per_unit DECIMAL(18, 2),
    total_value DECIMAL(18, 2),
    transaction_date DATE NOT NULL,
    FOREIGN KEY (portfolio_id) REFERENCES PORTFOLIO(portfolio_id) ON DELETE CASCADE,
    FOREIGN KEY (asset_id) REFERENCES ASSET(asset_id) ON DELETE CASCADE
)ENGINE=FEDERATED
CONNECTION='mysql://fed-user:fed-pswd@10.1.18.48:3306/dbmshack/TRANSACTIONS';

--5
SELECT 
    inv.full_name AS "Investor's Full Name",
    port.portfolio_name AS "Portfolio Name",
    a.asset_name AS "Asset Name",
    ROUND(pa.current_value * POWER(1 + 0.05, 20), 2) AS "Projected Asset Value After 20 Years"
FROM 
    Portfolio_Asset pa
JOIN 
    Portfolio port ON pa.portfolio_id = port.portfolio_id
JOIN 
    Investor inv ON port.investor_id = inv.investor_id
JOIN 
    Asset a ON pa.asset_id = a.asset_id;

--6

DELIMITER $$

CREATE PROCEDURE TransferAsset2(
    IN source_portfolio_id INT, 
    IN destination_portfolio_id INT, 
    IN asset_id INT, 
    IN transfer_units DECIMAL(18, 2) 
)
BEGIN
    DECLARE source_investor_id INT;
    DECLARE destination_investor_id INT;
    DECLARE current_price DECIMAL(18, 2);
    DECLARE transfer_value DECIMAL(18, 2);
    DECLARE source_units DECIMAL(18, 2);

    SELECT investor_id INTO source_investor_id
    FROM PORTFOLIO_3
    WHERE portfolio_id = source_portfolio_id
    LIMIT 1;

    SELECT investor_id INTO destination_investor_id
    FROM PORTFOLIO_3
    WHERE portfolio_id = destination_portfolio_id
    LIMIT 1;

    IF source_investor_id != destination_investor_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Both portfolios must belong to the same investor.';
    END IF;

    SELECT units_held INTO source_units
    FROM PORTFOLIO_ASSET
    WHERE portfolio_id = source_portfolio_id AND asset_id = asset_id
    LIMIT 1;

    IF source_units IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The asset does not exist in the source portfolio.';
    END IF;

    IF source_units < transfer_units THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient units in the source portfolio.';
    END IF;

    SELECT current_price INTO current_price
    FROM ASSET
    WHERE asset_id = asset_id
    LIMIT 1;

    SET transfer_value = current_price * transfer_units;

    UPDATE PORTFOLIO_ASSET
    SET units_held = units_held - transfer_units,
        current_value = current_value - transfer_value
    WHERE portfolio_id = source_portfolio_id AND asset_id = asset_id;

    INSERT INTO PORTFOLIO_ASSET (portfolio_id, asset_id, units_held, current_value, last_updated)
    VALUES (destination_portfolio_id, asset_id, transfer_units, transfer_value, CURDATE())
    ON DUPLICATE KEY UPDATE
        units_held = units_held + transfer_units,
        current_value = current_value + transfer_value,
        last_updated = CURDATE();

    UPDATE PORTFOLIO_3
    SET total_value = total_value - transfer_value
    WHERE portfolio_id = source_portfolio_id;

    UPDATE PORTFOLIO_3
    SET total_value = total_value + transfer_value
    WHERE portfolio_id = destination_portfolio_id;

END$$

DELIMITER ;

--7
DELIMITER $$

CREATE TRIGGER update_portfolio_asset
AFTER INSERT ON Transaction
FOR EACH ROW
BEGIN
    DECLARE updated_value DECIMAL(15, 2);

    SELECT current_value INTO updated_value
    FROM Portfolio_Asset
    WHERE portfolio_id = NEW.portfolio_id AND asset_id = NEW.asset_id;

    IF NEW.transaction_type = 'Buy' THEN
        UPDATE Portfolio_Asset
        SET current_value = current_value + (NEW.units * NEW.price_per_unit),
            last_updated = CURRENT_TIMESTAMP
        WHERE portfolio_id = NEW.portfolio_id AND asset_id = NEW.asset_id;
    ELSEIF NEW.transaction_type = 'Sell' THEN
        UPDATE Portfolio_Asset
        SET current_value = current_value - (NEW.units * NEW.price_per_unit),
            last_updated = CURRENT_TIMESTAMP
        WHERE portfolio_id = NEW.portfolio_id AND asset_id = NEW.asset_id;
    END IF;
END$$

DELIMITER ;

/*

import streamlit as st
import mysql.connector
import pandas as pd

# Database connection
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",  # Replace with your username
        password="",  # Replace with your password
        database="investment_db"  # Replace with your database name
    )

# Function to display Portfolio_Asset table
def display_portfolio_assets():
    conn = get_db_connection()
    query = "SELECT * FROM Portfolio_Asset"
    df = pd.read_sql(query, conn)
    conn.close()
    return df

# Function to add a transaction
def add_transaction(portfolio_id, asset_id, transaction_type, units, price_per_unit):
    conn = get_db_connection()
    cursor = conn.cursor()
    query = """
    INSERT INTO Transaction (portfolio_id, asset_id, transaction_type, transaction_date, units, price_per_unit, total_value)
    VALUES (%s, %s, %s, NOW(), %s, %s, %s)
    """
    total_value = units * price_per_unit
    cursor.execute(query, (portfolio_id, asset_id, transaction_type, units, price_per_unit, total_value))
    conn.commit()
    conn.close()

# Streamlit UI
st.title("Portfolio Asset Management")
st.write("Demonstrating SQL Trigger Execution")

# Display Portfolio_Asset table
st.header("Portfolio Assets")
st.write("Current state of Portfolio_Asset table:")
df = display_portfolio_assets()
st.dataframe(df)

# Add a transaction
st.header("Add a Transaction")
portfolio_id = st.number_input("Portfolio ID", min_value=1, step=1)
asset_id = st.number_input("Asset ID", min_value=1, step=1)
transaction_type = st.selectbox("Transaction Type", ["Buy", "Sell"])
units = st.number_input("Units", min_value=0.01, step=0.01, format="%.2f")
price_per_unit = st.number_input("Price Per Unit", min_value=0.01, step=0.01, format="%.2f")

if st.button("Add Transaction"):
    add_transaction(portfolio_id, asset_id, transaction_type, units, price_per_unit)
    st.success("Transaction added successfully!")
    st.write("Updated Portfolio_Asset table:")
    df = display_portfolio_assets()
    st.dataframe(df)

*/

--8
DELIMITER $$

CREATE FUNCTION calculate_future_value(current_value DECIMAL, interest_rate DECIMAL, years INT)
RETURNS DECIMAL
DETERMINISTIC
BEGIN
    DECLARE future_value DECIMAL;
    SET future_value = current_value * POWER(1 + interest_rate, years);
    RETURN future_value;
END$$

DELIMITER ;

SELECT 
    i.full_name AS investor_name,
    p.portfolio_name,
    a.asset_name,
    pa.current_value AS current_asset_value,
    calculate_future_value(pa.current_value, 0.05, 10) AS projected_asset_value_10_years
FROM 
    Portfolio_Asset pa
JOIN 
    Portfolio p ON pa.portfolio_id = p.portfolio_id
JOIN 
    Investor i ON p.investor_id = i.investor_id
JOIN 
    Asset a ON pa.asset_id = a.asset_id;

--9
INSERT INTO Portfolio (investor_id, portfolio_name, initial_investment)
VALUES (1, 'Retirement Fund', 5000);

START TRANSACTION;

UPDATE Portfolio
SET initial_investment = initial_investment + 1000
WHERE portfolio_name = 'Retirement Fund';

UPDATE Portfolio
SET initial_investment = initial_investment + 500
WHERE portfolio_name = 'Retirement Fund';

COMMIT;
