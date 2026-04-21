-- Faker SQL - Database Schema
-- PostgreSQL schema with extensible locale support

-- Enable extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Drop tables if exist (for clean reinstall)
DROP TABLE IF EXISTS batch_tracking CASCADE;
DROP TABLE IF EXISTS eye_colors CASCADE;
DROP TABLE IF EXISTS phone_prefixes CASCADE;
DROP TABLE IF EXISTS email_domains CASCADE;
DROP TABLE IF EXISTS streets CASCADE;
DROP TABLE IF EXISTS cities CASCADE;
DROP TABLE IF EXISTS names CASCADE;
DROP TABLE IF EXISTS locales CASCADE;

-- Locales table
CREATE TABLE locales (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    phone_format VARCHAR(100),
    address_format VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Names table with locale and gender support
CREATE TABLE names (
    id SERIAL PRIMARY KEY,
    locale VARCHAR(10) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    gender CHAR(1) CHECK (gender IN ('M', 'F', NULL)),
    weight INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(locale, first_name, last_name, middle_name, gender)
);

CREATE INDEX idx_names_locale ON names(locale);
CREATE INDEX idx_names_locale_gender ON names(locale, gender);

-- Cities table
CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    locale VARCHAR(10) NOT NULL,
    city_name VARCHAR(100) NOT NULL,
    region VARCHAR(100),
    country VARCHAR(100) NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    postal_code VARCHAR(20),
    weight INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(locale, city_name, region)
);

CREATE INDEX idx_cities_locale ON cities(locale);

-- Streets table
CREATE TABLE streets (
    id SERIAL PRIMARY KEY,
    locale VARCHAR(10) NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    street_type VARCHAR(50),
    weight INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(locale, street_name, street_type)
);

CREATE INDEX idx_streets_locale ON streets(locale);

-- Email domains table
CREATE TABLE email_domains (
    id SERIAL PRIMARY KEY,
    locale VARCHAR(10) NOT NULL,
    domain VARCHAR(100) NOT NULL,
    weight INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(locale, domain)
);

CREATE INDEX idx_email_domains_locale ON email_domains(locale);

-- Phone prefixes table
CREATE TABLE phone_prefixes (
    id SERIAL PRIMARY KEY,
    locale VARCHAR(10) NOT NULL,
    prefix VARCHAR(10) NOT NULL,
    operator VARCHAR(50),
    weight INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(locale, prefix)
);

CREATE INDEX idx_phone_prefixes_locale ON phone_prefixes(locale);

-- Eye colors table
CREATE TABLE eye_colors (
    id SERIAL PRIMARY KEY,
    color VARCHAR(50) NOT NULL UNIQUE,
    weight INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Hair colors table
CREATE TABLE hair_colors (
    id SERIAL PRIMARY KEY,
    color VARCHAR(50) NOT NULL UNIQUE,
    weight INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Distributions table for height/weight
CREATE TABLE distributions (
    id SERIAL PRIMARY KEY,
    locale VARCHAR(10) NOT NULL,
    attribute VARCHAR(50) NOT NULL,
    distribution_type VARCHAR(20) NOT NULL CHECK (distribution_type IN ('normal', 'uniform', 'discrete')),
    mean_value DOUBLE PRECISION,
    std_dev DOUBLE PRECISION,
    min_value DOUBLE PRECISION,
    max_value DOUBLE PRECISION,
    unit VARCHAR(20),
    UNIQUE(locale, attribute)
);

CREATE INDEX idx_distributions_locale ON distributions(locale);

-- Fake user results (temporary storage for procedure output)
CREATE TABLE fake_user_results (
    id SERIAL PRIMARY KEY,
    session_id UUID NOT NULL,
    row_index INTEGER NOT NULL,
    full_name TEXT,
    address TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    height TEXT,
    weight TEXT,
    eye_color TEXT,
    phone TEXT,
    email TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Batch tracking for reproducibility (per session)
CREATE TABLE batch_tracking (
    id SERIAL PRIMARY KEY,
    session_id UUID NOT NULL,
    locale VARCHAR(10) NOT NULL,
    seed INTEGER NOT NULL,
    batch_index INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(session_id, locale, seed, batch_index)
);

-- View for locale info
CREATE OR REPLACE VIEW v_locale_info AS
SELECT
    l.code,
    l.name AS locale_name,
    l.country,
    COUNT(DISTINCT n.id) AS names_count,
    COUNT(DISTINCT c.id) AS cities_count,
    COUNT(DISTINCT s.id) AS streets_count,
    COUNT(DISTINCT e.id) AS email_domains_count,
    COUNT(DISTINCT p.id) AS phone_prefixes_count
FROM locales l
LEFT JOIN names n ON n.locale = l.code
LEFT JOIN cities c ON c.locale = l.code
LEFT JOIN streets s ON s.locale = l.code
LEFT JOIN email_domains e ON e.locale = l.code
LEFT JOIN phone_prefixes p ON p.locale = l.code
GROUP BY l.code, l.name, l.country;
