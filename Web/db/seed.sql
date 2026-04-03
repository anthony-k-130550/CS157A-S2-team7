USE project;

INSERT INTO Users (UserID, FullName, Email, Password, Department) VALUES
(1, 'Bob Dylan', 'bob.dylan@gmail.com', 'bd123', 'Computer Science'),
(2, 'Anthony Kieu', 'anthony.kieu@gmail.com', 'ak275', 'Computer Science'),
(3, 'Carlos Rivera', 'carlos.rivera@gmail.com', 'c345', 'Physics'),
(4, 'Emily Chen', 'emily.chen@gmail.com', 'd456', 'Biology'),
(5, 'Daniel Kim', 'daniel.kim@gmail.com', 'e567', 'Computer Science'),
(6, 'Sophia Martinez', 'sophia.martinez@gmail.com', 'f678', 'Chemistry'),
(7, 'Liam Brown', 'liam.brown@gmail.com', 'g789', 'History'),
(8, 'Olivia Patel', 'olivia.patel@gmail.com', 'h890', 'Psychology'),
(9, 'Noah Williams', 'noah.williams@gmail.com', 'i901', 'Engineering'),
(10, 'Ava Thompson', 'ava.thompson@gmail.com', 'j012', 'Economics'),
(11, 'Ethan Brown', 'ethan.brown@gmail.com', 'k123', 'Computer Science'),
(12, 'Mia Garcia', 'mia.garcia@gmail.com', 'l234', 'Mathematics'),
(13, 'Lucas Nguyen', 'lucas.nguyen@gmail.com', 'm345', 'Physics'),
(14, 'Isabella Rossi', 'isabella.rossi@gmail.com', 'n456', 'Biology'),
(15, 'James Wilson', 'james.wilson@gmail.com', 'o567', 'Chemistry'),
(16, 'Grace Miller', 'grace.miller@gmail.com', 'p678', 'Physics'),
(17, 'Henry Davis', 'henry.davis@gmail.com', 'q789', 'Mathematics'),
(18, 'Chloe Anderson', 'chloe.anderson@gmail.com', 'r890', 'Computer Science'),
(19, 'Nathan Scott', 'nathan.scott@gmail.com', 's901', 'Biology'),
(20, 'Zoe Ramirez', 'zoe.ramirez@gmail.com', 't012', 'Chemistry');

INSERT INTO Students (UserID, StudentID) VALUES
(1, 58347),
(2, 91426),
(3, 70215),
(4, 46839),
(5, 65124),
(6, 83710),
(7, 59263),
(8, 74018),
(9, 32659),
(10, 90541);

INSERT INTO Admins (UserID, AdminID) VALUES
(11, 0),
(12, 1111111),
(13, 2222222),
(14, 3333333),
(15, 4444444),
(16, 5555555),
(17, 6666666),
(18, 7777777),
(19, 8888888),
(20, 9999999);

INSERT INTO Course (CourseID, Department, CourseNumber, CourseName) VALUES
(1, 'Computer Science', 101, 'Introduction to Computer Science'),
(2, 'Mathematics', 101, 'Introduction to Mathematics'),
(3, 'Physics', 101, 'Introduction to Physics'),
(4, 'Biology', 101, 'Introduction to Biology'),
(5, 'Chemistry', 101, 'Introduction to Chemistry'),
(6, 'Psychology', 101, 'Introduction to Psychology'),
(7, 'Economics', 101, 'Introduction to Economics'),
(8, 'History', 101, 'Introduction to History'),
(9, 'Engineering', 101, 'Introduction to Engineering'),
(10, 'Philosophy', 101, 'Introduction to Philosophy');

INSERT INTO Building (BuildingName) VALUES
('MacQuarrie Hall'),
('Martin Luther Jr. Library'),
('Boccardo Hall'),
('Duncan Hall'),
('Sweeney Hall'),
('Hugh Gillis Hall'),
('Interdisciplinary Science Building'),
('Science Building'),
('Dudley Moorhead Hall'),
('Engineering Building');

INSERT INTO Room (RoomID, BuildingName) VALUES
(101, 'MacQuarrie Hall'),
(245, 'MacQuarrie Hall'),
(265, 'Martin Luther Jr. Library'),
(201, 'Martin Luther Jr. Library'),
(120, 'Boccardo Hall'),
(178, 'Boccardo Hall'),
(333, 'Duncan Hall'),
(342, 'Duncan Hall'),
(150, 'Sweeney Hall'),
(162, 'Sweeney Hall'),
(111, 'Hugh Gillis Hall'),
(218, 'Hugh Gillis Hall'),
(388, 'Interdisciplinary Science Building'),
(489, 'Interdisciplinary Science Building'),
(142, 'Science Building'),
(112, 'Science Building'),
(348, 'Dudley Moorhead Hall'),
(350, 'Dudley Moorhead Hall'),
(175, 'Engineering Building'),
(301, 'Engineering Building');

INSERT INTO StudySession (SessionID, Title, StartTime, EndTime, Day, Capacity, Description) VALUES
(1, 'CS101 Midterm Review', '09:00:00', '10:30:00', '2026-04-01', 25, 'cs review'),
(2, 'Calculus I Limits Workshop', '11:00:00', '12:30:00', '2026-04-01', 20, 'more calculus help'),
(3, 'Physics Mechanics Help', '13:00:00', '14:30:00', '2026-04-02', 30, 'physics help, please come'),
(4, 'Biology Cell Structure Study', '15:00:00', '16:30:00', '2026-04-02', 18, 'bio study group, upcoming test for cell struct'),
(5, 'Chemistry Stoichiometry Review', '09:30:00', '11:00:00', '2026-04-03', 22, 'more practice problems as a group'),
(6, 'Psychology Intro Concepts', '12:00:00', '13:00:00', '2026-04-03', 15, 'review psychology concepts as a team'),
(7, 'Economics Supply and Demand', '14:00:00', '15:30:00', '2026-04-04', 20, 'please come help me learn economics'),
(8, 'History Essay Workshop', '16:00:00', '17:30:00', '2026-04-04', 12, 'we can peer review each others essays'),
(9, 'Engineering Statics Problems', '10:00:00', '11:30:00', '2026-04-05', 24, 'solving problems'),
(10, 'Math Linear Algebra Review', '12:30:00', '14:00:00', '2026-04-05', 20, 'more work on matrices and linear transformations'),
(11, 'CS Data Structures Study', '15:00:00', '16:30:00', '2026-04-06', 25, 'focusing on B trees'),
(12, 'Biology Genetics Basics', '09:00:00', '10:30:00', '2026-04-06', 18, 'punnett squares practice problems from class'),
(13, 'Chemistry Lab Prep', '11:00:00', '12:00:00', '2026-04-07', 16, 'going over key concepts before the lab'),
(14, 'Physics Electricity Session', '13:30:00', '15:00:00', '2026-04-07', 20, 'circuit analysis practice problems'),
(15, 'Math Probability Study', '15:30:00', '17:00:00', '2026-04-08', 22, 'discrete');

INSERT INTO Disables (AdminUserID, StudentUserID, Reason) VALUES
(11, 1, 'Bad Behavior'),
(11, 2, 'Bad Behavior'),
(11, 3, 'Bad Behavior'),
(11, 4, 'Bad Behavior'),
(13, 5, 'Bad Behavior'),
(12, 6, 'Bad Behavior'),
(13, 7, 'Bad Behavior'),
(13, 8, 'Bad Behavior'),
(12, 9, 'Bad Behavior'),
(12, 10, 'Bad Behavior');

INSERT INTO Deletes (AdminUserID, SessionID, Reason) VALUES
(15, 1, 'Violated Web Policy'),
(15, 2, 'Violated Web Policy'),
(15, 3, 'Violated Web Policy'),
(15, 4, 'Violated Web Policy'),
(15, 5, 'Violated Web Policy'),
(15, 6, 'Violated Web Policy'),
(15, 7, 'Violated Web Policy'),
(15, 8, 'Violated Web Policy'),
(15, 9, 'Violated Web Policy'),
(15, 10, 'Violated Web Policy');

INSERT INTO Joins (StudentUserID, SessionID, SuccessStatus) VALUES
(3, 7, 'successfully joined'),
(8, 2, 'successfully joined'),
(1, 5, 'successfully joined'),
(10, 4, 'successfully joined'),
(6, 9, 'successfully joined'),
(2, 3, 'successfully joined'),
(7, 10, 'successfully joined'),
(5, 1, 'successfully joined'),
(9, 6, 'successfully joined'),
(4, 8, 'successfully joined');

INSERT INTO Creates (StudentUserID, SessionID, SuccessStatus) VALUES
(1, 1, 'successfully created'),
(2, 2, 'successfully created'),
(3, 3, 'successfully created'),
(4, 4, 'successfully created'),
(5, 5, 'successfully created'),
(6, 6, 'successfully created'),
(7, 7, 'successfully created'),
(8, 8, 'successfully created'),
(9, 9, 'successfully created'),
(10, 10, 'successfully created');

INSERT INTO StudyingFor (SessionID, CourseID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 2),
(11, 1),
(12, 4),
(13, 5),
(14, 3),
(15, 2);

INSERT INTO TakesPlaceIn (RoomID, BuildingName, SessionID) VALUES
(101, 'MacQuarrie Hall', 1),
(245, 'MacQuarrie Hall', 2),
(265, 'Martin Luther Jr. Library', 3),
(201, 'Martin Luther Jr. Library', 4),
(120, 'Boccardo Hall', 5),
(178, 'Boccardo Hall', 6),
(333, 'Duncan Hall', 7),
(342, 'Duncan Hall', 8),
(150, 'Sweeney Hall', 9),
(162, 'Sweeney Hall', 10),
(111, 'Hugh Gillis Hall', 11),
(218, 'Hugh Gillis Hall', 12),
(388, 'Interdisciplinary Science Building', 13),
(489, 'Interdisciplinary Science Building', 14),
(142, 'Science Building', 15);
