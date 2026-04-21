-- =============================================================================
-- Faker SQL - Generator Functions
-- =============================================================================

DROP FUNCTION IF EXISTS fn_generate_name(VARCHAR, INTEGER, INTEGER, INTEGER, INTEGER);
DROP FUNCTION IF EXISTS fn_generate_address(VARCHAR, INTEGER, INTEGER, INTEGER, INTEGER);
DROP FUNCTION IF EXISTS fn_generate_phone(VARCHAR, INTEGER, INTEGER, INTEGER, INTEGER);
DROP FUNCTION IF EXISTS fn_generate_email(VARCHAR, TEXT, INTEGER, INTEGER, INTEGER, INTEGER);
DROP FUNCTION IF EXISTS fn_generate_physical(VARCHAR, INTEGER, INTEGER, INTEGER, VARCHAR);

-- =============================================================================
-- Name Generator: weighted selection over (locale, gender)
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_generate_name(
    p_locale VARCHAR,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_row_index INTEGER,
    p_format_type INTEGER
)
RETURNS TEXT
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_first_name TEXT;
    v_last_name TEXT;
    v_middle_name TEXT;
    v_title TEXT;
    v_gender CHAR(1);
    v_ids INTEGER[];
    v_weights INTEGER[];
    v_mids INTEGER[];
    v_mweights INTEGER[];
    v_choice INTEGER;
    v_result TEXT;
BEGIN
    v_gender := CASE WHEN fn_random_int(p_locale, p_seed, p_batch_index, p_row_index, 'gender', 0, 1) = 0 THEN 'M' ELSE 'F' END;

    SELECT COALESCE(array_agg(id ORDER BY id), ARRAY[]::INTEGER[]),
           COALESCE(array_agg(weight ORDER BY id), ARRAY[]::INTEGER[])
    INTO v_ids, v_weights
    FROM names
    WHERE locale = p_locale AND (gender IS NULL OR gender = v_gender);

    IF v_ids IS NULL OR array_length(v_ids, 1) IS NULL THEN
        RETURN 'Unknown User';
    END IF;

    v_choice := fn_weighted_choice(p_locale, p_seed, p_batch_index, p_row_index, 'first_name', v_weights);
    SELECT TRIM(first_name) INTO v_first_name FROM names WHERE id = v_ids[v_choice];

    v_choice := fn_weighted_choice(p_locale, p_seed, p_batch_index, p_row_index, 'last_name', v_weights);
    SELECT TRIM(last_name) INTO v_last_name FROM names WHERE id = v_ids[v_choice];

    IF fn_random_int(p_locale, p_seed, p_batch_index, p_row_index, 'has_middle', 0, 1) = 1 THEN
        SELECT COALESCE(array_agg(id ORDER BY id), ARRAY[]::INTEGER[]),
               COALESCE(array_agg(weight ORDER BY id), ARRAY[]::INTEGER[])
        INTO v_mids, v_mweights
        FROM names
        WHERE locale = p_locale AND middle_name IS NOT NULL AND (gender IS NULL OR gender = v_gender);
        IF v_mids IS NOT NULL AND array_length(v_mids, 1) IS NOT NULL THEN
            v_choice := fn_weighted_choice(p_locale, p_seed, p_batch_index, p_row_index, 'middle_name', v_mweights);
            SELECT TRIM(middle_name) INTO v_middle_name FROM names WHERE id = v_mids[v_choice];
        END IF;
    END IF;

    IF fn_random_int(p_locale, p_seed, p_batch_index, p_row_index, 'has_title', 0, 2) = 0 THEN
        v_title := CASE WHEN v_gender = 'M' THEN 'Mr.' ELSE 'Ms.' END;
    END IF;

    CASE p_format_type
        WHEN 0 THEN v_result := v_first_name || ' ' || v_last_name;
        WHEN 1 THEN v_result := COALESCE(v_title || ' ', '') || v_first_name || ' ' || v_last_name;
        WHEN 2 THEN v_result := v_first_name || ' ' || COALESCE(v_middle_name || ' ', '') || v_last_name;
        WHEN 3 THEN v_result := COALESCE(v_title || ' ', '') || v_first_name || ' ' || COALESCE(v_middle_name || ' ', '') || v_last_name;
        ELSE v_result := v_last_name || ', ' || v_first_name;
    END CASE;
    RETURN v_result;
END;
$$;

-- =============================================================================
-- Address Generator
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_generate_address(
    p_locale VARCHAR,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_row_index INTEGER,
    p_format_type INTEGER
)
RETURNS TEXT
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_street_name TEXT;
    v_street_type TEXT;
    v_building INTEGER;
    v_apt TEXT;
    v_city TEXT;
    v_region TEXT;
    v_postal TEXT;
    v_country TEXT;
    v_ids INTEGER[];
    v_weights INTEGER[];
    v_choice INTEGER;
    v_result TEXT;
BEGIN
    SELECT COALESCE(array_agg(id ORDER BY id), ARRAY[]::INTEGER[]),
           COALESCE(array_agg(weight ORDER BY id), ARRAY[]::INTEGER[])
    INTO v_ids, v_weights FROM cities WHERE locale = p_locale;
    IF v_ids IS NULL OR array_length(v_ids, 1) IS NULL THEN
        RETURN 'Unknown City';
    END IF;
    v_choice := fn_weighted_choice(p_locale, p_seed, p_batch_index, p_row_index, 'city', v_weights);
    SELECT TRIM(city_name), region, country, postal_code
    INTO v_city, v_region, v_country, v_postal
    FROM cities WHERE id = v_ids[v_choice];

    SELECT COALESCE(array_agg(id ORDER BY id), ARRAY[]::INTEGER[]),
           COALESCE(array_agg(weight ORDER BY id), ARRAY[]::INTEGER[])
    INTO v_ids, v_weights FROM streets WHERE locale = p_locale;
    IF v_ids IS NULL OR array_length(v_ids, 1) IS NULL THEN
        RETURN v_city || ', ' || v_country;
    END IF;
    v_choice := fn_weighted_choice(p_locale, p_seed, p_batch_index, p_row_index, 'street', v_weights);
    SELECT TRIM(street_name), street_type
    INTO v_street_name, v_street_type
    FROM streets WHERE id = v_ids[v_choice];

    v_building := fn_random_int(p_locale, p_seed, p_batch_index, p_row_index, 'building', 1, 200);
    IF fn_random_int(p_locale, p_seed, p_batch_index, p_row_index, 'has_apt', 0, 4) > 0 THEN
        v_apt := ', Apt ' || fn_random_int(p_locale, p_seed, p_batch_index, p_row_index, 'apt', 1, 100);
    ELSE
        v_apt := '';
    END IF;

    CASE p_format_type
        WHEN 0 THEN
            v_result := v_street_name || ' ' || COALESCE(v_street_type || ' ', '') ||
                       v_building::TEXT || v_apt || ', ' || v_city || ' ' ||
                       COALESCE(v_postal, '') || ', ' || v_country;
        WHEN 1 THEN
            v_result := v_building::TEXT || ' ' || v_street_name || ' ' ||
                       COALESCE(v_street_type, '') || v_apt || ', ' || v_city || ', ' ||
                       COALESCE(v_region || ' ', '') || COALESCE(v_postal, '');
        ELSE
            v_result := v_city || ', ' || COALESCE(v_region || ', ', '') ||
                       v_street_name || ' ' || v_building::TEXT || v_apt;
    END CASE;
    RETURN v_result;
END;
$$;

-- =============================================================================
-- Phone Generator
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_generate_phone(
    p_locale VARCHAR,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_row_index INTEGER,
    p_format_type INTEGER
)
RETURNS TEXT
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_prefix TEXT;
    v_number TEXT;
    v_ids INTEGER[];
    v_weights INTEGER[];
    v_choice INTEGER;
    v_result TEXT;
BEGIN
    SELECT COALESCE(array_agg(id ORDER BY id), ARRAY[]::INTEGER[]),
           COALESCE(array_agg(weight ORDER BY id), ARRAY[]::INTEGER[])
    INTO v_ids, v_weights FROM phone_prefixes WHERE locale = p_locale;

    IF v_ids IS NULL OR array_length(v_ids, 1) IS NULL THEN
        v_prefix := CASE p_locale WHEN 'uz_UZ' THEN '+998' WHEN 'ru_RU' THEN '+7' ELSE '+1' END;
    ELSE
        v_choice := fn_weighted_choice(p_locale, p_seed, p_batch_index, p_row_index, 'prefix', v_weights);
        SELECT prefix INTO v_prefix FROM phone_prefixes WHERE id = v_ids[v_choice];
    END IF;

    v_number := LPAD(fn_random_int(p_locale, p_seed, p_batch_index, p_row_index, 'phone_num', 0, 9999999)::TEXT, 7, '0');

    CASE p_format_type
        WHEN 0 THEN
            v_result := v_prefix || ' ' || SUBSTRING(v_number, 1, 3) || '-' || SUBSTRING(v_number, 4, 2) || '-' || SUBSTRING(v_number, 6, 2);
        WHEN 1 THEN
            v_result := v_prefix || ' (' || SUBSTRING(v_number, 1, 3) || ') ' || SUBSTRING(v_number, 4, 4);
        ELSE
            v_result := v_prefix || v_number;
    END CASE;
    RETURN v_result;
END;
$$;

-- =============================================================================
-- Email Generator
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_generate_email(
    p_locale VARCHAR,
    p_full_name TEXT,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_row_index INTEGER,
    p_format_type INTEGER
)
RETURNS TEXT
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_name_parts TEXT[];
    v_first_name TEXT;
    v_last_name TEXT;
    v_domain TEXT;
    v_ids INTEGER[];
    v_weights INTEGER[];
    v_choice INTEGER;
    v_email TEXT;
BEGIN
    v_name_parts := string_to_array(regexp_replace(p_full_name, '[,\.]', '', 'g'), ' ');
    v_first_name := LOWER(v_name_parts[1]);
    v_last_name := LOWER(v_name_parts[array_length(v_name_parts, 1)]);
    v_first_name := regexp_replace(v_first_name, '[^a-z0-9]', '', 'g');
    v_last_name := regexp_replace(v_last_name, '[^a-z0-9]', '', 'g');
    IF v_first_name = '' THEN v_first_name := 'user'; END IF;
    IF v_last_name = '' THEN v_last_name := 'name'; END IF;

    SELECT COALESCE(array_agg(id ORDER BY id), ARRAY[]::INTEGER[]),
           COALESCE(array_agg(weight ORDER BY id), ARRAY[]::INTEGER[])
    INTO v_ids, v_weights FROM email_domains WHERE locale = p_locale;

    IF v_ids IS NULL OR array_length(v_ids, 1) IS NULL THEN
        v_domain := 'example.com';
    ELSE
        v_choice := fn_weighted_choice(p_locale, p_seed, p_batch_index, p_row_index, 'domain', v_weights);
        SELECT domain INTO v_domain FROM email_domains WHERE id = v_ids[v_choice];
    END IF;

    CASE p_format_type
        WHEN 0 THEN v_email := v_first_name || '.' || v_last_name;
        WHEN 1 THEN v_email := v_first_name || v_last_name;
        WHEN 2 THEN v_email := v_first_name || '_' || v_last_name;
        WHEN 3 THEN v_email := v_first_name || v_last_name || fn_random_int(p_locale, p_seed, p_batch_index, p_row_index, 'email_num', 10, 99);
        ELSE v_email := v_first_name || '.' || v_last_name || fn_random_int(p_locale, p_seed, p_batch_index, p_row_index, 'email_num', 10, 99);
    END CASE;
    RETURN v_email || '@' || v_domain;
END;
$$;

-- =============================================================================
-- Physical Attributes Generator
-- =============================================================================

CREATE OR REPLACE FUNCTION fn_generate_physical(
    p_locale VARCHAR,
    p_seed INTEGER,
    p_batch_index INTEGER,
    p_row_index INTEGER,
    p_attr_type VARCHAR
)
RETURNS TEXT
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
    v_mean DOUBLE PRECISION;
    v_stddev DOUBLE PRECISION;
    v_min DOUBLE PRECISION;
    v_max DOUBLE PRECISION;
    v_ids INTEGER[];
    v_weights INTEGER[];
    v_choice INTEGER;
    v_color TEXT;
    v_value DOUBLE PRECISION;
BEGIN
    IF p_attr_type IN ('height', 'weight') THEN
        SELECT mean_value, std_dev, min_value, max_value
        INTO v_mean, v_stddev, v_min, v_max
        FROM distributions
        WHERE locale = p_locale AND attribute = p_attr_type
        LIMIT 1;
        IF v_mean IS NULL THEN
            IF p_attr_type = 'height' THEN
                v_mean := 170.0; v_stddev := 10.0; v_min := 140.0; v_max := 210.0;
            ELSE
                v_mean := 70.0; v_stddev := 15.0; v_min := 40.0; v_max := 150.0;
            END IF;
        END IF;
        v_value := fn_normal_value(p_locale, p_seed, p_batch_index, p_row_index, p_attr_type, v_mean, v_stddev);
        IF v_min IS NOT NULL THEN v_value := GREATEST(v_value, v_min); END IF;
        IF v_max IS NOT NULL THEN v_value := LEAST(v_value, v_max); END IF;
        RETURN ROUND(v_value::numeric, 1)::TEXT;

    ELSIF p_attr_type = 'eye_color' THEN
        SELECT COALESCE(array_agg(id ORDER BY id), ARRAY[]::INTEGER[]),
               COALESCE(array_agg(weight ORDER BY id), ARRAY[]::INTEGER[])
        INTO v_ids, v_weights FROM eye_colors;
        IF v_ids IS NULL OR array_length(v_ids, 1) IS NULL THEN RETURN 'Brown'; END IF;
        v_choice := fn_weighted_choice(p_locale, p_seed, p_batch_index, p_row_index, 'eye_color', v_weights);
        SELECT color INTO v_color FROM eye_colors WHERE id = v_ids[v_choice];
        RETURN COALESCE(v_color, 'Brown');

    ELSIF p_attr_type = 'hair_color' THEN
        SELECT COALESCE(array_agg(id ORDER BY id), ARRAY[]::INTEGER[]),
               COALESCE(array_agg(weight ORDER BY id), ARRAY[]::INTEGER[])
        INTO v_ids, v_weights FROM hair_colors;
        IF v_ids IS NULL OR array_length(v_ids, 1) IS NULL THEN RETURN 'Black'; END IF;
        v_choice := fn_weighted_choice(p_locale, p_seed, p_batch_index, p_row_index, 'hair_color', v_weights);
        SELECT color INTO v_color FROM hair_colors WHERE id = v_ids[v_choice];
        RETURN COALESCE(v_color, 'Black');
    ELSE
        RETURN NULL;
    END IF;
END;
$$;
