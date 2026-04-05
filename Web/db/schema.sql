DROP DATABASE IF EXISTS project;
CREATE DATABASE project;
USE project;

CREATE TABLE Users (
    UserID INTEGER PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(50) UNIQUE,
    Password VARCHAR(50),
    Department VARCHAR(50)
);

CREATE TABLE Students (
    UserID INTEGER PRIMARY KEY,
    StudentID INTEGER UNIQUE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Admins (
    UserID INTEGER PRIMARY KEY,
    AdminID INTEGER UNIQUE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Course (
    CourseID INTEGER PRIMARY KEY,
    Department VARCHAR(50),
    CourseNumber INTEGER,
    CourseName VARCHAR(100)
);

CREATE TABLE Building (
    BuildingName VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Room (
    RoomID INTEGER,
    BuildingName VARCHAR(100),
    PRIMARY KEY (RoomID, BuildingName),
    FOREIGN KEY (BuildingName) REFERENCES Building(BuildingName)
);

CREATE TABLE StudySession (
    SessionID INTEGER AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    StartTime TIME,
    EndTime TIME,
    Day DATE,
    Capacity INTEGER,
    Description VARCHAR(300)
);

CREATE TABLE Disables (
    AdminUserID INTEGER,
    StudentUserID INTEGER,
    Reason VARCHAR(200),
    PRIMARY KEY (AdminUserID, StudentUserID),
    UNIQUE (StudentUserID),
    FOREIGN KEY (AdminUserID) REFERENCES Admins(UserID),
    FOREIGN KEY (StudentUserID) REFERENCES Students(UserID)
);

CREATE TABLE Deletes (
    AdminUserID INTEGER,
    SessionID INTEGER,
    Reason VARCHAR(200),
    PRIMARY KEY (AdminUserID, SessionID),
    UNIQUE (SessionID),
    FOREIGN KEY (AdminUserID) REFERENCES Users(UserID),
    FOREIGN KEY (SessionID) REFERENCES StudySession(SessionID)
);

CREATE TABLE Joins (
    StudentUserID INTEGER,
    SessionID INTEGER,
    SuccessStatus VARCHAR(50),
    PRIMARY KEY (StudentUserID, SessionID),
    FOREIGN KEY (StudentUserID) REFERENCES Students(UserID),
    FOREIGN KEY (SessionID) REFERENCES StudySession(SessionID)
);

CREATE TABLE Creates (
    StudentUserID INTEGER,
    SessionID INTEGER,
    SuccessStatus VARCHAR(50),
    PRIMARY KEY (StudentUserID, SessionID),
    UNIQUE (SessionID),
    FOREIGN KEY (StudentUserID) REFERENCES Students(UserID),
    FOREIGN KEY (SessionID) REFERENCES StudySession(SessionID)
);

CREATE TABLE StudyingFor (
    SessionID INTEGER,
    CourseID INTEGER,
    PRIMARY KEY (SessionID, CourseID),
    UNIQUE (SessionID),
    FOREIGN KEY (SessionID) REFERENCES StudySession(SessionID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE TakesPlaceIn (
    RoomID INTEGER,
    BuildingName VARCHAR(100),
    SessionID INTEGER,
    PRIMARY KEY (RoomID, BuildingName, SessionID),
    UNIQUE (SessionID),
    FOREIGN KEY (RoomID, BuildingName) REFERENCES Room(RoomID, BuildingName),
    FOREIGN KEY (SessionID) REFERENCES StudySession(SessionID)
);
