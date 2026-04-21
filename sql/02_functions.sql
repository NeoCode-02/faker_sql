-- =============================================================================
-- Faker SQL - Core Functions for Deterministic Randomness
-- =============================================================================

DROP FUNCTION IF EXISTS fn_hash_to_int(TEXT);
DROP FUNCTION IF EXISTS fn_random_int(VARCHAR, INTEGER, INTEGER, INTEGER, VARCHAR, INTEGER, INTEGER);
DROP FUNCTION IF EXISTS fn_random_float(VARCHAR, INTEGER, INTEGER, INTEGER, VARCHAR);
DROP FUNCTION IF EXISTS fn_weighted_choice(VARCHAR, INTEGER, INTEGER, INTEGER, VARCHAR, INTEGER[]);
DROP FUNCTION IF EXISTS fn_normal_value(VARCHAR, INTEGER, INTEGER, INTEGER, VARCHAR, DOUBLE PRECISION, DOUBLE PRECISION);
DROP FUNCTION IF EXISTS fn_uniform_sphere_point(VARCHAR, INTEGER, INTEGER, INTEGER, VARCHAR);

-- =============================================================================
-- Core Hash Function
-- SHA256 -> first 8 bytes folded to positive BIGINT [0, 2^63-1]
-- Top byte masked to 7 bits to guarantee non-negative result.
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_hash_to_int(input TEXT)
RETURNS BIGINT
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    hash_bytes BYTEA;
    result BIGINT;
BEGIN
    hash_bytes := digest(input::BYTEA, 'sha256');
    result := ((get_byte(hash_bytes, 0) & 127)::BIGINT << 56)
            | (get_byte(hash_bytes, 1)::BIGINT << 48)
            | (get_byte(hash_bytes, 2)::BIGINT << 40)
            | (get_byte(hash_bytes, 3)::BIGINT << 32)
            | (get_byte(hash_bytes, 4)::BIGINT << 24)
            | (get_byte(hash_bytes, 5)::BIGINT << 16)
            | (get_byte(hash_bytes, 6)::BIGINT << 8)
            | get_byte(hash_bytes, 7)::BIGINT;
    RETURN result;
END;
$$;

-- =============================================================================
-- Deterministic Random Integer in [min, max]
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_random_int(
    p_locale VARCHAR,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_row_index INTEGER,
    p_key VARCHAR,
    p_min INTEGER,
    p_max INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    hash_int BIGINT;
    range_size BIGINT;
BEGIN
    hash_int := fn_hash_to_int(
        p_locale || '|' || p_seed::TEXT || '|' ||
        p_batch_index::TEXT || '|' || p_row_index::TEXT || '|' || p_key
    );
    range_size := (p_max - p_min + 1)::BIGINT;
    IF range_size <= 0 THEN
        RETURN p_min;
    END IF;
    RETURN p_min + (hash_int % range_size)::INTEGER;
END;
$$;

-- =============================================================================
-- Deterministic Random Float in [0, 1)
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_random_float(
    p_locale VARCHAR,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_row_index INTEGER,
    p_key VARCHAR
)
RETURNS DOUBLE PRECISION
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    hash_int BIGINT;
BEGIN
    hash_int := fn_hash_to_int(
        p_locale || '|' || p_seed::TEXT || '|' ||
        p_batch_index::TEXT || '|' || p_row_index::TEXT || '|' || p_key || '_float'
    );
    RETURN (hash_int % 1000000000)::DOUBLE PRECISION / 1000000000.0;
END;
$$;

-- =============================================================================
-- Weighted Choice: returns 1-based index into weights array
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_weighted_choice(
    p_locale VARCHAR,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_row_index INTEGER,
    p_key VARCHAR,
    p_weights INTEGER[]
)
RETURNS INTEGER
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    total_weight BIGINT := 0;
    rand_float DOUBLE PRECISION;
    cumulative DOUBLE PRECISION := 0;
    i INTEGER;
    n INTEGER;
BEGIN
    n := array_length(p_weights, 1);
    IF n IS NULL OR n = 0 THEN
        RETURN 1;
    END IF;
    FOR i IN 1..n LOOP
        total_weight := total_weight + GREATEST(p_weights[i], 0);
    END LOOP;
    IF total_weight <= 0 THEN
        RETURN 1 + (fn_hash_to_int(p_locale || p_seed::TEXT || p_batch_index || p_row_index || p_key) % n)::INTEGER;
    END IF;
    rand_float := fn_random_float(p_locale, p_seed, p_batch_index, p_row_index, p_key) * total_weight;
    FOR i IN 1..n LOOP
        cumulative := cumulative + GREATEST(p_weights[i], 0);
        IF rand_float < cumulative THEN
            RETURN i;
        END IF;
    END LOOP;
    RETURN n;
END;
$$;

-- =============================================================================
-- Normal Distribution (Box-Muller transform)
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_normal_value(
    p_locale VARCHAR,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_row_index INTEGER,
    p_key VARCHAR,
    p_mean DOUBLE PRECISION,
    p_stddev DOUBLE PRECISION
)
RETURNS DOUBLE PRECISION
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    u1 DOUBLE PRECISION;
    u2 DOUBLE PRECISION;
    z0 DOUBLE PRECISION;
    pi_constant DOUBLE PRECISION := 3.14159265358979;
BEGIN
    u1 := fn_random_float(p_locale, p_seed, p_batch_index, p_row_index, p_key || '_u1');
    u2 := fn_random_float(p_locale, p_seed, p_batch_index, p_row_index, p_key || '_u2');
    u1 := GREATEST(u1, 1e-9);
    z0 := sqrt(-2.0 * ln(u1)) * cos(2.0 * pi_constant * u2);
    RETURN p_mean + z0 * p_stddev;
END;
$$;

-- =============================================================================
-- Uniform Point on Sphere
-- z ~ Uniform[-1,1], theta ~ Uniform[0,2pi); lat = asin(z)
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_uniform_sphere_point(
    p_locale VARCHAR,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_row_index INTEGER,
    p_key VARCHAR
)
RETURNS TABLE(latitude DOUBLE PRECISION, longitude DOUBLE PRECISION)
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
    u DOUBLE PRECISION;
    theta DOUBLE PRECISION;
    pi_constant DOUBLE PRECISION := 3.14159265358979;
BEGIN
    u := fn_random_float(p_locale, p_seed, p_batch_index, p_row_index, p_key || '_u') * 2.0 - 1.0;
    theta := fn_random_float(p_locale, p_seed, p_batch_index, p_row_index, p_key || '_theta') * 2.0 * pi_constant;
    latitude := asin(u) * 180.0 / pi_constant;
    longitude := (theta - pi_constant) * 180.0 / pi_constant;
    RETURN NEXT;
END;
$$;
