-- =============================================================================
-- Faker SQL - Main Procedure
-- =============================================================================
DROP FUNCTION IF EXISTS sp_generate_fake_users(TEXT, INTEGER, INTEGER, INTEGER);
DROP FUNCTION IF EXISTS sp_generate_fake_users(TEXT, INTEGER);

CREATE OR REPLACE FUNCTION sp_generate_fake_users(
    p_locale TEXT,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_batch_size INTEGER
)
RETURNS TABLE (
    row_index INTEGER,
    full_name TEXT,
    address TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    height TEXT,
    weight TEXT,
    eye_color TEXT,
    phone TEXT,
    email TEXT
)
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_idx INTEGER;
    v_geo_lat DOUBLE PRECISION;
    v_geo_lon DOUBLE PRECISION;
BEGIN
    FOR v_idx IN 0..p_batch_size - 1 LOOP
        -- Generate all fields
        full_name := fn_generate_name(p_locale, p_seed, p_batch_index, v_idx, 
            fn_random_int(p_locale, p_seed, p_batch_index, v_idx, 'name_fmt', 0, 4));
        address := fn_generate_address(p_locale, p_seed, p_batch_index, v_idx,
            fn_random_int(p_locale, p_seed, p_batch_index, v_idx, 'addr_fmt', 0, 2));
        
        -- Get geolocation
        BEGIN
            SELECT f.latitude, f.longitude INTO v_geo_lat, v_geo_lon
            FROM fn_uniform_sphere_point(p_locale, p_seed, p_batch_index, v_idx, 'geo') AS f;
            latitude := v_geo_lat;
            longitude := v_geo_lon;
        EXCEPTION WHEN OTHERS THEN
            latitude := 0.0;
            longitude := 0.0;
        END;
        
        height := fn_generate_physical(p_locale, p_seed, p_batch_index, v_idx, 'height');
        weight := fn_generate_physical(p_locale, p_seed, p_batch_index, v_idx, 'weight');
        eye_color := fn_generate_physical(p_locale, p_seed, p_batch_index, v_idx, 'eye_color');
        phone := fn_generate_phone(p_locale, p_seed, p_batch_index, v_idx,
            fn_random_int(p_locale, p_seed, p_batch_index, v_idx, 'phone_fmt', 0, 2));
        email := fn_generate_email(p_locale, full_name, p_seed, p_batch_index, v_idx,
            fn_random_int(p_locale, p_seed, p_batch_index, v_idx, 'email_fmt', 0, 4));
        
        row_index := v_idx;
        RETURN NEXT;
    END LOOP;
END;
$$;

CREATE OR REPLACE FUNCTION sp_generate_fake_users(p_locale TEXT, p_seed INTEGER)
RETURNS TABLE (row_index INTEGER, full_name TEXT, address TEXT, latitude DOUBLE PRECISION, longitude DOUBLE PRECISION, height TEXT, weight TEXT, eye_color TEXT, phone TEXT, email TEXT)
LANGUAGE plpgsql
STABLE AS $$
BEGIN RETURN QUERY SELECT * FROM sp_generate_fake_users(p_locale, p_seed, 0, 10);
END;
$$;