CREATE TABLE members (
    member_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    join_date DATE
);

CREATE TABLE trainers (
    trainer_id INT PRIMARY KEY,
    name VARCHAR(50),
    specialty VARCHAR(50)
);

CREATE TABLE plans (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE subscriptions (
    sub_id INT PRIMARY KEY,
    member_id INT,
    plan_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (plan_id) REFERENCES plans(plan_id)
);

CREATE TABLE sessions (
    session_id INT PRIMARY KEY,
    member_id INT,
    trainer_id INT,
    session_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
);






INSERT INTO members VALUES
(1, 'Omar', 20, 'Male', '2026-01-01'),
(2, 'Ali', 22, 'Male', '2026-02-01'),
(3, 'Sara', 21, 'Female', '2026-03-01'),
(4, 'Mona', 25, 'Female', '2026-01-15'),
(5, 'Youssef', 23, 'Male', '2026-02-10');

INSERT INTO trainers VALUES
(1, 'Ahmed', 'Fitness'),
(2, 'Hassan', 'Bodybuilding'),
(3, 'Nour', 'Cardio');

INSERT INTO plans VALUES
(1, 'Basic', 300),
(2, 'Standard', 500),
(3, 'Premium', 800);

INSERT INTO subscriptions VALUES
(1, 1, 2, '2026-01-01', '2026-03-01'),
(2, 2, 3, '2026-02-01', '2026-04-01'),
(3, 3, 1, '2026-03-01', '2026-05-01'),
(4, 4, 2, '2026-01-15', '2026-03-15'),
(5, 5, 3, '2026-02-10', '2026-04-10');

INSERT INTO sessions VALUES
(1, 1, 1, '2026-02-01'),
(2, 2, 2, '2026-02-05'),
(3, 3, 3, '2026-03-05'),
(4, 1, 2, '2026-02-10'),
(5, 4, 1, '2026-02-20');




SELECT m.name, p.plan_name
FROM members m
JOIN subscriptions s ON m.member_id = s.member_id
JOIN plans p ON s.plan_id = p.plan_id;
SELECT p.plan_name, COUNT(*) AS total_members
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
GROUP BY p.plan_name;
SELECT name
FROM members
WHERE member_id IN (
    SELECT member_id
    FROM subscriptions s
    JOIN plans p ON s.plan_id = p.plan_id
    WHERE p.price > 500
);
SELECT name,
CASE
    WHEN age < 21 THEN 'Young'
    WHEN age BETWEEN 21 AND 30 THEN 'Adult'
    ELSE 'Senior'
END AS category
FROM members;
SELECT t.name, COUNT(*) AS total_sessions
FROM sessions s
JOIN trainers t ON s.trainer_id = t.trainer_id
GROUP BY t.name
ORDER BY total_sessions DESC;
