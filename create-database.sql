-- Database
CREATE DATABASE IF NOT EXISTS InsideOutDB;
USE InsideOutDB;


-- Rules Table
CREATE TABLE IF NOT EXISTS Rules (
    rule_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- FeatureScore Table
CREATE TABLE IF NOT EXISTS FeatureScore (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    score FLOAT NOT NULL
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
    value VARCHAR(255) NOT NULL
);

-- Users Table
CREATE TABLE IF NOT EXISTS Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    rule_id INT,
    full_name VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    hashed_password VARCHAR(255) NOT NULL,
    salt VARCHAR(255) NOT NULL,
    FOREIGN KEY (rule_id) REFERENCES Rules(rule_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Patients Table
CREATE TABLE IF NOT EXISTS Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    created_by INT,
    id_number VARCHAR(255) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Medical_Data Table
CREATE TABLE IF NOT EXISTS Medical_Data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    trained BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
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
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    created_by INT,
    prediction_feature_score_id INT,
    assessment INT,
    actual_risk INT,
    medical_data_id INT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        on UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (prediction_feature_score_id) REFERENCES FeatureScore(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (assessment) REFERENCES Risks(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (actual_risk) REFERENCES Risks(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (medical_data_id) REFERENCES Medical_Data(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- FeatureImportance Table
CREATE TABLE IF NOT EXISTS FeatureImportance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    report_id INT,
    feature_score_id INT,
    FOREIGN KEY (report_id) REFERENCES Reports(report_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (feature_score_id) REFERENCES FeatureScore(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);