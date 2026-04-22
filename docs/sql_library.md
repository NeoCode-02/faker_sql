# Faker SQL — Library Documentation

This is a small Faker library I wrote as PostgreSQL stored functions. You call a function and get fake user data back. I made everything deterministic, so the same inputs always give the same output. It works for two locales right now: `uz_UZ` and `ru_RU`.

---

## fn_hash_to_int(input)

This is my source of randomness. I take the text input, run SHA256 on it, grab the first 8 bytes, and pack them into a 64-bit integer. SHA256 gives a uniform output, so any 8 bytes of it are good enough as a random number. I also clear the top bit so the result never comes out negative, which would break the `%` operator later.

---

## fn_random_int(locale, seed, batch_index, row_index, key, min, max)

I needed a way to turn the inputs into a number in a range. So I build a single string `locale|seed|batch_index|row_index|key`, hash it with `fn_hash_to_int`, and do `min + (hash % (max - min + 1))`. The `key` is how I keep different fields from correlating — for example I pass `'first_name'` and `'last_name'` as keys so those two picks stay independent inside the same row.

---

## fn_random_float(locale, seed, batch_index, row_index, key)

Same idea as the integer version, but I want a value in `[0, 1)`. I take the hash and compute `(hash % 10^9) / 10^9`. Nine digits of precision is plenty for what I use it for (Box-Muller, weighted choice, sphere sampling).

---

## fn_weighted_choice(locale, seed, batch_index, row_index, key, weights)

I used this when some options should be picked more often than others, like Tashkent appearing more than a small town. I sum all the weights, then pick a random float in `[0, total)`, and walk through the weights with a running sum until it passes that number. The probability of each index ends up being `weights[i] / total`.

---

## fn_normal_value(locale, seed, batch_index, row_index, key, mean, stddev)

For things like height and weight I couldn't use uniform randomness, because real people cluster around an average. So I used the Box-Muller formula:

```
z = sqrt(-2 * ln(u1)) * cos(2 * pi * u2)
```

`u1` and `u2` are two uniform floats I get from `fn_random_float` with different keys. `z` comes out standard normal (mean 0, stddev 1), and then I shift and scale it: `mean + z * stddev`. I also clamp `u1` to at least `1e-9` so `ln(u1)` doesn't blow up near zero.

---

## fn_uniform_sphere_point(locale, seed, batch_index, row_index, key)

For random geolocation I couldn't just pick uniform latitude and longitude, because that bunches points near the poles (circles of latitude get smaller as you go up). Instead I pick the vertical coordinate `z` uniformly in `[-1, 1]` and the angle `theta` uniformly in `[0, 2π)`, then convert back:

```
latitude  = asin(z)     * 180 / π
longitude = (theta - π) * 180 / π
```

Using `asin(z)` instead of a uniform latitude is what gives every patch of the sphere equal probability.

---

## fn_generate_name(locale, seed, batch_index, row_index, format_type)

I wanted names with some variation, so I pick the gender 50/50 first, then pull all rows in `names` matching that gender and locale. I use `fn_weighted_choice` twice — once for the first name, once for the last name — with different keys so the pair varies naturally. With 50% chance I add a middle name (picked only from rows where `middle_name` is not null), and with 33% chance I prepend `Mr.` or `Ms.`. Finally I glue it together using one of five patterns based on `format_type`:

| format_type | Pattern |
|-------------|---------|
| 0 | `First Last` |
| 1 | `Title First Last` |
| 2 | `First Middle Last` |
| 3 | `Title First Middle Last` |
| 4 | `Last, First` |

---

## fn_generate_address(locale, seed, batch_index, row_index, format_type)

Weighted pick of a city and a street for the locale. Building number is just `fn_random_int` in 1–200. With 80% chance I also add `, Apt N` where `N` is 1–100. Then I put everything together in one of three patterns:

| format_type | Pattern |
|-------------|---------|
| 0 | `Street Type Number, City Postal, Country` |
| 1 | `Number Street Type, City, Region Postal` |
| 2 | `City, Region, Street Number` |

---

## fn_generate_phone(locale, seed, batch_index, row_index, format_type)

I pick a prefix from `phone_prefixes` with weighted choice so bigger operators come up more often. Then I generate a 7-digit subscriber number with `fn_random_int`, zero-padded. Three formats:

| format_type | Example |
|-------------|---------|
| 0 | `+998 123-45-67` |
| 1 | `+998 (123) 4567` |
| 2 | `+9981234567` |

---

## fn_generate_email(locale, full_name, seed, batch_index, row_index, format_type)

I take the full name that was already generated, split it on spaces, drop commas and dots, grab the first token as the first name and the last token as the last name, lowercase them, and strip anything that isn't a letter or digit. Then I pick a domain with weighted choice and combine like this:

| format_type | Pattern |
|-------------|---------|
| 0 | `first.last@domain` |
| 1 | `firstlast@domain` |
| 2 | `first_last@domain` |
| 3 | `firstlast42@domain` (random 2-digit suffix) |
| 4 | `first.last42@domain` |

---

## fn_generate_physical(locale, seed, batch_index, row_index, attr_type)

One function, three outputs. For `height` and `weight` I read the mean, stddev, min and max from the `distributions` table, call `fn_normal_value`, and clamp the result to the `[min, max]` range so I don't get something like a 3-metre-tall person. For `eye_color` I use weighted choice over the `eye_colors` lookup table.

---

## sp_generate_fake_users(locale, seed, batch_index, batch_size)

This is the one the app actually calls. It loops `batch_size` times and for each row calls every generator above. For each row the format type of the name, address, phone and email is itself picked from the hash with `fn_random_int`, so the output looks varied without the caller having to pass format numbers. The function returns a table with these columns:

| Column | Type |
|--------|------|
| `row_index` | INTEGER |
| `full_name` | TEXT |
| `address` | TEXT |
| `latitude` | DOUBLE PRECISION |
| `longitude` | DOUBLE PRECISION |
| `height` | TEXT (cm) |
| `weight` | TEXT (kg) |
| `eye_color` | TEXT |
| `phone` | TEXT |
| `email` | TEXT |
