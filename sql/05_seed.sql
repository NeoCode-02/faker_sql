-- =============================================================================
-- Faker SQL - Seed Data
-- =============================================================================
-- Large datasets for Uzbek and Russian locales
-- =============================================================================

-- Enable UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =============================================================================
-- Locales
-- =============================================================================

INSERT INTO locales (code, name, country, phone_format, address_format) VALUES
('uz_UZ', 'Uzbekistan', 'Uzbekistan', '+998 {areaCode} {number}', '{street}, {city} {postal}, {country}'),
('ru_RU', 'Russia', 'Russia', '+7 ({areaCode}) {number}', '{street}, {city} {postal}, {country}');

-- =============================================================================
-- Uzbek Names (first, last, middle) - 500+ entries
-- =============================================================================

INSERT INTO names (locale, first_name, last_name, middle_name, gender, weight) VALUES
-- Male names
('uz_UZ', 'Abdulloh', 'Abdullayev', 'Abdullovich', 'M', 10),
('uz_UZ', 'Abdulaziz', 'Abdullayev', 'Abdulazizovich', 'M', 10),
('uz_UZ', 'Abdulhamid', 'Ahmadov', 'Abdulhamidovich', 'M', 9),
('uz_UZ', 'Abdulmalik', 'Karimov', 'Malikovich', 'M', 9),
('uz_UZ', 'Abdulvahob', 'Bahodirov', 'Vahobovich', 'M', 8),
('uz_UZ', 'Akmal', 'Aliev', 'Akmalovich', 'M', 10),
('uz_UZ', 'Akrom', 'Rasulov', 'Akromovich', 'M', 10),
('uz_UZ', 'Alisher', 'Navoiy', 'Alisherovich', 'M', 10),
('uz_UZ', 'Asliddin', 'Eshonqulov', 'Asliddinovich', 'M', 9),
('uz_UZ', 'Bahodir', 'Tojiev', 'Bahodirovich', 'M', 10),
('uz_UZ', 'Botir', 'Quliev', 'Botirovich', 'M', 8),
('uz_UZ', 'Dilshod', 'Abdullayev', 'Dilshodovich', 'M', 10),
('uz_UZ', 'Doniyor', 'Tursunov', 'Doniyorovich', 'M', 9),
('uz_UZ', 'Eldor', 'Shomarudov', 'Eldorovich', 'M', 9),
('uz_UZ', 'Fazliddin', 'Inoyatov', 'Fazliddinovich', 'M', 8),
('uz_UZ', 'Feruz', 'Nazarov', 'Feruzovich', 'M', 9),
('uz_UZ', 'G''anijon', 'G''aniyev', 'G''anijonovich', 'M', 7),
('uz_UZ', 'Halim', 'Halimov', 'Halimovich', 'M', 9),
('uz_UZ', 'Hamid', 'Karimov', 'Hamidovich', 'M', 10),
('uz_UZ', 'Hasan', 'Hayitov', 'Hasanovich', 'M', 10),
('uz_UZ', 'Husan', 'Yusupov', 'Husanovich', 'M', 8),
('uz_UZ', 'Ibrohim', 'Muhammadjonov', 'Ibrohimovich', 'M', 10),
('uz_UZ', 'Ilhom', 'Yusupov', 'Ilhomovich', 'M', 8),
('uz_UZ', 'Islom', 'Samiev', 'Islomovich', 'M', 9),
('uz_UZ', 'Jahongir', 'Tursunov', 'Jahongirovich', 'M', 10),
('uz_UZ', 'Javohir', 'Narziev', 'Javohirovich', 'M', 9),
('uz_UZ', 'Kamol', 'Nazarov', 'Kamolovich', 'M', 10),
('uz_UZ', 'Karim', 'Babaev', 'Karimovich', 'M', 10),
('uz_UZ', 'Kobil', 'Kobilov', 'Kobilovich', 'M', 9),
('uz_UZ', 'Kohin', 'Saidov', 'Kohinovich', 'M', 7),
('uz_UZ', 'Komil', 'Komilov', 'Komilovich', 'M', 10),
('uz_UZ', 'Laziz', 'Laziev', 'Lazizovich', 'M', 9),
('uz_UZ', 'Madamin', 'Madaminov', 'Madaminovich', 'M', 9),
('uz_UZ', 'Mahmud', 'Rahmonov', 'Mahmudovich', 'M', 10),
('uz_UZ', 'Mansur', 'Saidov', 'Mansurovich', 'M', 10),
('uz_UZ', 'Maruf', 'Muminov', 'Marufovich', 'M', 8),
('uz_UZ', 'Muhammad', 'Ali', 'Muhammad', 'M', 10),
('uz_UZ', 'Mukhtor', 'Ataev', 'Mukhtorovich', 'M', 9),
('uz_UZ', 'Nodir', 'Nodirov', 'Nodirovich', 'M', 9),
('uz_UZ', 'Norqobil', 'Tursunov', 'Norqobilovich', 'M', 7),
('uz_UZ', 'Oybek', 'Oybekov', 'Oybekovich', 'M', 10),
('uz_UZ', 'Odil', 'Odilov', 'Odilovich', 'M', 9),
('uz_UZ', 'Otabek', 'Otabekov', 'Otabekovich', 'M', 9),
('uz_UZ', 'Ozod', 'Mansurov', 'Ozodovich', 'M', 9),
('uz_UZ', 'Rahim', 'Rahimov', 'Rahimovich', 'M', 10),
('uz_UZ', 'Rahmon', 'Rahmonov', 'Rahmonovich', 'M', 10),
('uz_UZ', 'Rashid', 'Rashidov', 'Rashidovich', 'M', 9),
('uz_UZ', 'Ravshan', 'Ravshanov', 'Ravshanovich', 'M', 9),
('uz_UZ', 'Rustam', 'Rustamov', 'Rustamovich', 'M', 10),
('uz_UZ', 'Said', 'Saidov', 'Saidovich', 'M', 10),
('uz_UZ', 'Salohiddin', 'Rustamov', 'Salohiddinovich', 'M', 8),
('uz_UZ', 'Samandar', 'Sattorov', 'Samandarovich', 'M', 8),
('uz_UZ', 'Sardor', 'Sattorov', 'Sardorovich', 'M', 10),
('uz_UZ', 'Shahobiddin', 'Shahobiddinov', 'Shahobiddinovich', 'M', 8),
('uz_UZ', 'Shavkat', 'Shavkatov', 'Shavkatovich', 'M', 10),
('uz_UZ', 'Sherzod', 'Sherzodov', 'Sherzodovich', 'M', 10),
('uz_UZ', 'Shoxrux', 'Shoxruxov', 'Shoxruxovich', 'M', 9),
('uz_UZ', 'Siroj', 'Sirojev', 'Sirojovich', 'M', 9),
('uz_UZ', 'Suhrob', 'Suhrobov', 'Suhrobovich', 'M', 9),
('uz_UZ', 'Sunnat', 'Sunnatov', 'Sunnatovich', 'M', 9),
('uz_UZ', 'Ulug''bek', 'Ulug''bekov', 'Ulug''bekovich', 'M', 10),
('uz_UZ', 'Vohid', 'Vohidov', 'Vohidovich', 'M', 9),
('uz_UZ', 'Xurshid', 'Xurshidov', 'Xurshidovich', 'M', 10),
('uz_UZ', 'Yigitali', 'Yigitaliyev', 'Yigitaliievich', 'M', 9),
('uz_UZ', 'Yuldashev', 'Yuldashev', 'Yuldashevich', 'M', 9),
('uz_UZ', 'Yusuf', 'Yusupov', 'Yusufovich', 'M', 10),
('uz_UZ', 'Zafar', 'Zafarov', 'Zafarovich', 'M', 10),
('uz_UZ', 'Ziyod', 'Ziyodov', 'Ziyodovich', 'M', 9),
-- Female names
('uz_UZ', 'Malika', 'Obidova', 'Malikаvna', 'F', 10),
('uz_UZ', 'Gulshan', 'Saidova', 'Gulshanovna', 'F', 10),
('uz_UZ', 'Gulnora', 'Karimova', 'Gulnorayevna', 'F', 10),
('uz_UZ', 'Gulbahor', 'Yusupova', 'Gulbahor qizi', 'F', 9),
('uz_UZ', 'Gulnoz', 'Gulnozova', 'Gulnoz qizi', 'F', 9),
('uz_UZ', 'Nigina', 'Yusupova', 'Negin qizi', 'F', 10),
('uz_UZ', 'Maftuna', 'Saidova', 'Maftuna qizi', 'F', 10),
('uz_UZ', 'Madina', 'Karimova', 'Madina qizi', 'F', 10),
('uz_UZ', 'Maqsuda', 'Rahimova', 'Maqsuda qizi', 'F', 9),
('uz_UZ', 'Marjona', 'Rahmonova', 'Marjona qizi', 'F', 9),
('uz_UZ', 'Munira', 'Alieva', 'Munira qizi', 'F', 10),
('uz_UZ', 'Nilufar', 'Saidova', 'Nilufar qizi', 'F', 10),
('uz_UZ', 'Nodira', 'Tursunova', 'Nodira qizi', 'F', 10),
('uz_UZ', 'Ozoda', 'Rahimova', 'Ozoda qizi', 'F', 10),
('uz_UZ', 'Roxsana', 'Rustamova', 'Roxsana qizi', 'F', 10),
('uz_UZ', 'Sabzamon', 'Eshonqulova', 'Sabzamon qizi', 'F', 9),
('uz_UZ', 'Saida', 'Saidova', 'Saida qizi', 'F', 10),
('uz_UZ', 'Sarvinoz', 'Karimova', 'Sarvinoz qizi', 'F', 10),
('uz_UZ', 'Sevara', 'Bahodirova', 'Sevara qizi', 'F', 10),
('uz_UZ', 'Shahlo', 'Shahloiva', 'Shahlo qizi', 'F', 10),
('uz_UZ', 'Shirin', 'Nazarova', 'Shirin qizi', 'F', 10),
('uz_UZ', 'Sogdiana', 'Inoyatova', 'Sogdiana qizi', 'F', 9),
('uz_UZ', 'Soxibaxon', 'Mansurova', 'Soxibaxon qizi', 'F', 8),
('uz_UZ', 'Surayyo', 'Saidova', 'Surayyo qizi', 'F', 9),
('uz_UZ', 'Tamanna', 'Tursunova', 'Tamanna qizi', 'F', 10),
('uz_UZ', 'Tillashah', 'Inoyatova', 'Tillashah qizi', 'F', 8),
('uz_UZ', 'Umida', 'Eshonqulova', 'Umida qizi', 'F', 10),
('uz_UZ', 'Vasila', 'Karimova', 'Vasila qizi', 'F', 9),
('uz_UZ', 'Zebo', 'Rahimova', 'Zebo qizi', 'F', 9),
('uz_UZ', 'Zuhra', 'Yusupova', 'Zuhra qizi', 'F', 10),
('uz_UZ', 'Zulfiya', 'Saidova', 'Zulfiya qizi', 'F', 10);

-- Add more Uzbek names (generated for scale)
DO $$
DECLARE
    additional_first_m TEXT[] := ARRAY['Azamat', 'Aziz', 'Beko', 'Doston', 'Firdavs', 'Hamza', 'Ismoil', 'Jasur', 'Khujaan', 'Malik', 'Nurzjon', 'Olim', 'Osaid', 'Sokhib', 'Suxrob', 'Tolib', 'Ulug', 'Aziz', 'Bek', 'Diyor', 'Hamid', 'Iskandar', 'Jamol', 'Kahramon', 'Laziz', 'Mansur', 'Nazar', 'Ozod', 'Palon', 'Qahramon', 'Ramazon', 'Sadriddin', 'Tohir', 'Vahdat', 'Xasan', 'Yusufali'];
    additional_last_f TEXT[] := ARRAY['Kamola', 'Dilshod', 'Gulshan', 'Mahbuba', 'Nargiza', 'Ozoda', 'Shahlo', 'Gulshan', 'Zebo', 'Aziza', 'Gulnora', 'Sarvinoz', 'Mukhtabar', 'Nilufar', 'Shirin', 'Sevara', 'Saida', 'Madina', 'Roxsana', 'Munira'];
    additional_last_m TEXT[] := ARRAY['Kamirov', 'Dilshodov', 'G''ofurov', 'Mahmutov', 'Nargizov', 'Ozodov', 'Shahlov', 'G''ulshanov', 'Zebov', 'Azizov', 'Gulnorov', 'Sarvinov', 'Mukhtabarov', 'Nilufarov', 'Shirinov', 'Sevarov', 'Saidov', 'Madinov', 'Roxsanov', 'Munirav'];
    fname TEXT;
    lname TEXT;
    i INT;
BEGIN
    FOR i IN 1..array_length(additional_first_m, 1) LOOP
        fname := additional_first_m[i];
        lname := additional_last_m[((i - 1) % array_length(additional_last_m, 1)) + 1];
        INSERT INTO names (locale, first_name, last_name, gender, weight)
        VALUES ('uz_UZ', fname, lname, 'M', 8)
        ON CONFLICT DO NOTHING;
    END LOOP;
    
    FOR i IN 1..array_length(additional_last_f, 1) LOOP
        fname := additional_last_f[i];
        lname := additional_last_f[i] || 'ova';
        INSERT INTO names (locale, first_name, last_name, gender, weight)
        VALUES ('uz_UZ', fname, lname, 'F', 8)
        ON CONFLICT DO NOTHING;
    END LOOP;
END $$;

-- =============================================================================
-- Russian Names - 500+ entries
-- =============================================================================

INSERT INTO names (locale, first_name, last_name, middle_name, gender, weight) VALUES
-- Male Russian names
('ru_RU', 'Aleksandr', 'Ivanov', 'Aleksandrovich', 'M', 10),
('ru_RU', 'Alexey', 'Petrov', 'Alexeyevich', 'M', 10),
('ru_RU', 'Andrey', 'Smirnov', 'Andreyevich', 'M', 10),
('ru_RU', 'Anton', 'Kuznetsov', 'Antonovich', 'M', 10),
('ru_RU', 'Artem', 'Popov', 'Artemovich', 'M', 10),
('ru_RU', 'Boris', 'Vasiliev', 'Borisovich', 'M', 9),
('ru_RU', 'Bogdan', 'Mikhailov', 'Bogdanovich', 'M', 9),
('ru_RU', 'Vadim', 'Sokolov', 'Vadimovich', 'M', 9),
('ru_RU', 'Valentin', 'Morozov', 'Valentinovich', 'M', 8),
('ru_RU', 'Viktor', 'Fedorov', 'Viktorovich', 'M', 10),
('ru_RU', 'Vladimir', 'Volkov', 'Vladimirovich', 'M', 10),
('ru_RU', 'Vyacheslav', 'Alexeev', 'Vyacheslavovich', 'M', 9),
('ru_RU', 'Gennady', 'Lebedev', 'Gennadievich', 'M', 9),
('ru_RU', 'Georgiy', 'Kozlov', 'Georgievich', 'M', 9),
('ru_RU', 'Grigory', 'Novikov', 'Grigorievich', 'M', 9),
('ru_RU', 'Daniil', 'Nikitin', 'Danielievich', 'M', 10),
('ru_RU', 'Dmitriy', 'Orlov', 'Dmitrievich', 'M', 10),
('ru_RU', 'Evgeny', 'Zaitsev', 'Evgenievich', 'M', 10),
('ru_RU', 'Egor', 'Romanov', 'Egorovich', 'M', 10),
('ru_RU', 'Ivan', 'Makarov', 'Ivanovich', 'M', 10),
('ru_RU', 'Igor', 'Klimov', 'Igorievich', 'M', 9),
('ru_RU', 'Ilya', 'Filanov', 'Ilich', 'M', 10),
('ru_RU', 'Konstantin', 'Kalinin', 'Konstantinovich', 'M', 9),
('ru_RU', 'Kirill', 'Gromov', 'Kirillovich', 'M', 10),
('ru_RU', 'Leonid', 'Borisov', 'Leonidovich', 'M', 9),
('ru_RU', 'Maksim', 'Korsakov', 'Maksimovich', 'M', 10),
('ru_RU', 'Mikhail', 'Sazonov', 'Mikhailovich', 'M', 10),
('ru_RU', 'Nikolay', 'Yakovlev', 'Nikolaevich', 'M', 10),
('ru_RU', 'Oleg', 'Voloshin', 'Olegovich', 'M', 10),
('ru_RU', 'Pavel', 'Tarasov', 'Pavlovich', 'M', 10),
('ru_RU', 'Petr', 'Doronin', 'Petrovich', 'M', 10),
('ru_RU', 'Roman', 'Yermolov', 'Romanovich', 'M', 10),
('ru_RU', 'Sergey', 'Vorobiev', 'Sergeevich', 'M', 10),
('ru_RU', 'Stanislav', 'Malikov', 'Stanislavovich', 'M', 9),
('ru_RU', 'Stepan', 'Goncharov', 'Stepanovich', 'M', 9),
('ru_RU', 'Svyatoslav', 'Kolesnikov', 'Svyatoslavovich', 'M', 8),
('ru_RU', 'Timofey', 'Kovalev', 'Timofeyevich', 'M', 9),
('ru_RU', 'Vitaliy', 'Trofimov', 'Vitalievich', 'M', 9),
('ru_RU', 'Vladislav', 'Samoilov', 'Vladislavovich', 'M', 10),
('ru_RU', 'Yuriy', 'Keldysh', 'Yurievich', 'M', 9),
('ru_RU', 'Yakov', 'Petrov', 'Yakovlevich', 'M', 9),
('ru_RU', 'Yan', 'Sidorov', 'Yanovich', 'M', 9),
('ru_RU', 'Zhenya', 'Malyshev', 'Zhenievich', 'M', 8),
-- Female Russian names
('ru_RU', 'Aleksandra', 'Ivanova', 'Aleksandrovna', 'F', 10),
('ru_RU', 'Alexandra', 'Petrova', 'Alexandrovna', 'F', 10),
('ru_RU', 'Alla', 'Smirnova', 'Alla', 'F', 9),
('ru_RU', 'Alina', 'Kuznetsova', 'Alina', 'F', 10),
('ru_RU', 'Alyona', 'Popova', 'Alyona', 'F', 10),
('ru_RU', 'Angelina', 'Vasilieva', 'Angelina', 'F', 10),
('ru_RU', 'Anna', 'Mikhailova', 'Anna', 'F', 10),
('ru_RU', 'Antonina', 'Sokolova', 'Antonina', 'F', 9),
('ru_RU', 'Asya', 'Morozova', 'Asya', 'F', 9),
('ru_RU', 'Bella', 'Fedorova', 'Bella', 'F', 9),
('ru_RU', 'Bogdana', 'Volkova', 'Bogdana', 'F', 8),
('ru_RU', 'Viktoria', 'Alexeeva', 'Viktoria', 'F', 10),
('ru_RU', 'Galina', 'Lebedeva', 'Galina', 'F', 9),
('ru_RU', 'Daria', 'Kozlova', 'Daria', 'F', 10),
('ru_RU', 'Elena', 'Novikova', 'Elena', 'F', 10),
('ru_RU', 'Elizaveta', 'Orlova', 'Elizaveta', 'F', 10),
('ru_RU', 'Zhanna', 'Zaitseva', 'Zhanna', 'F', 10),
('ru_RU', 'Irina', 'Romanova', 'Irina', 'F', 10),
('ru_RU', 'Kira', 'Makarova', 'Kira', 'F', 9),
('ru_RU', 'Kristina', 'Klimova', 'Kristina', 'F', 10),
('ru_RU', 'Lana', 'Filanova', 'Lana', 'F', 9),
('ru_RU', 'Larisa', 'Kalinina', 'Larisa', 'F', 9),
('ru_RU', 'Lidia', 'Gromova', 'Lidia', 'F', 9),
('ru_RU', 'Lyudmila', 'Borisova', 'Lyudmila', 'F', 10),
('ru_RU', 'Marina', 'Korsakova', 'Marina', 'F', 10),
('ru_RU', 'Maria', 'Sazonova', 'Maria', 'F', 10),
('ru_RU', 'Marta', 'Yakovleva', 'Marta', 'F', 9),
('ru_RU', 'Nadezhda', 'Voloshina', 'Nadezhda', 'F', 10),
('ru_RU', 'Nina', 'Tarasova', 'Nina', 'F', 9),
('ru_RU', 'Olga', 'Doronina', 'Olga', 'F', 10),
('ru_RU', 'Oksana', 'Yermolova', 'Oksana', 'F', 10),
('ru_RU', 'Polina', 'Vorobieva', 'Polina', 'F', 10),
('ru_RU', 'Svetlana', 'Malikova', 'Svetlana', 'F', 10),
('ru_RU', 'Sophia', 'Goncharova', 'Sophia', 'F', 10),
('ru_RU', 'Tatiana', 'Kolesnikova', 'Tatiana', 'F', 10),
('ru_RU', 'Tamara', 'Kovaleva', 'Tamara', 'F', 9),
('ru_RU', 'Taisia', 'Trofimova', 'Taisia', 'F', 9),
('ru_RU', 'Ulyana', 'Samoilova', 'Ulyana', 'F', 10),
('ru_RU', 'Yulia', 'Keldysheva', 'Yulia', 'F', 10);

-- =============================================================================
-- Cities - Uzbek
-- =============================================================================

INSERT INTO cities (locale, city_name, region, country, latitude, longitude, postal_code, weight) VALUES
('uz_UZ', 'Toshkent', 'Toshkent', 'Uzbekistan', 41.2995, 69.2401, '100000', 20),
('uz_UZ', 'Samarkand', 'Samarkand', 'Uzbekistan', 39.6270, 66.9750, '140100', 15),
('uz_UZ', 'Bukhara', 'Bukhara', 'Uzbekistan', 39.7681, 64.4553, '705000', 12),
('uz_UZ', 'Navoi', 'Navoi', 'Uzbekistan', 40.0844, 65.3792, '210400', 8),
('uz_UZ', 'Andijan', 'Andijan', 'Uzbekistan', 40.7826, 72.3438, '170100', 10),
('uz_UZ', 'Fergana', 'Fergana', 'Uzbekistan', 40.3912, 71.7891, '150100', 10),
('uz_UZ', 'Nukus', 'Qoraqalpog''iston', 'Uzbekistan', 42.4603, 59.6101, '230000', 8),
('uz_UZ', 'Qarshi', 'Qashqadaryo', 'Uzbekistan', 38.8692, 65.1790, '180100', 8),
('uz_UZ', 'Guliston', 'Sirdaryo', 'Uzbekistan', 40.6222, 68.7844, '161000', 7),
('uz_UZ', 'Jizzax', 'Jizzax', 'Uzbekistan', 40.1231, 67.8421, '130100', 7),
('uz_UZ', 'Shahrisabz', 'Qashqadaryo', 'Uzbekistan', 39.0542, 66.0419, '181300', 6),
('uz_UZ', 'Termez', 'Surxondaryo', 'Uzbekistan', 37.2242, 67.2719, '190100', 6),
('uz_UZ', 'Kokand', 'Fergana', 'Uzbekistan', 40.5426, 70.9325, '151000', 7),
('uz_UZ', 'Margilan', 'Fergana', 'Uzbekistan', 40.4710, 71.7182, '151100', 6),
('uz_UZ', 'Urgench', 'Xorazm', 'Uzbekistan', 41.5550, 60.6331, '221000', 7),
('uz_UZ', 'Khiva', 'Xorazm', 'Uzbekistan', 41.3783, 60.3637, '221100', 5),
('uz_UZ', 'Angren', 'Toshkent', 'Uzbekistan', 41.0147, 70.0854, '110100', 5),
('uz_UZ', 'Olmaliq', 'Toshkent', 'Uzbekistan', 40.8431, 69.6039, '110200', 6);

-- =============================================================================
-- Cities - Russian (major cities)
-- =============================================================================

INSERT INTO cities (locale, city_name, region, country, latitude, longitude, postal_code, weight) VALUES
('ru_RU', 'Moscow', 'Moscow', 'Russia', 55.7558, 37.6173, '101000', 20),
('ru_RU', 'Saint Petersburg', 'Leningrad', 'Russia', 59.9311, 30.3609, '190000', 15),
('ru_RU', 'Novosibirsk', 'Novosibirsk', 'Russia', 55.0084, 82.9357, '630000', 12),
('ru_RU', 'Yekaterinburg', 'Sverdlovsk', 'Russia', 56.8389, 60.6057, '620000', 10),
('ru_RU', 'Nizhny Novgorod', 'Nizhny Novgorod', 'Russia', 56.2965, 43.9363, '603000', 9),
('ru_RU', 'Kazan', 'Tatarstan', 'Russia', 55.8304, 49.0661, '420000', 9),
('ru_RU', 'Chelyabinsk', 'Chelyabinsk', 'Russia', 55.1644, 61.4368, '454000', 8),
('ru_RU', 'Samara', 'Samara', 'Russia', 53.2028, 50.1428, '443000', 8),
('ru_RU', 'Omsk', 'Omsk', 'Russia', 54.9914, 73.3715, '644000', 7),
('ru_RU', 'Rostov-on-Don', 'Rostov', 'Russia', 47.2220, 39.7203, '344000', 8),
('ru_RU', 'Ufa', 'Bashkortostan', 'Russia', 54.7351, 55.9725, '450000', 7),
('ru_RU', 'Krasnoyarsk', 'Krasnoyarsk', 'Russia', 56.0152, 92.8938, '660000', 7),
('ru_RU', 'Voronezh', 'Voronezh', 'Russia', 51.6720, 39.1843, '394000', 6),
('ru_RU', 'Volgograd', 'Volgograd', 'Russia', 48.7202, 44.5018, '400000', 7),
('ru_RU', 'Krasnodar', 'Krasnodar', 'Russia', 45.0448, 38.9760, '350000', 7),
('ru_RU', 'Saratov', 'Saratov', 'Russia', 51.5331, 45.9588, '410000', 6),
('ru_RU', 'Tyumen', 'Tyumen', 'Russia', 57.1530, 65.5343, '625000', 6),
('ru_RU', 'Tula', 'Tula', 'Russia', 54.1965, 37.6182, '300000', 6),
('ru_RU', 'Kaliningrad', 'Kaliningrad', 'Russia', 54.7104, 20.4626, '236000', 5),
('ru_RU', 'Izhevsk', 'Udmurtia', 'Russia', 56.8518, 53.2052, '426000', 5),
('ru_RU', 'Irkutsk', 'Irkutsk', 'Russia', 52.2865, 104.2192, '664000', 5),
('ru_RU', 'Khabarovsk', 'Khabarovsk', 'Russia', 48.4805, 135.0737, '680000', 5);

-- =============================================================================
-- Streets
-- =============================================================================

INSERT INTO streets (locale, street_name, street_type, weight) VALUES
-- Uzbek streets
('uz_UZ', 'Navoiy', 'ko''chasi', 10),
('uz_UZ', 'Amir Temur', 'yo''li', 10),
('uz_UZ', 'Tashkent', 'ko''chasi', 10),
('uz_UZ', 'Mira', 'ko''chasi', 9),
('uz_UZ', 'Qorasaroy', 'ko''chasi', 9),
('uz_UZ', 'Shota Rustaveli', 'ko''chasi', 8),
('uz_UZ', 'Matbuotchilar', 'ko''chasi', 8),
('uz_UZ', 'Bobur', 'ko''chasi', 10),
('uz_UZ', 'Abdulla Qodiriy', 'ko''chasi', 9),
('uz_UZ', 'Furqat', 'ko''chasi', 9),
('uz_UZ', 'Chorsu', 'ko''chasi', 10),
('uz_UZ', 'Beshagach', 'yo''li', 8),
('uz_UZ', 'Katta Qo''rg''on', 'ko''chasi', 8),
('uz_UZ', 'Qo''yliq', 'ko''chasi', 7),
('uz_UZ', 'Darvoza', 'ko''chasi', 8),
('uz_UZ', 'Oqtepa', 'ko''chasi', 8),
('uz_UZ', 'Yangi Hayot', 'ko''chasi', 7),
('uz_UZ', 'Bog''bon', 'ko''chasi', 7),
('uz_UZ', 'Maksim Gorkiy', 'ko''chasi', 8),
('uz_UZ', 'Pushkin', 'ko''chasi', 9),
-- Russian streets
('ru_RU', 'Lenina', 'улица', 10),
('ru_RU', 'Mira', 'улица', 10),
('ru_RU', 'Oktyabrskaya', 'улица', 10),
('ru_RU', 'Kirov', 'улица', 9),
('ru_RU', 'Gorkogo', 'улица', 9),
('ru_RU', 'Pravdy', 'переулок', 9),
('ru_RU', 'Kommunisticheskaya', 'улица', 10),
('ru_RU', 'Svobody', 'переулок', 8),
('ru_RU', 'Pobedy', 'проспект', 10),
('ru_RU', 'Sovetskaya', 'улица', 10),
('ru_RU', 'Novaya', 'улица', 9),
('ru_RU', 'Zelyonaya', 'улица', 9),
('ru_RU', 'Naberezhnaya', 'набережная', 9),
('ru_RU', 'Pervomayskaya', 'улица', 9),
('ru_RU', 'Sportivnaya', 'улица', 8),
('ru_RU', 'Shkolnaya', 'улица', 8),
('ru_RU', 'Bolnichnaya', 'улица', 8),
('ru_RU', 'Vokzalnaya', 'улица', 9),
('ru_RU', 'Sadovaya', 'улица', 9),
('ru_RU', 'Parkovaya', 'улица', 8);

-- =============================================================================
-- Email domains
-- =============================================================================

INSERT INTO email_domains (locale, domain, weight) VALUES
-- Uzbek domains
('uz_UZ', 'gmail.com', 10),
('uz_UZ', 'yandex.uz', 9),
('uz_UZ', 'mail.ru', 9),
('uz_UZ', 'pochta.uz', 7),
('uz_UZ', 'inbox.uz', 7),
('uz_UZ', 'turkiston.uz', 5),
('uz_UZ', 'samarkand.uz', 5),
('uz_UZ', 'tashkent.uz', 5),
('uz_UZ', 'uznet.uz', 5),
('uz_UZ', 'olam.uz', 4),
-- Russian domains
('ru_RU', 'gmail.com', 10),
('ru_RU', 'yandex.ru', 10),
('ru_RU', 'mail.ru', 10),
('ru_RU', 'rambler.ru', 8),
('ru_RU', 'list.ru', 8),
('ru_RU', 'inbox.ru', 7),
('ru_RU', 'bk.ru', 6),
('ru_RU', 'yandex.com', 5),
('ru_RU', 'google.com', 5),
('ru_RU', 'outlook.com', 5);

-- =============================================================================
-- Phone prefixes
-- =============================================================================

INSERT INTO phone_prefixes (locale, prefix, operator, weight) VALUES
-- Uzbek
('uz_UZ', '+99890', 'Beeline', 10),
('uz_UZ', '+99891', 'Beeline', 8),
('uz_UZ', '+99893', 'UCell', 10),
('uz_UZ', '+99894', 'UCell', 8),
('uz_UZ', '+99895', 'Perfectum', 9),
('uz_UZ', '+99897', 'Perfectum', 8),
('uz_UZ', '+99899', 'Beeline', 7),
-- Russian
('ru_RU', '+7903', 'MTS', 10),
('ru_RU', '+7909', 'MTS', 9),
('ru_RU', '+7910', 'MTS', 8),
('ru_RU', '+7912', 'Megafon', 10),
('ru_RU', '+7919', 'Megafon', 9),
('ru_RU', '+7920', 'Megafon', 8),
('ru_RU', '+7921', 'TELE2', 10),
('ru_RU', '+7922', 'TELE2', 9),
('ru_RU', '+7925', 'TELE2', 8),
('ru_RU', '+7950', 'MTS', 9),
('ru_RU', '+7951', 'MTS', 8);

-- =============================================================================
-- Eye colors
-- =============================================================================

INSERT INTO eye_colors (color, weight) VALUES
('Brown', 10),
('Blue', 8),
('Green', 7),
('Hazel', 6),
('Gray', 5),
('Amber', 4),
('Black', 4);

-- =============================================================================
-- Hair colors
-- =============================================================================

INSERT INTO hair_colors (color, weight) VALUES
('Black', 10),
('Brown', 10),
('Blonde', 8),
('Red', 6),
('Gray', 5),
('White', 4),
('Auburn', 4);

-- =============================================================================
-- Distributions (height/weight)
-- =============================================================================

INSERT INTO distributions (locale, attribute, distribution_type, mean_value, std_dev, min_value, max_value, unit) VALUES
-- Uzbek
('uz_UZ', 'height', 'normal', 170.0, 10.0, 150.0, 200.0, 'cm'),
('uz_UZ', 'weight', 'normal', 70.0, 15.0, 40.0, 120.0, 'kg'),
-- Russian
('ru_RU', 'height', 'normal', 175.0, 10.0, 150.0, 210.0, 'cm'),
('ru_RU', 'weight', 'normal', 75.0, 15.0, 40.0, 130.0, 'kg');

-- =============================================================================
-- Expanded Name Pools: cross-combined for 500+ per locale
-- =============================================================================

DO $$
DECLARE
    -- Uzbek pools
    uz_first_m TEXT[] := ARRAY['Abdumalik','Adham','Akbar','Anvar','Arslon','Aybek','Azamat','Baxtiyor','Behruz','Bekzod','Diyorbek','Elyor','Farhod','Firdavs','Ganjibek','Hikmat','Ikrom','Iskandar','Jamoliddin','Javlon','Kamoliddin','Khurshid','Lutfullo','Mirzo','Murodjon','Nuriddin','Ozodbek','Qudratillo','Rustamjon','Sanjar','Sardorbek','Shahriyor','Temurbek','Ulugbek','Umarjon','Valijon','Xojiakbar','Yigitbek','Zafarbek','Jahongir','Bahrom','Davron','Eshmat','Farrux','Gayrat','Hakim','Jamshid','Kamron','Lazizbek','Muxiddin'];
    uz_last_m TEXT[] := ARRAY['Abdullayev','Akbarov','Aliev','Anvarov','Atajonov','Babakulov','Bahodirov','Berdiev','Boboyorov','Djuraev','Ergashev','Fayzullaev','Gafurov','Hakimov','Hamdamov','Ibragimov','Ismoilov','Juraev','Kamalov','Karimov','Khakimov','Mamatov','Mirzaev','Muhammadiev','Narzullaev','Nuraliev','Omonov','Pulatov','Qosimov','Rajabov','Saidov','Salimov','Shirinov','Tojiev','Tursunov','Umarov','Usmonov','Vohidov','Xolmatov','Yunusov','Yusupov','Zoirov','Toirov','Sobirov','Rahmatov','Qodirov','Polatov','Niyozov','Muradov','Latipov'];
    uz_middle_m TEXT[] := ARRAY['ogli','o''g''li','Abduqodirovich','Akbarovich','Alisherovich','Anvarovich','Bahodirovich','Bekzodovich','Davronovich','Elyorovich','Farhodovich','Ganijonovich','Hikmatovich','Islomovich','Jamolovich','Karimovich','Lutfullоevich','Mirzoievich','Nuriddinovich','Oybekovich','Qudratovich','Rustamovich','Sardorovich','Temurovich','Ulugbekovich'];
    uz_first_f TEXT[] := ARRAY['Aziza','Bahora','Charos','Diyora','Elzoda','Farida','Gulbahor','Hadicha','Iroda','Jamila','Kamilla','Lola','Mahliyo','Nafisa','Odina','Parvina','Qunduz','Rayhona','Sabina','Shaxzoda','Tursunoy','Umida','Vazira','Xosiyat','Yulduz','Zarina','Aziza','Bibisora','Dilnoza','Farangiz','Gulrux','Hulkar','Iroda','Javohira','Kamola','Latofat','Malohat','Nargiza','Oygul','Parvona','Qamariddinxon','Robiya','Salima','Tamila','Vasila','Xolida','Yorqinoy','Zebuniso','Aziza','Bahtiyoroy'];
    uz_last_f TEXT[] := ARRAY['Abdullayeva','Akbarova','Aliyeva','Anvarova','Atajonova','Babakulova','Bahodirova','Berdieva','Boboyorova','Djuraeva','Ergasheva','Fayzullayeva','Gafurova','Hakimova','Hamdamova','Ibragimova','Ismoilova','Juraeva','Kamalova','Karimova','Khakimova','Mamatova','Mirzaeva','Muhammadieva','Narzullayeva','Nuraliyeva','Omonova','Pulatova','Qosimova','Rajabova','Saidova','Salimova','Shirinova','Tojieva','Tursunova','Umarova','Usmonova','Vohidova','Xolmatova','Yunusova','Yusupova','Zoirova','Toirova','Sobirova','Rahmatova','Qodirova','Polatova','Niyozova','Muradova','Latipova'];
    uz_middle_f TEXT[] := ARRAY['qizi','Abduqodirovna','Akbarovna','Alisherovna','Anvarovna','Bahodirovna','Bekzodovna','Davronovna','Elyorovna','Farhodovna','Ganijonovna','Hikmatovna','Islomovna','Jamolovna','Karimovna','Mirzoievna','Nuriddinovna','Oybekovna','Qudratovna','Rustamovna','Sardorovna','Temurovna','Ulugbekovna','Zafarovna','Xurshidovna'];
    -- Russian pools
    ru_first_m TEXT[] := ARRAY['Artur','Bogdan','Vsevolod','Gavriil','Denis','Yaroslav','Zakhar','Innokenty','Lev','Makar','Miron','Nazar','Platon','Rodion','Savva','Timur','Fedor','Fyodor','Philipp','Eduard','Erik','Arkady','Vitaliy','Gleb','German','Yefim','Zinovy','Ippolit','Yulian','Klim','Lavrenty','Mark','Matvey','Naum','Orest','Prokhor','Radion','Ruslan','Semyon','Taras','Trofim','Ustin','Feofan','Khariton','Tsezar','Eduard','Yury','Yan','Valeriy','Avgust'];
    ru_last_m TEXT[] := ARRAY['Abramov','Afanasiev','Belyaev','Bogdanov','Bystrov','Vinogradov','Voronin','Golubev','Gurov','Denisov','Dorofeev','Ershov','Zhdanov','Ignatov','Isaev','Kazakov','Kalashnikov','Kiselev','Kolobov','Kornilov','Krylov','Kuznetsov','Lapin','Larin','Lukin','Maksimov','Medvedev','Melnikov','Muromtsev','Nazarov','Nosov','Odintsov','Osipov','Pavlov','Panov','Polyakov','Prokhorov','Raskolnikov','Rodin','Rumyantsev','Savelyev','Selivanov','Sergeev','Sidorov','Silin','Sobolev','Stepanov','Subbotin','Tikhonov','Timofeev'];
    ru_middle_m TEXT[] := ARRAY['Aleksandrovich','Alekseevich','Anatolievich','Andreyevich','Arkadyevich','Borisovich','Vadimovich','Valentinovich','Viktorovich','Vladimirovich','Vyacheslavovich','Gennadievich','Georgievich','Grigorievich','Danilovich','Denisovich','Dmitrievich','Evgenievich','Egorovich','Ivanovich','Igorevich','Ilyich','Kirillovich','Konstantinovich','Leonidovich'];
    ru_first_f TEXT[] := ARRAY['Agata','Albina','Valentina','Vera','Veronika','Vladlena','Gelena','Dinara','Evdokia','Evgenia','Zinaida','Zoya','Inna','Inga','Iya','Kapitolina','Karina','Klara','Ksenia','Lyubov','Lyudmila','Margarita','Melania','Miroslava','Nadezhda','Natalia','Nika','Oktyabrina','Pelageya','Rada','Raisa','Regina','Rimma','Roza','Ruslana','Sofia','Stanislava','Stella','Taisia','Feodora','Khristina','Eleonora','Elvira','Emilia','Yuna','Yaroslava','Alyona','Anfisa','Bogdana','Varvara'];
    ru_last_f TEXT[] := ARRAY['Abramova','Afanasieva','Belyaeva','Bogdanova','Bystrova','Vinogradova','Voronina','Golubeva','Gurova','Denisova','Dorofeeva','Ershova','Zhdanova','Ignatova','Isaeva','Kazakova','Kalashnikova','Kiseleva','Kolobova','Kornilova','Krylova','Kuznetsova','Lapina','Larina','Lukina','Maksimova','Medvedeva','Melnikova','Muromtseva','Nazarova','Nosova','Odintsova','Osipova','Pavlova','Panova','Polyakova','Prokhorova','Rodina','Rumyantseva','Savelyeva','Selivanova','Sergeeva','Sidorova','Silina','Soboleva','Stepanova','Subbotina','Tikhonova','Timofeeva','Ulyanova'];
    ru_middle_f TEXT[] := ARRAY['Aleksandrovna','Alekseevna','Anatolievna','Andreyevna','Arkadyevna','Borisovna','Vadimovna','Valentinovna','Viktorovna','Vladimirovna','Vyacheslavovna','Gennadievna','Georgievna','Grigorievna','Danilovna','Denisovna','Dmitrievna','Evgenievna','Egorovna','Ivanovna','Igorevna','Ilichna','Kirillovna','Konstantinovna','Leonidovna'];
    i INT; j INT;
BEGIN
    -- Uzbek male: 50 x 12 = 600 combos (filtered by conflict)
    FOR i IN 1..array_length(uz_first_m, 1) LOOP
        FOR j IN 1..12 LOOP
            INSERT INTO names (locale, first_name, last_name, middle_name, gender, weight)
            VALUES ('uz_UZ', uz_first_m[i], uz_last_m[((i+j) % array_length(uz_last_m,1))+1], uz_middle_m[((i*j) % array_length(uz_middle_m,1))+1], 'M', 5 + ((i+j) % 6))
            ON CONFLICT DO NOTHING;
        END LOOP;
    END LOOP;
    -- Uzbek female
    FOR i IN 1..array_length(uz_first_f, 1) LOOP
        FOR j IN 1..12 LOOP
            INSERT INTO names (locale, first_name, last_name, middle_name, gender, weight)
            VALUES ('uz_UZ', uz_first_f[i], uz_last_f[((i+j) % array_length(uz_last_f,1))+1], uz_middle_f[((i*j) % array_length(uz_middle_f,1))+1], 'F', 5 + ((i+j) % 6))
            ON CONFLICT DO NOTHING;
        END LOOP;
    END LOOP;
    -- Russian male
    FOR i IN 1..array_length(ru_first_m, 1) LOOP
        FOR j IN 1..12 LOOP
            INSERT INTO names (locale, first_name, last_name, middle_name, gender, weight)
            VALUES ('ru_RU', ru_first_m[i], ru_last_m[((i+j) % array_length(ru_last_m,1))+1], ru_middle_m[((i*j) % array_length(ru_middle_m,1))+1], 'M', 5 + ((i+j) % 6))
            ON CONFLICT DO NOTHING;
        END LOOP;
    END LOOP;
    -- Russian female
    FOR i IN 1..array_length(ru_first_f, 1) LOOP
        FOR j IN 1..12 LOOP
            INSERT INTO names (locale, first_name, last_name, middle_name, gender, weight)
            VALUES ('ru_RU', ru_first_f[i], ru_last_f[((i+j) % array_length(ru_last_f,1))+1], ru_middle_f[((i*j) % array_length(ru_middle_f,1))+1], 'F', 5 + ((i+j) % 6))
            ON CONFLICT DO NOTHING;
        END LOOP;
    END LOOP;
END $$;

-- =============================================================================
-- Expanded Streets Pool (more variety per locale)
-- =============================================================================

DO $$
DECLARE
    uz_streets TEXT[] := ARRAY['Mustaqillik','Istiqlol','Buyuk Ipak Yoli','Yunusobod','Mirzo Ulug''bek','Sharof Rashidov','Islom Karimov','Zulfiyaxonim','Oybek','Hamid Olimjon','Shayx Zayniddin','Labzak','Xadra','Ozbekiston','Katta Darxon','Alisher Navoiy','Abay','Abror','Afrosiyob','Arpapoya','Buyuk Turon','Chimboy','Dorboz','Farg''ona','Gagarin','Hazrati Imom','Ibn Sino','Kichik Halqa','Mingchinor','Oltin Vodiy','Paxtachi','Qibray','Rabg''uziy','Sebzor','Tolariq','Uchquduq','Yangiyo''l'];
    uz_types TEXT[] := ARRAY['ko''chasi','yo''li','shoh ko''chasi','tor ko''chasi','xiyoboni'];
    ru_streets TEXT[] := ARRAY['Tverskaya','Arbat','Neglinnaya','Nikolskaya','Bolshaya Ordynka','Pyatnitskaya','Volkhonka','Prechistenka','Ostozhenka','Solyanka','Maroseyka','Pokrovka','Chistye Prudy','Nevsky','Liteyny','Sadovaya','Bolshaya Morskaya','Moika','Fontanka','Vasilievsky','Petrogradskaya','Konnogvardeysky','Bakunina','Chernyshevskogo','Molodyozhnaya','Stroiteley','Geroev','Profsoyuznaya','Kosmonavtov','Chaykovskogo','Lermontova','Tolstogo','Chekhova','Dostoevskogo','Pushkina','Turgeneva','Gogolya','Fadeeva','Mayakovskogo'];
    ru_types TEXT[] := ARRAY['улица','проспект','переулок','набережная','площадь','бульвар','шоссе'];
    i INT; j INT;
BEGIN
    FOR i IN 1..array_length(uz_streets, 1) LOOP
        FOR j IN 1..array_length(uz_types, 1) LOOP
            INSERT INTO streets (locale, street_name, street_type, weight)
            VALUES ('uz_UZ', uz_streets[i], uz_types[j], 5 + ((i+j) % 5))
            ON CONFLICT DO NOTHING;
        END LOOP;
    END LOOP;
    FOR i IN 1..array_length(ru_streets, 1) LOOP
        FOR j IN 1..array_length(ru_types, 1) LOOP
            INSERT INTO streets (locale, street_name, street_type, weight)
            VALUES ('ru_RU', ru_streets[i], ru_types[j], 5 + ((i+j) % 5))
            ON CONFLICT DO NOTHING;
        END LOOP;
    END LOOP;
END $$;