-- Database
CREATE DATABASE IF NOT EXISTS InsideOutDB;
USE InsideOutDB;


-- Roles Table
CREATE TABLE IF NOT EXISTS Roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);


-- Risks Table
CREATE TABLE IF NOT EXISTS Risks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    risk_level VARCHAR(255) NOT NULL UNIQUE
);

-- Medical_Data_Feature Table
CREATE TABLE IF NOT EXISTS Medical_Data_Feature (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    value VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Users Table
CREATE TABLE IF NOT EXISTS Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT,
    full_name VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES Roles(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Patients Table
CREATE TABLE IF NOT EXISTS Patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_by INT,
    id_number VARCHAR(255) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (created_by) REFERENCES Users(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Medical_Data Table
CREATE TABLE IF NOT EXISTS Medical_Data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    trained BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (patient_id) REFERENCES Patients(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Medical_Data_Features Table
CREATE TABLE IF NOT EXISTS Medical_Data_Features (
    id INT AUTO_INCREMENT PRIMARY KEY,
    medical_data_id INT,
    medical_data_feature_id INT,
    FOREIGN KEY (medical_data_id) REFERENCES Medical_Data(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (medical_data_feature_id) REFERENCES Medical_Data_Feature(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Reports Table
CREATE TABLE IF NOT EXISTS Reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    created_by INT,
    actual_risk INT,
    medical_data_id INT,
    risk_level INT,
    assessment_score FLOAT,
    ds2_vote TINYINT CHECK (ds2_vote BETWEEN 0 AND 5),
    ds4_vote TINYINT CHECK (ds4_vote BETWEEN 0 AND 5),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES Users(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (actual_risk) REFERENCES Risks(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES Patients(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (risk_level) REFERENCES Risks(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (medical_data_id) REFERENCES Medical_Data(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Model Predictions Table
CREATE TABLE IF NOT EXISTS Model_Predictions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(255) NOT NULL,
    prediction TINYINT NOT NULL,
    model_accuracy FLOAT NOT NULL
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Report Model Predictions Table
CREATE TABLE IF NOT EXISTS Report_Model_Predictions  (
    id INT AUTO_INCREMENT PRIMARY KEY,
    report_id INT,
    prediction_id INT,
    FOREIGN KEY (report_id) REFERENCES Reports(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (prediction_id) REFERENCES Model_Predictions(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);