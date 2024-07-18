DROP DATABASE IF EXISTS quick_campus;
CREATE DATABASE quick_campus;
USE quick_campus;

CREATE TABLE roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL
);

CREATE TABLE status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);


CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role_id INT,
    profile_image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);


CREATE TABLE requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    rider_id INT,
    request_type ENUM ('send', 'deliver') NOT NULL,
    pickup_latitude DECIMAL(9,6),
    pickup_longitude DECIMAL(9,6),
    dropoff_latitude DECIMAL(9,6),
    dropoff_longitude DECIMAL(9,6),
    status_id INT,
    created_at DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES users(user_id),
    FOREIGN KEY (rider_id) REFERENCES users(user_id),
    FOREIGN KEY (status_id) REFERENCES status(status_id)
);


CREATE TABLE ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    request_id INT,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    feedback TEXT,
    created_at DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (request_id) REFERENCES requests(request_id)
);

INSERT INTO roles (role_name) VALUES
('admin'),
('student'),
('rider');


INSERT INTO status (status_name) VALUES
('picked'),
('arriving'),
('delivered'),
('finalised');
