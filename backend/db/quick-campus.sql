-- Drop the database if it exists and create a new one
DROP DATABASE IF EXISTS quick_campus;
CREATE DATABASE quick_campus;
USE quick_campus;

-- Create the roles table
CREATE TABLE roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL
);

-- Create the status table
CREATE TABLE status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);

-- Create the users table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    role_id INT,
    profile_image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

-- Create the requests table
CREATE TABLE requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    rider_id INT,
    dropoff_latitude DECIMAL(9,6),
    dropoff_longitude DECIMAL(9,6),
    created_at DATE DEFAULT CURRENT_DATE,
    status INT DEFAULT 1,
    FOREIGN KEY (student_id) REFERENCES users(user_id),
    FOREIGN KEY (rider_id) REFERENCES users(user_id),
    FOREIGN KEY (status) REFERENCES status(status_id)
);

-- Create the ratings table
CREATE TABLE ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    request_id INT,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    feedback TEXT,
    created_at DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (request_id) REFERENCES requests(request_id)
);

-- Create the pending_requests table
CREATE TABLE pending_requests (
    pending_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    dropoff_latitude DECIMAL(9,6),
    dropoff_longitude DECIMAL(9,6),
    created_at DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES users(user_id)
);

-- Insert default roles
INSERT INTO roles (role_name) VALUES
('admin'),
('student'),
('rider');

-- Insert default statuses
INSERT INTO status (status_name) VALUES
('begin'),
('picked'),
('arriving'),
('delivered'),
('finalised');
