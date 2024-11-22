import streamlit as st
import mysql.connector
import pandas as pd

from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

# Database connection
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",  # Replace with your username
        password=os.getenv("DB_PASSWORD"),  # Replace with your password
        database="hackathon"  # Replace with your database name
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