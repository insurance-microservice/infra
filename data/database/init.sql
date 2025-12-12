CREATE SCHEMA IF NOT EXISTS customer_svc;

CREATE TABLE customer_svc.customer (
    customer_id BIGSERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(25),
    age INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE SCHEMA IF NOT EXISTS policy_svc;

CREATE TABLE policy_svc.policy (
    policy_id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    policy_number VARCHAR(50),
    type VARCHAR(50) NOT NULL,
    premium_amount NUMERIC(12,2) NOT NULL,
    coverage_amount NUMERIC(12,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    start_date DATE,
    end_date DATE
);

CREATE SCHEMA IF NOT EXISTS payment_svc;

CREATE TABLE payment_svc.payment (
    payment_id BIGSERIAL PRIMARY KEY,
    policy_id BIGINT NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'UNPAID',
    billing_date DATE DEFAULT CURRENT_DATE,
    payment_date DATE
);

CREATE SCHEMA IF NOT EXISTS claim_svc;

CREATE TABLE claim_svc.claim (
    claim_id BIGSERIAL PRIMARY KEY,
    policy_id BIGINT NOT NULL,
    claim_number VARCHAR(50),
    description TEXT,
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT NOW(),
    approved_at TIMESTAMP
);

CREATE SCHEMA IF NOT EXISTS underwriting_svc;

CREATE TABLE underwriting_svc.underwriting (
    underwriting_id BIGSERIAL PRIMARY KEY,
    policy_id BIGINT NOT NULL,
    risk_score INT,
    status VARCHAR(20),
    reason TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);


-- indexes
CREATE INDEX idx_policy_customer_id ON policy_svc.policy(customer_id);
CREATE INDEX idx_payment_policy_id ON payment_svc.payment(policy_id);
CREATE INDEX idx_claim_policy_id ON claim_svc.claim(policy_id);
CREATE INDEX idx_underwriting_policy_id ON underwriting_svc.underwriting(policy_id);

