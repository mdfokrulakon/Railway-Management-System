DROP TABLE BOOKINGS CASCADE CONSTRAINTS;
DROP TABLE TICKETS CASCADE CONSTRAINTS;
DROP TABLE SCHEDULE CASCADE CONSTRAINTS;
DROP TABLE PASSENGER_EMAIL CASCADE CONSTRAINTS;
DROP TABLE PASSENGER_PHONE CASCADE CONSTRAINTS;
DROP TABLE PASSENGERS CASCADE CONSTRAINTS;
DROP TABLE SEATS CASCADE CONSTRAINTS;
DROP TABLE COACH CASCADE CONSTRAINTS;
DROP TABLE CLASSES CASCADE CONSTRAINTS;
DROP TABLE TRAINS CASCADE CONSTRAINTS;
DROP TABLE ROUTES CASCADE CONSTRAINTS;
DROP TABLE FARE_RULES CASCADE CONSTRAINTS;
DROP TABLE PLATFORMS CASCADE CONSTRAINTS;
DROP TABLE STATIONS CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE_EMAIL CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE_PHONE_NUMBER CASCADE CONSTRAINTS;
DROP TABLE TICKET_COUNTER_STAFF CASCADE CONSTRAINTS;
DROP TABLE GUARDS CASCADE CONSTRAINTS;
DROP TABLE MAINTENANCE_WORKERS CASCADE CONSTRAINTS;
DROP TABLE ENGINE_DRIVERS CASCADE CONSTRAINTS;
DROP TABLE ADMIN_STAFF CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEES CASCADE CONSTRAINTS;
DROP TABLE PAYMENTS CASCADE CONSTRAINTS;
DROP TABLE CANCELLATIONS CASCADE CONSTRAINTS;
DROP TABLE MAINTENANCE CASCADE CONSTRAINTS;


CREATE TABLE EMPLOYEES (
    employee_id VARCHAR2(10) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    name VARCHAR2(100),
    joining_date DATE,
    nid_number VARCHAR2(20),
    status VARCHAR2(20)
);

CREATE TABLE ADMIN_STAFF (
    employee_id VARCHAR2(10) PRIMARY KEY,
    department VARCHAR2(50),
    access_level VARCHAR2(20),
    position VARCHAR2(50),
    CONSTRAINT EMP_ADM_ST_FK FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id)
);

CREATE TABLE ENGINE_DRIVERS (
    employee_id VARCHAR2(10) PRIMARY KEY,
    license_number VARCHAR2(10),
    train_types_certified VARCHAR2(50),
    last_medical_check DATE,
    year_experience VARCHAR2(50),
    CONSTRAINT ENG_DRI_EMP_FK FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id)
);

CREATE TABLE MAINTENANCE_WORKERS (
    employee_id VARCHAR2(10) PRIMARY KEY,
    specialization VARCHAR2(50),
    certification_level VARCHAR2(50),
    tools_assigned VARCHAR2(50),
    CONSTRAINT MAINT_WOR_EMP_FK FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id)
);

CREATE TABLE GUARDS (
    employee_id VARCHAR2(10) PRIMARY KEY,
    badge_number VARCHAR2(20),
    duty_location VARCHAR2(50),
    weapons_trained VARCHAR2(10),
    CONSTRAINT GUARDS_EMPLOYEES_FK FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id)
);

CREATE TABLE TICKET_COUNTER_STAFF (
    employee_id VARCHAR2(10) PRIMARY KEY,
    counter_number VARCHAR2(10),
    shift_timing VARCHAR2(50),
    daily_quota NUMBER,
    CONSTRAINT TCK_CNT_ST_EMP_FK FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id)
);

CREATE TABLE EMPLOYEE_PHONE_NUMBER (
    employee_id VARCHAR2(10) PRIMARY KEY,
    primary_number VARCHAR2(20),
    secondary_number VARCHAR2(20),
    CONSTRAINT EMP_PHN_NM_EMP_FK FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id)
);

CREATE TABLE EMPLOYEE_EMAIL (
    employee_id VARCHAR2(10) PRIMARY KEY,
    primary_email VARCHAR2(100),
    secondary_email VARCHAR2(100),
    CONSTRAINT EMPLOYEE_EMAIL_EMPLOYEES_FK FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id)
);

CREATE TABLE STATIONS (
    station_id VARCHAR2(10) PRIMARY KEY,
    station_code VARCHAR2(10),
    station_name VARCHAR2(100),
    city VARCHAR2(50),
    division VARCHAR2(50),
    platform_count VARCHAR2(20)
);

CREATE TABLE PLATFORMS (
    platform_id VARCHAR2(10) PRIMARY KEY,
    platform_number VARCHAR2(20),
    is_accessible VARCHAR2(10),
    length_meters NUMBER(6,2),
    station_id VARCHAR2(10),
    CONSTRAINT PLATFORMS_STATIONS_FK FOREIGN KEY (station_id) REFERENCES STATIONS(station_id)
);

CREATE TABLE TRAINS (
    train_id VARCHAR2(10) PRIMARY KEY,
    train_name VARCHAR2(100),
    train_number VARCHAR2(10),
    status VARCHAR2(20),
    capacity NUMBER,
    train_type VARCHAR2(50),
    max_speed VARCHAR2(10)
);


CREATE TABLE ROUTES (
    route_id VARCHAR2(10) PRIMARY KEY,
    from_station_id VARCHAR2(10),
    to_station_id VARCHAR2(10),
    distance_km VARCHAR2(10),
    fare_id VARCHAR2(10),
    train_id VARCHAR2(10),
    CONSTRAINT ROUTES_FROM_STATION_FK FOREIGN KEY (from_station_id) REFERENCES STATIONS(station_id),
    CONSTRAINT ROUTES_TO_STATION_FK FOREIGN KEY (to_station_id) REFERENCES STATIONS(station_id),
    CONSTRAINT ROUTES_TRAINS_FK FOREIGN KEY (train_id) REFERENCES TRAINS(train_id) 
);

CREATE TABLE CLASSES (
    class_id VARCHAR2(10) PRIMARY KEY,
    class_name VARCHAR2(100),
    description VARCHAR2(300),
    multiplier NUMERIC(2,1)
);

CREATE TABLE FARE_RULES (
    fare_id VARCHAR2(10) PRIMARY KEY,
    route_id VARCHAR2(10),
    base_fare NUMBER(10,2),
    fare_multiplier NUMBER(10,2),
    effective_date DATE,
    class_id VARCHAR2(10),
    CONSTRAINT FARE_RULES_CLASSES_FK FOREIGN KEY (class_id) REFERENCES CLASSES(class_id)
);

CREATE TABLE COACH (
    coach_id VARCHAR2(10) PRIMARY KEY,
    coach_number VARCHAR2(50),
    seat_capacity NUMBER,
    train_id VARCHAR2(10),
    class_id VARCHAR2(10),
    CONSTRAINT COACH_TRAINS_FK FOREIGN KEY (train_id) REFERENCES TRAINS(train_id),
    CONSTRAINT COACH_CLASSES_FK FOREIGN KEY (class_id) REFERENCES CLASSES(class_id)
);

CREATE TABLE SEATS (
    seat_id VARCHAR2(10),
    coach_id VARCHAR2(10),
    seat_number VARCHAR2(10),
    status VARCHAR2(20),
    CONSTRAINT SEATS_PK PRIMARY KEY (seat_id, coach_id, seat_number),
    CONSTRAINT SEATS_COACH_FK FOREIGN KEY (coach_id) REFERENCES COACH(coach_id)
);

CREATE TABLE PASSENGERS (
    passenger_id VARCHAR2(10) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    name VARCHAR2(100),
    date_of_birth DATE,
    gender VARCHAR2(10)
);

CREATE TABLE PASSENGER_PHONE (
    passenger_id VARCHAR2(10) PRIMARY KEY,
    primary_phone VARCHAR2(20),
    secondary_phone VARCHAR2(20),
    CONSTRAINT PASSENGER_PHONE_PASSENGERS_FK FOREIGN KEY (passenger_id) REFERENCES PASSENGERS(passenger_id)
);

CREATE TABLE PASSENGER_EMAIL (
    passenger_id VARCHAR2(10) PRIMARY KEY,
    primary_email VARCHAR2(100),
    secondary_email VARCHAR2(100),
    CONSTRAINT PASSENGER_EMAIL_PASSENGERS_FK FOREIGN KEY (passenger_id) REFERENCES PASSENGERS(passenger_id)
);


CREATE TABLE SCHEDULE (
    schedule_id VARCHAR2(10) PRIMARY KEY,
    departure_time DATE,
    arrival_time DATE,
    schedule_date DATE,
    route_id VARCHAR2(10),
    CONSTRAINT SCHEDULE_ROUTES_FK FOREIGN KEY (route_id) REFERENCES ROUTES(route_id)
);

CREATE TABLE BOOKINGS (
    booking_id VARCHAR2(10) PRIMARY KEY,
    booking_date DATE,
    status VARCHAR2(20),
    passenger_id VARCHAR2(10),
    schedule_id VARCHAR2(10),
    CONSTRAINT BOOKINGS_PASSENGERS_FK FOREIGN KEY (passenger_id) REFERENCES PASSENGERS(passenger_id),
    CONSTRAINT BOOKINGS_SCHEDULE_FK FOREIGN KEY (schedule_id) REFERENCES SCHEDULE(schedule_id)
);

CREATE TABLE TICKETS (
    ticket_id VARCHAR2(10) PRIMARY KEY,
    booking_id VARCHAR2(10),
    fare NUMBER(10,2),
    status VARCHAR2(20),
    seat_id VARCHAR2(10),
    coach_id VARCHAR2(10),
    seat_number VARCHAR2(10),
    CONSTRAINT TICKETS_BOOKINGS_FK FOREIGN KEY (booking_id) REFERENCES BOOKINGS(booking_id),
    CONSTRAINT TICKETS_SEATS_FK FOREIGN KEY (seat_id, coach_id, seat_number) REFERENCES SEATS(seat_id, coach_id, seat_number)
);

CREATE TABLE PAYMENTS (
    payment_id VARCHAR2(10) PRIMARY KEY,
    amount NUMBER(10,2),
    payment_method VARCHAR2(50),
    payment_status VARCHAR2(50),
    transaction_id VARCHAR2(10),
    payment_date DATE,
    booking_id VARCHAR2(10),
    CONSTRAINT PAYMENTS_BOOKINGS_FK FOREIGN KEY (booking_id) REFERENCES BOOKINGS(booking_id)
);

CREATE TABLE CANCELLATIONS (
    cancellation_id VARCHAR2(10) PRIMARY KEY,
    ticket_id VARCHAR2(10),
    cancellation_date DATE,
    refund_amount NUMBER(10,2),
    reason VARCHAR2(50),
    status VARCHAR2(20),
    booking_id VARCHAR2(10),
    CONSTRAINT CANCELLATIONS_BOOKINGS_FK FOREIGN KEY (booking_id) REFERENCES BOOKINGS(booking_id)
);

CREATE TABLE MAINTENANCE (
    maintenance_id VARCHAR2(10) PRIMARY KEY,
    reported_by VARCHAR2(50),
    maintenance_type VARCHAR2(50),
    description VARCHAR2(300),
    status VARCHAR2(20),
    start_date DATE,
    end_date DATE,
    employee_id VARCHAR2(10),
    train_id VARCHAR2(10),
    CONSTRAINT MAINTENANCE_EMPLOYEES_FK FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id),
    CONSTRAINT MAINTENANCE_TRAINS_FK FOREIGN KEY (train_id) REFERENCES TRAINS(train_id)
);




INSERT INTO STATIONS VALUES ('ST001', 'DHK', 'Kamalapur Railway Station',     'Dhaka',         'Dhaka',     '20');
INSERT INTO STATIONS VALUES ('ST002', 'CGP', 'Chittagong Railway Station',    'Chittagong',    'Chittagong','12');
INSERT INTO STATIONS VALUES ('ST003', 'RJS', 'Rajshahi Railway Station',      'Rajshahi',      'Rajshahi',   '8');
INSERT INTO STATIONS VALUES ('ST004', 'KHL', 'Khulna Railway Station',        'Khulna',        'Khulna',    '10');
INSERT INTO STATIONS VALUES ('ST005', 'SYL', 'Sylhet Railway Station',        'Sylhet',        'Sylhet',     '8');
INSERT INTO STATIONS VALUES ('ST006', 'MYM', 'Mymensingh Railway Station',    'Mymensingh',    'Mymensingh','6');
INSERT INTO STATIONS VALUES ('ST007', 'CXB', 'Cox''s Bazar Railway Station', 'Cox''s Bazar',  'Chittagong','4');
INSERT INTO STATIONS VALUES ('ST008', 'BRS', 'Barisal Railway Station',       'Barisal',       'Barisal',    '6');
INSERT INTO STATIONS VALUES ('ST009', 'RPR', 'Rangpur Railway Station',       'Rangpur',       'Rangpur',    '5');
INSERT INTO STATIONS VALUES ('ST010', 'DIN', 'Dinajpur Railway Station',      'Dinajpur',      'Rangpur',    '5');
INSERT INTO STATIONS VALUES ('ST011', 'NLP', 'Nilphamari Railway Station',     'Nilphamari',    'Rangpur',    '4');
INSERT INTO STATIONS VALUES ('ST012', 'KST', 'Kushtia Railway Station',        'Kushtia',       'Khulna',     '5');
INSERT INTO STATIONS VALUES ('ST013', 'BNB', 'Brahmanbaria Railway Station',   'Brahmanbaria',  'Chittagong','4');
INSERT INTO STATIONS VALUES ('ST014', 'BKP', 'Bogra Railway Station',          'Bogra',         'Rajshahi',   '6');
INSERT INTO STATIONS VALUES ('ST015', 'NCL', 'Noakhali Railway Station',       'Noakhali',      'Chittagong','3');
INSERT INTO STATIONS VALUES ('ST016', 'THN', 'Thakurgaon Railway Station',      'Thakurgaon',    'Rangpur',    '4');
INSERT INTO STATIONS VALUES ('ST017', 'JMP', 'Jamalpur Railway Station',       'Jamalpur',      'Mymensingh','5');
INSERT INTO STATIONS VALUES ('ST018', 'JPH', 'Joypurhat Railway Station',       'Joypurhat',     'Rajshahi',   '4');
INSERT INTO STATIONS VALUES ('ST019', 'PBA', 'Pabna Railway Station',          'Pabna',         'Rajshahi',   '4');
INSERT INTO STATIONS VALUES ('ST020', 'SRJ', 'Sirajganj Railway Station',      'Sirajganj',     'Rajshahi',   '5');
INSERT INTO STATIONS VALUES ('ST021', 'GOP', 'Gopalganj Railway Station',     'Gopalganj',     'Dhaka',      '3');
INSERT INTO STATIONS VALUES ('ST022', 'MDR', 'Madaripur Railway Station',     'Madaripur',     'Dhaka',      '2');
INSERT INTO STATIONS VALUES ('ST023', 'FEN', 'Feni Railway Station',           'Feni',          'Chittagong','4');
INSERT INTO STATIONS VALUES ('ST024', 'RMG', 'Ramu Railway Station',           'Ramu',          'Chittagong','2');
INSERT INTO STATIONS VALUES ('ST025', 'ZKG', 'Zakiganj Railway Station',       'Zakiganj',      'Sylhet',     '2');
INSERT INTO STATIONS VALUES ('ST026', 'SHR', 'Sherpur Railway Station',        'Sherpur',       'Mymensingh','2');
INSERT INTO STATIONS VALUES ('ST027', 'KHC', 'Khagrachari Railway Station',    'Khagrachari',   'Chittagong','1');
INSERT INTO STATIONS VALUES ('ST028', 'BDB', 'Bandarban Railway Station',      'Bandarban',     'Chittagong','1');
INSERT INTO STATIONS VALUES ('ST029', 'CNW', 'Chapainawabganj Railway Station','Chapainawabganj','Rajshahi',  '3');
INSERT INTO STATIONS VALUES ('ST030', 'PTA', 'Patuakhali Railway Station',      'Patuakhali',    'Barisal',    '2');
INSERT INTO STATIONS VALUES ('ST031', 'PCG', 'Panchagarh Railway Station',    'Panchagarh',    'Rangpur',    '2');
INSERT INTO STATIONS VALUES ('ST032', 'TGL', 'Tangail Railway Station',        'Tangail',       'Dhaka',      '4');
INSERT INTO STATIONS VALUES ('ST033', 'GSH', 'Ghorashal Railway Station',      'Ghorashal',     'Dhaka',      '1');
INSERT INTO STATIONS VALUES ('ST034', 'CDG', 'Chauddagram Railway Station',   'Chauddagram',   'Chittagong','3');
INSERT INTO STATIONS VALUES ('ST035', 'KST', 'Kushtia Railway Station',        'Kushtia',       'Khulna',     '4');
INSERT INTO STATIONS VALUES ('ST036', 'CMA', 'Chilmari Railway Station',       'Chilmari',      'Kurigram',   '2');
INSERT INTO STATIONS VALUES ('ST037', 'KRM', 'Kurigram Railway Station',       'Kurigram',      'Rangpur',    '3');
INSERT INTO STATIONS VALUES ('ST038', 'PRP', 'Pirojpur Railway Station',       'Pirojpur',      'Barisal',    '2');
INSERT INTO STATIONS VALUES ('ST039', 'MNJ', 'Manikganj Railway Station',      'Manikganj',     'Dhaka',      '2');
INSERT INTO STATIONS VALUES ('ST040', 'PHB', 'Phulbari Railway Station',       'Phulbari',      'Dinajpur',   '2');
INSERT INTO STATIONS VALUES ('ST041', 'MRZ', 'Mirzapur Railway Station',      'Mirzapur',      'Tangail',    '1');
INSERT INTO STATIONS VALUES ('ST042', 'KTB', 'Kutubdia Railway Station',       'Kutubdia',      'Chittagong','1');
INSERT INTO STATIONS VALUES ('ST043', 'MLB', 'Moulvibazar Railway Station',    'Moulvibazar',   'Sylhet',     '2');
INSERT INTO STATIONS VALUES ('ST044', 'NWB', 'Nawabganj Railway Station',      'Nawabganj',     'Chapainawabganj','1');
INSERT INTO STATIONS VALUES ('ST045', 'NSD', 'Narsingdi Railway Station',     'Narsingdi',     'Dhaka',      '2');
INSERT INTO STATIONS VALUES ('ST046', 'CNX', 'Chunarughat Railway Station',    'Chunarughat',   'Habiganj',   '1');
INSERT INTO STATIONS VALUES ('ST047', 'HBG', 'Habiganj Railway Station',       'Habiganj',      'Sylhet',     '2');
INSERT INTO STATIONS VALUES ('ST048', 'LKM', 'Laksam Railway Station',        'Laksam',        'Chittagong','3');
INSERT INTO STATIONS VALUES ('ST049', 'KLG', 'Kaliganj Railway Station',      'Kaliganj',      'Gazipur',    '2');
INSERT INTO STATIONS VALUES ('ST050', 'JSR', 'Jessore Railway Station',       'Jessore',       'Khulna',     '6');




INSERT INTO PLATFORMS VALUES ('PL001', 'Platform 1', 'Yes', 350.00, 'ST001');
INSERT INTO PLATFORMS VALUES ('PL002', 'Platform 2', 'Yes', 350.00, 'ST001');
INSERT INTO PLATFORMS VALUES ('PL003', 'Platform 3', 'Yes', 300.00, 'ST001');
INSERT INTO PLATFORMS VALUES ('PL004', 'Platform 4', 'No',  300.00, 'ST001');
INSERT INTO PLATFORMS VALUES ('PL005', 'Platform 5', 'Yes', 250.00, 'ST001');
INSERT INTO PLATFORMS VALUES ('PL006', 'Platform 1', 'Yes', 300.00, 'ST002');
INSERT INTO PLATFORMS VALUES ('PL007', 'Platform 2', 'Yes', 300.00, 'ST002');  
INSERT INTO PLATFORMS VALUES ('PL008', 'Platform 3', 'Yes', 250.00, 'ST002');
INSERT INTO PLATFORMS VALUES ('PL009', 'Platform 4', 'No',  250.00, 'ST002');
INSERT INTO PLATFORMS VALUES ('PL010', 'Platform 5', 'Yes', 200.00, 'ST002');
INSERT INTO PLATFORMS VALUES ('PL011', 'Platform 1', 'Yes', 203.00, 'ST003');
INSERT INTO PLATFORMS VALUES ('PL012', 'Platform 2', 'No',  203.00, 'ST003');
INSERT INTO PLATFORMS VALUES ('PL013', 'Platform 3', 'Yes', 203.00, 'ST003');
INSERT INTO PLATFORMS VALUES ('PL014', 'Platform 4', 'No',  203.00, 'ST003');
INSERT INTO PLATFORMS VALUES ('PL015', 'Platform 5', 'Yes', 203.00, 'ST003');
INSERT INTO PLATFORMS VALUES ('PL016', 'Platform 1', 'Yes', 204.00, 'ST004');
INSERT INTO PLATFORMS VALUES ('PL017', 'Platform 2', 'No',  204.00, 'ST004');
INSERT INTO PLATFORMS VALUES ('PL018', 'Platform 3', 'Yes', 204.00, 'ST004');
INSERT INTO PLATFORMS VALUES ('PL019', 'Platform 4', 'No',  204.00, 'ST004');
INSERT INTO PLATFORMS VALUES ('PL020', 'Platform 5', 'Yes', 204.00, 'ST004');
INSERT INTO PLATFORMS VALUES ('PL021', 'Platform 1', 'Yes', 205.00, 'ST005');
INSERT INTO PLATFORMS VALUES ('PL022', 'Platform 2', 'No',  205.00, 'ST005');
INSERT INTO PLATFORMS VALUES ('PL023', 'Platform 3', 'Yes', 205.00, 'ST005');
INSERT INTO PLATFORMS VALUES ('PL024', 'Platform 4', 'No',  205.00, 'ST005');
INSERT INTO PLATFORMS VALUES ('PL025', 'Platform 5', 'Yes', 205.00, 'ST005');
INSERT INTO PLATFORMS VALUES ('PL026', 'Platform 1', 'Yes', 206.00, 'ST006');
INSERT INTO PLATFORMS VALUES ('PL027', 'Platform 2', 'No',  206.00, 'ST006');
INSERT INTO PLATFORMS VALUES ('PL028', 'Platform 3', 'Yes', 206.00, 'ST006');
INSERT INTO PLATFORMS VALUES ('PL029', 'Platform 4', 'No',  206.00, 'ST006');
INSERT INTO PLATFORMS VALUES ('PL030', 'Platform 5', 'Yes', 206.00, 'ST006');
INSERT INTO PLATFORMS VALUES ('PL031', 'Platform 1', 'Yes', 350.00, 'ST007');
INSERT INTO PLATFORMS VALUES ('PL032', 'Platform 2', 'Yes', 350.00, 'ST007');
INSERT INTO PLATFORMS VALUES ('PL033', 'Platform 3', 'Yes', 300.00, 'ST007');
INSERT INTO PLATFORMS VALUES ('PL034', 'Platform 4', 'No',  300.00, 'ST007');
INSERT INTO PLATFORMS VALUES ('PL035', 'Platform 5', 'Yes', 250.00, 'ST007');
INSERT INTO PLATFORMS VALUES ('PL036', 'Platform 1', 'Yes', 300.00, 'ST008');
INSERT INTO PLATFORMS VALUES ('PL037', 'Platform 2', 'Yes', 300.00, 'ST008');  
INSERT INTO PLATFORMS VALUES ('PL038', 'Platform 3', 'Yes', 250.00, 'ST008');
INSERT INTO PLATFORMS VALUES ('PL039', 'Platform 4', 'No',  250.00, 'ST008');
INSERT INTO PLATFORMS VALUES ('PL040', 'Platform 5', 'Yes', 200.00, 'ST008');
INSERT INTO PLATFORMS VALUES ('PL041', 'Platform 1', 'Yes', 203.00, 'ST009');
INSERT INTO PLATFORMS VALUES ('PL042', 'Platform 2', 'No',  203.00, 'ST009');
INSERT INTO PLATFORMS VALUES ('PL043', 'Platform 3', 'Yes', 203.00, 'ST009');
INSERT INTO PLATFORMS VALUES ('PL044', 'Platform 4', 'No',  203.00, 'ST009');
INSERT INTO PLATFORMS VALUES ('PL045', 'Platform 5', 'Yes', 203.00, 'ST009');
INSERT INTO PLATFORMS VALUES ('PL046', 'Platform 1', 'Yes', 204.00, 'ST010');
INSERT INTO PLATFORMS VALUES ('PL047', 'Platform 2', 'No',  204.00, 'ST010');
INSERT INTO PLATFORMS VALUES ('PL048', 'Platform 3', 'Yes', 204.00, 'ST010');
INSERT INTO PLATFORMS VALUES ('PL049', 'Platform 4', 'No',  204.00, 'ST010');
INSERT INTO PLATFORMS VALUES ('PL050', 'Platform 5', 'Yes', 204.00, 'ST010');
INSERT INTO PLATFORMS VALUES ('PL051', 'Platform 1', 'Yes', 205.00, 'ST011');
INSERT INTO PLATFORMS VALUES ('PL052', 'Platform 2', 'No',  205.00, 'ST011');
INSERT INTO PLATFORMS VALUES ('PL053', 'Platform 3', 'Yes', 205.00, 'ST011');
INSERT INTO PLATFORMS VALUES ('PL054', 'Platform 4', 'No',  205.00, 'ST011');
INSERT INTO PLATFORMS VALUES ('PL055', 'Platform 5', 'Yes', 205.00, 'ST011');
INSERT INTO PLATFORMS VALUES ('PL056', 'Platform 1', 'Yes', 250.00, 'ST012');
INSERT INTO PLATFORMS VALUES ('PL057', 'Platform 2', 'No',  250.00, 'ST012');
INSERT INTO PLATFORMS VALUES ('PL058', 'Platform 3', 'Yes', 250.00, 'ST012');
INSERT INTO PLATFORMS VALUES ('PL059', 'Platform 4', 'No',  250.00, 'ST012');
INSERT INTO PLATFORMS VALUES ('PL060', 'Platform 5', 'Yes', 250.00, 'ST012');
INSERT INTO PLATFORMS VALUES ('PL066', 'Platform 1', 'Yes', 250.00, 'ST013');
INSERT INTO PLATFORMS VALUES ('PL067', 'Platform 2', 'No',  250.00, 'ST013');
INSERT INTO PLATFORMS VALUES ('PL068', 'Platform 3', 'Yes', 250.00, 'ST013');
INSERT INTO PLATFORMS VALUES ('PL069', 'Platform 4', 'No',  250.00, 'ST013');
INSERT INTO PLATFORMS VALUES ('PL070', 'Platform 5', 'Yes', 250.00, 'ST013');
INSERT INTO PLATFORMS VALUES ('PL071', 'Platform 1', 'Yes', 250.00, 'ST014');
INSERT INTO PLATFORMS VALUES ('PL072', 'Platform 2', 'No',  250.00, 'ST014');
INSERT INTO PLATFORMS VALUES ('PL073', 'Platform 3', 'Yes', 250.00, 'ST014');
INSERT INTO PLATFORMS VALUES ('PL074', 'Platform 4', 'No',  250.00, 'ST014');
INSERT INTO PLATFORMS VALUES ('PL075', 'Platform 5', 'Yes', 250.00, 'ST014');
INSERT INTO PLATFORMS VALUES ('PL076', 'Platform 1', 'Yes', 250.00, 'ST015');
INSERT INTO PLATFORMS VALUES ('PL077', 'Platform 2', 'No',  250.00, 'ST015');
INSERT INTO PLATFORMS VALUES ('PL078', 'Platform 3', 'Yes', 250.00, 'ST015');
INSERT INTO PLATFORMS VALUES ('PL079', 'Platform 4', 'No',  250.00, 'ST015');
INSERT INTO PLATFORMS VALUES ('PL080', 'Platform 5', 'Yes', 250.00, 'ST015');
INSERT INTO PLATFORMS VALUES ('PL081', 'Platform 1', 'Yes', 240.00, 'ST016');
INSERT INTO PLATFORMS VALUES ('PL082', 'Platform 2', 'No',  240.00, 'ST016');
INSERT INTO PLATFORMS VALUES ('PL083', 'Platform 3', 'Yes', 240.00, 'ST016');
INSERT INTO PLATFORMS VALUES ('PL084', 'Platform 4', 'No',  240.00, 'ST016');
INSERT INTO PLATFORMS VALUES ('PL085', 'Platform 5', 'Yes', 240.00, 'ST016');
INSERT INTO PLATFORMS VALUES ('PL086', 'Platform 1', 'Yes', 230.00, 'ST017');
INSERT INTO PLATFORMS VALUES ('PL087', 'Platform 2', 'No',  230.00, 'ST017');
INSERT INTO PLATFORMS VALUES ('PL088', 'Platform 3', 'Yes', 230.00, 'ST017');
INSERT INTO PLATFORMS VALUES ('PL089', 'Platform 4', 'No',  230.00, 'ST017');
INSERT INTO PLATFORMS VALUES ('PL090', 'Platform 5', 'Yes', 230.00, 'ST017');
INSERT INTO PLATFORMS VALUES ('PL091', 'Platform 1', 'Yes', 260.00, 'ST018');
INSERT INTO PLATFORMS VALUES ('PL092', 'Platform 2', 'No',  260.00, 'ST018');
INSERT INTO PLATFORMS VALUES ('PL093', 'Platform 3', 'Yes', 260.00, 'ST018');
INSERT INTO PLATFORMS VALUES ('PL094', 'Platform 4', 'No',  260.00, 'ST018');
INSERT INTO PLATFORMS VALUES ('PL095', 'Platform 5', 'Yes', 260.00, 'ST018');
INSERT INTO PLATFORMS VALUES ('PL096', 'Platform 1', 'Yes', 255.00, 'ST019');
INSERT INTO PLATFORMS VALUES ('PL097', 'Platform 2', 'No',  255.00, 'ST019');
INSERT INTO PLATFORMS VALUES ('PL098', 'Platform 3', 'Yes', 255.00, 'ST019');
INSERT INTO PLATFORMS VALUES ('PL099', 'Platform 4', 'No',  255.00, 'ST019');
INSERT INTO PLATFORMS VALUES ('PL100', 'Platform 5', 'Yes', 255.00, 'ST019');
INSERT INTO PLATFORMS VALUES ('PL101', 'Platform 1', 'Yes', 270.00, 'ST020');
INSERT INTO PLATFORMS VALUES ('PL102', 'Platform 2', 'No',  270.00, 'ST020');
INSERT INTO PLATFORMS VALUES ('PL103', 'Platform 3', 'Yes', 270.00, 'ST020');
INSERT INTO PLATFORMS VALUES ('PL104', 'Platform 4', 'No',  270.00, 'ST020');
INSERT INTO PLATFORMS VALUES ('PL105', 'Platform 5', 'Yes', 270.00, 'ST020');
INSERT INTO PLATFORMS VALUES ('PL106', 'Platform 1', 'Yes', 245.00, 'ST021');
INSERT INTO PLATFORMS VALUES ('PL107', 'Platform 2', 'No',  245.00, 'ST021');
INSERT INTO PLATFORMS VALUES ('PL108', 'Platform 3', 'Yes', 245.00, 'ST021');
INSERT INTO PLATFORMS VALUES ('PL109', 'Platform 4', 'No',  245.00, 'ST021');
INSERT INTO PLATFORMS VALUES ('PL110', 'Platform 5', 'Yes', 245.00, 'ST021');
INSERT INTO PLATFORMS VALUES ('PL111', 'Platform 1', 'Yes', 260.00, 'ST022');
INSERT INTO PLATFORMS VALUES ('PL112', 'Platform 2', 'No',  260.00, 'ST022');
INSERT INTO PLATFORMS VALUES ('PL113', 'Platform 3', 'Yes', 260.00, 'ST022');
INSERT INTO PLATFORMS VALUES ('PL114', 'Platform 4', 'No',  260.00, 'ST022');
INSERT INTO PLATFORMS VALUES ('PL115', 'Platform 5', 'Yes', 260.00, 'ST022');
INSERT INTO PLATFORMS VALUES ('PL116', 'Platform 1', 'Yes', 275.00, 'ST023');
INSERT INTO PLATFORMS VALUES ('PL117', 'Platform 2', 'No',  275.00, 'ST023');
INSERT INTO PLATFORMS VALUES ('PL118', 'Platform 3', 'Yes', 275.00, 'ST023');
INSERT INTO PLATFORMS VALUES ('PL119', 'Platform 4', 'No',  275.00, 'ST023');
INSERT INTO PLATFORMS VALUES ('PL120', 'Platform 5', 'Yes', 275.00, 'ST023');
INSERT INTO PLATFORMS VALUES ('PL121', 'Platform 1', 'Yes', 265.00, 'ST024');
INSERT INTO PLATFORMS VALUES ('PL122', 'Platform 2', 'No',  265.00, 'ST024');
INSERT INTO PLATFORMS VALUES ('PL123', 'Platform 3', 'Yes', 265.00, 'ST024');
INSERT INTO PLATFORMS VALUES ('PL124', 'Platform 4', 'No',  265.00, 'ST024');
INSERT INTO PLATFORMS VALUES ('PL125', 'Platform 5', 'Yes', 265.00, 'ST024');
INSERT INTO PLATFORMS VALUES ('PL126', 'Platform 1', 'Yes', 255.00, 'ST025');
INSERT INTO PLATFORMS VALUES ('PL127', 'Platform 2', 'No',  255.00, 'ST025');
INSERT INTO PLATFORMS VALUES ('PL128', 'Platform 3', 'Yes', 255.00, 'ST025');
INSERT INTO PLATFORMS VALUES ('PL129', 'Platform 4', 'No',  255.00, 'ST025');
INSERT INTO PLATFORMS VALUES ('PL130', 'Platform 5', 'Yes', 255.00, 'ST025');
INSERT INTO PLATFORMS VALUES ('PL131', 'Platform 1', 'Yes', 245.00, 'ST026');
INSERT INTO PLATFORMS VALUES ('PL132', 'Platform 2', 'No',  245.00, 'ST026');
INSERT INTO PLATFORMS VALUES ('PL133', 'Platform 3', 'Yes', 245.00, 'ST026');
INSERT INTO PLATFORMS VALUES ('PL134', 'Platform 4', 'No',  245.00, 'ST026');
INSERT INTO PLATFORMS VALUES ('PL135', 'Platform 5', 'Yes', 245.00, 'ST026');
INSERT INTO PLATFORMS VALUES ('PL136', 'Platform 1', 'Yes', 235.00, 'ST027');
INSERT INTO PLATFORMS VALUES ('PL137', 'Platform 2', 'No',  235.00, 'ST027');
INSERT INTO PLATFORMS VALUES ('PL138', 'Platform 3', 'Yes', 235.00, 'ST027');
INSERT INTO PLATFORMS VALUES ('PL139', 'Platform 4', 'No',  235.00, 'ST027');
INSERT INTO PLATFORMS VALUES ('PL140', 'Platform 5', 'Yes', 235.00, 'ST027');
INSERT INTO PLATFORMS VALUES ('PL141', 'Platform 1', 'Yes', 250.00, 'ST028');
INSERT INTO PLATFORMS VALUES ('PL142', 'Platform 2', 'No',  250.00, 'ST028');
INSERT INTO PLATFORMS VALUES ('PL143', 'Platform 3', 'Yes', 250.00, 'ST028');
INSERT INTO PLATFORMS VALUES ('PL144', 'Platform 4', 'No',  250.00, 'ST028');
INSERT INTO PLATFORMS VALUES ('PL145', 'Platform 5', 'Yes', 250.00, 'ST028');
INSERT INTO PLATFORMS VALUES ('PL146', 'Platform 1', 'Yes', 260.00, 'ST029');
INSERT INTO PLATFORMS VALUES ('PL147', 'Platform 2', 'No',  260.00, 'ST029');
INSERT INTO PLATFORMS VALUES ('PL148', 'Platform 3', 'Yes', 260.00, 'ST029');
INSERT INTO PLATFORMS VALUES ('PL149', 'Platform 4', 'No',  260.00, 'ST029');
INSERT INTO PLATFORMS VALUES ('PL150', 'Platform 5', 'Yes', 260.00, 'ST029');
INSERT INTO PLATFORMS VALUES ('PL151', 'Platform 1', 'Yes', 270.00, 'ST030');
INSERT INTO PLATFORMS VALUES ('PL152', 'Platform 2', 'No',  270.00, 'ST030');
INSERT INTO PLATFORMS VALUES ('PL153', 'Platform 3', 'Yes', 270.00, 'ST030');
INSERT INTO PLATFORMS VALUES ('PL154', 'Platform 4', 'No',  270.00, 'ST030');
INSERT INTO PLATFORMS VALUES ('PL155', 'Platform 5', 'Yes', 270.00, 'ST030');
INSERT INTO PLATFORMS VALUES ('PL156', 'Platform 1', 'Yes', 255.00, 'ST031');
INSERT INTO PLATFORMS VALUES ('PL157', 'Platform 2', 'No',  255.00, 'ST031');
INSERT INTO PLATFORMS VALUES ('PL158', 'Platform 3', 'Yes', 255.00, 'ST031');
INSERT INTO PLATFORMS VALUES ('PL159', 'Platform 4', 'No',  255.00, 'ST031');
INSERT INTO PLATFORMS VALUES ('PL160', 'Platform 5', 'Yes', 255.00, 'ST031');
INSERT INTO PLATFORMS VALUES ('PL161', 'Platform 1', 'Yes', 245.00, 'ST032');
INSERT INTO PLATFORMS VALUES ('PL162', 'Platform 2', 'No',  245.00, 'ST032');
INSERT INTO PLATFORMS VALUES ('PL163', 'Platform 3', 'Yes', 245.00, 'ST032');
INSERT INTO PLATFORMS VALUES ('PL164', 'Platform 4', 'No',  245.00, 'ST032');
INSERT INTO PLATFORMS VALUES ('PL165', 'Platform 5', 'Yes', 245.00, 'ST032');
INSERT INTO PLATFORMS VALUES ('PL166', 'Platform 1', 'Yes', 250.00, 'ST033');
INSERT INTO PLATFORMS VALUES ('PL167', 'Platform 2', 'No',  250.00, 'ST033');
INSERT INTO PLATFORMS VALUES ('PL168', 'Platform 3', 'Yes', 250.00, 'ST033');
INSERT INTO PLATFORMS VALUES ('PL169', 'Platform 4', 'No',  250.00, 'ST033');
INSERT INTO PLATFORMS VALUES ('PL170', 'Platform 5', 'Yes', 250.00, 'ST033');
INSERT INTO PLATFORMS VALUES ('PL171', 'Platform 1', 'Yes', 260.00, 'ST034');
INSERT INTO PLATFORMS VALUES ('PL172', 'Platform 2', 'No',  260.00, 'ST034');
INSERT INTO PLATFORMS VALUES ('PL173', 'Platform 3', 'Yes', 260.00, 'ST034');
INSERT INTO PLATFORMS VALUES ('PL174', 'Platform 4', 'No',  260.00, 'ST034');
INSERT INTO PLATFORMS VALUES ('PL175', 'Platform 5', 'Yes', 260.00, 'ST034');
INSERT INTO PLATFORMS VALUES ('PL176', 'Platform 1', 'Yes', 240.00, 'ST035');
INSERT INTO PLATFORMS VALUES ('PL177', 'Platform 2', 'No',  240.00, 'ST035');
INSERT INTO PLATFORMS VALUES ('PL178', 'Platform 3', 'Yes', 240.00, 'ST035');
INSERT INTO PLATFORMS VALUES ('PL179', 'Platform 4', 'No',  240.00, 'ST035');
INSERT INTO PLATFORMS VALUES ('PL180', 'Platform 5', 'Yes', 240.00, 'ST035');
INSERT INTO PLATFORMS VALUES ('PL181', 'Platform 1', 'Yes', 255.00, 'ST036');
INSERT INTO PLATFORMS VALUES ('PL182', 'Platform 2', 'No',  255.00, 'ST036');
INSERT INTO PLATFORMS VALUES ('PL183', 'Platform 3', 'Yes', 255.00, 'ST036');
INSERT INTO PLATFORMS VALUES ('PL184', 'Platform 4', 'No',  255.00, 'ST036');
INSERT INTO PLATFORMS VALUES ('PL185', 'Platform 5', 'Yes', 255.00, 'ST036');
INSERT INTO PLATFORMS VALUES ('PL186', 'Platform 1', 'Yes', 245.00, 'ST037');
INSERT INTO PLATFORMS VALUES ('PL187', 'Platform 2', 'No',  245.00, 'ST037');
INSERT INTO PLATFORMS VALUES ('PL188', 'Platform 3', 'Yes', 245.00, 'ST037');
INSERT INTO PLATFORMS VALUES ('PL189', 'Platform 4', 'No',  245.00, 'ST037');
INSERT INTO PLATFORMS VALUES ('PL190', 'Platform 5', 'Yes', 245.00, 'ST037');
INSERT INTO PLATFORMS VALUES ('PL191', 'Platform 1', 'Yes', 250.00, 'ST038');
INSERT INTO PLATFORMS VALUES ('PL192', 'Platform 2', 'No', 250.00, 'ST038');
INSERT INTO PLATFORMS VALUES ('PL193', 'Platform 3', 'Yes', 250.00, 'ST038');
INSERT INTO PLATFORMS VALUES ('PL194', 'Platform 4', 'No', 250.00, 'ST038');
INSERT INTO PLATFORMS VALUES ('PL195', 'Platform 5', 'Yes', 250.00, 'ST038');
INSERT INTO PLATFORMS VALUES ('PL196', 'Platform 1', 'Yes', 260.00, 'ST039');
INSERT INTO PLATFORMS VALUES ('PL197', 'Platform 2', 'No', 260.00, 'ST039');
INSERT INTO PLATFORMS VALUES ('PL198', 'Platform 3', 'Yes', 260.00, 'ST039');
INSERT INTO PLATFORMS VALUES ('PL199', 'Platform 4', 'No', 260.00, 'ST039');
INSERT INTO PLATFORMS VALUES ('PL200', 'Platform 5', 'Yes', 260.00, 'ST039');
INSERT INTO PLATFORMS VALUES ('PL201', 'Platform 1', 'Yes', 240.00, 'ST040');
INSERT INTO PLATFORMS VALUES ('PL202', 'Platform 2', 'No', 240.00, 'ST040');
INSERT INTO PLATFORMS VALUES ('PL203', 'Platform 3', 'Yes', 240.00, 'ST040');
INSERT INTO PLATFORMS VALUES ('PL204', 'Platform 4', 'No', 240.00, 'ST040');
INSERT INTO PLATFORMS VALUES ('PL205', 'Platform 5', 'Yes', 240.00, 'ST040');
INSERT INTO PLATFORMS VALUES ('PL206', 'Platform 1', 'Yes', 255.00, 'ST041');
INSERT INTO PLATFORMS VALUES ('PL207', 'Platform 2', 'No', 255.00, 'ST041');
INSERT INTO PLATFORMS VALUES ('PL208', 'Platform 3', 'Yes', 255.00, 'ST041');
INSERT INTO PLATFORMS VALUES ('PL209', 'Platform 4', 'No', 255.00, 'ST041');
INSERT INTO PLATFORMS VALUES ('PL210', 'Platform 5', 'Yes', 255.00, 'ST041');
INSERT INTO PLATFORMS VALUES ('PL211', 'Platform 1', 'Yes', 245.00, 'ST042');
INSERT INTO PLATFORMS VALUES ('PL212', 'Platform 2', 'No', 245.00, 'ST042');
INSERT INTO PLATFORMS VALUES ('PL213', 'Platform 3', 'Yes', 245.00, 'ST042');
INSERT INTO PLATFORMS VALUES ('PL214', 'Platform 4', 'No', 245.00, 'ST042');
INSERT INTO PLATFORMS VALUES ('PL215', 'Platform 5', 'Yes', 245.00, 'ST042');
INSERT INTO PLATFORMS VALUES ('PL216', 'Platform 1', 'Yes', 250.00, 'ST043');
INSERT INTO PLATFORMS VALUES ('PL217', 'Platform 2', 'No', 250.00, 'ST043');
INSERT INTO PLATFORMS VALUES ('PL218', 'Platform 3', 'Yes', 250.00, 'ST043');
INSERT INTO PLATFORMS VALUES ('PL219', 'Platform 4', 'No', 250.00, 'ST043');
INSERT INTO PLATFORMS VALUES ('PL220', 'Platform 5', 'Yes', 250.00, 'ST043');
INSERT INTO PLATFORMS VALUES ('PL221', 'Platform 1', 'Yes', 260.00, 'ST044');
INSERT INTO PLATFORMS VALUES ('PL222', 'Platform 2', 'No', 260.00, 'ST044');
INSERT INTO PLATFORMS VALUES ('PL223', 'Platform 3', 'Yes', 260.00, 'ST044');
INSERT INTO PLATFORMS VALUES ('PL224', 'Platform 4', 'No', 260.00, 'ST044');
INSERT INTO PLATFORMS VALUES ('PL225', 'Platform 5', 'Yes', 260.00, 'ST044');
INSERT INTO PLATFORMS VALUES ('PL226', 'Platform 1', 'Yes', 240.00, 'ST045');
INSERT INTO PLATFORMS VALUES ('PL227', 'Platform 2', 'No', 240.00, 'ST045');
INSERT INTO PLATFORMS VALUES ('PL228', 'Platform 3', 'Yes', 240.00, 'ST045');
INSERT INTO PLATFORMS VALUES ('PL229', 'Platform 4', 'No', 240.00, 'ST045');
INSERT INTO PLATFORMS VALUES ('PL230', 'Platform 5', 'Yes', 240.00, 'ST045');
INSERT INTO PLATFORMS VALUES ('PL231', 'Platform 1', 'Yes', 255.00, 'ST046');
INSERT INTO PLATFORMS VALUES ('PL232', 'Platform 2', 'No', 255.00, 'ST046');
INSERT INTO PLATFORMS VALUES ('PL233', 'Platform 3', 'Yes', 255.00, 'ST046');
INSERT INTO PLATFORMS VALUES ('PL234', 'Platform 4', 'No', 255.00, 'ST046');
INSERT INTO PLATFORMS VALUES ('PL235', 'Platform 5', 'Yes', 255.00, 'ST046');
INSERT INTO PLATFORMS VALUES ('PL236', 'Platform 1', 'Yes', 245.00, 'ST047');
INSERT INTO PLATFORMS VALUES ('PL237', 'Platform 2', 'No', 245.00, 'ST047');
INSERT INTO PLATFORMS VALUES ('PL238', 'Platform 3', 'Yes', 245.00, 'ST047');
INSERT INTO PLATFORMS VALUES ('PL239', 'Platform 4', 'No', 245.00, 'ST047');
INSERT INTO PLATFORMS VALUES ('PL240', 'Platform 5', 'Yes', 245.00, 'ST047');
INSERT INTO PLATFORMS VALUES ('PL241', 'Platform 1', 'Yes', 250.00, 'ST048');
INSERT INTO PLATFORMS VALUES ('PL242', 'Platform 2', 'No', 250.00, 'ST048');
INSERT INTO PLATFORMS VALUES ('PL243', 'Platform 3', 'Yes', 250.00, 'ST048');
INSERT INTO PLATFORMS VALUES ('PL244', 'Platform 4', 'No', 250.00, 'ST048');
INSERT INTO PLATFORMS VALUES ('PL245', 'Platform 5', 'Yes', 250.00, 'ST048');
INSERT INTO PLATFORMS VALUES ('PL246', 'Platform 1', 'Yes', 260.00, 'ST049');
INSERT INTO PLATFORMS VALUES ('PL247', 'Platform 2', 'No', 260.00, 'ST049');
INSERT INTO PLATFORMS VALUES ('PL248', 'Platform 3', 'Yes', 260.00, 'ST049');
INSERT INTO PLATFORMS VALUES ('PL249', 'Platform 4', 'No', 260.00, 'ST049');
INSERT INTO PLATFORMS VALUES ('PL250', 'Platform 5', 'Yes', 260.00, 'ST049');
INSERT INTO PLATFORMS VALUES ('PL061', 'Platform 1', 'Yes', 250.00, 'ST050');
INSERT INTO PLATFORMS VALUES ('PL062', 'Platform 2', 'No',  250.00, 'ST050');
INSERT INTO PLATFORMS VALUES ('PL063', 'Platform 3', 'Yes', 250.00, 'ST050');
INSERT INTO PLATFORMS VALUES ('PL064', 'Platform 4', 'No',  250.00, 'ST050');
INSERT INTO PLATFORMS VALUES ('PL065', 'Platform 5', 'Yes', 250.00, 'ST050');




INSERT INTO EMPLOYEES VALUES ('EMP001', 'Abdul', 'Karim', 'Abdul Karim', TO_DATE('2015-03-15', 'YYYY-MM-DD'), '1234567890', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP001', 'HR', 'Level 3', 'HR Manager');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP001', '01711234567', '01987654321');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP001', 'abdul.karim@br.gov.bd', 'abdul.karim.personal@email.com');

INSERT INTO EMPLOYEES VALUES ('EMP002', 'Shamim', 'Ahmed', 'Shamim Ahmed', TO_DATE('2016-04-10', 'YYYY-MM-DD'), '1234567891', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP002', 'Finance', 'Level 2', 'Finance Officer');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP002', '01721234567', '01987654322');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP002', 'shamim.ahmed@br.gov.bd', 'shamim.ahmed.personal@email.com');

INSERT INTO EMPLOYEES VALUES ('EMP003', 'Nasima', 'Khatun', 'Nasima Khatun', TO_DATE('2017-05-20', 'YYYY-MM-DD'), '1234567892', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP003', 'Admin', 'Level 1', 'Assistant Admin');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP003', '01731234567', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP003', 'nasima.khatun@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP004', 'Fahim', 'Hossain', 'Fahim Hossain', TO_DATE('2018-06-15', 'YYYY-MM-DD'), '1234567893', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP004', 'IT', 'Level 3', 'IT Manager');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP004', '01741234567', '01987654324');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP004', 'fahim.hossain@br.gov.bd', 'fahim.hossain.personal@email.com');

INSERT INTO EMPLOYEES VALUES ('EMP005', 'Rehana', 'Begum', 'Rehana Begum', TO_DATE('2019-07-10', 'YYYY-MM-DD'), '1234567894', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP005', 'HR', 'Level 2', 'HR Officer');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP005', '01751234567', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP005', 'rehana.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP006', 'Imran', 'Ali', 'Imran Ali', TO_DATE('2016-08-25', 'YYYY-MM-DD'), '1234567895', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP006', 'Finance', 'Level 3', 'Finance Manager');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP006', '01761234567', '01987654326');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP006', 'imran.ali@br.gov.bd', 'imran.ali.personal@email.com');

INSERT INTO EMPLOYEES VALUES ('EMP007', 'Sumaiya', 'Parvin', 'Sumaiya Parvin', TO_DATE('2017-09-12', 'YYYY-MM-DD'), '1234567896', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP007', 'Admin', 'Level 1', 'Admin Assistant');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP007', '01771234567', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP007', 'sumaiya.parvin@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP008', 'Jahid', 'Hasan', 'Jahid Hasan', TO_DATE('2018-10-05', 'YYYY-MM-DD'), '1234567897', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP008', 'IT', 'Level 2', 'System Analyst');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP008', '01781234567', '01987654328');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP008', 'jahid.hasan@br.gov.bd', 'jahid.hasan.personal@email.com');

INSERT INTO EMPLOYEES VALUES ('EMP009', 'Lina', 'Akter', 'Lina Akter', TO_DATE('2019-11-20', 'YYYY-MM-DD'), '1234567898', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP009', 'HR', 'Level 1', 'HR Assistant');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP009', '01791234567', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP009', 'lina.akter@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP010', 'Tariq', 'Islam', 'Tariq Islam', TO_DATE('2015-12-15', 'YYYY-MM-DD'), '1234567899', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP010', 'Finance', 'Level 2', 'Accounts Officer');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP010', '01801234567', '01987654330');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP010', 'tariq.islam@br.gov.bd', 'tariq.islam.personal@email.com');

INSERT INTO EMPLOYEES VALUES ('EMP011', 'Rashed', 'Khan', 'Rashed Khan', TO_DATE('2016-01-05', 'YYYY-MM-DD'), '1234567810', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP011', 'Admin', 'Level 1', 'Admin Assistant');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP011', '01811234567', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP011', 'rashed.khan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP012', 'Nusrat', 'Jahan', 'Nusrat Jahan', TO_DATE('2017-02-10', 'YYYY-MM-DD'), '1234567811', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP012', 'HR', 'Level 3', 'HR Manager');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP012', '01821234567', '01987654340');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP012', 'nusrat.jahan@br.gov.bd', 'nusrat.jahan.personal@email.com');

INSERT INTO EMPLOYEES VALUES ('EMP013', 'Firoz', 'Ahmed', 'Firoz Ahmed', TO_DATE('2018-03-15', 'YYYY-MM-DD'), '1234567812', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP013', 'Finance', 'Level 2', 'Finance Officer');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP013', '01831234567', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP013', 'firoz.ahmed@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP014', 'Sabina', 'Sultana', 'Sabina Sultana', TO_DATE('2019-04-20', 'YYYY-MM-DD'), '1234567813', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP014', 'Admin', 'Level 1', 'Admin Assistant');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP014', '01841234567', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP014', 'sabina.sultana@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP015', 'Arif', 'Hossain', 'Arif Hossain', TO_DATE('2015-05-25', 'YYYY-MM-DD'), '1234567814', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP015', 'IT', 'Level 3', 'IT Manager');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP015', '01851234567', '01987654345');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP015', 'arif.hossain@br.gov.bd', 'arif.hossain.personal@email.com');

INSERT INTO EMPLOYEES VALUES ('EMP016', 'Farzana', 'Begum', 'Farzana Begum', TO_DATE('2016-06-30', 'YYYY-MM-DD'), '1234567815', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP016', 'HR', 'Level 2', 'HR Officer');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP016', '01861234567', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP016', 'farzana.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP017', 'Kamal', 'Ahmed', 'Kamal Ahmed', TO_DATE('2017-07-05', 'YYYY-MM-DD'), '1234567816', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP017', 'Finance', 'Level 3', 'Finance Manager');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP017', '01871234567', '01987654347');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP017', 'kamal.ahmed@br.gov.bd', 'kamal.ahmed.personal@email.com');

INSERT INTO EMPLOYEES VALUES ('EMP018', 'Naila', 'Khatun', 'Naila Khatun', TO_DATE('2018-08-10', 'YYYY-MM-DD'), '1234567817', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP018', 'Admin', 'Level 1', 'Admin Assistant');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP018', '01881234567', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP018', 'naila.khatun@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP019', 'Jamil', 'Uddin', 'Jamil Uddin', TO_DATE('2019-09-15', 'YYYY-MM-DD'), '1234567818', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP019', 'IT', 'Level 2', 'System Analyst');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP019', '01891234567', '01987654349');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP019', 'jamil.uddin@br.gov.bd', 'jamil.uddin.personal@email.com');

INSERT INTO EMPLOYEES VALUES ('EMP020', 'Laila', 'Begum', 'Laila Begum', TO_DATE('2015-10-20', 'YYYY-MM-DD'), '1234567819', 'Active');
INSERT INTO ADMIN_STAFF VALUES ('EMP020', 'HR', 'Level 1', 'HR Assistant');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP020', '01901234567', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP020', 'laila.begum@br.gov.bd', NULL);



INSERT INTO EMPLOYEES VALUES ('EMP021', 'Rahim', 'Uddin', 'Rahim Uddin', TO_DATE('2016-05-20', 'YYYY-MM-DD'), '2345678901', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP021', 'DRV12345', 'Intercity, Mail', TO_DATE('2023-01-15', 'YYYY-MM-DD'), '10');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP021', '01811223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP021', 'rahim.uddin@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP022', 'Jamal', 'Hossain', 'Jamal Hossain', TO_DATE('2017-06-22', 'YYYY-MM-DD'), '2345678902', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP022', 'DRV12346', 'Suburban, Mail', TO_DATE('2022-11-10', 'YYYY-MM-DD'), '8');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP022', '01821223344', '01987654321');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP022', 'jamal.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP023', 'Sajid', 'Khan', 'Sajid Khan', TO_DATE('2018-07-15', 'YYYY-MM-DD'), '2345678903', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP023', 'DRV12347', 'Intercity', TO_DATE('2021-08-25', 'YYYY-MM-DD'), '5');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP023', '01831223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP023', 'sajid.khan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP024', 'Rashed', 'Ali', 'Rashed Ali', TO_DATE('2019-08-18', 'YYYY-MM-DD'), '2345678904', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP024', 'DRV12348', 'Mail', TO_DATE('2020-05-30', 'YYYY-MM-DD'), '3');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP024', '01841223344', '01798765432');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP024', 'rashed.ali@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP025', 'Hasan', 'Chowdhury', 'Hasan Chowdhury', TO_DATE('2015-09-12', 'YYYY-MM-DD'), '2345678905', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP025', 'DRV12349', 'Suburban', TO_DATE('2019-12-20', 'YYYY-MM-DD'), '7');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP025', '01851223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP025', 'hasan.chowdhury@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP026', 'Faruk', 'Islam', 'Faruk Islam', TO_DATE('2016-10-10', 'YYYY-MM-DD'), '2345678906', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP026', 'DRV12350', 'Intercity, Mail', TO_DATE('2023-03-01', 'YYYY-MM-DD'), '12');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP026', '01861223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP026', 'faruk.islam@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP027', 'Salma', 'Begum', 'Salma Begum', TO_DATE('2017-11-15', 'YYYY-MM-DD'), '2345678907', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP027', 'DRV12351', 'Intercity', TO_DATE('2021-04-15', 'YYYY-MM-DD'), '6');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP027', '01871223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP027', 'salma.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP028', 'Mizan', 'Haque', 'Mizan Haque', TO_DATE('2018-12-20', 'YYYY-MM-DD'), '2345678908', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP028', 'DRV12352', 'Mail', TO_DATE('2022-07-10', 'YYYY-MM-DD'), '4');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP028', '01881223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP028', 'mizan.haque@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP029', 'Rina', 'Akter', 'Rina Akter', TO_DATE('2019-01-18', 'YYYY-MM-DD'), '2345678909', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP029', 'DRV12353', 'Suburban', TO_DATE('2020-02-05', 'YYYY-MM-DD'), '3');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP029', '01891223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP029', 'rina.akter@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP030', 'Jamal', 'Ahmed', 'Jamal Ahmed', TO_DATE('2015-02-12', 'YYYY-MM-DD'), '2345678910', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP030', 'DRV12354', 'Intercity, Mail', TO_DATE('2018-11-25', 'YYYY-MM-DD'), '9');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP030', '01901223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP030', 'jamal.ahmed@br.gov.bd', NULL);



INSERT INTO EMPLOYEES VALUES ('EMP031', 'Sabbir', 'Rahman', 'Sabbir Rahman', TO_DATE('2016-03-22', 'YYYY-MM-DD'), '2345678911', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP031', 'DRV12355', 'Intercity', TO_DATE('2019-06-18', 'YYYY-MM-DD'), '7');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP031', '01911223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP031', 'sabbir.rahman@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP032', 'Farhana', 'Sultana', 'Farhana Sultana', TO_DATE('2017-04-30', 'YYYY-MM-DD'), '2345678912', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP032', 'DRV12356', 'Mail', TO_DATE('2020-01-12', 'YYYY-MM-DD'), '5');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP032', '01921223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP032', 'farhana.sultana@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP033', 'Iqbal', 'Hossain', 'Iqbal Hossain', TO_DATE('2018-05-15', 'YYYY-MM-DD'), '2345678913', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP033', 'DRV12357', 'Suburban', TO_DATE('2021-08-09', 'YYYY-MM-DD'), '4');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP033', '01931223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP033', 'iqbal.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP034', 'Mumtaz', 'Khan', 'Mumtaz Khan', TO_DATE('2019-06-10', 'YYYY-MM-DD'), '2345678914', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP034', 'DRV12358', 'Intercity, Mail', TO_DATE('2022-04-20', 'YYYY-MM-DD'), '3');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP034', '01941223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP034', 'mumtaz.khan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP035', 'Reza', 'Ahmed', 'Reza Ahmed', TO_DATE('2015-07-25', 'YYYY-MM-DD'), '2345678915', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP035', 'DRV12359', 'Mail', TO_DATE('2017-11-30', 'YYYY-MM-DD'), '10');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP035', '01951223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP035', 'reza.ahmed@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP036', 'Sadia', 'Begum', 'Sadia Begum', TO_DATE('2016-08-05', 'YYYY-MM-DD'), '2345678916', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP036', 'DRV12360', 'Suburban', TO_DATE('2019-03-22', 'YYYY-MM-DD'), '6');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP036', '01961223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP036', 'sadia.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP037', 'Tariq', 'Hossain', 'Tariq Hossain', TO_DATE('2017-09-12', 'YYYY-MM-DD'), '2345678917', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP037', 'DRV12361', 'Intercity', TO_DATE('2020-12-05', 'YYYY-MM-DD'), '8');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP037', '01971223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP037', 'tariq.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP038', 'Roksana', 'Khatun', 'Roksana Khatun', TO_DATE('2018-10-18', 'YYYY-MM-DD'), '2345678918', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP038', 'DRV12362', 'Mail', TO_DATE('2021-07-30', 'YYYY-MM-DD'), '5');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP038', '01981223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP038', 'roksana.khatun@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP039', 'Javed', 'Ali', 'Javed Ali', TO_DATE('2019-11-23', 'YYYY-MM-DD'), '2345678919', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP039', 'DRV12363', 'Suburban', TO_DATE('2022-06-10', 'YYYY-MM-DD'), '3');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP039', '01991223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP039', 'javed.ali@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP040', 'Mona', 'Islam', 'Mona Islam', TO_DATE('2015-12-28', 'YYYY-MM-DD'), '2345678920', 'Active');
INSERT INTO ENGINE_DRIVERS VALUES ('EMP040', 'DRV12364', 'Intercity, Mail', TO_DATE('2018-09-15', 'YYYY-MM-DD'), '7');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP040', '02001223344', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP040', 'mona.islam@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP041', 'Kamal', 'Hossain', 'Kamal Hossain', TO_DATE('2017-01-10', 'YYYY-MM-DD'), '3456789012', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP041', 'Engine Specialist', 'Level 3', 'Tool Set A');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP041', '01955667788', '01611223344');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP041', 'kamal.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP042', 'Nazmul', 'Islam', 'Nazmul Islam', TO_DATE('2016-02-20', 'YYYY-MM-DD'), '3456789013', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP042', 'Signal Technician', 'Level 2', 'Tool Set B');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP042', '01965667788', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP042', 'nazmul.islam@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP043', 'Rina', 'Begum', 'Rina Begum', TO_DATE('2018-03-15', 'YYYY-MM-DD'), '3456789014', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP043', 'Track Engineer', 'Level 1', 'Tool Set C');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP043', '01975667788', '01711223344');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP043', 'rina.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP044', 'Faisal', 'Khan', 'Faisal Khan', TO_DATE('2019-04-10', 'YYYY-MM-DD'), '3456789015', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP044', 'Electrical Engineer', 'Level 3', 'Tool Set D');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP044', '01985667788', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP044', 'faisal.khan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP045', 'Tania', 'Sultana', 'Tania Sultana', TO_DATE('2017-05-05', 'YYYY-MM-DD'), '3456789016', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP045', 'Signal Technician', 'Level 2', 'Tool Set B');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP045', '01995667788', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP045', 'tania.sultana@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP046', 'Rashed', 'Ahmed', 'Rashed Ahmed', TO_DATE('2016-06-01', 'YYYY-MM-DD'), '3456789017', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP046', 'Engine Specialist', 'Level 3', 'Tool Set A');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP046', '01905667788', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP046', 'rashed.ahmed@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP047', 'Sumaiya', 'Parvin', 'Sumaiya Parvin', TO_DATE('2018-07-25', 'YYYY-MM-DD'), '3456789018', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP047', 'Track Engineer', 'Level 1', 'Tool Set C');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP047', '01915667788', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP047', 'sumaiya.parvin@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP048', 'Jahid', 'Hasan', 'Jahid Hasan', TO_DATE('2019-08-30', 'YYYY-MM-DD'), '3456789019', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP048', 'Electrical Engineer', 'Level 2', 'Tool Set D');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP048', '01925667788', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP048', 'jahid.hasan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP049', 'Nusrat', 'Jahan', 'Nusrat Jahan', TO_DATE('2017-09-15', 'YYYY-MM-DD'), '3456789020', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP049', 'Signal Technician', 'Level 1', 'Tool Set B');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP049', '01935667788', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP049', 'nusrat.jahan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP050', 'Firoz', 'Ahmed', 'Firoz Ahmed', TO_DATE('2016-10-20', 'YYYY-MM-DD'), '3456789021', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP050', 'Engine Specialist', 'Level 3', 'Tool Set A');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP050', '01945667788', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP050', 'firoz.ahmed@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP051', 'Rumana', 'Khatun', 'Rumana Khatun', TO_DATE('2017-11-10', 'YYYY-MM-DD'), '3456789022', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP051', 'Track Engineer', 'Level 2', 'Tool Set C');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP051', '01955667789', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP051', 'rumana.khatun@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP052', 'Iqbal', 'Hossain', 'Iqbal Hossain', TO_DATE('2018-12-05', 'YYYY-MM-DD'), '3456789023', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP052', 'Electrical Engineer', 'Level 1', 'Tool Set D');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP052', '01965667789', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP052', 'iqbal.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP053', 'Shamim', 'Ali', 'Shamim Ali', TO_DATE('2019-01-25', 'YYYY-MM-DD'), '3456789024', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP053', 'Signal Technician', 'Level 3', 'Tool Set B');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP053', '01975667789', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP053', 'shamim.ali@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP054', 'Rina', 'Begum', 'Rina Begum', TO_DATE('2015-02-15', 'YYYY-MM-DD'), '3456789025', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP054', 'Engine Specialist', 'Level 2', 'Tool Set A');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP054', '01985667789', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP054', 'rina.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP055', 'Fahim', 'Khan', 'Fahim Khan', TO_DATE('2016-03-10', 'YYYY-MM-DD'), '3456789026', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP055', 'Track Engineer', 'Level 1', 'Tool Set C');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP055', '01995667789', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP055', 'fahim.khan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP056', 'Sumaiya', 'Parvin', 'Sumaiya Parvin', TO_DATE('2017-04-05', 'YYYY-MM-DD'), '3456789027', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP056', 'Electrical Engineer', 'Level 3', 'Tool Set D');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP056', '01905667790', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP056', 'sumaiya.parvin@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP057', 'Jahid', 'Hasan', 'Jahid Hasan', TO_DATE('2018-05-20', 'YYYY-MM-DD'), '3456789028', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP057', 'Signal Technician', 'Level 2', 'Tool Set B');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP057', '01915667790', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP057', 'jahid.hasan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP058', 'Nusrat', 'Jahan', 'Nusrat Jahan', TO_DATE('2019-06-25', 'YYYY-MM-DD'), '3456789029', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP058', 'Engine Specialist', 'Level 1', 'Tool Set A');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP058', '01925667790', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP058', 'nusrat.jahan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP059', 'Firoz', 'Ahmed', 'Firoz Ahmed', TO_DATE('2015-07-30', 'YYYY-MM-DD'), '3456789030', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP059', 'Track Engineer', 'Level 3', 'Tool Set C');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP059', '01935667790', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP059', 'firoz.ahmed@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP060', 'Rumana', 'Khatun', 'Rumana Khatun', TO_DATE('2016-08-15', 'YYYY-MM-DD'), '3456789031', 'Active');
INSERT INTO MAINTENANCE_WORKERS VALUES ('EMP060', 'Electrical Engineer', 'Level 2', 'Tool Set D');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP060', '01945667790', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP060', 'rumana.khatun@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP061', 'Fatema', 'Begum', 'Fatema Begum', TO_DATE('2018-07-25', 'YYYY-MM-DD'), '4567890123', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP061', 'Counter 1', 'Morning Shift', 50);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP061', '01512345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP061', 'fatema.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP062', 'Shahida', 'Khatun', 'Shahida Khatun', TO_DATE('2017-08-15', 'YYYY-MM-DD'), '4567890124', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP062', 'Counter 2', 'Evening Shift', 40);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP062', '01522345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP062', 'shahida.khatun@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP063', 'Raju', 'Hossain', 'Raju Hossain', TO_DATE('2019-09-10', 'YYYY-MM-DD'), '4567890125', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP063', 'Counter 3', 'Morning Shift', 45);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP063', '01532345678', '01711234567');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP063', 'raju.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP064', 'Naila', 'Begum', 'Naila Begum', TO_DATE('2016-10-20', 'YYYY-MM-DD'), '4567890126', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP064', 'Counter 4', 'Evening Shift', 35);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP064', '01542345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP064', 'naila.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP065', 'Jahid', 'Islam', 'Jahid Islam', TO_DATE('2015-11-25', 'YYYY-MM-DD'), '4567890127', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP065', 'Counter 5', 'Morning Shift', 30);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP065', '01552345678', '01811234567');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP065', 'jahid.islam@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP066', 'Shamima', 'Akter', 'Shamima Akter', TO_DATE('2018-12-15', 'YYYY-MM-DD'), '4567890128', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP066', 'Counter 1', 'Morning Shift', 50);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP066', '01562345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP066', 'shamima.akter@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP067', 'Riaz', 'Ahmed', 'Riaz Ahmed', TO_DATE('2017-01-10', 'YYYY-MM-DD'), '4567890129', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP067', 'Counter 2', 'Evening Shift', 40);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP067', '01572345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP067', 'riaz.ahmed@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP068', 'Sadia', 'Parvin', 'Sadia Parvin', TO_DATE('2019-02-18', 'YYYY-MM-DD'), '4567890130', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP068', 'Counter 3', 'Morning Shift', 45);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP068', '01582345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP068', 'sadia.parvin@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP069', 'Kamal', 'Hossain', 'Kamal Hossain', TO_DATE('2016-03-22', 'YYYY-MM-DD'), '4567890131', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP069', 'Counter 4', 'Evening Shift', 35);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP069', '01592345678', '01721234567');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP069', 'kamal.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP070', 'Mina', 'Begum', 'Mina Begum', TO_DATE('2015-04-10', 'YYYY-MM-DD'), '4567890132', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP070', 'Counter 5', 'Morning Shift', 30);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP070', '01602345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP070', 'mina.begum@br.gov.bd', NULL);



INSERT INTO EMPLOYEES VALUES ('EMP071', 'Sabbir', 'Rahman', 'Sabbir Rahman', TO_DATE('2017-05-05', 'YYYY-MM-DD'), '4567890133', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP071', 'Counter 1', 'Morning Shift', 50);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP071', '01612345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP071', 'sabbir.rahman@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP072', 'Nusrat', 'Jahan', 'Nusrat Jahan', TO_DATE('2018-06-10', 'YYYY-MM-DD'), '4567890134', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP072', 'Counter 2', 'Evening Shift', 40);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP072', '01622345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP072', 'nusrat.jahan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP073', 'Iqbal', 'Hossain', 'Iqbal Hossain', TO_DATE('2019-07-15', 'YYYY-MM-DD'), '4567890135', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP073', 'Counter 3', 'Morning Shift', 45);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP073', '01632345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP073', 'iqbal.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP074', 'Sabina', 'Sultana', 'Sabina Sultana', TO_DATE('2015-08-20', 'YYYY-MM-DD'), '4567890136', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP074', 'Counter 4', 'Evening Shift', 35);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP074', '01642345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP074', 'sabina.sultana@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP075', 'Arif', 'Khan', 'Arif Khan', TO_DATE('2016-09-25', 'YYYY-MM-DD'), '4567890137', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP075', 'Counter 5', 'Morning Shift', 30);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP075', '01652345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP075', 'arif.khan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP076', 'Tania', 'Begum', 'Tania Begum', TO_DATE('2017-10-30', 'YYYY-MM-DD'), '4567890138', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP076', 'Counter 1', 'Morning Shift', 50);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP076', '01662345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP076', 'tania.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP077', 'Jamil', 'Uddin', 'Jamil Uddin', TO_DATE('2018-11-05', 'YYYY-MM-DD'), '4567890139', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP077', 'Counter 2', 'Evening Shift', 40);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP077', '01672345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP077', 'jamil.uddin@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP078', 'Lina', 'Akter', 'Lina Akter', TO_DATE('2019-12-10', 'YYYY-MM-DD'), '4567890140', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP078', 'Counter 3', 'Morning Shift', 45);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP078', '01682345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP078', 'lina.akter@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP079', 'Rashid', 'Ali', 'Rashid Ali', TO_DATE('2015-01-15', 'YYYY-MM-DD'), '4567890141', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP079', 'Counter 4', 'Evening Shift', 35);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP079', '01692345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP079', 'rashid.ali@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP080', 'Farzana', 'Sultana', 'Farzana Sultana', TO_DATE('2016-02-20', 'YYYY-MM-DD'), '4567890142', 'Active');
INSERT INTO TICKET_COUNTER_STAFF VALUES ('EMP080', 'Counter 5', 'Morning Shift', 30);
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP080', '01702345678', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP080', 'farzana.sultana@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP081', 'Nurul', 'Islam', 'Nurul Islam', TO_DATE('2019-02-18', 'YYYY-MM-DD'), '5678901234', 'Active');
INSERT INTO GUARDS VALUES ('EMP081', 'GRD123', 'Platform 1', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP081', '01798765432', '01876543210');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP081', 'nurul.islam@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP082', 'Rashed', 'Khan', 'Rashed Khan', TO_DATE('2018-06-12', 'YYYY-MM-DD'), '5678901235', 'Active');
INSERT INTO GUARDS VALUES ('EMP082', 'GRD124', 'Platform 2', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP082', '01788765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP082', 'rashed.khan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP083', 'Sabina', 'Begum', 'Sabina Begum', TO_DATE('2017-11-22', 'YYYY-MM-DD'), '5678901236', 'Active');
INSERT INTO GUARDS VALUES ('EMP083', 'GRD125', 'Platform 3', 'No');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP083', '01778765432', '01866543210');
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP083', 'sabina.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP084', 'Fahim', 'Hossain', 'Fahim Hossain', TO_DATE('2016-08-15', 'YYYY-MM-DD'), '5678901237', 'Active');
INSERT INTO GUARDS VALUES ('EMP084', 'GRD126', 'Platform 4', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP084', '01768765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP084', 'fahim.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP085', 'Rina', 'Akter', 'Rina Akter', TO_DATE('2019-01-20', 'YYYY-MM-DD'), '5678901238', 'Active');
INSERT INTO GUARDS VALUES ('EMP085', 'GRD127', 'Platform 5', 'No');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP085', '01758765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP085', 'rina.akter@br.gov.bd', NULL);


INSERT INTO EMPLOYEES VALUES ('EMP086', 'Javed', 'Khan', 'Javed Khan', TO_DATE('2017-03-10', 'YYYY-MM-DD'), '5678901240', 'Active');
INSERT INTO GUARDS VALUES ('EMP086', 'GRD128', 'Platform 1', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP086', '01708765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP086', 'javed.khan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP087', 'Sadia', 'Begum', 'Sadia Begum', TO_DATE('2018-04-15', 'YYYY-MM-DD'), '5678901241', 'Active');
INSERT INTO GUARDS VALUES ('EMP087', 'GRD129', 'Platform 2', 'No');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP087', '01718765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP087', 'sadia.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP088', 'Rashed', 'Islam', 'Rashed Islam', TO_DATE('2019-05-20', 'YYYY-MM-DD'), '5678901242', 'Active');
INSERT INTO GUARDS VALUES ('EMP088', 'GRD130', 'Platform 3', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP088', '01728765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP088', 'rashed.islam@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP089', 'Mina', 'Khatun', 'Mina Khatun', TO_DATE('2015-06-25', 'YYYY-MM-DD'), '5678901243', 'Active');
INSERT INTO GUARDS VALUES ('EMP089', 'GRD131', 'Platform 4', 'No');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP089', '01738765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP089', 'mina.khatun@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP090', 'Fahim', 'Ali', 'Fahim Ali', TO_DATE('2016-07-30', 'YYYY-MM-DD'), '5678901244', 'Active');
INSERT INTO GUARDS VALUES ('EMP090', 'GRD132', 'Platform 5', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP090', '01748765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP090', 'fahim.ali@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP091', 'Sumaiya', 'Begum', 'Sumaiya Begum', TO_DATE('2017-08-15', 'YYYY-MM-DD'), '5678901245', 'Active');
INSERT INTO GUARDS VALUES ('EMP091', 'GRD133', 'Platform 1', 'No');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP091', '01758765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP091', 'sumaiya.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP092', 'Jahid', 'Hossain', 'Jahid Hossain', TO_DATE('2018-09-20', 'YYYY-MM-DD'), '5678901246', 'Active');
INSERT INTO GUARDS VALUES ('EMP092', 'GRD134', 'Platform 2', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP092', '01768765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP092', 'jahid.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP093', 'Nusrat', 'Islam', 'Nusrat Islam', TO_DATE('2019-10-25', 'YYYY-MM-DD'), '5678901247', 'Active');
INSERT INTO GUARDS VALUES ('EMP093', 'GRD135', 'Platform 3', 'No');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP093', '01778765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP093', 'nusrat.islam@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP094', 'Firoz', 'Khan', 'Firoz Khan', TO_DATE('2015-11-30', 'YYYY-MM-DD'), '5678901248', 'Active');
INSERT INTO GUARDS VALUES ('EMP094', 'GRD136', 'Platform 4', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP094', '01788765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP094', 'firoz.khan@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP095', 'Rumana', 'Begum', 'Rumana Begum', TO_DATE('2016-12-15', 'YYYY-MM-DD'), '5678901249', 'Active');
INSERT INTO GUARDS VALUES ('EMP095', 'GRD137', 'Platform 5', 'No');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP095', '01798765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP095', 'rumana.begum@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP096', 'Iqbal', 'Ahmed', 'Iqbal Ahmed', TO_DATE('2017-01-10', 'YYYY-MM-DD'), '5678901250', 'Active');
INSERT INTO GUARDS VALUES ('EMP096', 'GRD138', 'Platform 1', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP096', '01808765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP096', 'iqbal.ahmed@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP097', 'Sabina', 'Khatun', 'Sabina Khatun', TO_DATE('2018-02-15', 'YYYY-MM-DD'), '5678901251', 'Active');
INSERT INTO GUARDS VALUES ('EMP097', 'GRD139', 'Platform 2', 'No');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP097', '01818765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP097', 'sabina.khatun@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP098', 'Rashid', 'Hossain', 'Rashid Hossain', TO_DATE('2019-03-20', 'YYYY-MM-DD'), '5678901252', 'Active');
INSERT INTO GUARDS VALUES ('EMP098', 'GRD140', 'Platform 3', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP098', '01828765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP098', 'rashid.hossain@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP099', 'Mina', 'Islam', 'Mina Islam', TO_DATE('2015-04-25', 'YYYY-MM-DD'), '5678901253', 'Active');
INSERT INTO GUARDS VALUES ('EMP099', 'GRD141', 'Platform 4', 'No');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP099', '01838765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP099', 'mina.islam@br.gov.bd', NULL);

INSERT INTO EMPLOYEES VALUES ('EMP100', 'Fahim', 'Begum', 'Fahim Begum', TO_DATE('2016-05-30', 'YYYY-MM-DD'), '5678901254', 'Active');
INSERT INTO GUARDS VALUES ('EMP100', 'GRD142', 'Platform 5', 'Yes');
INSERT INTO EMPLOYEE_PHONE_NUMBER VALUES ('EMP100', '01848765432', NULL);
INSERT INTO EMPLOYEE_EMAIL VALUES ('EMP100', 'fahim.begum@br.gov.bd', NULL);




INSERT INTO CLASSES VALUES ('CL001', 'AC', 'Air Conditioned', 1.5);
INSERT INTO CLASSES VALUES ('CL002', 'First Class', 'First Class Non-AC', 1.2);
INSERT INTO CLASSES VALUES ('CL003', 'Shovan', 'Standard Class', 1.0);
INSERT INTO CLASSES VALUES ('CL004', 'Shovan Chair', 'Standard Chair Car', 1.1);
INSERT INTO CLASSES VALUES ('CL005', 'AC Chair', 'Air Conditioned Chair Car', 1.4);




INSERT INTO TRAINS VALUES ('TR001', 'Subarna Express', '701', 'Active', 500, 'Intercity', '120');
INSERT INTO TRAINS VALUES ('TR002', 'Mohanagar Provati', '703', 'Active', 500, 'Intercity', '120');
INSERT INTO TRAINS VALUES ('TR003', 'Mohanagar Godhuli', '705', 'Active', 500, 'Intercity', '120');
INSERT INTO TRAINS VALUES ('TR004', 'Ekota Express', '751', 'Active', 500, 'Mail', '100');
INSERT INTO TRAINS VALUES ('TR005', 'Tista Express', '759', 'Active', 500, 'Mail', '100');
INSERT INTO TRAINS VALUES ('TR006', 'Chitra Express', '707', 'Active', 500, 'Intercity', '120');
INSERT INTO TRAINS VALUES ('TR007', 'Kapotaksha Express', '709', 'Active', 500, 'Intercity', '120');
INSERT INTO TRAINS VALUES ('TR008', 'Sundarban Express', '711', 'Active', 500, 'Intercity', '120');
INSERT INTO TRAINS VALUES ('TR009', 'Rangpur Express', '753', 'Active', 500, 'Mail', '100');
INSERT INTO TRAINS VALUES ('TR010', 'Drutajan Express', '755', 'Active', 500, 'Mail', '100');
INSERT INTO TRAINS VALUES ('TR011', 'Padma Express', '761', 'Active', 450, 'Mail', '110');
INSERT INTO TRAINS VALUES ('TR012', 'Meghna Express', '763', 'Active', 450, 'Mail', '110');
INSERT INTO TRAINS VALUES ('TR013', 'Nilsagar Express', '765', 'Active', 450, 'Mail', '110');
INSERT INTO TRAINS VALUES ('TR014', 'Joydev Express', '767', 'Active', 450, 'Mail', '110');
INSERT INTO TRAINS VALUES ('TR015', 'Rajshahi Express', '769', 'Active', 450, 'Intercity', '115');
INSERT INTO TRAINS VALUES ('TR016', 'Barishal Express', '771', 'Active', 450, 'Intercity', '115');
INSERT INTO TRAINS VALUES ('TR017', 'Paharpur Express', '773', 'Active', 450, 'Intercity', '115');
INSERT INTO TRAINS VALUES ('TR018', 'Jamuna Express', '775', 'Active', 450, 'Intercity', '115');
INSERT INTO TRAINS VALUES ('TR019', 'Sundarban Mail', '777', 'Active', 400, 'Mail', '105');
INSERT INTO TRAINS VALUES ('TR020', 'Moyna Express', '779', 'Active', 400, 'Mail', '105');



INSERT INTO FARE_RULES VALUES ('FR001', 'RT001', 500.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL001');
INSERT INTO FARE_RULES VALUES ('FR002', 'RT001', 400.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL002');
INSERT INTO FARE_RULES VALUES ('FR003', 'RT001', 300.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL003');
INSERT INTO FARE_RULES VALUES ('FR004', 'RT001', 350.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL004');
INSERT INTO FARE_RULES VALUES ('FR005', 'RT001', 450.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL005');
INSERT INTO FARE_RULES VALUES ('FR006', 'RT002', 450.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL001');
INSERT INTO FARE_RULES VALUES ('FR007', 'RT002', 350.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL002');
INSERT INTO FARE_RULES VALUES ('FR008', 'RT002', 250.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL003');
INSERT INTO FARE_RULES VALUES ('FR009', 'RT002', 300.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL004');
INSERT INTO FARE_RULES VALUES ('FR010', 'RT002', 400.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL005');
INSERT INTO FARE_RULES VALUES ('FR011', 'RT003', 550.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL001');
INSERT INTO FARE_RULES VALUES ('FR012', 'RT003', 450.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL002');
INSERT INTO FARE_RULES VALUES ('FR013', 'RT003', 350.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL003');
INSERT INTO FARE_RULES VALUES ('FR014', 'RT003', 400.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL004');
INSERT INTO FARE_RULES VALUES ('FR015', 'RT003', 500.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL005');
INSERT INTO FARE_RULES VALUES ('FR016', 'RT004', 480.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL001');
INSERT INTO FARE_RULES VALUES ('FR017', 'RT004', 380.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL002');
INSERT INTO FARE_RULES VALUES ('FR018', 'RT004', 280.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL003');
INSERT INTO FARE_RULES VALUES ('FR019', 'RT004', 330.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL004');
INSERT INTO FARE_RULES VALUES ('FR020', 'RT004', 430.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL005');
INSERT INTO FARE_RULES VALUES ('FR021', 'RT005', 200.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL001');
INSERT INTO FARE_RULES VALUES ('FR022', 'RT005', 150.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL002');
INSERT INTO FARE_RULES VALUES ('FR023', 'RT005', 100.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL003');
INSERT INTO FARE_RULES VALUES ('FR024', 'RT005', 120.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL004');
INSERT INTO FARE_RULES VALUES ('FR025', 'RT005', 180.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL005');
INSERT INTO FARE_RULES VALUES ('FR026', 'RT006', 220.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL001');
INSERT INTO FARE_RULES VALUES ('FR027', 'RT006', 170.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL002');
INSERT INTO FARE_RULES VALUES ('FR028', 'RT006', 130.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL003');
INSERT INTO FARE_RULES VALUES ('FR029', 'RT006', 150.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL004');
INSERT INTO FARE_RULES VALUES ('FR030', 'RT006', 200.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL005');
INSERT INTO FARE_RULES VALUES ('FR031', 'RT007', 280.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL001');
INSERT INTO FARE_RULES VALUES ('FR032', 'RT007', 230.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL002');
INSERT INTO FARE_RULES VALUES ('FR033', 'RT007', 180.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL003');
INSERT INTO FARE_RULES VALUES ('FR034', 'RT007', 200.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL004');
INSERT INTO FARE_RULES VALUES ('FR035', 'RT007', 250.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL005');
INSERT INTO FARE_RULES VALUES ('FR036', 'RT008', 140.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL001');
INSERT INTO FARE_RULES VALUES ('FR037', 'RT008', 110.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL002');
INSERT INTO FARE_RULES VALUES ('FR038', 'RT008', 90.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL003');
INSERT INTO FARE_RULES VALUES ('FR039', 'RT008', 100.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL004');
INSERT INTO FARE_RULES VALUES ('FR040', 'RT008', 130.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL005');
INSERT INTO FARE_RULES VALUES ('FR041', 'RT009', 320.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL001');
INSERT INTO FARE_RULES VALUES ('FR042', 'RT009', 270.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL002');
INSERT INTO FARE_RULES VALUES ('FR043', 'RT009', 220.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL003');
INSERT INTO FARE_RULES VALUES ('FR044', 'RT009', 250.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL004');
INSERT INTO FARE_RULES VALUES ('FR045', 'RT009', 300.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL005');
INSERT INTO FARE_RULES VALUES ('FR046', 'RT010', 280.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL001');
INSERT INTO FARE_RULES VALUES ('FR047', 'RT010', 230.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL002');
INSERT INTO FARE_RULES VALUES ('FR048', 'RT010', 180.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL003');
INSERT INTO FARE_RULES VALUES ('FR049', 'RT010', 200.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL004');
INSERT INTO FARE_RULES VALUES ('FR050', 'RT010', 250.00, 1.0, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'CL005');






INSERT INTO ROUTES VALUES ('RT001', 'ST001', 'ST002', '350', 'FR001', 'TR001');
INSERT INTO ROUTES VALUES ('RT002', 'ST001', 'ST003', '340', 'FR002', 'TR002');
INSERT INTO ROUTES VALUES ('RT003', 'ST001', 'ST004', '400', 'FR003', 'TR003');
INSERT INTO ROUTES VALUES ('RT004', 'ST001', 'ST005', '320', 'FR004', 'TR004');
INSERT INTO ROUTES VALUES ('RT005', 'ST002', 'ST007', '150', 'FR005', 'TR005');
INSERT INTO ROUTES VALUES ('RT006', 'ST001', 'ST006', '120', 'FR006', 'TR006');
INSERT INTO ROUTES VALUES ('RT007', 'ST003', 'ST009', '200', 'FR007', 'TR007');
INSERT INTO ROUTES VALUES ('RT008', 'ST004', 'ST050', '80', 'FR009', 'TR008');
INSERT INTO ROUTES VALUES ('RT009', 'ST005', 'ST001', '320', 'FR010', 'TR009');
INSERT INTO ROUTES VALUES ('RT010', 'ST006', 'ST001', '120', 'FR011', 'TR010');
INSERT INTO ROUTES VALUES ('RT011', 'ST007', 'ST002', '150', 'FR012', 'TR011');
INSERT INTO ROUTES VALUES ('RT012', 'ST009', 'ST003', '200', 'FR013', 'TR012');
INSERT INTO ROUTES VALUES ('RT013', 'ST050', 'ST004', '80', 'FR014', 'TR013');
INSERT INTO ROUTES VALUES ('RT014', 'ST002', 'ST001', '350', 'FR014', 'TR014');
INSERT INTO ROUTES VALUES ('RT015', 'ST003', 'ST001', '340', 'FR016', 'TR015');
INSERT INTO ROUTES VALUES ('RT016', 'ST004', 'ST001', '400', 'FR017', 'TR016');
INSERT INTO ROUTES VALUES ('RT017', 'ST005', 'ST001', '320', 'FR018', 'TR017');
INSERT INTO ROUTES VALUES ('RT018', 'ST001', 'ST007', '470', 'FR019', 'TR018');
INSERT INTO ROUTES VALUES ('RT019', 'ST006', 'ST002', '370', 'FR020', 'TR019');
INSERT INTO ROUTES VALUES ('RT020', 'ST009', 'ST005', '280', 'FR021', 'TR020');





INSERT INTO COACH VALUES ('CH001', 'A1', 50, 'TR001', 'CL001');
INSERT INTO COACH VALUES ('CH002', 'A2', 50, 'TR001', 'CL001');
INSERT INTO COACH VALUES ('CH003', 'B1', 60, 'TR001', 'CL002');
INSERT INTO COACH VALUES ('CH004', 'B2', 60, 'TR001', 'CL002');
INSERT INTO COACH VALUES ('CH005', 'S1', 70, 'TR001', 'CL003');
INSERT INTO COACH VALUES ('CH006', 'A1', 50, 'TR002', 'CL001');
INSERT INTO COACH VALUES ('CH007', 'B1', 60, 'TR002', 'CL002');
INSERT INTO COACH VALUES ('CH008', 'B2', 60, 'TR002', 'CL002');
INSERT INTO COACH VALUES ('CH009', 'S1', 70, 'TR002', 'CL003');
INSERT INTO COACH VALUES ('CH010', 'S2', 70, 'TR002', 'CL003');
INSERT INTO COACH VALUES ('CH011', 'A1', 50, 'TR003', 'CL001');
INSERT INTO COACH VALUES ('CH012', 'A2', 50, 'TR003', 'CL001');
INSERT INTO COACH VALUES ('CH013', 'B1', 60, 'TR003', 'CL002');
INSERT INTO COACH VALUES ('CH014', 'B2', 60, 'TR003', 'CL002');
INSERT INTO COACH VALUES ('CH015', 'S1', 70, 'TR003', 'CL003');
INSERT INTO COACH VALUES ('CH016', 'A1', 50, 'TR004', 'CL001');
INSERT INTO COACH VALUES ('CH017', 'B1', 60, 'TR004', 'CL002');
INSERT INTO COACH VALUES ('CH018', 'B2', 60, 'TR004', 'CL002');
INSERT INTO COACH VALUES ('CH019', 'S1', 70, 'TR004', 'CL003');
INSERT INTO COACH VALUES ('CH020', 'S2', 70, 'TR004', 'CL003');
INSERT INTO COACH VALUES ('CH021', 'A1', 50, 'TR005', 'CL001');
INSERT INTO COACH VALUES ('CH022', 'A2', 50, 'TR005', 'CL001');
INSERT INTO COACH VALUES ('CH023', 'B1', 60, 'TR005', 'CL002');
INSERT INTO COACH VALUES ('CH024', 'B2', 60, 'TR005', 'CL002');
INSERT INTO COACH VALUES ('CH025', 'S1', 70, 'TR005', 'CL003');
INSERT INTO COACH VALUES ('CH026', 'A1', 50, 'TR006', 'CL001');
INSERT INTO COACH VALUES ('CH027', 'B1', 60, 'TR006', 'CL002');
INSERT INTO COACH VALUES ('CH028', 'B2', 60, 'TR006', 'CL002');
INSERT INTO COACH VALUES ('CH029', 'S1', 70, 'TR006', 'CL003');
INSERT INTO COACH VALUES ('CH030', 'S2', 70, 'TR006', 'CL003');
INSERT INTO COACH VALUES ('CH031', 'A1', 50, 'TR007', 'CL001');
INSERT INTO COACH VALUES ('CH032', 'A2', 50, 'TR007', 'CL001');
INSERT INTO COACH VALUES ('CH033', 'B1', 60, 'TR007', 'CL002');
INSERT INTO COACH VALUES ('CH034', 'B2', 60, 'TR007', 'CL002');
INSERT INTO COACH VALUES ('CH035', 'S1', 70, 'TR007', 'CL003');
INSERT INTO COACH VALUES ('CH036', 'A1', 50, 'TR008', 'CL001');
INSERT INTO COACH VALUES ('CH037', 'B1', 60, 'TR008', 'CL002');
INSERT INTO COACH VALUES ('CH038', 'B2', 60, 'TR008', 'CL002');
INSERT INTO COACH VALUES ('CH039', 'S1', 70, 'TR008', 'CL003');
INSERT INTO COACH VALUES ('CH040', 'S2', 70, 'TR008', 'CL003');
INSERT INTO COACH VALUES ('CH041', 'A1', 50, 'TR009', 'CL001');
INSERT INTO COACH VALUES ('CH042', 'A2', 50, 'TR009', 'CL001');
INSERT INTO COACH VALUES ('CH043', 'B1', 60, 'TR009', 'CL002');
INSERT INTO COACH VALUES ('CH044', 'B2', 60, 'TR009', 'CL002');
INSERT INTO COACH VALUES ('CH045', 'S1', 70, 'TR009', 'CL003');
INSERT INTO COACH VALUES ('CH046', 'A1', 50, 'TR010', 'CL001');
INSERT INTO COACH VALUES ('CH047', 'B1', 60, 'TR010', 'CL002');
INSERT INTO COACH VALUES ('CH048', 'B2', 60, 'TR010', 'CL002');
INSERT INTO COACH VALUES ('CH049', 'S1', 70, 'TR010', 'CL003');
INSERT INTO COACH VALUES ('CH050', 'S2', 70, 'TR010', 'CL003');



INSERT INTO PASSENGERS VALUES ('PS001', 'Abdul', 'Karim', 'Abdul Karim', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS002', 'Fatema', 'Begum', 'Fatema Begum', TO_DATE('1985-08-20', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS003', 'Jahid', 'Hossain', 'Jahid Hossain', TO_DATE('1990-11-10', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS004', 'Nazia', 'Khatun', 'Nazia Khatun', TO_DATE('1992-02-28', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS005', 'Rafiq', 'Ahmed', 'Rafiq Ahmed', TO_DATE('1988-07-07', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS006', 'Sadia', 'Islam', 'Sadia Islam', TO_DATE('1993-04-05', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS007', 'Monir', 'Haque', 'Monir Haque', TO_DATE('1979-12-25', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS008', 'Sharmin', 'Akter', 'Sharmin Akter', TO_DATE('1991-06-15', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS009', 'Kamrul', 'Islam', 'Kamrul Islam', TO_DATE('1984-09-09', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS010', 'Tania', 'Chowdhury', 'Tania Chowdhury', TO_DATE('1996-01-18', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS011', 'Imran', 'Khan', 'Imran Khan', TO_DATE('1987-08-03', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS012', 'Nasrin', 'Parvin', 'Nasrin Parvin', TO_DATE('1994-03-21', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS013', 'Shafiq', 'Rahman', 'Shafiq Rahman', TO_DATE('1981-10-29', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS014', 'Rumana', 'Begum', 'Rumana Begum', TO_DATE('1990-05-12', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS015', 'Hasan', 'Mollah', 'Hasan Mollah', TO_DATE('1982-11-07', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS016', 'Sultana', 'Khatun', 'Sultana Khatun', TO_DATE('1993-07-16', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS017', 'Arif', 'Ali', 'Arif Ali', TO_DATE('1985-02-23', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS018', 'Mousumi', 'Sultana', 'Mousumi Sultana', TO_DATE('1992-09-30', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS019', 'Jamal', 'Uddin', 'Jamal Uddin', TO_DATE('1978-01-14', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS020', 'Farzana', 'Akter', 'Farzana Akter', TO_DATE('1995-12-22', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS021', 'Sajid', 'Hossain', 'Sajid Hossain', TO_DATE('1983-06-11', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS022', 'Rina', 'Begum', 'Rina Begum', TO_DATE('1991-04-28', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS023', 'Zahid', 'Hasan', 'Zahid Hasan', TO_DATE('1980-03-17', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS024', 'Salma', 'Parvin', 'Salma Parvin', TO_DATE('1989-08-05', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS025', 'Irfan', 'Khan', 'Irfan Khan', TO_DATE('1977-11-19', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS026', 'Nasima', 'Khatun', 'Nasima Khatun', TO_DATE('1994-02-10', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS027', 'Biplob', 'Roy', 'Biplob Roy', TO_DATE('1986-07-08', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS028', 'Shirin', 'Akter', 'Shirin Akter', TO_DATE('1992-05-14', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS029', 'Rashed', 'Chowdhury', 'Rashed Chowdhury', TO_DATE('1981-12-03', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS030', 'Taslima', 'Begum', 'Taslima Begum', TO_DATE('1995-09-27', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS031', 'Kamal', 'Ahmed', 'Kamal Ahmed', TO_DATE('1979-01-02', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS032', 'Sabrina', 'Parvin', 'Sabrina Parvin', TO_DATE('1990-06-19', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS033', 'Nayeem', 'Hossain', 'Nayeem Hossain', TO_DATE('1983-03-24', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS034', 'Munira', 'Khatun', 'Munira Khatun', TO_DATE('1991-11-06', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS035', 'Faisal', 'Islam', 'Faisal Islam', TO_DATE('1985-08-15', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS036', 'Rokeya', 'Begum', 'Rokeya Begum', TO_DATE('1993-02-04', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS037', 'Tariq', 'Ahmed', 'Tariq Ahmed', TO_DATE('1980-07-22', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS038', 'Nusrat', 'Akter', 'Nusrat Akter', TO_DATE('1992-01-30', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS039', 'Saiful', 'Islam', 'Saiful Islam', TO_DATE('1978-04-18', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS040', 'Sumaiya', 'Begum', 'Sumaiya Begum', TO_DATE('1994-09-12', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS041', 'Jamil', 'Hossain', 'Jamil Hossain', TO_DATE('1982-12-25', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS042', 'Sabina', 'Khatun', 'Sabina Khatun', TO_DATE('1991-07-07', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS043', 'Riaz', 'Ahmed', 'Riaz Ahmed', TO_DATE('1984-05-11', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS044', 'Tanjina', 'Parvin', 'Tanjina Parvin', TO_DATE('1990-10-02', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS045', 'Sabbir', 'Khan', 'Sabbir Khan', TO_DATE('1979-03-29', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS046', 'Naila', 'Begum', 'Naila Begum', TO_DATE('1993-06-13', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS047', 'Khaled', 'Hasan', 'Khaled Hasan', TO_DATE('1981-09-19', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS048', 'Sadia', 'Akter', 'Sadia Akter', TO_DATE('1992-11-23', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS049', 'Rafiqul', 'Islam', 'Rafiqul Islam', TO_DATE('1985-01-05', 'YYYY-MM-DD'), 'Male');
INSERT INTO PASSENGERS VALUES ('PS050', 'Mina', 'Parvin', 'Mina Parvin', TO_DATE('1990-08-17', 'YYYY-MM-DD'), 'Female');
INSERT INTO PASSENGERS VALUES ('PS051', 'Md Fokrul', 'Akon', 'Md Fokrul Akon', TO_DATE('2003-05-09', 'YYYY-MM-DD'), 'Male');



INSERT INTO PASSENGER_PHONE VALUES ('PS001', '01711234567', '01987654321');
INSERT INTO PASSENGER_PHONE VALUES ('PS002', '01811223344', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS003', '01999887766', '01755667788');
INSERT INTO PASSENGER_PHONE VALUES ('PS004', '01612345678', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS005', '01599887744', '01844556677');
INSERT INTO PASSENGER_PHONE VALUES ('PS006', '01733445566', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS007', '01922334455', '01866778899');
INSERT INTO PASSENGER_PHONE VALUES ('PS008', '01655667788', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS009', '01544332211', '01988776655');
INSERT INTO PASSENGER_PHONE VALUES ('PS010', '01877665544', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS011', '01799887766', '01988775544');
INSERT INTO PASSENGER_PHONE VALUES ('PS012', '01644556677', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS013', '01566778899', '01788990011');
INSERT INTO PASSENGER_PHONE VALUES ('PS014', '01899887766', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS015', '01777665544', '01988776655');
INSERT INTO PASSENGER_PHONE VALUES ('PS016', '01633445566', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS017', '01955667788', '01799887766');
INSERT INTO PASSENGER_PHONE VALUES ('PS018', '01544332211', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS019', '01866778899', '01988776655');
INSERT INTO PASSENGER_PHONE VALUES ('PS020', '01799887766', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS021', '01677665544', '01988775544');
INSERT INTO PASSENGER_PHONE VALUES ('PS022', '01944556677', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS023', '01566778899', '01788990011');
INSERT INTO PASSENGER_PHONE VALUES ('PS024', '01899887766', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS025', '01777665544', '01988776655');
INSERT INTO PASSENGER_PHONE VALUES ('PS026', '01633445566', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS027', '01955667788', '01799887766');
INSERT INTO PASSENGER_PHONE VALUES ('PS028', '01544332211', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS029', '01866778899', '01988776655');
INSERT INTO PASSENGER_PHONE VALUES ('PS030', '01799887766', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS031', '01677665544', '01988775544');
INSERT INTO PASSENGER_PHONE VALUES ('PS032', '01944556677', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS033', '01566778899', '01788990011');
INSERT INTO PASSENGER_PHONE VALUES ('PS034', '01899887766', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS035', '01777665544', '01988776655');
INSERT INTO PASSENGER_PHONE VALUES ('PS036', '01633445566', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS037', '01955667788', '01799887766');
INSERT INTO PASSENGER_PHONE VALUES ('PS038', '01544332211', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS039', '01866778899', '01988776655');
INSERT INTO PASSENGER_PHONE VALUES ('PS040', '01799887766', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS041', '01677665544', '01988775544');
INSERT INTO PASSENGER_PHONE VALUES ('PS042', '01944556677', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS043', '01566778899', '01788990011');
INSERT INTO PASSENGER_PHONE VALUES ('PS044', '01899887766', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS045', '01777665544', '01988776655');
INSERT INTO PASSENGER_PHONE VALUES ('PS046', '01633445566', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS047', '01955667788', '01799887766');
INSERT INTO PASSENGER_PHONE VALUES ('PS048', '01544332211', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS049', '01866778899', '01988776655');
INSERT INTO PASSENGER_PHONE VALUES ('PS050', '01799887766', NULL);
INSERT INTO PASSENGER_PHONE VALUES ('PS051', '01799887766', NULL);



INSERT INTO PASSENGER_EMAIL VALUES ('PS001', 'abdul.karim@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS002', 'fatema.begum@email.com', 'fatema.personal@email.com');
INSERT INTO PASSENGER_EMAIL VALUES ('PS003', 'jahid.hossain@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS004', 'nazia.khatun@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS005', 'rafiq.ahmed@email.com', 'rafiq.work@email.com');
INSERT INTO PASSENGER_EMAIL VALUES ('PS006', 'sadia.islam@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS007', 'monir.haque@email.com', 'monir.office@email.com');
INSERT INTO PASSENGER_EMAIL VALUES ('PS008', 'sharmin.akter@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS009', 'kamrul.islam@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS010', 'tania.chowdhury@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS011', 'imran.khan@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS012', 'nasrin.parvin@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS013', 'shafiq.rahman@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS014', 'rumana.begum@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS015', 'hasan.mollah@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS016', 'sultana.khatun@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS017', 'arif.ali@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS018', 'mousumi.sultana@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS019', 'jamal.uddin@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS020', 'farzana.akter@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS021', 'sajid.hossain@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS022', 'rina.begum@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS023', 'zahid.hasan@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS024', 'salma.parvin@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS025', 'irfan.khan@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS026', 'nasima.khatun@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS027', 'biplob.roy@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS028', 'shirin.akter@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS029', 'rashed.chowdhury@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS030', 'taslima.begum@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS031', 'kamal.ahmed@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS032', 'sabrina.parvin@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS033', 'nayeem.hossain@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS034', 'munira.khatun@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS035', 'faisal.islam@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS036', 'rokeya.begum@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS037', 'tariq.ahmed@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS038', 'nusrat.akter@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS039', 'saiful.islam@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS040', 'sumaiya.begum@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS041', 'jamil.hossain@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS042', 'sabina.khatun@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS043', 'riaz.ahmed@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS044', 'tanjina.parvin@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS045', 'sabbir.khan@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS046', 'naila.begum@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS047', 'khaled.hasan@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS048', 'sadia.akter@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS049', 'rafiqul.islam@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS050', 'mina.parvin@email.com', NULL);
INSERT INTO PASSENGER_EMAIL VALUES ('PS051', 'mdfokrulakon@email.com', NULL);




INSERT INTO SCHEDULE VALUES ('SC001', TO_DATE('2023-06-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-01 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'RT001');
INSERT INTO SCHEDULE VALUES ('SC002', TO_DATE('2023-06-01 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-01 21:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'RT009');
INSERT INTO SCHEDULE VALUES ('SC003', TO_DATE('2023-06-02 06:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-02 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-02', 'YYYY-MM-DD'), 'RT002');
INSERT INTO SCHEDULE VALUES ('SC004', TO_DATE('2023-06-02 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-02 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-02', 'YYYY-MM-DD'), 'RT010');
INSERT INTO SCHEDULE VALUES ('SC005', TO_DATE('2023-06-03 07:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-03 13:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-03', 'YYYY-MM-DD'), 'RT003');
INSERT INTO SCHEDULE VALUES ('SC006', TO_DATE('2023-06-03 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-03 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-03', 'YYYY-MM-DD'), 'RT011');
INSERT INTO SCHEDULE VALUES ('SC007', TO_DATE('2023-06-04 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-04 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-04', 'YYYY-MM-DD'), 'RT004');
INSERT INTO SCHEDULE VALUES ('SC008', TO_DATE('2023-06-04 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-04 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-04', 'YYYY-MM-DD'), 'RT012');
INSERT INTO SCHEDULE VALUES ('SC009', TO_DATE('2023-06-05 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-05 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-05', 'YYYY-MM-DD'), 'RT005');
INSERT INTO SCHEDULE VALUES ('SC010', TO_DATE('2023-06-05 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-05 22:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-05', 'YYYY-MM-DD'), 'RT013');

INSERT INTO SCHEDULE VALUES ('SC011', TO_DATE('2023-06-06 06:50:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-06 13:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-06', 'YYYY-MM-DD'), 'RT001');
INSERT INTO SCHEDULE VALUES ('SC012', TO_DATE('2023-06-06 14:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-06 20:40:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-06', 'YYYY-MM-DD'), 'RT009');
INSERT INTO SCHEDULE VALUES ('SC013', TO_DATE('2023-06-07 07:05:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-07 13:35:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-07', 'YYYY-MM-DD'), 'RT002');
INSERT INTO SCHEDULE VALUES ('SC014', TO_DATE('2023-06-07 15:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-07 21:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-07', 'YYYY-MM-DD'), 'RT010');
INSERT INTO SCHEDULE VALUES ('SC015', TO_DATE('2023-06-08 07:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-08 13:50:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-08', 'YYYY-MM-DD'), 'RT003');
INSERT INTO SCHEDULE VALUES ('SC016', TO_DATE('2023-06-08 15:40:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-08 22:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-08', 'YYYY-MM-DD'), 'RT011');
INSERT INTO SCHEDULE VALUES ('SC017', TO_DATE('2023-06-09 08:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-09 14:40:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-09', 'YYYY-MM-DD'), 'RT004');
INSERT INTO SCHEDULE VALUES ('SC018', TO_DATE('2023-06-09 16:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-09 22:40:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-09', 'YYYY-MM-DD'), 'RT012');
INSERT INTO SCHEDULE VALUES ('SC019', TO_DATE('2023-06-10 07:40:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-10 14:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'RT005');
INSERT INTO SCHEDULE VALUES ('SC020', TO_DATE('2023-06-10 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-10 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'RT013');

INSERT INTO SCHEDULE VALUES ('SC021', TO_DATE('2023-06-11 06:55:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-11 13:25:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-11', 'YYYY-MM-DD'), 'RT001');
INSERT INTO SCHEDULE VALUES ('SC022', TO_DATE('2023-06-11 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-11 20:50:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-11', 'YYYY-MM-DD'), 'RT009');
INSERT INTO SCHEDULE VALUES ('SC023', TO_DATE('2023-06-12 07:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-12 13:40:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-12', 'YYYY-MM-DD'), 'RT002');
INSERT INTO SCHEDULE VALUES ('SC024', TO_DATE('2023-06-12 15:25:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-12 21:55:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-12', 'YYYY-MM-DD'), 'RT010');
INSERT INTO SCHEDULE VALUES ('SC025', TO_DATE('2023-06-13 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-13 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-13', 'YYYY-MM-DD'), 'RT003');
INSERT INTO SCHEDULE VALUES ('SC026', TO_DATE('2023-06-13 15:55:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-13 22:25:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-13', 'YYYY-MM-DD'), 'RT011');
INSERT INTO SCHEDULE VALUES ('SC027', TO_DATE('2023-06-14 08:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-14 14:50:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-14', 'YYYY-MM-DD'), 'RT004');
INSERT INTO SCHEDULE VALUES ('SC028', TO_DATE('2023-06-14 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-14 22:50:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-14', 'YYYY-MM-DD'), 'RT012');
INSERT INTO SCHEDULE VALUES ('SC029', TO_DATE('2023-06-15 07:50:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-15 14:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'RT005');
INSERT INTO SCHEDULE VALUES ('SC030', TO_DATE('2023-06-15 16:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-15 22:40:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'RT013');
INSERT INTO SCHEDULE VALUES ('SC031', TO_DATE('2023-06-16 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-16 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-16', 'YYYY-MM-DD'), 'RT001');
INSERT INTO SCHEDULE VALUES ('SC032', TO_DATE('2023-06-16 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-16 21:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-16', 'YYYY-MM-DD'), 'RT009');
INSERT INTO SCHEDULE VALUES ('SC033', TO_DATE('2023-06-17 06:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-17 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-17', 'YYYY-MM-DD'), 'RT002');
INSERT INTO SCHEDULE VALUES ('SC034', TO_DATE('2023-06-17 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-17 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-17', 'YYYY-MM-DD'), 'RT010');
INSERT INTO SCHEDULE VALUES ('SC035', TO_DATE('2023-06-18 07:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-18 13:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-18', 'YYYY-MM-DD'), 'RT003');
INSERT INTO SCHEDULE VALUES ('SC036', TO_DATE('2023-06-18 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-18 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-18', 'YYYY-MM-DD'), 'RT011');
INSERT INTO SCHEDULE VALUES ('SC037', TO_DATE('2023-06-19 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-19 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-19', 'YYYY-MM-DD'), 'RT004');
INSERT INTO SCHEDULE VALUES ('SC038', TO_DATE('2023-06-19 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-19 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-19', 'YYYY-MM-DD'), 'RT012');
INSERT INTO SCHEDULE VALUES ('SC039', TO_DATE('2023-06-20 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-20', 'YYYY-MM-DD'), 'RT005');
INSERT INTO SCHEDULE VALUES ('SC040', TO_DATE('2023-06-20 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-20 22:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-20', 'YYYY-MM-DD'), 'RT013');
INSERT INTO SCHEDULE VALUES ('SC041', TO_DATE('2023-06-21 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-21 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-21', 'YYYY-MM-DD'), 'RT001');
INSERT INTO SCHEDULE VALUES ('SC042', TO_DATE('2023-06-21 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-21 21:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-21', 'YYYY-MM-DD'), 'RT009');
INSERT INTO SCHEDULE VALUES ('SC043', TO_DATE('2023-06-22 06:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-22 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-22', 'YYYY-MM-DD'), 'RT002');
INSERT INTO SCHEDULE VALUES ('SC044', TO_DATE('2023-06-22 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-22 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-22', 'YYYY-MM-DD'), 'RT010');
INSERT INTO SCHEDULE VALUES ('SC045', TO_DATE('2023-06-23 07:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-23 13:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-23', 'YYYY-MM-DD'), 'RT003');
INSERT INTO SCHEDULE VALUES ('SC046', TO_DATE('2023-06-23 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-23 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-23', 'YYYY-MM-DD'), 'RT011');
INSERT INTO SCHEDULE VALUES ('SC047', TO_DATE('2023-06-24 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-24 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-24', 'YYYY-MM-DD'), 'RT004');
INSERT INTO SCHEDULE VALUES ('SC048', TO_DATE('2023-06-24 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-24 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-24', 'YYYY-MM-DD'), 'RT012');
INSERT INTO SCHEDULE VALUES ('SC049', TO_DATE('2023-06-25 07:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-25 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-25', 'YYYY-MM-DD'), 'RT005');
INSERT INTO SCHEDULE VALUES ('SC050', TO_DATE('2023-06-25 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-25 22:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2023-06-25', 'YYYY-MM-DD'), 'RT013');




INSERT INTO BOOKINGS VALUES ('BK001', SYSDATE, 'Confirmed', 'PS001', 'SC001');
INSERT INTO BOOKINGS VALUES ('BK002', SYSDATE, 'Confirmed', 'PS002', 'SC002');
INSERT INTO BOOKINGS VALUES ('BK003', SYSDATE, 'Pending', 'PS003', 'SC003');
INSERT INTO BOOKINGS VALUES ('BK004', SYSDATE, 'Confirmed', 'PS004', 'SC004');
INSERT INTO BOOKINGS VALUES ('BK005', SYSDATE, 'Confirmed', 'PS005', 'SC005');
INSERT INTO BOOKINGS VALUES ('BK006', SYSDATE, 'Pending', 'PS006', 'SC006');
INSERT INTO BOOKINGS VALUES ('BK007', SYSDATE, 'Confirmed', 'PS007', 'SC007');
INSERT INTO BOOKINGS VALUES ('BK008', SYSDATE, 'Confirmed', 'PS008', 'SC008');
INSERT INTO BOOKINGS VALUES ('BK009', SYSDATE, 'Confirmed', 'PS009', 'SC009');
INSERT INTO BOOKINGS VALUES ('BK010', SYSDATE, 'Pending', 'PS010', 'SC010');
INSERT INTO BOOKINGS VALUES ('BK011', SYSDATE, 'Confirmed', 'PS011', 'SC011');
INSERT INTO BOOKINGS VALUES ('BK012', SYSDATE, 'Confirmed', 'PS012', 'SC012');
INSERT INTO BOOKINGS VALUES ('BK013', SYSDATE, 'Confirmed', 'PS013', 'SC013');
INSERT INTO BOOKINGS VALUES ('BK014', SYSDATE, 'Pending', 'PS014', 'SC014');
INSERT INTO BOOKINGS VALUES ('BK015', SYSDATE, 'Confirmed', 'PS015', 'SC015');
INSERT INTO BOOKINGS VALUES ('BK016', SYSDATE, 'Confirmed', 'PS016', 'SC016');
INSERT INTO BOOKINGS VALUES ('BK017', SYSDATE, 'Pending', 'PS017', 'SC017');
INSERT INTO BOOKINGS VALUES ('BK018', SYSDATE, 'Confirmed', 'PS018', 'SC018');
INSERT INTO BOOKINGS VALUES ('BK019', SYSDATE, 'Confirmed', 'PS019', 'SC019');
INSERT INTO BOOKINGS VALUES ('BK020', SYSDATE, 'Confirmed', 'PS020', 'SC020');
INSERT INTO BOOKINGS VALUES ('BK021', SYSDATE, 'Confirmed', 'PS021', 'SC021');
INSERT INTO BOOKINGS VALUES ('BK022', SYSDATE, 'Confirmed', 'PS022', 'SC022');
INSERT INTO BOOKINGS VALUES ('BK023', SYSDATE, 'Pending', 'PS023', 'SC023');
INSERT INTO BOOKINGS VALUES ('BK024', SYSDATE, 'Confirmed', 'PS024', 'SC024');
INSERT INTO BOOKINGS VALUES ('BK025', SYSDATE, 'Confirmed', 'PS025', 'SC025');
INSERT INTO BOOKINGS VALUES ('BK026', SYSDATE, 'Confirmed', 'PS026', 'SC026');
INSERT INTO BOOKINGS VALUES ('BK027', SYSDATE, 'Pending', 'PS027', 'SC027');
INSERT INTO BOOKINGS VALUES ('BK028', SYSDATE, 'Confirmed', 'PS028', 'SC028');
INSERT INTO BOOKINGS VALUES ('BK029', SYSDATE, 'Confirmed', 'PS029', 'SC029');
INSERT INTO BOOKINGS VALUES ('BK030', SYSDATE, 'Confirmed', 'PS030', 'SC030');
INSERT INTO BOOKINGS VALUES ('BK031', SYSDATE, 'Confirmed', 'PS031', 'SC031');
INSERT INTO BOOKINGS VALUES ('BK032', SYSDATE, 'Pending', 'PS032', 'SC032');
INSERT INTO BOOKINGS VALUES ('BK033', SYSDATE, 'Confirmed', 'PS033', 'SC033');
INSERT INTO BOOKINGS VALUES ('BK034', SYSDATE, 'Confirmed', 'PS034', 'SC034');
INSERT INTO BOOKINGS VALUES ('BK035', SYSDATE, 'Confirmed', 'PS035', 'SC035');
INSERT INTO BOOKINGS VALUES ('BK036', SYSDATE, 'Pending', 'PS036', 'SC036');
INSERT INTO BOOKINGS VALUES ('BK037', SYSDATE, 'Confirmed', 'PS037', 'SC037');
INSERT INTO BOOKINGS VALUES ('BK038', SYSDATE, 'Confirmed', 'PS038', 'SC038');
INSERT INTO BOOKINGS VALUES ('BK039', SYSDATE, 'Confirmed', 'PS039', 'SC039');
INSERT INTO BOOKINGS VALUES ('BK040', SYSDATE, 'Confirmed', 'PS040', 'SC040');
INSERT INTO BOOKINGS VALUES ('BK041', SYSDATE, 'Confirmed', 'PS041', 'SC041');
INSERT INTO BOOKINGS VALUES ('BK042', SYSDATE, 'Confirmed', 'PS042', 'SC042');
INSERT INTO BOOKINGS VALUES ('BK043', SYSDATE, 'Pending', 'PS043', 'SC043');
INSERT INTO BOOKINGS VALUES ('BK044', SYSDATE, 'Confirmed', 'PS044', 'SC044');
INSERT INTO BOOKINGS VALUES ('BK045', SYSDATE, 'Confirmed', 'PS045', 'SC045');
INSERT INTO BOOKINGS VALUES ('BK046', SYSDATE, 'Confirmed', 'PS046', 'SC046');
INSERT INTO BOOKINGS VALUES ('BK047', SYSDATE, 'Pending', 'PS047', 'SC047');
INSERT INTO BOOKINGS VALUES ('BK048', SYSDATE, 'Confirmed', 'PS048', 'SC048');
INSERT INTO BOOKINGS VALUES ('BK049', SYSDATE, 'Confirmed', 'PS049', 'SC049');
INSERT INTO BOOKINGS VALUES ('BK050', SYSDATE, 'Confirmed', 'PS050', 'SC050');



INSERT INTO SEATS VALUES ('S1', 'CH001', '1A', 'Available');
INSERT INTO SEATS VALUES ('S2', 'CH001', '1B', 'Booked');
INSERT INTO SEATS VALUES ('S3', 'CH001', '1C', 'Available');
INSERT INTO SEATS VALUES ('S4', 'CH001', '1D', 'Booked');
INSERT INTO SEATS VALUES ('S5', 'CH001', '2A', 'Available');
INSERT INTO SEATS VALUES ('S6', 'CH001', '2B', 'Booked');
INSERT INTO SEATS VALUES ('S7', 'CH001', '2C', 'Available');
INSERT INTO SEATS VALUES ('S8', 'CH001', '2D', 'Booked');
INSERT INTO SEATS VALUES ('S9', 'CH001', '3A', 'Available');
INSERT INTO SEATS VALUES ('S10', 'CH001', '3B', 'Booked');
INSERT INTO SEATS VALUES ('S11', 'CH001', '3C', 'Available');
INSERT INTO SEATS VALUES ('S12', 'CH001', '3D', 'Booked');
INSERT INTO SEATS VALUES ('S13', 'CH001', '4A', 'Available');
INSERT INTO SEATS VALUES ('S14', 'CH001', '4B', 'Booked');
INSERT INTO SEATS VALUES ('S15', 'CH001', '4C', 'Available');
INSERT INTO SEATS VALUES ('S16', 'CH001', '4D', 'Booked');
INSERT INTO SEATS VALUES ('S17', 'CH001', '5A', 'Available');
INSERT INTO SEATS VALUES ('S18', 'CH001', '5B', 'Booked');
INSERT INTO SEATS VALUES ('S19', 'CH001', '5C', 'Available');
INSERT INTO SEATS VALUES ('S20', 'CH001', '5D', 'Booked');
INSERT INTO SEATS VALUES ('S21', 'CH002', '1A', 'Available');
INSERT INTO SEATS VALUES ('S22', 'CH002', '1B', 'Available');
INSERT INTO SEATS VALUES ('S23', 'CH002', '1C', 'Booked');
INSERT INTO SEATS VALUES ('S24', 'CH002', '1D', 'Booked');
INSERT INTO SEATS VALUES ('S25', 'CH002', '2A', 'Available');
INSERT INTO SEATS VALUES ('S26', 'CH002', '2B', 'Booked');
INSERT INTO SEATS VALUES ('S27', 'CH002', '2C', 'Available');
INSERT INTO SEATS VALUES ('S28', 'CH002', '2D', 'Booked');
INSERT INTO SEATS VALUES ('S29', 'CH002', '3A', 'Available');
INSERT INTO SEATS VALUES ('S30', 'CH002', '3B', 'Booked');
INSERT INTO SEATS VALUES ('S31', 'CH002', '3C', 'Available');
INSERT INTO SEATS VALUES ('S32', 'CH002', '3D', 'Booked');
INSERT INTO SEATS VALUES ('S33', 'CH002', '4A', 'Available');
INSERT INTO SEATS VALUES ('S34', 'CH002', '4B', 'Booked');
INSERT INTO SEATS VALUES ('S35', 'CH002', '4C', 'Available');
INSERT INTO SEATS VALUES ('S36', 'CH003', '1A', 'Available');
INSERT INTO SEATS VALUES ('S37', 'CH003', '1B', 'Booked');
INSERT INTO SEATS VALUES ('S38', 'CH003', '1C', 'Available');
INSERT INTO SEATS VALUES ('S39', 'CH003', '1D', 'Booked');
INSERT INTO SEATS VALUES ('S40', 'CH003', '2A', 'Available');
INSERT INTO SEATS VALUES ('S41', 'CH003', '2B', 'Booked');
INSERT INTO SEATS VALUES ('S42', 'CH003', '2C', 'Available');
INSERT INTO SEATS VALUES ('S43', 'CH003', '2D', 'Booked');
INSERT INTO SEATS VALUES ('S44', 'CH003', '3A', 'Available');
INSERT INTO SEATS VALUES ('S45', 'CH003', '3B', 'Booked');
INSERT INTO SEATS VALUES ('S46', 'CH003', '3C', 'Available');
INSERT INTO SEATS VALUES ('S47', 'CH003', '3D', 'Booked');
INSERT INTO SEATS VALUES ('S48', 'CH003', '4A', 'Available');
INSERT INTO SEATS VALUES ('S49', 'CH003', '4B', 'Booked');
INSERT INTO SEATS VALUES ('S50', 'CH003', '4C', 'Available');


INSERT INTO TICKETS VALUES ('TK001', 'BK001', 750.00, 'Booked', 'S1', 'CH001', '1A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S1' AND coach_id = 'CH001' AND seat_number = '1A';

INSERT INTO TICKETS VALUES ('TK002', 'BK002', 450.00, 'Booked', 'S2', 'CH001', '1B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S2' AND coach_id = 'CH001' AND seat_number = '1B';

INSERT INTO TICKETS VALUES ('TK003', 'BK003', 600.00, 'Booked', 'S3', 'CH001', '1C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S3' AND coach_id = 'CH001' AND seat_number = '1C';

INSERT INTO TICKETS VALUES ('TK004', 'BK004', 700.00, 'Booked', 'S4', 'CH001', '1D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S4' AND coach_id = 'CH001' AND seat_number = '1D';

INSERT INTO TICKETS VALUES ('TK005', 'BK005', 550.00, 'Booked', 'S5', 'CH001', '2A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S5' AND coach_id = 'CH001' AND seat_number = '2A';

INSERT INTO TICKETS VALUES ('TK006', 'BK006', 480.00, 'Booked', 'S6', 'CH001', '2B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S6' AND coach_id = 'CH001' AND seat_number = '2B';

INSERT INTO TICKETS VALUES ('TK007', 'BK007', 520.00, 'Booked', 'S7', 'CH001', '2C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S7' AND coach_id = 'CH001' AND seat_number = '2C';

INSERT INTO TICKETS VALUES ('TK008', 'BK008', 470.00, 'Booked', 'S8', 'CH001', '2D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S8' AND coach_id = 'CH001' AND seat_number = '2D';

INSERT INTO TICKETS VALUES ('TK009', 'BK009', 690.00, 'Booked', 'S9', 'CH001', '3A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S9' AND coach_id = 'CH001' AND seat_number = '3A';

INSERT INTO TICKETS VALUES ('TK010', 'BK010', 720.00, 'Booked', 'S10', 'CH001', '3B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S10' AND coach_id = 'CH001' AND seat_number = '3B';

INSERT INTO TICKETS VALUES ('TK011', 'BK011', 530.00, 'Booked', 'S11', 'CH001', '3C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S11' AND coach_id = 'CH001' AND seat_number = '3C';

INSERT INTO TICKETS VALUES ('TK012', 'BK012', 580.00, 'Booked', 'S12', 'CH001', '3D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S12' AND coach_id = 'CH001' AND seat_number = '3D';

INSERT INTO TICKETS VALUES ('TK013', 'BK013', 610.00, 'Booked', 'S13', 'CH001', '4A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S13' AND coach_id = 'CH001' AND seat_number = '4A';

INSERT INTO TICKETS VALUES ('TK014', 'BK014', 495.00, 'Booked', 'S14', 'CH001', '4B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S14' AND coach_id = 'CH001' AND seat_number = '4B';

INSERT INTO TICKETS VALUES ('TK015', 'BK015', 560.00, 'Booked', 'S15', 'CH001', '4C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S15' AND coach_id = 'CH001' AND seat_number = '4C';

INSERT INTO TICKETS VALUES ('TK016', 'BK016', 590.00, 'Booked', 'S16', 'CH001', '4D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S16' AND coach_id = 'CH001' AND seat_number = '4D';

INSERT INTO TICKETS VALUES ('TK017', 'BK017', 650.00, 'Booked', 'S17', 'CH001', '5A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S17' AND coach_id = 'CH001' AND seat_number = '5A';

INSERT INTO TICKETS VALUES ('TK018', 'BK018', 480.00, 'Booked', 'S18', 'CH001', '5B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S18' AND coach_id = 'CH001' AND seat_number = '5B';

INSERT INTO TICKETS VALUES ('TK019', 'BK019', 710.00, 'Booked', 'S19', 'CH001', '5C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S19' AND coach_id = 'CH001' AND seat_number = '5C';

INSERT INTO TICKETS VALUES ('TK020', 'BK020', 670.00, 'Booked', 'S20', 'CH001', '5D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S20' AND coach_id = 'CH001' AND seat_number = '5D';

INSERT INTO TICKETS VALUES ('TK021', 'BK021', 540.00, 'Booked', 'S21', 'CH002', '1A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S21' AND coach_id = 'CH002' AND seat_number = '1A';

INSERT INTO TICKETS VALUES ('TK022', 'BK022', 580.00, 'Booked', 'S22', 'CH002', '1B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S22' AND coach_id = 'CH002' AND seat_number = '1B';

INSERT INTO TICKETS VALUES ('TK023', 'BK023', 615.00, 'Booked', 'S23', 'CH002', '1C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S23' AND coach_id = 'CH002' AND seat_number = '1C';

INSERT INTO TICKETS VALUES ('TK024', 'BK024', 500.00, 'Booked', 'S24', 'CH002', '1D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S24' AND coach_id = 'CH002' AND seat_number = '1D';

INSERT INTO TICKETS VALUES ('TK025', 'BK025', 560.00, 'Booked', 'S25', 'CH002', '2A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S25' AND coach_id = 'CH002' AND seat_number = '2A';

INSERT INTO TICKETS VALUES ('TK026', 'BK026', 600.00, 'Booked', 'S26', 'CH002', '2B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S26' AND coach_id = 'CH002' AND seat_number = '2B';

INSERT INTO TICKETS VALUES ('TK027', 'BK027', 640.00, 'Booked', 'S27', 'CH002', '2C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S27' AND coach_id = 'CH002' AND seat_number = '2C';

INSERT INTO TICKETS VALUES ('TK028', 'BK028', 490.00, 'Booked', 'S28', 'CH002', '2D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S28' AND coach_id = 'CH002' AND seat_number = '2D';

INSERT INTO TICKETS VALUES ('TK029', 'BK029', 710.00, 'Booked', 'S29', 'CH002', '3A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S29' AND coach_id = 'CH002' AND seat_number = '3A';

INSERT INTO TICKETS VALUES ('TK030', 'BK030', 670.00, 'Booked', 'S30', 'CH002', '3B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S30' AND coach_id = 'CH002' AND seat_number = '3B';

INSERT INTO TICKETS VALUES ('TK031', 'BK031', 535.00, 'Booked', 'S31', 'CH002', '3C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S31' AND coach_id = 'CH002' AND seat_number = '3C';

INSERT INTO TICKETS VALUES ('TK032', 'BK032', 580.00, 'Booked', 'S32', 'CH002', '3D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S32' AND coach_id = 'CH002' AND seat_number = '3D';

INSERT INTO TICKETS VALUES ('TK033', 'BK033', 610.00, 'Booked', 'S33', 'CH002', '4A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S33' AND coach_id = 'CH002' AND seat_number = '4A';

INSERT INTO TICKETS VALUES ('TK034', 'BK034', 495.00, 'Booked', 'S34', 'CH002', '4B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S34' AND coach_id = 'CH002' AND seat_number = '4B';

INSERT INTO TICKETS VALUES ('TK035', 'BK035', 560.00, 'Booked', 'S35', 'CH002', '4C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S35' AND coach_id = 'CH002' AND seat_number = '4C';

INSERT INTO TICKETS VALUES ('TK036', 'BK036', 590.00, 'Booked', 'S36', 'CH003', '1A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S36' AND coach_id = 'CH003' AND seat_number = '1A';

INSERT INTO TICKETS VALUES ('TK037', 'BK037', 650.00, 'Booked', 'S37', 'CH003', '1B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S37' AND coach_id = 'CH003' AND seat_number = '1B';

INSERT INTO TICKETS VALUES ('TK038', 'BK038', 480.00, 'Booked', 'S38', 'CH003', '1C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S38' AND coach_id = 'CH003' AND seat_number = '1C';

INSERT INTO TICKETS VALUES ('TK039', 'BK039', 710.00, 'Booked', 'S39', 'CH003', '1D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S39' AND coach_id = 'CH003' AND seat_number = '1D';

INSERT INTO TICKETS VALUES ('TK040', 'BK040', 670.00, 'Booked', 'S40', 'CH003', '2A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S40' AND coach_id = 'CH003' AND seat_number = '2A';
INSERT INTO TICKETS VALUES ('TK041', 'BK041', 540.00, 'Booked', 'S41', 'CH003', '2B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S41' AND coach_id = 'CH003' AND seat_number = '2B';

INSERT INTO TICKETS VALUES ('TK042', 'BK042', 580.00, 'Booked', 'S42', 'CH003', '2C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S42' AND coach_id = 'CH003' AND seat_number = '2C';

INSERT INTO TICKETS VALUES ('TK043', 'BK043', 615.00, 'Booked', 'S43', 'CH003', '2D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S43' AND coach_id = 'CH003' AND seat_number = '2D';

INSERT INTO TICKETS VALUES ('TK044', 'BK044', 500.00, 'Booked', 'S44', 'CH003', '3A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S44' AND coach_id = 'CH003' AND seat_number = '3A';

INSERT INTO TICKETS VALUES ('TK045', 'BK045', 560.00, 'Booked', 'S45', 'CH003', '3B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S45' AND coach_id = 'CH003' AND seat_number = '3B';

INSERT INTO TICKETS VALUES ('TK046', 'BK046', 600.00, 'Booked', 'S46', 'CH003', '3C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S46' AND coach_id = 'CH003' AND seat_number = '3C';

INSERT INTO TICKETS VALUES ('TK047', 'BK047', 640.00, 'Booked', 'S47', 'CH003', '3D');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S47' AND coach_id = 'CH003' AND seat_number = '3D';

INSERT INTO TICKETS VALUES ('TK048', 'BK048', 490.00, 'Booked', 'S48', 'CH003', '4A');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S48' AND coach_id = 'CH003' AND seat_number = '4A';

INSERT INTO TICKETS VALUES ('TK049', 'BK049', 710.00, 'Booked', 'S49', 'CH003', '4B');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S49' AND coach_id = 'CH003' AND seat_number = '4B';

INSERT INTO TICKETS VALUES ('TK050', 'BK050', 670.00, 'Booked', 'S50', 'CH003', '4C');
UPDATE SEATS SET status = 'Booked' WHERE seat_id = 'S50' AND coach_id = 'CH003' AND seat_number = '4C';




INSERT INTO PAYMENTS VALUES ('PY001', 750.00, 'Credit Card', 'Completed', 'TXN12345', SYSDATE, 'BK001');
INSERT INTO PAYMENTS VALUES ('PY002', 450.00, 'bKash', 'Completed', 'TXN23456', SYSDATE, 'BK002');
INSERT INTO PAYMENTS VALUES ('PY003', 600.00, 'Nagad', 'Completed', 'TXN34567', SYSDATE, 'BK003');
INSERT INTO PAYMENTS VALUES ('PY004', 700.00, 'Credit Card', 'Completed', 'TXN45678', SYSDATE, 'BK004');
INSERT INTO PAYMENTS VALUES ('PY005', 550.00, 'Rocket', 'Completed', 'TXN56789', SYSDATE, 'BK005');
INSERT INTO PAYMENTS VALUES ('PY006', 480.00, 'bKash', 'Completed', 'TXN67890', SYSDATE, 'BK006');
INSERT INTO PAYMENTS VALUES ('PY007', 520.00, 'Credit Card', 'Completed', 'TXN78901', SYSDATE, 'BK007');
INSERT INTO PAYMENTS VALUES ('PY008', 470.00, 'Nagad', 'Completed', 'TXN89012', SYSDATE, 'BK008');
INSERT INTO PAYMENTS VALUES ('PY009', 690.00, 'Rocket', 'Completed', 'TXN90123', SYSDATE, 'BK009');
INSERT INTO PAYMENTS VALUES ('PY010', 720.00, 'bKash', 'Completed', 'TXN01234', SYSDATE, 'BK010');
INSERT INTO PAYMENTS VALUES ('PY011', 530.00, 'Credit Card', 'Completed', 'TXN11223', SYSDATE, 'BK011');
INSERT INTO PAYMENTS VALUES ('PY012', 580.00, 'Nagad', 'Completed', 'TXN22334', SYSDATE, 'BK012');
INSERT INTO PAYMENTS VALUES ('PY013', 610.00, 'Rocket', 'Completed', 'TXN33445', SYSDATE, 'BK013');
INSERT INTO PAYMENTS VALUES ('PY014', 495.00, 'bKash', 'Completed', 'TXN44556', SYSDATE, 'BK014');
INSERT INTO PAYMENTS VALUES ('PY015', 560.00, 'Credit Card', 'Completed', 'TXN55667', SYSDATE, 'BK015');
INSERT INTO PAYMENTS VALUES ('PY016', 590.00, 'Nagad', 'Completed', 'TXN66778', SYSDATE, 'BK016');
INSERT INTO PAYMENTS VALUES ('PY017', 650.00, 'Rocket', 'Completed', 'TXN77889', SYSDATE, 'BK017');
INSERT INTO PAYMENTS VALUES ('PY018', 480.00, 'bKash', 'Completed', 'TXN88990', SYSDATE, 'BK018');
INSERT INTO PAYMENTS VALUES ('PY019', 710.00, 'Credit Card', 'Completed', 'TXN99001', SYSDATE, 'BK019');
INSERT INTO PAYMENTS VALUES ('PY020', 670.00, 'Nagad', 'Completed', 'TXN10112', SYSDATE, 'BK020');
INSERT INTO PAYMENTS VALUES ('PY021', 540.00, 'Rocket', 'Completed', 'TXN11122', SYSDATE, 'BK021');
INSERT INTO PAYMENTS VALUES ('PY022', 580.00, 'bKash', 'Completed', 'TXN12132', SYSDATE, 'BK022');
INSERT INTO PAYMENTS VALUES ('PY023', 615.00, 'Credit Card', 'Completed', 'TXN13142', SYSDATE, 'BK023');
INSERT INTO PAYMENTS VALUES ('PY024', 500.00, 'Nagad', 'Completed', 'TXN14152', SYSDATE, 'BK024');
INSERT INTO PAYMENTS VALUES ('PY025', 560.00, 'Rocket', 'Completed', 'TXN15162', SYSDATE, 'BK025');
INSERT INTO PAYMENTS VALUES ('PY026', 600.00, 'bKash', 'Completed', 'TXN16172', SYSDATE, 'BK026');
INSERT INTO PAYMENTS VALUES ('PY027', 640.00, 'Credit Card', 'Completed', 'TXN17182', SYSDATE, 'BK027');
INSERT INTO PAYMENTS VALUES ('PY028', 490.00, 'Nagad', 'Completed', 'TXN18192', SYSDATE, 'BK028');
INSERT INTO PAYMENTS VALUES ('PY029', 710.00, 'Rocket', 'Completed', 'TXN19202', SYSDATE, 'BK029');
INSERT INTO PAYMENTS VALUES ('PY030', 670.00, 'bKash', 'Completed', 'TXN20212', SYSDATE, 'BK030');
INSERT INTO PAYMENTS VALUES ('PY031', 535.00, 'Credit Card', 'Completed', 'TXN21222', SYSDATE, 'BK031');
INSERT INTO PAYMENTS VALUES ('PY032', 580.00, 'Nagad', 'Completed', 'TXN22232', SYSDATE, 'BK032');
INSERT INTO PAYMENTS VALUES ('PY033', 610.00, 'Rocket', 'Completed', 'TXN23242', SYSDATE, 'BK033');
INSERT INTO PAYMENTS VALUES ('PY034', 495.00, 'bKash', 'Completed', 'TXN24252', SYSDATE, 'BK034');
INSERT INTO PAYMENTS VALUES ('PY035', 560.00, 'Credit Card', 'Completed', 'TXN25262', SYSDATE, 'BK035');
INSERT INTO PAYMENTS VALUES ('PY036', 590.00, 'Nagad', 'Completed', 'TXN26272', SYSDATE, 'BK036');
INSERT INTO PAYMENTS VALUES ('PY037', 650.00, 'Rocket', 'Completed', 'TXN27282', SYSDATE, 'BK037');
INSERT INTO PAYMENTS VALUES ('PY038', 480.00, 'bKash', 'Completed', 'TXN28292', SYSDATE, 'BK038');
INSERT INTO PAYMENTS VALUES ('PY039', 710.00, 'Credit Card', 'Completed', 'TXN29302', SYSDATE, 'BK039');
INSERT INTO PAYMENTS VALUES ('PY040', 670.00, 'Nagad', 'Completed', 'TXN30312', SYSDATE, 'BK040');
INSERT INTO PAYMENTS VALUES ('PY041', 540.00, 'Rocket', 'Completed', 'TXN31322', SYSDATE, 'BK041');
INSERT INTO PAYMENTS VALUES ('PY042', 580.00, 'bKash', 'Completed', 'TXN32332', SYSDATE, 'BK042');
INSERT INTO PAYMENTS VALUES ('PY043', 615.00, 'Credit Card', 'Completed', 'TXN33342', SYSDATE, 'BK043');
INSERT INTO PAYMENTS VALUES ('PY044', 500.00, 'Nagad', 'Completed', 'TXN34352', SYSDATE, 'BK044');
INSERT INTO PAYMENTS VALUES ('PY045', 560.00, 'Rocket', 'Completed', 'TXN35362', SYSDATE, 'BK045');
INSERT INTO PAYMENTS VALUES ('PY046', 600.00, 'bKash', 'Completed', 'TXN36372', SYSDATE, 'BK046');
INSERT INTO PAYMENTS VALUES ('PY047', 640.00, 'Credit Card', 'Completed', 'TXN37382', SYSDATE, 'BK047');
INSERT INTO PAYMENTS VALUES ('PY048', 490.00, 'Nagad', 'Completed', 'TXN38392', SYSDATE, 'BK048');
INSERT INTO PAYMENTS VALUES ('PY049', 710.00, 'Rocket', 'Completed', 'TXN39402', SYSDATE, 'BK049');
INSERT INTO PAYMENTS VALUES ('PY050', 670.00, 'bKash', 'Completed', 'TXN40412', SYSDATE, 'BK050');




INSERT INTO MAINTENANCE VALUES ('MT001', 'EMP041', 'Engine Check', 'Routine engine maintenance', 'Completed', TO_DATE('2023-05-01', 'YYYY-MM-DD'), TO_DATE('2023-05-02', 'YYYY-MM-DD'), 'EMP041', 'TR001');
INSERT INTO MAINTENANCE VALUES ('MT002', 'EMP042', 'Brake Inspection', 'Brake system check', 'Completed', TO_DATE('2023-05-15', 'YYYY-MM-DD'), TO_DATE('2023-05-16', 'YYYY-MM-DD'), 'EMP042', 'TR002');
INSERT INTO MAINTENANCE VALUES ('MT003', 'EMP043', 'Wheel Alignment', 'Alignment and balancing', 'Completed', TO_DATE('2023-05-05', 'YYYY-MM-DD'), TO_DATE('2023-05-06', 'YYYY-MM-DD'), 'EMP043', 'TR003');
INSERT INTO MAINTENANCE VALUES ('MT004', 'EMP044', 'Engine Oil Change', 'Changed engine oil and filters', 'Completed', TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-05-11', 'YYYY-MM-DD'), 'EMP044', 'TR004');
INSERT INTO MAINTENANCE VALUES ('MT005', 'EMP045', 'Brake Pad Replacement', 'Replaced worn brake pads', 'Completed', TO_DATE('2023-05-12', 'YYYY-MM-DD'), TO_DATE('2023-05-13', 'YYYY-MM-DD'), 'EMP045', 'TR005');
INSERT INTO MAINTENANCE VALUES ('MT006', 'EMP046', 'Air Conditioning Service', 'Serviced A/C system', 'Completed', TO_DATE('2023-05-07', 'YYYY-MM-DD'), TO_DATE('2023-05-08', 'YYYY-MM-DD'), 'EMP046', 'TR006');
INSERT INTO MAINTENANCE VALUES ('MT007', 'EMP047', 'Lighting Check', 'Checked and replaced lights', 'Completed', TO_DATE('2023-05-09', 'YYYY-MM-DD'), TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'EMP047', 'TR007');
INSERT INTO MAINTENANCE VALUES ('MT008', 'EMP048', 'Suspension Check', 'Suspension system inspection', 'Completed', TO_DATE('2023-05-11', 'YYYY-MM-DD'), TO_DATE('2023-05-12', 'YYYY-MM-DD'), 'EMP048', 'TR008');
INSERT INTO MAINTENANCE VALUES ('MT009', 'EMP049', 'Fuel System Cleaning', 'Cleaned fuel injectors', 'Completed', TO_DATE('2023-05-13', 'YYYY-MM-DD'), TO_DATE('2023-05-14', 'YYYY-MM-DD'), 'EMP049', 'TR009');
INSERT INTO MAINTENANCE VALUES ('MT010', 'EMP050', 'Safety Inspection', 'Overall safety check', 'Completed', TO_DATE('2023-05-14', 'YYYY-MM-DD'), TO_DATE('2023-05-15', 'YYYY-MM-DD'), 'EMP050', 'TR010');
INSERT INTO MAINTENANCE VALUES ('MT011', 'EMP041', 'Engine Tune-Up', 'Engine performance tuning', 'Completed', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-02', 'YYYY-MM-DD'), 'EMP041', 'TR001');
INSERT INTO MAINTENANCE VALUES ('MT012', 'EMP042', 'Brake Fluid Replacement', 'Replaced brake fluid', 'Completed', TO_DATE('2023-06-03', 'YYYY-MM-DD'), TO_DATE('2023-06-04', 'YYYY-MM-DD'), 'EMP042', 'TR002');
INSERT INTO MAINTENANCE VALUES ('MT013', 'EMP043', 'Wheel Replacement', 'Replaced worn wheels', 'Completed', TO_DATE('2023-06-05', 'YYYY-MM-DD'), TO_DATE('2023-06-06', 'YYYY-MM-DD'), 'EMP043', 'TR003');
INSERT INTO MAINTENANCE VALUES ('MT014', 'EMP044', 'Oil Filter Change', 'Changed oil filter', 'Completed', TO_DATE('2023-06-07', 'YYYY-MM-DD'), TO_DATE('2023-06-08', 'YYYY-MM-DD'), 'EMP044', 'TR004');
INSERT INTO MAINTENANCE VALUES ('MT015', 'EMP045', 'Brake Inspection', 'Brake system check', 'Completed', TO_DATE('2023-06-09', 'YYYY-MM-DD'), TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'EMP045', 'TR005');
INSERT INTO MAINTENANCE VALUES ('MT016', 'EMP046', 'A/C Recharge', 'Recharged air conditioning', 'Completed', TO_DATE('2023-06-11', 'YYYY-MM-DD'), TO_DATE('2023-06-12', 'YYYY-MM-DD'), 'EMP046', 'TR006');
INSERT INTO MAINTENANCE VALUES ('MT017', 'EMP047', 'Lighting Replacement', 'Replaced faulty lights', 'Completed', TO_DATE('2023-06-13', 'YYYY-MM-DD'), TO_DATE('2023-06-14', 'YYYY-MM-DD'), 'EMP047', 'TR007');
INSERT INTO MAINTENANCE VALUES ('MT018', 'EMP048', 'Suspension Repair', 'Repaired suspension parts', 'Completed', TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2023-06-16', 'YYYY-MM-DD'), 'EMP048', 'TR008');
INSERT INTO MAINTENANCE VALUES ('MT019', 'EMP049', 'Fuel Filter Replacement', 'Replaced fuel filter', 'Completed', TO_DATE('2023-06-17', 'YYYY-MM-DD'), TO_DATE('2023-06-18', 'YYYY-MM-DD'), 'EMP049', 'TR009');
INSERT INTO MAINTENANCE VALUES ('MT020', 'EMP050', 'Safety Audit', 'Detailed safety audit', 'Completed', TO_DATE('2023-06-19', 'YYYY-MM-DD'), TO_DATE('2023-06-20', 'YYYY-MM-DD'), 'EMP050', 'TR010');
INSERT INTO MAINTENANCE VALUES ('MT021', 'EMP041', 'Engine Diagnostics', 'Checked engine diagnostics system', 'Completed', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-07-02', 'YYYY-MM-DD'), 'EMP041', 'TR001');
INSERT INTO MAINTENANCE VALUES ('MT022', 'EMP042', 'Brake Pad Inspection', 'Inspected brake pads', 'Completed', TO_DATE('2023-07-03', 'YYYY-MM-DD'), TO_DATE('2023-07-04', 'YYYY-MM-DD'), 'EMP042', 'TR002');
INSERT INTO MAINTENANCE VALUES ('MT023', 'EMP043', 'Wheel Bearing Lubrication', 'Lubricated wheel bearings', 'Completed', TO_DATE('2023-07-05', 'YYYY-MM-DD'), TO_DATE('2023-07-06', 'YYYY-MM-DD'), 'EMP043', 'TR003');
INSERT INTO MAINTENANCE VALUES ('MT024', 'EMP044', 'Oil Level Check', 'Checked oil levels', 'Completed', TO_DATE('2023-07-07', 'YYYY-MM-DD'), TO_DATE('2023-07-08', 'YYYY-MM-DD'), 'EMP044', 'TR004');
INSERT INTO MAINTENANCE VALUES ('MT025', 'EMP045', 'Brake Fluid Top-Up', 'Topped up brake fluid', 'Completed', TO_DATE('2023-07-09', 'YYYY-MM-DD'), TO_DATE('2023-07-10', 'YYYY-MM-DD'), 'EMP045', 'TR005');
INSERT INTO MAINTENANCE VALUES ('MT026', 'EMP046', 'A/C Filter Replacement', 'Replaced air conditioning filter', 'Completed', TO_DATE('2023-07-11', 'YYYY-MM-DD'), TO_DATE('2023-07-12', 'YYYY-MM-DD'), 'EMP046', 'TR006');
INSERT INTO MAINTENANCE VALUES ('MT027', 'EMP047', 'Lighting System Check', 'Checked all lighting systems', 'Completed', TO_DATE('2023-07-13', 'YYYY-MM-DD'), TO_DATE('2023-07-14', 'YYYY-MM-DD'), 'EMP047', 'TR007');
INSERT INTO MAINTENANCE VALUES ('MT028', 'EMP048', 'Suspension Lubrication', 'Lubricated suspension joints', 'Completed', TO_DATE('2023-07-15', 'YYYY-MM-DD'), TO_DATE('2023-07-16', 'YYYY-MM-DD'), 'EMP048', 'TR008');
INSERT INTO MAINTENANCE VALUES ('MT029', 'EMP049', 'Fuel System Inspection', 'Inspected fuel system', 'Completed', TO_DATE('2023-07-17', 'YYYY-MM-DD'), TO_DATE('2023-07-18', 'YYYY-MM-DD'), 'EMP049', 'TR009');
INSERT INTO MAINTENANCE VALUES ('MT030', 'EMP050', 'Safety Equipment Check', 'Checked safety equipment', 'Completed', TO_DATE('2023-07-19', 'YYYY-MM-DD'), TO_DATE('2023-07-20', 'YYYY-MM-DD'), 'EMP050', 'TR010');
INSERT INTO MAINTENANCE VALUES ('MT031', 'EMP041', 'Engine Filter Replacement', 'Replaced engine air filter', 'Completed', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-02', 'YYYY-MM-DD'), 'EMP041', 'TR001');
INSERT INTO MAINTENANCE VALUES ('MT032', 'EMP042', 'Brake Line Inspection', 'Inspected brake lines', 'Completed', TO_DATE('2023-08-03', 'YYYY-MM-DD'), TO_DATE('2023-08-04', 'YYYY-MM-DD'), 'EMP042', 'TR002');
INSERT INTO MAINTENANCE VALUES ('MT033', 'EMP043', 'Wheel Cleaning', 'Cleaned wheel assemblies', 'Completed', TO_DATE('2023-08-05', 'YYYY-MM-DD'), TO_DATE('2023-08-06', 'YYYY-MM-DD'), 'EMP043', 'TR003');
INSERT INTO MAINTENANCE VALUES ('MT034', 'EMP044', 'Oil Pressure Check', 'Checked oil pressure', 'Completed', TO_DATE('2023-08-07', 'YYYY-MM-DD'), TO_DATE('2023-08-08', 'YYYY-MM-DD'), 'EMP044', 'TR004');
INSERT INTO MAINTENANCE VALUES ('MT035', 'EMP045', 'Brake Adjustment', 'Adjusted brake mechanisms', 'Completed', TO_DATE('2023-08-09', 'YYYY-MM-DD'), TO_DATE('2023-08-10', 'YYYY-MM-DD'), 'EMP045', 'TR005');
INSERT INTO MAINTENANCE VALUES ('MT036', 'EMP046', 'A/C Compressor Service', 'Serviced A/C compressor', 'Completed', TO_DATE('2023-08-11', 'YYYY-MM-DD'), TO_DATE('2023-08-12', 'YYYY-MM-DD'), 'EMP046', 'TR006');
INSERT INTO MAINTENANCE VALUES ('MT037', 'EMP047', 'Lighting Wiring Check', 'Checked wiring for lights', 'Completed', TO_DATE('2023-08-13', 'YYYY-MM-DD'), TO_DATE('2023-08-14', 'YYYY-MM-DD'), 'EMP047', 'TR007');
INSERT INTO MAINTENANCE VALUES ('MT038', 'EMP048', 'Suspension Replacement', 'Replaced suspension parts', 'Completed', TO_DATE('2023-08-15', 'YYYY-MM-DD'), TO_DATE('2023-08-16', 'YYYY-MM-DD'), 'EMP048', 'TR008');
INSERT INTO MAINTENANCE VALUES ('MT039', 'EMP049', 'Fuel Injector Cleaning', 'Cleaned fuel injectors', 'Completed', TO_DATE('2023-08-17', 'YYYY-MM-DD'), TO_DATE('2023-08-18', 'YYYY-MM-DD'), 'EMP049', 'TR009');
INSERT INTO MAINTENANCE VALUES ('MT040', 'EMP050', 'Safety Drill', 'Conducted safety drill', 'Completed', TO_DATE('2023-08-19', 'YYYY-MM-DD'), TO_DATE('2023-08-20', 'YYYY-MM-DD'), 'EMP050', 'TR010');
INSERT INTO MAINTENANCE VALUES ('MT041', 'EMP041', 'Engine Calibration', 'Calibrated engine sensors', 'Completed', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-09-02', 'YYYY-MM-DD'), 'EMP041', 'TR001');
INSERT INTO MAINTENANCE VALUES ('MT042', 'EMP042', 'Brake System Upgrade', 'Upgraded brake system', 'Completed', TO_DATE('2023-09-03', 'YYYY-MM-DD'), TO_DATE('2023-09-04', 'YYYY-MM-DD'), 'EMP042', 'TR002');
INSERT INTO MAINTENANCE VALUES ('MT043', 'EMP043', 'Wheel Replacement', 'Replaced wheels', 'Completed', TO_DATE('2023-09-05', 'YYYY-MM-DD'), TO_DATE('2023-09-06', 'YYYY-MM-DD'), 'EMP043', 'TR003');
INSERT INTO MAINTENANCE VALUES ('MT044', 'EMP044', 'Oil Leak Repair', 'Repaired oil leaks', 'Completed', TO_DATE('2023-09-07', 'YYYY-MM-DD'), TO_DATE('2023-09-08', 'YYYY-MM-DD'), 'EMP044', 'TR004');
INSERT INTO MAINTENANCE VALUES ('MT045', 'EMP045', 'Brake Disc Replacement', 'Replaced brake discs', 'Completed', TO_DATE('2023-09-09', 'YYYY-MM-DD'), TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'EMP045', 'TR005');
INSERT INTO MAINTENANCE VALUES ('MT046', 'EMP046', 'A/C Thermostat Replacement', 'Replaced A/C thermostat', 'Completed', TO_DATE('2023-09-11', 'YYYY-MM-DD'), TO_DATE('2023-09-12', 'YYYY-MM-DD'), 'EMP046', 'TR006');
INSERT INTO MAINTENANCE VALUES ('MT047', 'EMP047', 'Lighting Panel Repair', 'Repaired lighting control panel', 'Completed', TO_DATE('2023-09-13', 'YYYY-MM-DD'), TO_DATE('2023-09-14', 'YYYY-MM-DD'), 'EMP047', 'TR007');
INSERT INTO MAINTENANCE VALUES ('MT048', 'EMP048', 'Suspension Shock Test', 'Tested suspension shocks', 'Completed', TO_DATE('2023-09-15', 'YYYY-MM-DD'), TO_DATE('2023-09-16', 'YYYY-MM-DD'), 'EMP048', 'TR008');
INSERT INTO MAINTENANCE VALUES ('MT049', 'EMP049', 'Fuel Pump Replacement', 'Replaced fuel pump unit', 'Completed', TO_DATE('2023-09-17', 'YYYY-MM-DD'), TO_DATE('2023-09-18', 'YYYY-MM-DD'), 'EMP049', 'TR009');
INSERT INTO MAINTENANCE VALUES ('MT050', 'EMP050', 'Emergency Brake Test', 'Tested emergency brake system', 'Completed', TO_DATE('2023-09-19', 'YYYY-MM-DD'), TO_DATE('2023-09-20', 'YYYY-MM-DD'), 'EMP050', 'TR010');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN001', 'TK001', TO_DATE('2025-05-01', 'YYYY-MM-DD'), 50.00, 'Passenger request', 'Processed', 'BK001');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN002', 'TK002', TO_DATE('2025-05-02', 'YYYY-MM-DD'), 30.00, 'Train delay', 'Processed', 'BK002');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN003', 'TK003', TO_DATE('2025-05-03', 'YYYY-MM-DD'), 20.00, 'Health emergency', 'Pending', 'BK003');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN004', 'TK004', TO_DATE('2025-05-04', 'YYYY-MM-DD'), 40.00, 'Schedule conflict', 'Processed', 'BK004');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN005', 'TK005', TO_DATE('2025-05-05', 'YYYY-MM-DD'), 25.00, 'Passenger request', 'Rejected', 'BK005');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN006', 'TK006', TO_DATE('2025-05-06', 'YYYY-MM-DD'), 35.00, 'Train cancelled', 'Processed', 'BK006');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN007', 'TK007', TO_DATE('2025-05-07', 'YYYY-MM-DD'), 45.00, 'Passenger request', 'Processed', 'BK007');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN008', 'TK008', TO_DATE('2025-05-08', 'YYYY-MM-DD'), 15.00, 'Schedule conflict', 'Pending', 'BK008');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN009', 'TK009', TO_DATE('2025-05-09', 'YYYY-MM-DD'), 50.00, 'Health emergency', 'Processed', 'BK009');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN010', 'TK010', TO_DATE('2025-05-10', 'YYYY-MM-DD'), 20.00, 'Passenger request', 'Processed', 'BK010');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN011', 'TK011', TO_DATE('2025-05-11', 'YYYY-MM-DD'), 30.00, 'Train delay', 'Rejected', 'BK011');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN012', 'TK012', TO_DATE('2025-05-12', 'YYYY-MM-DD'), 25.00, 'Passenger request', 'Processed', 'BK012');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN013', 'TK013', TO_DATE('2025-05-13', 'YYYY-MM-DD'), 35.00, 'Schedule conflict', 'Pending', 'BK013');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN014', 'TK014', TO_DATE('2025-05-14', 'YYYY-MM-DD'), 40.00, 'Passenger request', 'Processed', 'BK014');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN015', 'TK015', TO_DATE('2025-05-15', 'YYYY-MM-DD'), 45.00, 'Train cancelled', 'Processed', 'BK015');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN016', 'TK016', TO_DATE('2025-05-16', 'YYYY-MM-DD'), 15.00, 'Passenger request', 'Rejected', 'BK016');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN017', 'TK017', TO_DATE('2025-05-17', 'YYYY-MM-DD'), 50.00, 'Health emergency', 'Processed', 'BK017');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN018', 'TK018', TO_DATE('2025-05-18', 'YYYY-MM-DD'), 20.00, 'Schedule conflict', 'Pending', 'BK018');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN019', 'TK019', TO_DATE('2025-05-19', 'YYYY-MM-DD'), 30.00, 'Passenger request', 'Processed', 'BK019');

INSERT INTO CANCELLATIONS (cancellation_id, ticket_id, cancellation_date, refund_amount, reason, status, booking_id) VALUES ('CAN020', 'TK020', TO_DATE('2025-05-20', 'YYYY-MM-DD'), 25.00, 'Train delay', 'Processed', 'BK020');







SELECT * FROM EMPLOYEES;
SELECT * FROM ADMIN_STAFF;
SELECT * FROM ENGINE_DRIVERS;
SELECT * FROM MAINTENANCE_WORKERS;
SELECT * FROM GUARDS;
SELECT * FROM TICKET_COUNTER_STAFF;
SELECT * FROM EMPLOYEE_PHONE_NUMBER;
SELECT * FROM EMPLOYEE_EMAIL;
SELECT * FROM STATIONS;
SELECT * FROM PLATFORMS;
SELECT * FROM TRAINS;
SELECT * FROM ROUTES;
SELECT * FROM CLASSES;
SELECT * FROM FARE_RULES;
SELECT * FROM COACH;
SELECT * FROM SEATS;
SELECT * FROM PASSENGERS;
SELECT * FROM PASSENGER_PHONE;
SELECT * FROM PASSENGER_EMAIL;
SELECT * FROM SCHEDULE;
SELECT * FROM BOOKINGS;
SELECT * FROM TICKETS;
SELECT * FROM PAYMENTS;
SELECT * FROM CANCELLATIONS;
SELECT * FROM MAINTENANCE;








-- =============================================
-- 1. COMPLETE TICKET INFORMATION VIEW
-- Comprehensive view of all ticket-related information
-- =============================================
CREATE OR REPLACE VIEW V_Ticket_Info AS
SELECT 
    t.ticket_id,                               -- Ticket identifier
    t.status AS ticket_status,                 -- Status of the ticket (e.g., booked, canceled)
    t.fare,                                    -- Fare for the ticket
    p.first_name || ' ' || p.last_name AS passenger_name,  -- Full passenger name
    ph.primary_phone,                          -- Passenger's phone number
    em.primary_email,                          -- Passenger's email address
    s.schedule_date,                           -- Schedule date of the train
    s.departure_time,                          -- Train departure time
    s.arrival_time,                            -- Train arrival time
    tr.train_name,                             -- Name of the train
    tr.train_number,                           -- Number of the train
    r.route_id,                                -- Route ID of the train
    fs.station_name AS from_station,           -- Name of departure station
    ts.station_name AS to_station,             -- Name of arrival station
    co.coach_number,                           -- Coach number
    cl.class_name,                             -- Travel class (e.g., AC, Sleeper)
    t.seat_number,                             -- Assigned seat number
    b.booking_date,                            -- Booking date
    pmt.payment_method,                        -- Payment method used
    pmt.payment_status                         -- Status of payment
FROM TICKETS t
JOIN BOOKINGS b ON t.booking_id = b.booking_id
JOIN PASSENGERS p ON b.passenger_id = p.passenger_id
JOIN PASSENGER_PHONE ph ON p.passenger_id = ph.passenger_id
JOIN PASSENGER_EMAIL em ON p.passenger_id = em.passenger_id
JOIN SCHEDULE s ON b.schedule_id = s.schedule_id
JOIN ROUTES r ON s.route_id = r.route_id
JOIN STATIONS fs ON r.from_station_id = fs.station_id
JOIN STATIONS ts ON r.to_station_id = ts.station_id
JOIN TRAINS tr ON r.train_id = tr.train_id
JOIN COACH co ON t.coach_id = co.coach_id
JOIN CLASSES cl ON co.class_id = cl.class_id
LEFT JOIN PAYMENTS pmt ON b.booking_id = pmt.booking_id;

-- =============================================
-- 2. REVENUE PER ROUTE VIEW
-- Calculates total revenue by route
-- =============================================
CREATE OR REPLACE VIEW vw_revenue_per_route AS
SELECT 
    r.route_id,                              -- Route identifier
    SUM(pmt.amount) AS total_revenue         -- Total revenue for the route
FROM PAYMENTS pmt
JOIN BOOKINGS b ON pmt.booking_id = b.booking_id
JOIN SCHEDULE s ON b.schedule_id = s.schedule_id
JOIN ROUTES r ON s.route_id = r.route_id
GROUP BY r.route_id;

-- =============================================
-- 3. CLASS-WISE BOOKING STATISTICS VIEW
-- Provides ticket sales statistics by class
-- =============================================
CREATE OR REPLACE VIEW V_Class_Wise_Booking AS
SELECT 
    cl.class_name,                           -- Class type
    COUNT(t.ticket_id) AS total_tickets,     -- Number of tickets sold
    SUM(t.fare) AS total_fare                -- Total fare collected
FROM TICKETS t
JOIN COACH co ON t.coach_id = co.coach_id
JOIN CLASSES cl ON co.class_id = cl.class_id
GROUP BY cl.class_name;

-- =============================================
-- 4. CANCELLATIONS REPORT VIEW
-- Shows cancelled tickets with refund information
-- =============================================
CREATE OR REPLACE VIEW V_Cancellations_Info AS
SELECT 
    c.cancellation_id,                        -- Cancellation ID
    t.ticket_id,                              -- Ticket ID
    c.cancellation_date,                      -- Cancellation date
    c.refund_amount,                          -- Refund issued
    c.reason,                                 -- Reason for cancellation
    c.status AS cancellation_status,          -- Status of cancellation
    p.first_name || ' ' || p.last_name AS passenger_name, -- Passenger name
    fs.station_name AS from_station,          -- From station
    ts.station_name AS to_station             -- To station
FROM CANCELLATIONS c
JOIN TICKETS t ON c.ticket_id = t.ticket_id
JOIN BOOKINGS b ON c.booking_id = b.booking_id
JOIN PASSENGERS p ON b.passenger_id = p.passenger_id
JOIN SCHEDULE s ON b.schedule_id = s.schedule_id
JOIN ROUTES r ON s.route_id = r.route_id
JOIN STATIONS fs ON r.from_station_id = fs.station_id
JOIN STATIONS ts ON r.to_station_id = ts.station_id;

-- =============================================
-- 5. STAFF COUNT BY ROLE VIEW
-- Counts active staff members by role type
-- =============================================
CREATE OR REPLACE VIEW vw_staff_count_by_role AS
SELECT 'Admin' AS role, COUNT(*) AS total FROM ADMIN_STAFF
UNION
SELECT 'Driver', COUNT(*) FROM ENGINE_DRIVERS
UNION
SELECT 'Maintenance', COUNT(*) FROM MAINTENANCE_WORKERS
UNION
SELECT 'Guard', COUNT(*) FROM GUARDS
UNION
SELECT 'Ticket Staff', COUNT(*) FROM TICKET_COUNTER_STAFF;

-- =============================================
-- 6. TRAIN MOVEMENT VIEW
-- Shows train schedules with station movements
-- =============================================
CREATE OR REPLACE VIEW TRAIN_MOVEMENT_VIEW AS
SELECT 
    t.train_id,                               -- Train ID
    t.train_name,                             -- Train name
    sch.schedule_date,                        -- Schedule date
    sch.departure_time,                       -- Departure time
    sch.arrival_time,                         -- Arrival time
    fs.station_name AS from_station,          -- From station
    ts.station_name AS to_station             -- To station
FROM SCHEDULE sch
JOIN ROUTES r ON sch.route_id = r.route_id
JOIN TRAINS t ON r.train_id = t.train_id
JOIN STATIONS fs ON r.from_station_id = fs.station_id
JOIN STATIONS ts ON r.to_station_id = ts.station_id;

-- =============================================
-- 7. PASSENGERS WITHOUT TICKETS VIEW
-- Lists passengers who have never completed a booking
-- =============================================
CREATE OR REPLACE VIEW PASSENGERS_WITHOUT_TICKETS AS
SELECT 
    p.passenger_id,
    p.first_name,
    p.last_name,
    p.name,
    p.date_of_birth,
    p.gender,
    ph.primary_phone,
    ph.secondary_phone,
    em.primary_email,
    em.secondary_email
FROM PASSENGERS p
LEFT JOIN PASSENGER_PHONE ph ON p.passenger_id = ph.passenger_id
LEFT JOIN PASSENGER_EMAIL em ON p.passenger_id = em.passenger_id
LEFT JOIN BOOKINGS b ON p.passenger_id = b.passenger_id
LEFT JOIN TICKETS t ON b.booking_id = t.booking_id
WHERE t.ticket_id IS NULL;

-- =============================================
-- 8. BOOKING INFORMATION VIEW
-- Shows complete booking information including passenger and station details
-- =============================================
CREATE OR REPLACE VIEW VIEW_BOOKING_INFORMATION AS
SELECT 
    b.booking_id,                                      -- Booking ID
    b.booking_date,                                    -- Date when the booking was made
    b.status AS booking_status,                        -- Current booking status
    p.first_name || ' ' || p.last_name AS passenger_name, -- Full name of the passenger
    s.schedule_date,                                   -- Scheduled date of travel
    s.departure_time,                                  -- Departure time
    s.arrival_time,                                    -- Arrival time
    fs.station_name AS from_station,                   -- Name of origin station
    ts.station_name AS to_station                      -- Name of destination station
FROM BOOKINGS b
JOIN PASSENGERS p ON b.passenger_id = p.passenger_id
JOIN SCHEDULE s ON b.schedule_id = s.schedule_id
JOIN ROUTES r ON s.route_id = r.route_id
JOIN STATIONS fs ON r.from_station_id = fs.station_id
JOIN STATIONS ts ON r.to_station_id = ts.station_id;

-- =============================================
-- 9. PAYMENT DETAILS VIEW
-- Displays full payment details with passenger and booking information
-- =============================================
CREATE OR REPLACE VIEW VIEW_PAYMENT_DETAILS AS
SELECT 
    pmt.payment_id,                                   -- Unique payment ID
    pmt.amount,                                       -- Payment amount
    pmt.payment_method,                               -- Payment method
    pmt.payment_date,                                 -- Date of payment
    b.booking_id,                                     -- Associated booking ID
    ps.first_name || ' ' || ps.last_name AS passenger_name -- Name of the passenger
FROM PAYMENTS pmt
JOIN BOOKINGS b ON pmt.booking_id = b.booking_id
JOIN PASSENGERS ps ON b.passenger_id = ps.passenger_id;

-- =============================================
-- 10. MAINTENANCE DETAILS VIEW
-- Shows maintenance work details along with employee and train information
-- =============================================
CREATE OR REPLACE VIEW VIEW_MAINTENANCE_DETAILS AS
SELECT 
    m.maintenance_id,                                 -- Maintenance record ID
    m.maintenance_type,                               -- Type of maintenance
    m.status,                                         -- Status of the maintenance
    e.first_name || ' ' || e.last_name AS employee_name, -- Name of maintenance worker
    t.train_name                                      -- Name of the train
FROM MAINTENANCE m
JOIN EMPLOYEES e ON m.employee_id = e.employee_id
JOIN TRAINS t ON m.train_id = t.train_id;

-- =============================================
-- 11. REVENUE BY PAYMENT METHOD VIEW
-- Calculates total revenue grouped by payment method
-- =============================================
CREATE OR REPLACE VIEW VIEW_REVENUE_BY_PAYMENT_METHOD AS
SELECT 
    payment_method,                                  -- Method used to make the payment
    SUM(amount) AS total_revenue                     -- Total revenue generated per payment method
FROM PAYMENTS
GROUP BY payment_method;

-- =============================================
-- 12. TICKET SUMMARY VIEW
-- Shows number of tickets sold and total revenue for each train
-- =============================================
CREATE OR REPLACE VIEW VIEW_TICKET_SUMMARY AS
SELECT 
    tr.train_id,                                     -- Unique ID for the train
    tr.train_name,                                   -- Name of the train
    COUNT(t.ticket_id) AS total_tickets_sold,        -- Total number of tickets sold
    SUM(t.fare) AS total_revenue                     -- Total revenue generated
FROM TRAINS tr
JOIN ROUTES r ON tr.train_id = r.train_id
JOIN SCHEDULE s ON r.route_id = s.route_id
JOIN BOOKINGS b ON s.schedule_id = b.schedule_id
JOIN TICKETS t ON b.booking_id = t.booking_id
GROUP BY tr.train_id, tr.train_name
ORDER BY SUM(t.fare) DESC;

-- =============================================
-- 13. EMPLOYEE CONTACT VIEW
-- Consolidates employee info with their contact numbers and emails
-- =============================================
CREATE OR REPLACE VIEW vw_employee_contact AS
SELECT 
    e.employee_id,                                  -- Employee ID
    e.first_name,                                   -- First name
    e.last_name,                                    -- Last name
    ph.primary_number,                              -- Primary phone number
    em.primary_email                                -- Primary email address
FROM EMPLOYEES e
JOIN EMPLOYEE_PHONE_NUMBER ph ON e.employee_id = ph.employee_id
JOIN EMPLOYEE_EMAIL em ON e.employee_id = em.employee_id;

-- =============================================
-- 14. ROUTES AND STATIONS VIEW
-- Displays each route with the names of its origin and destination stations
-- =============================================
CREATE OR REPLACE VIEW vw_routes_stations AS
SELECT 
    r.route_id,                                     -- Route ID
    fs.station_name AS from_station,                -- Starting station
    ts.station_name AS to_station,                  -- Destination station
    r.distance_km                                   -- Distance in kilometers
FROM ROUTES r
JOIN STATIONS fs ON r.from_station_id = fs.station_id
JOIN STATIONS ts ON r.to_station_id = ts.station_id;

-- =============================================
-- 15. ENGINE DRIVER CERTIFICATION VIEW
-- Shows which engine drivers are certified for which types of trains
-- =============================================
CREATE OR REPLACE VIEW vw_engine_driver_train AS
SELECT 
    ed.employee_id,                                 -- Driver's employee ID
    e.first_name || ' ' || e.last_name AS driver_name, -- Full name
    ed.train_types_certified,                       -- Certified train types
    t.train_name                                    -- Train name
FROM ENGINE_DRIVERS ed
JOIN EMPLOYEES e ON ed.employee_id = e.employee_id
JOIN TRAINS t ON ed.train_types_certified LIKE '%' || t.train_type || '%';

-- =============================================
-- 16. COACH TRAIN CLASS VIEW
-- Shows coach details along with associated train and class names
-- =============================================
CREATE OR REPLACE VIEW VIEW_COACH_TRAIN_CLASS AS
SELECT 
    c.coach_id,                         -- Unique ID of the coach
    c.coach_number,                     -- Coach number
    c.seat_capacity,                    -- Total number of seats
    t.train_name,                       -- Name of the train
    cl.class_name                       -- Class of the coach
FROM COACH c
JOIN TRAINS t ON c.train_id = t.train_id
JOIN CLASSES cl ON c.class_id = cl.class_id;

-- =============================================
-- 17. AVERAGE FARE BY CLASS VIEW
-- Calculates average fare paid by class of coach
-- =============================================
CREATE OR REPLACE VIEW VIEW_AVG_FARE_BY_CLASS AS
SELECT 
    cl.class_name,                     -- Class name
    ROUND(AVG(t.fare), 2) AS average_fare -- Average fare
FROM TICKETS t
JOIN COACH co ON t.coach_id = co.coach_id
JOIN CLASSES cl ON co.class_id = cl.class_id
GROUP BY cl.class_name;

-- =============================================
-- 18. ROUTE CLASS FARE VIEW
-- Displays fare structure by route and class, with station names
-- =============================================
CREATE OR REPLACE VIEW vw_route_class_fare AS
SELECT 
    r.route_id,                        -- Route identifier
    fs.station_name AS from_station,  -- Source station
    ts.station_name AS to_station,    -- Destination station
    cl.class_name,                    -- Class of service
    fr.base_fare AS fare              -- Fare for the route
FROM FARE_RULES fr
JOIN CLASSES cl ON fr.class_id = cl.class_id
JOIN ROUTES r ON fr.route_id = r.route_id
JOIN STATIONS fs ON r.from_station_id = fs.station_id
JOIN STATIONS ts ON r.to_station_id = ts.station_id;



-- =============================================
-- 19. TRAIN CAPACITY UTILIZATION VIEW (FIXED)
-- Shows seat utilization percentage for each train
-- =============================================
CREATE OR REPLACE VIEW vw_train_capacity_utilization AS
SELECT 
    t.train_id,
    t.train_name,
    SUM(c.seat_capacity) AS total_capacity,
    COUNT(tk.ticket_id) AS seats_booked,
    ROUND(COUNT(tk.ticket_id) * 100.0 / SUM(c.seat_capacity), 2) AS utilization_percentage
FROM TRAINS t
JOIN COACH c ON t.train_id = c.train_id
LEFT JOIN TICKETS tk ON c.coach_id = tk.coach_id
GROUP BY t.train_id, t.train_name
ORDER BY utilization_percentage DESC;



-- =============================================
-- 20. PASSENGER TRAVEL HISTORY VIEW (CORRECTED)
-- Shows complete travel history for each passenger
-- =============================================
CREATE OR REPLACE VIEW vw_passenger_travel_history AS
SELECT 
    p.passenger_id,
    p.first_name || ' ' || p.last_name AS passenger_name,
    COUNT(t.ticket_id) AS total_trips,
    SUM(t.fare) AS total_spent,
    MIN(s.schedule_date) AS first_trip_date,
    MAX(s.schedule_date) AS last_trip_date,
    LISTAGG(DISTINCT tr.train_name, ', ') WITHIN GROUP (ORDER BY tr.train_name) AS trains_traveled,
    LISTAGG(DISTINCT fs.station_name || ' to ' || ts.station_name, ', ') 
        WITHIN GROUP (ORDER BY fs.station_name || ' to ' || ts.station_name) AS routes_traveled
FROM PASSENGERS p
JOIN BOOKINGS b ON p.passenger_id = b.passenger_id
JOIN TICKETS t ON b.booking_id = t.booking_id
JOIN SCHEDULE s ON b.schedule_id = s.schedule_id
JOIN ROUTES r ON s.route_id = r.route_id
JOIN TRAINS tr ON r.train_id = tr.train_id
JOIN STATIONS fs ON r.from_station_id = fs.station_id
JOIN STATIONS ts ON r.to_station_id = ts.station_id
GROUP BY p.passenger_id, p.first_name, p.last_name;











-- 1. Complete Ticket Information View
SELECT * FROM V_Ticket_Info;

-- 2. Revenue Per Route View
SELECT * FROM vw_revenue_per_route;

-- 3. Class-Wise Booking Statistics View
SELECT * FROM V_Class_Wise_Booking;

-- 4. Cancellations Report View
SELECT * FROM V_Cancellations_Info;

-- 5. Staff Count By Role View
SELECT * FROM vw_staff_count_by_role;

-- 6. Train Movement View
SELECT * FROM TRAIN_MOVEMENT_VIEW;

-- 7. Passengers Without Tickets View
SELECT * FROM PASSENGERS_WITHOUT_TICKETS;

-- 8. Booking Information View
SELECT * FROM VIEW_BOOKING_INFORMATION;

-- 9. Payment Details View
SELECT * FROM VIEW_PAYMENT_DETAILS;

-- 10. Maintenance Details View
SELECT * FROM VIEW_MAINTENANCE_DETAILS;

-- 11. Revenue By Payment Method View
SELECT * FROM VIEW_REVENUE_BY_PAYMENT_METHOD;

-- 12. Ticket Summary View
SELECT * FROM VIEW_TICKET_SUMMARY;

-- 13. Employee Contact View
SELECT * FROM vw_employee_contact;

-- 14. Routes And Stations View
SELECT * FROM vw_routes_stations;

-- 15. Engine Driver Certification View
SELECT * FROM vw_engine_driver_train;

-- 16. Coach Train Class View
SELECT * FROM VIEW_COACH_TRAIN_CLASS;

-- 17. Average Fare By Class View
SELECT * FROM VIEW_AVG_FARE_BY_CLASS;

-- 18. Route Class Fare View
SELECT * FROM vw_route_class_fare;

-- 19. Train Capacity Utilization View
SELECT * FROM vw_train_capacity_utilization;

-- 20. Passenger Travel History View
SELECT * FROM vw_passenger_travel_history;

