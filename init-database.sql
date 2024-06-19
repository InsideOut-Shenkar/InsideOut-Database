-- Connect to the Database
\c InsideOutDB;

-- Insert data into Risks table
INSERT INTO Risks (risk_level) VALUES 
    ('low'), 
    ('medium'), 
    ('high');

-- Insert data into Roles table
INSERT INTO Roles (name) VALUES 
    ('admin'), 
    ('doctor');
