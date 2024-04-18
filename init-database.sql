
USE InsideOutDB;

INSERT INTO Risks (risk_level) VALUES ('Low'), ('Medium'), ('High');
INSERT INTO Rules (name) VALUES ('Admin'), ('Doctor');

INSERT INTO Users (rule_id, full_name, username, hashed_password, salt)
VALUES
(2, 'Dr. Alice Smith', 'dr_alice', '<hashed_password_1>', '<salt_1>'),
(2, 'Dr. Bob Johnson', 'dr_bob', '<hashed_password_2>', '<salt_2>'),
(2, 'Dr. Clara Wilson', 'dr_clara', '<hashed_password_3>', '<salt_3>');
