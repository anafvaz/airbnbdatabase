CREATE DATABASE airbnb;
USE airbnb;
CREATE TABLE host (
	host_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    sarted_hosting DATE);
    
SELECT * FROM host;     

CREATE TABLE guest (
	guest_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE);
    
SELECT * FROM guest;

CREATE TABLE administration (
	admin_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    job_position VARCHAR(100));
    
SELECT * FROM administration;

CREATE TABLE user (
	user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    admin_id INT NOT NULL, 
    FOREIGN KEY (admin_id) REFERENCES administration(admin_id),
    guest_id INT NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id),
    host_id INT NOT NULL,
    FOREIGN KEY (host_id) REFERENCES host(host_id));
    
ALTER TABLE user
	MODIFY admin_id INT,
	MODIFY guest_id INT,
	MODIFY host_id INT;


CREATE TABLE language (
	language_id INT PRIMARY KEY AUTO_INCREMENT,
    laguage_name VARCHAR(50));

CREATE TABLE user_languages (
	user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    language_id INT NOT NULL,
    FOREIGN KEY (language_id) REFERENCES language(language_id));
    
CREATE TABLE country (
	country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL);
    
CREATE TABLE city (
	city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL);
    
CREATE TABLE property (
	property_id INT PRIMARY KEY AUTO_INCREMENT,
    num_guests INT NOT NULL,
    num_bedrooms INT NOT NULL,
    num_beds INT NOT NULL,
    num_baths INT NOT NULL,
    description TEXT NOT NULL,
    nightly_price DECIMAL(8,2) NOT NULL,
    address VARCHAR(250) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    host_id INT NOT NULL,
    FOREIGN KEY (host_id) REFERENCES host(host_id),
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    city_id INT NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(city_id));

CREATE TABLE photos (
	photo_id INT PRIMARY KEY AUTO_INCREMENT,
    photo_url VARCHAR(250) NOT NULL,
    property_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(property_id));
    
ALTER TABLE photos
	MODIFY photo_url VARCHAR(1500);
    
CREATE TABLE category (
	category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL);
    
CREATE TABLE property_category (
	property_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(property_id),
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(category_id));

CREATE TABLE amenities (
	amenities_id INT PRIMARY KEY AUTO_INCREMENT,
    wifi BOOLEAN DEFAULT FALSE,
    tv BOOLEAN DEFAULT FALSE,
    pet_friendly BOOLEAN DEFAULT FALSE,
    equipped_kitchen BOOLEAN DEFAULT FALSE,
    free_parking BOOLEAN DEFAULT FALSE,
    laundry BOOLEAN DEFAULT FALSE,
    swimming_pool BOOLEAN DEFAULT FALSE,
    hot_tub BOOLEAN DEFAULT FALSE,
    ac BOOLEAN DEFAULT FALSE,
    heating BOOLEAN DEFAULT FALSE,
    private_entrance BOOLEAN DEFAULT FALSE,
    balcony_patio BOOLEAN DEFAULT FALSE);
    
CREATE TABLE property_amenities (
	property_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(property_id),
    amenities_id INT NOT NULL,
    FOREIGN KEY (amenities_id) REFERENCES amenities(amenities_id));
    
CREATE TABLE review (
	review_id INT PRIMARY KEY AUTO_INCREMENT,
    overall_rating INT NOT NULL, 
	cleanliness INT NOT NULL,
    accuracy INT NOT NULL,
    check_in INT NOT NULL,
    communication INT NOT NULL,
    location INT NOT NULL,
    value INT NOT NULL,
    comment TEXT,
    property_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(property_id),
    guest_id INT NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id));
    
CREATE TABLE wishlist (
	property_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(property_id),
    guest_id INT NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id));

CREATE TABLE message (
	message_id INT PRIMARY KEY AUTO_INCREMENT,
    message TEXT,
    date_time DATETIME,
    guest_id INT NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id),
    host_id INT NOT NULL,
    FOREIGN KEY (host_id) REFERENCES host(host_id));
    
CREATE TABLE review_history (
	id INT PRIMARY KEY AUTO_INCREMENT,
    review_rating INT NOT NULL,
    review_date DATE,
    guest_id INT NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id));
    
CREATE TABLE reservation_history (
	reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_date DATE,
    guest_id INT NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id));
    
CREATE TABLE payment (
	payment_id INT PRIMARY KEY AUTO_INCREMENT,
    payment_amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    payment_satus VARCHAR(100) NOT NULL);

ALTER TABLE payment
	RENAME COLUMN payment_satus TO payment_status;

CREATE TABLE booking (
	booking_id INT PRIMARY KEY AUTO_INCREMENT,
    num_adult INT NOT NULL,
    num_childen INT NOT NULL,
    num_infant INT NOT NULL,
    num_pet INT NOT NULL,
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    nightly_price DECIMAL(8,2) NOT NULL,
    service_fee DECIMAL(6,2) NOT NULL,
    cleaning_fee DECIMAL(6,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    booking_satus VARCHAR(100) NOT NULL,
    guest_id INT NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES guest(guest_id),
    host_id INT NOT NULL,
    FOREIGN KEY (host_id) REFERENCES host(host_id),
    payment_id INT NOT NULL,
    FOREIGN KEY (payment_id) REFERENCES payment(payment_id));
    
ALTER TABLE booking
	RENAME COLUMN num_childen TO num_children,
    RENAME COLUMN booking_satus TO booking_status;

CREATE TABLE rules (
	rule_id INT PRIMARY KEY AUTO_INCREMENT,
    rule_title VARCHAR(250) NOT NULL,
    rule_description TEXT);
    
CREATE TABLE property_rule (
	property_id INT NOT NULL,
    FOREIGN KEY (property_id) REFERENCES property(property_id),
	rule_id INT NOT NULL,
    FOREIGN KEY (rule_id) REFERENCES rules(rule_id));



INSERT INTO host (first_name, last_name, date_of_birth, sarted_hosting)
VALUES
	('John', 'Doe', '1990-05-15', '2022-03-20'),
    ('Jane', 'Smith', '1985-12-10', '2019-01-05'),
    ('Bob', 'Johnson', '1978-09-25', '2021-06-12'),
    ('Alice', 'Williams', '1992-04-18', '2017-11-30'),
    ('Ana', 'Vaz', '1996-08-16', '2023-05-18'),
    ('Eva', 'Silva', '1996-02-22', '2019-07-03'),
    ('Frank', 'Miller', '2000-11-14', '2024-02-10'),
    ('Grace', 'Jones', '1988-06-05', '2016-08-22'),
    ('Henry', 'Wilson', '1993-09-30', '2020-12-08'),
    ('Isabel', 'Clark', '1982-03-12', '2018-04-25'),
    ('James', 'Moore', '1975-08-28', '2017-06-18'),
    ('Alex', 'Buck', '1993-10-31', '2019-09-09'),
    ('Olie', 'Anderson', '1984-04-02', '2021-05-14'),
    ('Mia', 'Martinez', '1987-07-19', '2018-11-28'),
    ('Nathan', 'Young', '1990-12-08', '2016-12-05'),
    ('Olivia', 'Harris', '1986-05-04', '2020-04-02'),
    ('Patrick', 'Lee', '1994-10-23', '2019-03-17'),
    ('Quinn', 'Taylor', '1979-02-09', '2020-10-30'),
    ('Rachel', 'White', '1991-06-26', '2018-07-07'),
    ('Samuel', 'Adams', '1983-09-12', '2017-02-14');
    
SELECT * FROM host;

INSERT INTO administration (first_name, last_name, job_position)
VALUES
	('Isabella', 'Young', 'Coordinator'),
    ('Noah', 'King', 'Manager'),
    ('Sophie', 'Cooper', 'Supervisor'),
    ('Michael', 'Hill', 'Analyst'),
    ('Ava', 'Barnes', 'Developer'),
    ('Ethan', 'Perez', 'Director'),
    ('Chloe', 'Fisher', 'Specialist'),
    ('Logan', 'Bell', 'Consultant'),
    ('Mia', 'Martin', 'Assistant'),
    ('William', 'Carter', 'Coordinator'),
    ('Emma', 'Smith', 'Manager'),
    ('Liam', 'Turner', 'Analyst'),
    ('Olivia', 'Clark', 'Supervisor'),
    ('Lucas', 'Ward', 'Developer'),
    ('Sophia', 'Parker', 'Consultant'),
    ('Jackson', 'Reed', 'Coordinator'),
    ('Grace', 'Baker', 'Manager'),
    ('Henry', 'Fisher', 'Analyst'),
    ('Ella', 'Miller', 'Director'),
    ('Benjamin', 'Hill', 'Assistant');


INSERT INTO guest (first_name, last_name, date_of_birth)
VALUES 
	('Kelly', 'Devine', '2000-07-15'),
    ('Olivia', 'Williams', '1985-04-22'),
    ('Noah', 'Brown', '1992-11-30'),
    ('Emma', 'Jones', '1987-07-10'),
    ('Ava', 'Davis', '1994-03-18'),
    ('Lucas', 'Martinez', '1988-09-25'),
    ('Sophia', 'Rodriguez', '1991-06-05'),
    ('Marley', 'Santos', '1999-02-12'),
    ('Isabella', 'Garcia', '1993-10-28'),
    ('Liam', 'Jackson', '1989-01-15'),
    ('Olivia', 'Smith', '1995-05-20'),
    ('Noah', 'Johnson', '1983-12-08'),
    ('Emma', 'Taylor', '1996-07-03'),
    ('Lucas', 'Anderson', '1984-04-17'),
    ('Sophia', 'Vergara', '1997-09-14'),
    ('Jackson', 'Perez', '1982-06-30'),
    ('Anna', 'Clark', '1998-02-22'),
    ('Ethan', 'Moore', '1981-11-10'),
    ('Amelia', 'Lopez', '1999-08-05'),
    ('Liam', 'Martin', '1985-03-25');
    
    
INSERT INTO user (email, password, admin_id, guest_id, host_id)
VALUES 
	('kellydevine@gmail.com', 'kelly02947', NULL, 1, NULL),
    ('sophie123@hotmail.com', 'rodrisoph692', NULL, 7, NULL),
    ('boby.jo@gmail,com', 'dancenow78', NULL, NULL, 3),
    ('isabellayoung@company.ca', 'bellacord96', 1, NULL, NULL),
    ('sam83@outlook.com', 'sam3624146', NULL, NULL, 20),
    ('emmat@gmail.com', 'tosh99e', NULL, 13, NULL),
    ('alexbuck@hotmail.com', 'gatinho93',NULL, NULL, 12),
    ('ellam@company.ca', 'trofydirect69', 19, NULL, NULL), 
    ('anafilipa@gmail.com', 'pipinha16', NULL, NULL, 5),
    ('michaelhill@company.ca', 'mike562132', 4, NULL, NULL),
    ('loganbell@company.ca', 'complog48', 8, NULL, NULL),
    ('marley99@outlook.com', 'marleyandi99',NULL, 8, NULL),
    ('janeandsmith@hotmail.com', 'smith12jan85', NULL, NULL, 2),
    ('sophieverg@hotmail.com', 'vergsoph8430', NULL, 15, NULL),
    ('doejohnny@gmail.com', 'dove3375', NULL, NULL, 1), 
    ('benhill@company.ca', 'hamburger99', 20, NULL, NULL),
    ('noahk@company.ca', 'kingmang1608', 2, NULL, NULL),
    ('whiter@gmail.com', 'snowwhite35', NULL, NULL, 19),
    ('mar1985@outlook.com', 'sealion85', NULL, 20, NULL);
    

INSERT INTO user (email, password, admin_id, guest_id, host_id)
VALUES ('sophiec@company.ca', 'miniecooper43', 3, NULL, NULL);

SELECT * FROM user;

INSERT INTO city (city_name)
VALUES 
	('Vancouver'),
    ('Toronto'),
    ('Montreal'),
    ('Victoria'),
    ('Halifax'),
    ('Seattle'),
    ('Phoenix'),
    ('San Diego'),
    ('Los Angeles'),
    ('Chicago'),
    ('London'),
    ('Brighton'),
    ('Bristol'),
    ('York'),
    ('Birmingham'),
    ('Berlin'),
    ('Munich'),
    ('Hamburg'),
    ('Stuttgart'),
    ('Frankfurt');
    
INSERT INTO country (country_name)
VALUES 
	('United States'),
    ('United Kingdom'),
    ('Canada'),
    ('Australia'),
    ('Germany'),
    ('France'),
    ('Italy'),
    ('Spain'),
    ('Japan'),
    ('China'),
    ('India'),
    ('Brazil'),
    ('Mexico'),
    ('South Africa'),
    ('Russia'),
    ('South Korea'),
    ('Argentina'),
    ('Sweden'),
    ('Norway'),
    ('Netherlands');
    
INSERT INTO amenities (wifi, tv, pet_friendly, equipped_kitchen, free_parking, laundry, swimming_pool, hot_tub, ac, heating, private_entrance, balcony_patio)
VALUES
	(1,1,0,1,0,1,0,0,1,1,1,0),
    (1,0,1,1,1,1,0,0,0,1,1,0),
    (0,1,0,0,0,1,0,0,1,1,0,0),
    (1,0,1,1,1,1,0,1,1,1,1,1),
    (1,1,1,1,1,1,0,1,0,0,1,1),
    (1,0,1,0,1,1,0,0,0,0,1,1),
    (1,1,0,1,0,1,0,0,1,1,1,0),
    (1,1,1,1,1,1,1,1,1,1,1,0),
    (1,1,0,1,0,1,0,1,1,1,1,1),
    (1,0,0,1,0,1,0,0,0,0,1,0),
    (1,0,0,0,0,0,0,0,1,1,0,0),
    (1,1,0,1,0,1,0,0,1,1,1,1),
    (0,0,0,0,0,1,0,0,1,1,1,0),
    (1,1,0,1,0,1,0,0,1,1,1,0),
    (1,1,1,1,0,0,1,0,1,1,1,1),
    (0,1,0,0,0,0,0,0,1,1,0,0),
    (1,1,0,1,1,1,0,1,1,1,1,1),
    (0,1,0,0,0,1,0,0,1,1,1,0),
    (1,1,1,0,0,1,0,0,0,0,1,1),
    (1,0,0,1,0,0,0,0,0,1,1,0);
    
INSERT INTO category (category_name)
VALUES
	('Beach'),
    ('Amazing Views'),
    ('Lake'),
    ('Rooms'),
    ('Cabins'),
    ('Beachfront'),
    ('Boats'),
    ('Castles'),
    ('Mansions'),
    ('Amazing pools'),
    ('Tiny homes'),
    ('New'),
    ('Trending'),
    ('Design'),
    ('Lakefront'),
    ('Surfing'),
    ('Camping'),
    ('Farms'),
    ('Vineyards'),
    ('Golfing');
    

INSERT INTO language (laguage_name)
VALUES 
	('English'),
    ('Spanish'),
    ('French'),
    ('German'),
    ('Chinese'),
    ('Japanese'),
    ('Russian'),
    ('Italian'),
    ('Portuguese'),
    ('Arabic'),
    ('Hindi'),
    ('Korean'),
    ('Dutch'),
    ('Swedish'),
    ('Turkish'),
    ('Indonesian'),
    ('Greek'),
    ('Polish'),
    ('Czech'),
    ('Thai');

INSERT INTO message (message, date_time, guest_id, host_id)
VALUES 
	('Hello, What time is the checkin?', '2023-01-23', 1, 4),
    ('Hi, The latest check in is at 4pm. Would that work for you?', '2023-01-24', 1, 4),
    ('Can I please cancel the reservation?', '2022-07-16', 3, 20),
    ('Good morning. Would it be possible to change the dates of the reservation?', '2024-01-04', 19, 1),
    ('Hi, cancellations need at least 24h notice.', '2024-01-04', 19, 1),
    ('Thanks for you help!', '2024-1-07', 20, 8),
    ('Pleas give me a call on my phone.', '2022-04-29', 10, 1),
	('Hi, what time is the latest check out?','2023-12-23', 7, 4),
    ('Everything was great! Thanks.', '2020-07-19', 4, 12),
    ('Hello. Please cancel my reservation. Thanks!', '2021-11-12', 9, 17),
    ('I have cancelled the reservation. Thanks.', '2021-11-13', 9, 17),
    ('Thanks! Have a good day.', '2021-11-13', 9, 17), 
    ('Hi. Can I please have a refund of my money?', '2024-02-25', 19, 7),
    ('Please contact administration.', '2024-02-26', 19, 7), 
    ('We had a great time, thanks!', '2019-12-12', 5, 2),
    ('Hello, What time is the checkin?', '2019-12-12', 5, 2),
    ('Can I please cancel the reservation?', '2022-08-16', 6, 2),
    ('Thanks for you help!', '2024-1-07', 6, 8),
    ('Hello, cancellations needs at least 24h notice.', '2024-02-20', 1, 1),
    ('No, thanks!', '2018-12-23', 20, 19);
    
INSERT INTO property (num_guests, num_bedrooms, num_beds, num_baths, description, nightly_price, address, postal_code, host_id, country_id, city_id)
VALUES
	(4, 2, 3, 2, 'Cozy apartment near the city center', 150.00, '123 Main St', '12345', 2, 3, 1),
    (2, 1, 1, 1, 'Modern loft in the heart of the city.', 100.00, '431 Elm Street', '92372', 14, 5, 20),
    (4, 2, 2, 1, 'Cozy cabin in the woods.', 160.00, '444 Forest Trail', '98765', 2, 3, 1),
    (6, 3, 4, 2, 'Sunny beach house with ocean views', 200.99, '123 Seaside st', '2231', 9, 1, 9),
    (2, 1, 1, 1, 'Artistic loft with skyline views', 115.00, '66 Nelsons court', '823714', 10, 5, 16),
    (5, 2, 2, 2, 'Modern loft in the heart of the city', 120.00, '101 Elm Street', '54321', 10, 5, 17),
    (8, 4, 5, 3, 'Luxurious villa with a private pool', 250.00, '202 Maple Lane', '13579', 5, 2, 12),
    (3, 2, 2, 1, 'Sunny beachfront condo', 173.00, '555 Beach Blvd', '67890', 20, 3, 5),
    (8, 4, 5, 3, 'Modern mansion with a private pool', 280.00, '888 Luxury Lane', '23456', 1, 1, 6),
    (5, 3, 2, 2, 'Tranquil cottage surrounded by nature', 110.00, '666 Meadow View', '54321', 1, 1, 6),
    (7, 4, 3, 2, 'Contemporary apartment in the city', 180.00, '222 Urban Avenue', '34567', 1, 1, 6),
    (8, 4, 5, 3, 'Riverside retreat with private access', 260.00, '777 Riverside Road', '23456', 16, 5, 19),
    (5, 3, 2, 2, 'Historic townhouse with modern amenities', 140.00, '888 History Street', '54321', 3, 3, 4),
    (7, 4, 3, 2, 'Chic apartment with city views', 170.00, '999 Chic Lane', '34567', 19, 2, 15),
	(6, 4, 4, 3, 'Grand penthouse with city skyline views', 360.00, '505 Sky Tower', '65432', 17, 1, 7), 
    (5, 2, 2, 2, 'Family-friendly suburban home', 120.00, '789 Oak Ridge', '12345', 8, 5, 18), 
    (6, 3, 3, 2, 'Historic mansion with antique charm', 200.00, '999 Heritage Avenue', '34567', 8, 5, 18),
    (5, 3, 3, 2, 'Quirky treehouse in the forest', 160.00, '888 Treetop Trail', '34567', 18, 3, 1),
    (2, 1, 1, 1, 'Contemporary apartment in the city', 180.00, '222 Urban Avenue', '34567',18, 3, 3),
    (7, 4, 4, 3, 'Grand penthouse with city skyline views', 300.00, '505 Sky Tower', '65432', 18, 3, 2);
    
INSERT INTO photos (photo_url, property_id)
VALUES 
	('https://www.airbnb.ca/rooms/1031344555885564904?adults=1&children=0&enable_m3_private_room=true&infants=0&pets=0&check_in=2024-03-05&check_out=2024-03-10&source_impression_id=p3_1709003009_%2FTp7HHJ%2FNxkuy8AH&previous_page_section_name=1000&federated_search_id=dc90d59a-4f70-46d8-9136-398abbfbeb5c&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1798087479', 1),
    ('https://www.airbnb.ca/rooms/1031344555885564904?adults=1&children=0&enable_m3_private_room=true&infants=0&pets=0&check_in=2024-03-05&check_out=2024-03-10&source_impression_id=p3_1709003009_%2FTp7HHJ%2FNxkuy8AH&previous_page_section_name=1000&federated_search_id=dc90d59a-4f70-46d8-9136-398abbfbeb5c&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1789057302', 1),
    ('https://www.airbnb.ca/rooms/1031344555885564904?adults=1&children=0&enable_m3_private_room=true&infants=0&pets=0&check_in=2024-03-05&check_out=2024-03-10&source_impression_id=p3_1709003009_%2FTp7HHJ%2FNxkuy8AH&previous_page_section_name=1000&federated_search_id=dc90d59a-4f70-46d8-9136-398abbfbeb5c&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1812772992', 1), 
    ('https://www.airbnb.ca/rooms/42971895?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=988024355&search_mode=flex_destinations_search&check_in=2024-03-31&check_out=2024-04-05&source_impression_id=p3_1709003123_kj9vhPvkYXMKzsBt&previous_page_section_name=1000&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1475726005', 2),
    ('https://www.airbnb.ca/rooms/42971895?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=988024355&search_mode=flex_destinations_search&check_in=2024-03-31&check_out=2024-04-05&source_impression_id=p3_1709003123_kj9vhPvkYXMKzsBt&previous_page_section_name=1000&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1475726230',2),
    ('https://www.airbnb.ca/rooms/1000627167235956148?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1758335856&search_mode=flex_destinations_search&check_in=2024-03-01&check_out=2024-03-06&source_impression_id=p3_1709003194_hLQyXXOTKvwZZJIC&previous_page_section_name=1000&federated_search_id=47d41c57-9fd6-4da1-803a-5db0bb36e6ff&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1758335856', 3),
    ('https://www.airbnb.ca/rooms/1000627167235956148?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1758335856&search_mode=flex_destinations_search&check_in=2024-03-01&check_out=2024-03-06&source_impression_id=p3_1709003194_hLQyXXOTKvwZZJIC&previous_page_section_name=1000&federated_search_id=47d41c57-9fd6-4da1-803a-5db0bb36e6ff&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1758335856', 3),
    ('https://www.airbnb.ca/rooms/1000627167235956148?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1758335856&search_mode=flex_destinations_search&check_in=2024-03-01&check_out=2024-03-06&source_impression_id=p3_1709003194_hLQyXXOTKvwZZJIC&previous_page_section_name=1000&federated_search_id=47d41c57-9fd6-4da1-803a-5db0bb36e6ff&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1758335902', 3),
    ('https://www.airbnb.ca/rooms/811681027974119521?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1573087171&search_mode=flex_destinations_search&check_in=2024-05-08&check_out=2024-05-13&source_impression_id=p3_1709003267_xJA1YpbiQMeMUiSk&previous_page_section_name=1000&federated_search_id=c30d3cd2-384b-4244-bf59-0b615550ab29&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1838525854', 4),
    ('https://www.airbnb.ca/rooms/811681027974119521?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1573087171&search_mode=flex_destinations_search&check_in=2024-05-08&check_out=2024-05-13&source_impression_id=p3_1709003267_xJA1YpbiQMeMUiSk&previous_page_section_name=1000&federated_search_id=c30d3cd2-384b-4244-bf59-0b615550ab29&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1838525871', 4),
    ('https://www.airbnb.ca/rooms/811681027974119521?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1573087171&search_mode=flex_destinations_search&check_in=2024-05-08&check_out=2024-05-13&source_impression_id=p3_1709003267_xJA1YpbiQMeMUiSk&previous_page_section_name=1000&federated_search_id=c30d3cd2-384b-4244-bf59-0b615550ab29&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1838525899', 4),
    ('https://www.airbnb.ca/rooms/29412586?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=600662082&search_mode=flex_destinations_search&check_in=2024-05-07&check_out=2024-05-12&source_impression_id=p3_1709003370_Nfyunk8QTonaezq7&previous_page_section_name=1000&modal=PHOTO_TOUR_SCROLLABLE', 5),
    ('https://www.airbnb.ca/rooms/29412586?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=600662082&search_mode=flex_destinations_search&check_in=2024-05-07&check_out=2024-05-12&source_impression_id=p3_1709003370_Nfyunk8QTonaezq7&previous_page_section_name=1000&modal=PHOTO_TOUR_SCROLLABLE&modalItem=759960578', 5),
    ('https://www.airbnb.ca/rooms/29412586?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=600662082&search_mode=flex_destinations_search&check_in=2024-05-07&check_out=2024-05-12&source_impression_id=p3_1709003370_Nfyunk8QTonaezq7&previous_page_section_name=1000&modal=PHOTO_TOUR_SCROLLABLE&modalItem=759960567', 5), 
    ('https://www.airbnb.ca/rooms/816301104680880036?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1578052203&search_mode=flex_destinations_search&check_in=2024-04-01&check_out=2024-04-06&source_impression_id=p3_1709003453_h2lurMHOU%2BkVrCQN&previous_page_section_name=1000&modal=PHOTO_TOUR_SCROLLABLE', 10),
    ('https://www.airbnb.ca/rooms/816301104680880036?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1578052203&search_mode=flex_destinations_search&check_in=2024-04-01&check_out=2024-04-06&source_impression_id=p3_1709003453_h2lurMHOU%2BkVrCQN&previous_page_section_name=1000&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1578052206', 10),
    ('https://www.airbnb.ca/rooms/816301104680880036?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1578052203&search_mode=flex_destinations_search&check_in=2024-04-01&check_out=2024-04-06&source_impression_id=p3_1709003453_h2lurMHOU%2BkVrCQN&previous_page_section_name=1000&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1578052222', 10),
    ('https://www.airbnb.ca/rooms/655904365046242702?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1497052694&search_mode=flex_destinations_search&check_in=2024-03-11&check_out=2024-03-16&source_impression_id=p3_1709003544_64OiDyWkVmHPDMIA&previous_page_section_name=1000&federated_search_id=c97695bd-0171-47fa-ad0a-e4bd8fca133d&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1497052081', 20),
    ('https://www.airbnb.ca/rooms/655904365046242702?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1497052694&search_mode=flex_destinations_search&check_in=2024-03-11&check_out=2024-03-16&source_impression_id=p3_1709003544_64OiDyWkVmHPDMIA&previous_page_section_name=1000&federated_search_id=c97695bd-0171-47fa-ad0a-e4bd8fca133d&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1497051996', 20),
    ('https://www.airbnb.ca/rooms/655904365046242702?adults=1&category_tag=Tag%3A7769&children=0&enable_m3_private_room=true&infants=0&pets=0&photo_id=1497052694&search_mode=flex_destinations_search&check_in=2024-03-11&check_out=2024-03-16&source_impression_id=p3_1709003544_64OiDyWkVmHPDMIA&previous_page_section_name=1000&federated_search_id=c97695bd-0171-47fa-ad0a-e4bd8fca133d&modal=PHOTO_TOUR_SCROLLABLE&modalItem=1497052058', 20);
    


INSERT INTO property_amenities (property_id, amenities_id)
VALUES
	(1,4),
    (2,9),
    (3,1),
    (4,2),
    (5,12),
    (6,3),
    (7,20),
    (8,5),
    (9,7),
    (10,1),
    (11,19),
    (12, 15),
    (13, 16),
    (14, 2),
    (15, 3),
    (16, 20),
    (17, 8),
    (18, 12),
    (19, 1),
    (20, 9);


INSERT INTO review (overall_rating, cleanliness, accuracy, check_in, communication, location, value, comment, property_id, guest_id)
VALUES
    (5, 4, 5, 5, 4, 5, 4, 'Great experience!', 10, 3),
    (4, 3, 4, 5, 3, 4, 3, 'Enjoyed my stay.', 9, 1),
    (5, 5, 5, 5, 5, 5, 5, 'Outstanding! It was a great experience.', 6, 3),
    (3, 2, 3, 3, 4, 3, 3, 'Could be better.', 17, 10),
    (4, 4, 4, 4, 4, 4, 4, 'Nice place!', 20, 4),
    (5, 5, 5, 5, 5, 5, 5, 'Perfect in every way.', 10, 9),
    (3, 2, 3, 3, 3, 4, 3, 'Average experience. It could improve', 1, 18),
    (5, 5, 5, 5, 5, 5, 5, 'Excellent!', 14, 4),
    (4, 4, 4, 4, 4, 4, 4, 'Good stay overall.', 2, 2),
    (3, 3, 3, 3, 3, 3, 3, 'Needs improvement.', 15, 12),
    (1, 1, 2, 4, 1, 1, 2, 'Nothing like the photos, really bad experience.', 16, 4),
    (4, 4, 3, 4, 4, 5, 3, 'Nice place, good value.', 1, 20),
    (5, 5, 5, 5, 5, 5, 5, 'Absolutely fantastic!', 6, 11),
    (3, 3, 2, 3, 4, 3, 3, 'Could be cleaner.', 20, 3),
    (4, 4, 4, 5, 4, 4, 4, 'Enjoyed the stay.', 9, 6),
    (5, 5, 5, 5, 5, 5, 5, 'Perfect in every way.', 1, 8),
    (3, 2, 3, 3, 3, 4, 3, 'Average experience.', 12, 9),
    (5, 4, 5, 5, 4, 5, 4, 'Great experience!', 19, 19),
    (3, 2, 4, 3, 3, 3, 3, 'Avarage!', 2, 13),
    (4, 4, 4, 4, 4, 4, 4, 'It was good like we were expecting.', 3, 16);
    
INSERT INTO payment (payment_amount, payment_date, payment_method, payment_satus)
VALUES 
	(210.00, '2022-03-01', 'Credit Card', 'Paid'),
    (150.00, '2023-04-05', 'PayPal', 'Pending'),
    (500.00, '2021-05-10', 'Debit Card', 'Paid'),
    (1060.00, '2022-06-15', 'Bank Transfer', 'Paid'),
    (365.00, '2019-12-12', 'Credit Card', 'Failed'),
    (1020.80, '2023-04-17', 'PayPal', 'Pending'),
    (500.00, '2024-02-10', 'Credit Card', 'Paid'),
    (250.00, '2022-06-15', 'Bank Transfer', 'Paid'),
    (2893.60, '2024-01-01', 'Credit Card', 'Paid'),
    (789.99, '2022-11-03', 'Credit Card', 'Paid'),
    (550.00, '2021-05-10', 'Debit Card', 'Paid'),
    (960.00, '2024-08-16', 'Credit Card', 'Paid'),
    (167.98, '2022-12-05', 'Credit Card', 'Paid'),
    (1200.50, '2024-01-18', 'PayPal', 'Pending'),
    (500.00, '2021-05-10', 'Debit Card', 'Paid'),
    (1060.00, '2022-06-15', 'PayPal', 'Failed'),
    (296.00, '2020-12-08', 'Credit Card', 'Paid'),
    (150.00, '2023-04-05', 'PayPal', 'Pending'),
    (769.00, '2023-09-10', 'Debit Card', 'Paid'),
    (250.00, '2021-06-15', 'Bank Transfer', 'Paid');
    
INSERT INTO booking (num_adult, num_childen, num_infant, num_pet, checkin_date, checkout_date, nightly_price, service_fee, cleaning_fee, total_price, booking_satus, guest_id, host_id, payment_id)
VALUES 
	(1, 0, 0, 0, '2022-03-01', '2022-03-02', 160.00, 30.00, 20.00, 210.00, 'Confirmed', 2, 5, 1),
    (1, 0, 0, 1, '2023-04-05', '2023-04-06', 110.00, 20.00, 20.00, 150.00, 'Pending', 20, 5, 2),
    (2, 0, 1, 0, '2021-05-10', '2021-05-12', 350.00, 100.00, 50.00, 500.00, 'Confirmed', 1, 20, 3),
    (4, 1, 0, 1, '2022-06-16', '2022-06-20', 800.00, 100.00, 160.00, 1060.00, 'Confirmed', 4, 12, 4),
    (2, 0, 0, 2, '2019-12-12', '2019-12-13', 265.00, 50.00, 50.00, 365.00, 'Confirmed', 19, 3, 5),
    (5, 0, 1, 0, '2023-04-17', '2023-04-20', 720.00, 100.00, 200.00, 1020.00, 'Pending', 16, 19, 6),
    (1, 0, 0, 0, '2022-03-01', '2022-03-02', 160.00, 30.00, 20.00, 210.00, 'Confirmed', 3, 1, 7),
    (2, 0, 1, 1, '2022-06-15', '2022-06-17', 210.00, 20.00, 20.00, 250.00, 'Confirmed', 10, 4, 8),
    (6, 1, 0, 1, '2024-01-10', '2025-01-15', 2190.00, 353.00, 350.60, 2893.60, 'Confirmed', 17, 10, 9),
    (2, 0, 0, 1, '2022-11-03', '2022-11-06', 589.99, 80.00, 120.00, 789.99, 'Pending', 2, 18, 10),
    (1, 0, 0, 0, '2021-05-13', '2021-05-14', 460.00, 40.00, 50.00, 550.00, 'Confirmed', 14, 11, 11),
    (3, 0, 1, 0, '2024-08-16', '2024-08-20', 855.00, 55.00, 50.00, 960.00, 'Pending', 13, 9, 12),
    (1, 0, 0, 0, '2022-12-06', '2022-12-07', 127.98, 30.00, 10.00, 167.98, 'Confirmed', 10, 4, 13),
    (2, 1, 0, 2, '2024-01-25', '2024-01-28', 900.00, 150.00, 150.50, 1200.50, 'Pending', 15, 1, 14),
    (2, 1, 0, 0, '2021-05-12', '2021-05-13', 380.00, 70.00, 50.00, 500.00, 'Confirmed', 6, 6, 15),
    (5, 0, 0, 0, '2022-06-20', '2022-06-24', 860.00, 100.00, 100.00, 1060.00, 'Pending', 4, 7, 16),
    (1, 0, 0, 1, '2020-12-10', '2020-12-11', 206.00, 40.00, 50.00, 296.00, 'Confirmed', 20, 5, 17),
    (1, 0, 0, 0, '2023-04-05', '2023-04-05', 100.00, 30.00, 20.00, 150.00, 'Pending', 18, 17, 18),
    (2, 1, 1, 0, '2023-09-10', '2023-09-15', 669.00, 50.00, 50.00, 769.00, 'Confirmed', 2, 3, 19),
    (1, 1, 0, 0, '2021-06-16', '2021-06-17', 160.00, 40.00, 50.00, 250.00, 'Confirmed', 1, 8, 20);
    
    
INSERT INTO wishlist (property_id, guest_id)
VALUES
	(2,5),
    (7,3),
    (7,20),
    (18, 2),
    (20, 1),
    (20, 13),
    (11, 10),
    (4, 5),
    (4, 6),
    (17, 4),
    (1, 1),
    (12, 8),
    (16, 3),
    (1, 20),
    (20, 6),
    (8, 8),
    (8, 19),
    (19, 1),
    (6, 3),
    (20, 20);
    
INSERT INTO user_languages (user_id, language_id)
VALUES
	(20, 1),
    (20, 5),
    (1, 4),
    (5,1),
    (5,18),
    (5, 12),
    (7, 3),
    (13, 1),
    (13, 13),
    (9, 1), 
    (12, 1),
    (12, 2),
    (8, 1),
    (8,2),
    (11, 10),
    (1, 1),
    (15, 2),
    (15, 3),
    (2,1),
    (2,2),
    (2,18);

INSERT INTO review_history (review_rating, review_date, guest_id)
VALUES
	(5, '2023-09-11', 3),
    (2, '2021-10-12', 3),
    (3, '2024-01-01', 1),
    (4, '2023-09-11', 18),
    (1, '2021-12-11', 18),
    (5, '2020-03-03', 1),
    (4, '2019-12-25', 20),
    (2, '2023-08-06', 5),
    (1, '2024-02-06', 5),
    (5, '2022-02-09', 14),
    (4, '2024-01-08', 16),
    (1, '2021-09-11', 16),
    (2, '2019-12-17', 2),
    (5, '2019-12-27', 19),
    (4, '2023-04-17', 19),
    (4, '2024-03-01', 4),
    (2, '2023-04-12', 10),
    (1, '2023-11-01', 10),
    (5, '2022-08-16', 7),
    (4, '2019-09-11', 6);

INSERT INTO reservation_history (reservation_date, guest_id)
VALUES
	('2019-12-23', 4),
	('2022-03-12', 10),
    ('2023-02-18', 10),
    ('2022-10-16', 20),
    ('2024-01-01', 1),
    ('2020-12-23', 5),
    ('2023-10-15', 3),
    ('2022-09-29', 12),
    ('2023-04-30', 12),
    ('2019-11-17', 1),
    ('2024-01-02', 15),
    ('2019-12-30', 8),
    ('2022-05-18', 7),
    ('2023-10-31', 14),
    ('2017-11-25', 9),
    ('2023-06-04', 11),
    ('2023-11-13', 1),
    ('2022-08-07', 17),
    ('2020-03-29', 2),
    ('2023-11-11', 2);
    
INSERT INTO rules (rule_title, rule_description)
VALUES 
	('No smoking', 'Smoking is not allowed in the property'),
    ('No Groups', 'We do not allow groups bigger than 8 people'),
    ('No pets', 'No pets allow'),
    ('No party', 'No parties allow in the property'),
    ('No guests', 'Guests are not permitted to bring outsiders inside the property'),
    ('No late check-out', 'Check out until 11AM'),
    ('Quiet hours', 'Quiet hours between 10PM and 9AM'),
    ('Pet Friendly', 'Pets are allowed with prior approval'),
    ('Check-in Time', 'Check-in time is after 3 PM'),
    ('ID Verification', 'Guests must provide valid ID for verification'),
    ('Cancellation Policy', 'Cancellation must be done 48 hours before check-in'),
    ('Minimum Stay', 'Minimum stay of 2 nights required'),
    ('Pool Hours', 'Pool hours are from 9 AM to 6 PM'),
    ('Guest Registration', 'Guests need to register upon arrival'),
	('No Loud Music', 'Loud music is not permitted after 10 PM'),
    ('Guest Parking', 'Designated parking spots for guests only'),
    ('Recycling Policy', 'Separate recycling bins are provided'),
    ('Use of Facilities', 'Guests have access to gym and swimming pool'),
    ('Security Deposit', 'Security deposit required for potential damages'),
    ('No Overnight Guests', 'Non-registered guests are not allowed overnight');
    
INSERT INTO property_rule (property_id, rule_id)
VALUES
	(1, 2),
    (1, 1),
    (1, 20),
    (10, 1),
    (10, 19),
    (10, 4),
    (10, 5),
    (4, 1),
    (4, 2),
    (6, 16),
    (6, 20),
    (8, 20),
    (8, 1),
    (20, 14),
    (20, 1),
    (19, 1),
    (19, 5),
    (19, 6),
    (11, 1),
    (11, 2);

SELECT * FROM user;

SELECT email
FROM user
WHERE admin_id IS NOT NULL;

SELECT property_id, address
FROM property
WHERE host_id = 2;

SELECT AVG(nightly_price)
FROM property;

SELECT MIN(total_price), MAX(total_price)
FROM booking;

SELECT SUM(total_price)
FROM booking
WHERE host_id = 5;

SELECT*
FROM administration
ORDER BY job_position;

SELECT *
FROM payment
WHERE payment_method = 'Credit Card' AND payment_status = 'Paid';

SELECT COUNT(property_id)
FROM property_rule
WHERE rule_id = 1 OR rule_id = 10;

ALTER TABLE host 
	RENAME COLUMN sarted_hosting TO started_hosting;

INSERT INTO host(first_name, last_name, date_of_birth, started_hosting)
VALUES ('Sonia', 'Silva', '1993-05-18', '2024-03-23');

SELECT *
FROM host;

DELETE FROM host WHERE host_id = 22;

COMMIT;

SELECT COUNT(DISTINCT rule_id) 
FROM rules;

SELECT *
FROM reservation_history
INNER JOIN guest ON reservation_history.guest_id = guest.guest_id;

SELECT *
FROM review
WHERE overall_rating >= 4;

SELECT amenities_id
FROM amenities
WHERE pet_friendly = 1
LIMIT 5;

SELECT COUNT(DISTINCT country_id)
FROM property;

ALTER TABLE language 
	RENAME COLUMN laguage_name TO language_name;

SELECT language_id, COUNT(*) AS language_count
FROM user_languages
GROUP BY language_id
ORDER BY language_count DESC
LIMIT 1;

SELECT user_languages.language_id, user_languages.language_count, language.language_name
FROM (
    SELECT language_id, COUNT(*) AS language_count
    FROM user_languages
    GROUP BY language_id
    ORDER BY language_count DESC
) AS user_languages
INNER JOIN language ON user_languages.language_id = language.language_id;

SELECT 
	(SELECT COUNT(*) FROM booking WHERE checkin_date < checkout_date) AS checked_rows,
    (SELECT COUNT(*) FROM booking) AS total_rows;

SELECT *
FROM booking
WHERE  checkin_date >= checkout_date ;

DELETE FROM booking WHERE booking_id = 18;

COMMIT;

SELECT * 
FROM guest 
ORDER BY last_name ASC;

SELECT *
FROM message
WHERE date_time BETWEEN '2022-01-01' AND '2023-01-01';

SELECT host_id, SUM(total_price) AS total_sum_2024
FROM booking
WHERE checkin_date >= '2024-01-01'
GROUP BY host_id
ORDER BY total_sum_2024 DESC;

SELECT guest.guest_id, guest.first_name, guest.last_name, booking.booking_id, booking.total_price, review.overall_rating, review.comment
FROM guest
INNER JOIN booking ON guest.guest_id = booking.guest_id
INNER JOIN review ON guest.guest_id = review.guest_id;

SELECT COUNT(*)
FROM administration;

SELECT COUNT(*)
FROM amenities;

SELECT COUNT(*)
FROM booking;

INSERT INTO booking (num_adult, num_children, num_infant, num_pet, checkin_date, checkout_date, nightly_price, service_fee, cleaning_fee, total_price, booking_status, guest_id, host_id, payment_id)
VALUES 
	(1, 0, 0, 0, '2022-03-01', '2022-03-02', 160.00, 30.00, 20.00, 210.00, 'Confirmed', 2, 5, 1);

SELECT COUNT(*)
FROM category;

SELECT COUNT(*)
FROM city;

SELECT COUNT(*)
FROM country;

SELECT COUNT(*)
FROM guest;

SELECT COUNT(*)
FROM host;

SELECT COUNT(*)
FROM language;

SELECT COUNT(*)
FROM message;

SELECT COUNT(*)
FROM payment;

SELECT COUNT(*)
FROM photos;

SELECT COUNT(*)
FROM property;

SELECT COUNT(*)
FROM property_amenities;

SELECT COUNT(*)
FROM property_category;

INSERT INTO property_category (property_id, category_id)
VALUES 
	(1,5),
    (11,1),
    (3,3),
    (18,5),
    (7,19),
    (9,1),
    (11,17),
    (1,20),
    (20,4),
    (11,2),
    (18,16),
    (6,1),
    (10,7),
    (20,20),
    (19,2),
    (5,17),
    (9,20),
    (6,6),
    (4,13),
    (20,13),
    (3,2);


SELECT COUNT(*)
FROM property_rule;

SELECT COUNT(*)
FROM review; 

SELECT COUNT(*)
FROM review_history;

SELECT COUNT(*)
FROM rules;

SELECT COUNT(*)
FROM user;

SELECT COUNT(*)
FROM user_languages;

SELECT COUNT(*)
FROM wishlist;

SELECT COUNT(*) AS table_count
FROM information_schema.tables
WHERE table_schema = 'airbnb';

SELECT SUM(table_rows) AS total_entries
FROM information_schema.tables
WHERE table_schema = 'airbnb';
