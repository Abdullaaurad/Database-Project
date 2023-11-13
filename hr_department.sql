-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 13, 2023 at 06:24 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hr_department`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateEmployeeLeaveRecords` ()   BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE type VARCHAR(50);
    
    WHILE counter <= 100 DO
        SET type = CASE
            WHEN counter % 4 = 1 THEN 'Sick Leave'
            WHEN counter % 4 = 2 THEN 'Vacation'
            WHEN counter % 4 = 3 THEN 'Parental Leave'
            WHEN counter % 4 = 0 THEN 'Maternity Leave'
            END;
        
        INSERT INTO employee_leave (Employee_Id, Commencement_Date, Conclusion_Date, Type, Acceptance)
        VALUES (counter, 
                DATE_ADD('2020-05-01', INTERVAL counter - 1 DAY),
                DATE_ADD('2020-05-01', INTERVAL counter + 29 DAY),
                type,
                'Yes');
        
        SET counter = counter + 1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateRandomApplicants20TimesNew` ()   BEGIN
  DECLARE i INT DEFAULT 1;
  
  WHILE i <= 20 DO
    -- Generate and insert random data 20 times
    INSERT INTO `applicant` (`Contact`, `Status`, `Interview_Time`, `Vacancy_Id`)
    SELECT CONCAT('ZERO', FLOOR(100000000 + RAND() * 900000000)) AS `Contact`,
           CASE WHEN i % 5 = 0 THEN 'Not Selected'
                WHEN i % 4 = 0 THEN 'Hired'
                WHEN i % 3 = 0 THEN 'Interview Scheduled'
                WHEN i % 2 = 0 THEN 'Under Review'
                ELSE 'Applied' END AS `Status`,
           DATE_ADD(NOW(), INTERVAL i DAY) AS `Interview_Time`,
           FLOOR(1 + RAND() * 25) AS `Vacancy_Id`;
    
    SET i = i + 1;
  END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateRandomPayrollData` ()   BEGIN
  DECLARE i INT DEFAULT 1;

  WHILE i <= 100 DO
    -- Generate random Employee_Id between 1 and 100
    SET @Employee_Id = FLOOR(RAND() * 100) + 1;

    -- Generate random salary within the range (50,000 - 500,000) and round to the nearest 10,000
    SET @Salary = ROUND((FLOOR(RAND() * (500000 - 50000) / 10000) * 10000) + 50000, 0);

    -- Generate random bonus between 10% and 20% of the salary (or 0) and round to the nearest 1,000
    SET @Bonus = CASE 
      WHEN RAND() < 0.2 THEN 0
      ELSE ROUND((FLOOR(RAND() * (0.1 * @Salary) / 1000) * 1000) + (0.1 * @Salary), 0)
    END;

    -- Insert the record into the payroll table
    INSERT INTO `payroll` (`Date`, `Salary`, `Bonus`, `Allowance`, `Employee_Id`)
    VALUES (DATE_FORMAT(DATE_ADD('2020-01-31', INTERVAL i MONTH), '%Y-%m-%d'), @Salary, @Bonus, 10000, @Employee_Id);

    SET i = i + 1;
  END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GenerateRandomRoundedPayrollRecords` ()   BEGIN
  DECLARE i INT DEFAULT 1;
  
  WHILE i <= 100 DO
    -- Generate random salary within the range (50,000 - 500,000) and round to the nearest 10,000
    SET @Salary = ROUND((FLOOR(RAND() * (500000 - 50000) / 10000) * 10000) + 50000, 0);
    
    -- Generate random bonus between 10% and 20% of the salary (or 0) and round to the nearest 1,000
    SET @Bonus = CASE 
                   WHEN RAND() < 0.2 THEN 0
                   ELSE ROUND((FLOOR(RAND() * (0.1 * @Salary) / 1000) * 1000) + (0.1 * @Salary), 0)
                 END;
    
    -- Insert the record into the payroll table
    INSERT INTO `payroll` (`Date`, `Salary`, `Bonus`, `Allowance`, `Employee_Id`)
    VALUES (DATE_FORMAT(DATE_ADD('2020-01-31', INTERVAL i MONTH), '%Y-%m-%d'), @Salary, @Bonus, 10000, '24');
    
    SET i = i + 1;
  END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertRandomAttendance` ()   BEGIN
  DECLARE counter INT DEFAULT 0;

  WHILE counter < 100 DO
    INSERT INTO `attendance` (`Employee_Id`, `Date`, `Arrival Time`, `Departure Time`)
    SELECT
      FLOOR(1 + (RAND() * 100)) as `Employee_Id`,
      DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 730) DAY) as `Date`,
      MAKETIME(7 + FLOOR(RAND() * 1), FLOOR(RAND() * 60), FLOOR(RAND() * 60)) as `Arrival Time`,
      MAKETIME(17 + FLOOR(RAND() * 1), FLOOR(RAND() * 60), FLOOR(RAND() * 60)) as `Departure Time`;

    SET counter = counter + 1;
  END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `applicant`
--

CREATE TABLE `applicant` (
  `Application_Id` smallint(5) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Contact` bigint(10) NOT NULL,
  `Status` varchar(30) DEFAULT 'Applied',
  `Interview_Time` datetime DEFAULT NULL,
  `Vacancy_Id` smallint(5) NOT NULL,
  `Email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `applicant`
--

INSERT INTO `applicant` (`Application_Id`, `Name`, `Contact`, `Status`, `Interview_Time`, `Vacancy_Id`, `Email`) VALUES
(1, 'S.A.Abdulla', 777362229, 'Applied', '2020-07-15 09:00:00', 11, 'Abdullaaurad@gmail.com'),
(2, 'Brad Pitt', 770000002, 'Under Review', '2020-03-02 10:00:00', 2, 'brad.pitt@example.com'),
(3, 'Leonardo DiCaprio', 770000003, 'Interview Scheduled', '2020-03-03 11:15:00', 3, 'leonardo.dicaprio@example.com'),
(4, 'Emma Watson', 770000004, 'Applied', '2020-03-04 13:45:00', 4, 'emma.watson@example.com'),
(5, 'Dwayne Johnson', 770000005, 'Selected', '2020-03-05 15:30:00', 5, 'dwayne.johnson@example.com'),
(6, 'Tom Hanks', 770000006, 'Selected', '2020-03-06 09:00:00', 6, 'tom.hanks@example.com'),
(7, 'Jennifer Aniston', 770000007, 'Under Review', '2020-03-07 10:30:00', 7, 'jennifer.aniston@example.com'),
(8, 'Robert Downey Jr.', 770000008, 'Interview Scheduled', '2020-03-08 11:45:00', 8, 'robert.downey@example.com'),
(9, 'Scarlett Johansson', 770000009, 'Not Selected', '2020-03-09 14:15:00', 9, 'scarlett.johansson@example.com'),
(10, 'Chris Hemsworth', 770000010, 'Selected', '2020-03-10 16:00:00', 10, 'chris.hemsworth@example.com'),
(11, 'Johnny Depp', 770000011, 'Applied', '2020-03-11 09:30:00', 11, 'johnny.depp@example.com'),
(12, 'Anne Hathaway', 770000012, 'Under Review', '2020-03-12 10:00:00', 12, 'anne.hathaway@example.com'),
(13, 'Chris Evans', 770000013, 'Interview Scheduled', '2020-03-13 11:15:00', 13, 'chris.evans@example.com'),
(14, 'Gal Gadot', 770000014, 'Not Selected', '2020-03-14 13:45:00', 14, 'gal.gadot@example.com'),
(15, 'Ryan Reynolds', 770000015, 'Selected', '2020-03-15 15:30:00', 15, 'ryan.reynolds@example.com'),
(16, 'Emma Stone', 770000016, 'Applied', '2020-03-16 09:00:00', 16, 'emma.stone@example.com'),
(17, 'Tom Cruise', 770000017, 'Under Review', '2020-03-17 10:30:00', 17, 'tom.cruise@example.com'),
(18, 'Charlize Theron', 770000018, 'Interview Scheduled', '2020-03-18 11:45:00', 18, 'charlize.theron@example.com'),
(19, 'Matt Damon', 770000019, 'Not Selected', '2020-03-19 14:15:00', 19, 'matt.damon@example.com'),
(20, 'Natalie Portman', 770000020, 'Selected', '2020-03-20 16:00:00', 20, 'natalie.portman@example.com'),
(21, 'Hugh Jackman', 770000021, 'Applied', '2020-03-21 09:30:00', 21, 'hugh.jackman@example.com'),
(22, 'Cate Blanchett', 770000022, 'Under Review', '2020-03-22 10:00:00', 22, 'cate.blanchett@example.com'),
(23, 'Chris Pratt', 770000023, 'Interview Scheduled', '2020-03-23 11:15:00', 23, 'chris.pratt@example.com'),
(24, 'Margot Robbie', 770000024, 'Not Selected', '2020-03-24 13:45:00', 24, 'margot.robbie@example.com'),
(25, 'Keanu Reeves', 770000025, 'Selected', '2020-03-25 15:30:00', 25, 'keanu.reeves@example.com'),
(26, 'Jennifer Lawrence', 770000026, 'Applied', '2020-03-26 09:00:00', 1, 'jennifer.lawrence@example.com'),
(27, 'Mark Wahlberg', 770000027, 'Under Review', '2020-03-27 10:30:00', 2, 'mark.wahlberg@example.com'),
(28, 'Zoe Saldana', 770000028, 'Interview Scheduled', '2020-03-28 11:45:00', 3, 'zoe.saldana@example.com'),
(29, 'Idris Elba', 770000029, 'Not Selected', '2020-03-29 14:15:00', 4, 'idris.elba@example.com'),
(30, 'Anne Hathaway', 770000030, 'Selected', '2020-03-30 16:00:00', 5, 'anne.hathaway@example.com'),
(31, 'Hugh Grant', 770000031, 'Applied', '2020-03-31 09:30:00', 6, 'hugh.grant@example.com'),
(32, 'Julia Roberts', 770000032, 'Under Review', '2020-04-01 10:00:00', 7, 'julia.roberts@example.com'),
(33, 'Chris Pine', 770000033, 'Interview Scheduled', '2020-04-02 11:15:00', 8, 'chris.pine@example.com'),
(34, 'Margot Robbie', 770000034, 'Not Selected', '2020-04-03 13:45:00', 9, 'margot.robbie@example.com'),
(35, 'Will Smith', 770000035, 'Selected', '2020-04-04 15:30:00', 10, 'will.smith@example.com'),
(36, 'Emma Watson', 770000036, 'Applied', '2020-04-05 09:00:00', 11, 'emma.watson@example.com'),
(37, 'Chris Hemsworth', 770000037, 'Under Review', '2020-04-06 10:30:00', 12, 'chris.hemsworth@example.com'),
(38, 'Charlize Theron', 770000038, 'Interview Scheduled', '2020-04-07 11:45:00', 13, 'charlize.theron@example.com'),
(39, 'Matt Damon', 770000039, 'Not Selected', '2020-04-08 14:15:00', 14, 'matt.damon@example.com'),
(40, 'Natalie Portman', 770000040, 'Selected', '2020-04-09 16:00:00', 15, 'natalie.portman@example.com'),
(41, 'Ryan Reynolds', 770000041, 'Applied', '2020-04-10 09:30:00', 16, 'ryan.reynolds@example.com'),
(42, 'Emma Stone', 770000042, 'Under Review', '2020-04-11 10:00:00', 17, 'emma.stone@example.com'),
(43, 'Tom Cruise', 770000043, 'Interview Scheduled', '2020-04-12 11:15:00', 18, 'tom.cruise@example.com'),
(44, 'Gal Gadot', 770000044, 'Not Selected', '2020-04-13 13:45:00', 19, 'gal.gadot@example.com'),
(45, 'Johnny Depp', 770000045, 'Selected', '2020-04-14 15:30:00', 20, 'johnny.depp@example.com'),
(46, 'Jennifer Aniston', 770000046, 'Applied', '2020-04-15 09:00:00', 21, 'jennifer.aniston@example.com'),
(47, 'Robert Downey Jr.', 770000047, 'Under Review', '2020-04-16 10:30:00', 22, 'robert.downey@example.com'),
(48, 'Scarlett Johansson', 770000048, 'Interview Scheduled', '2020-04-17 11:45:00', 23, 'scarlett.johansson@example.com'),
(49, 'Chris Evans', 770000049, 'Not Selected', '2020-04-18 14:15:00', 24, 'chris.evans@example.com'),
(50, 'Gal Gadot', 770000050, 'Selected', '2020-04-19 16:00:00', 25, 'gal.gadot@example.com'),
(51, 'Angelina Jolie', 770000001, 'Applied', '2020-03-01 09:30:00', 1, 'angelina.jolie@example.com');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `Employee_Id` bigint(12) NOT NULL,
  `Date` date NOT NULL,
  `Arrival Time` time NOT NULL,
  `Departure Time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`Employee_Id`, `Date`, `Arrival Time`, `Departure Time`) VALUES
(2, '2021-01-22', '07:27:25', '17:42:08'),
(3, '2021-04-06', '07:32:28', '17:18:19'),
(5, '2020-01-01', '07:19:03', '17:20:49'),
(5, '2020-07-30', '07:46:51', '17:22:56'),
(5, '2021-04-14', '07:30:16', '17:34:13'),
(6, '2020-09-08', '07:43:00', '17:06:04'),
(6, '2021-01-14', '07:34:34', '17:02:46'),
(8, '2020-02-02', '07:46:57', '17:20:22'),
(8, '2020-09-19', '07:51:29', '17:10:04'),
(9, '2021-03-14', '07:58:35', '17:32:29'),
(9, '2021-11-07', '07:10:43', '17:20:22'),
(11, '2020-03-02', '07:12:45', '17:42:56'),
(12, '2020-04-22', '07:42:13', '17:28:14'),
(13, '2020-08-02', '07:30:17', '17:42:46'),
(13, '2020-11-12', '07:43:13', '17:03:27'),
(13, '2021-04-20', '07:23:23', '17:30:18'),
(13, '2021-10-28', '07:12:30', '17:49:29'),
(14, '2021-01-22', '07:39:30', '17:21:05'),
(18, '2021-04-13', '07:28:19', '17:10:08'),
(18, '2021-05-04', '07:10:20', '17:01:28'),
(18, '2021-06-24', '07:36:30', '17:17:10'),
(19, '2020-04-19', '07:33:11', '17:44:54'),
(19, '2020-12-16', '07:50:38', '17:22:56'),
(21, '2021-03-08', '07:58:49', '17:36:24'),
(21, '2021-07-20', '07:04:29', '17:56:49'),
(22, '2020-02-17', '07:11:55', '17:29:18'),
(22, '2020-08-13', '07:33:06', '17:06:51'),
(24, '2020-06-16', '07:34:32', '17:13:11'),
(26, '2021-06-14', '07:12:25', '17:10:24'),
(27, '2021-07-12', '07:52:16', '17:52:10'),
(28, '2020-02-14', '07:16:52', '17:13:24'),
(31, '2020-02-06', '07:33:45', '17:29:57'),
(31, '2020-03-25', '07:55:38', '17:26:45'),
(32, '2021-08-20', '07:16:56', '17:29:51'),
(32, '2021-12-02', '07:27:40', '17:01:06'),
(33, '2021-07-12', '07:54:03', '17:28:47'),
(33, '2021-10-06', '07:37:43', '17:42:11'),
(34, '2020-12-08', '07:17:25', '17:52:42'),
(34, '2021-05-11', '07:00:48', '17:36:00'),
(35, '2021-06-08', '07:39:37', '17:47:32'),
(35, '2021-11-11', '07:23:04', '17:32:15'),
(36, '2020-12-29', '07:39:59', '17:06:29'),
(38, '2020-04-10', '07:24:19', '17:01:58'),
(38, '2020-05-26', '07:49:29', '17:24:05'),
(38, '2021-10-07', '07:48:09', '17:22:45'),
(39, '2020-06-18', '07:18:32', '17:13:49'),
(40, '2020-09-15', '07:47:16', '17:58:59'),
(40, '2021-06-26', '07:22:20', '17:53:43'),
(42, '2020-08-02', '07:18:47', '17:03:00'),
(43, '2021-02-17', '07:00:26', '17:39:39'),
(43, '2021-08-13', '07:28:02', '17:46:32'),
(43, '2021-12-14', '07:06:42', '17:57:08'),
(44, '2021-06-12', '07:22:57', '17:19:42'),
(45, '2020-08-28', '07:31:44', '17:27:54'),
(46, '2020-01-26', '07:52:57', '17:04:48'),
(47, '2021-09-12', '07:41:54', '17:42:02'),
(52, '2020-12-22', '07:58:13', '17:20:04'),
(53, '2020-10-04', '07:32:40', '17:48:43'),
(53, '2021-08-27', '07:19:57', '17:59:39'),
(54, '2020-08-21', '07:55:43', '17:59:29'),
(54, '2021-09-28', '07:08:25', '17:12:56'),
(55, '2021-04-02', '07:34:25', '17:46:36'),
(57, '2020-11-10', '07:56:22', '17:06:23'),
(60, '2020-12-23', '08:00:00', '19:00:00'),
(60, '2021-01-01', '08:05:00', '21:00:00'),
(60, '2021-03-11', '10:30:00', '17:00:00'),
(61, '2020-05-29', '07:20:09', '17:11:44'),
(61, '2021-12-07', '07:07:37', '17:51:02'),
(62, '2020-05-20', '07:57:27', '17:52:59'),
(62, '2021-11-04', '07:02:57', '17:17:35'),
(62, '2021-11-07', '07:08:20', '17:22:03'),
(65, '2020-07-17', '07:19:18', '17:58:07'),
(66, '2020-07-26', '07:22:30', '17:45:25'),
(67, '2020-05-08', '07:55:55', '17:39:35'),
(69, '2021-04-24', '07:06:55', '17:37:15'),
(71, '2020-06-20', '07:33:37', '17:28:55'),
(72, '2020-06-04', '07:54:48', '17:02:22'),
(72, '2020-12-07', '07:31:03', '17:32:29'),
(72, '2021-11-04', '07:39:48', '17:59:43'),
(73, '2020-08-14', '07:56:34', '17:24:58'),
(74, '2021-07-19', '07:01:08', '17:33:58'),
(75, '2021-10-05', '07:14:41', '17:23:54'),
(76, '2020-11-21', '07:24:13', '17:42:54'),
(79, '2021-01-25', '07:56:47', '17:24:31'),
(79, '2021-02-25', '07:58:13', '17:24:25'),
(81, '2020-08-16', '07:45:22', '17:53:40'),
(83, '2021-09-08', '07:15:01', '17:36:03'),
(83, '2021-11-07', '07:59:28', '17:35:47'),
(84, '2021-06-19', '07:40:49', '17:59:41'),
(85, '2021-03-28', '07:01:25', '17:43:39'),
(85, '2021-05-03', '07:02:47', '17:53:52'),
(85, '2021-07-09', '07:01:22', '17:41:11'),
(85, '2021-12-16', '07:51:13', '17:56:09'),
(86, '2021-07-11', '07:00:16', '17:57:41'),
(87, '2020-05-10', '07:01:09', '17:16:06'),
(89, '2020-07-09', '07:31:39', '17:32:35'),
(89, '2021-08-10', '07:29:20', '17:08:58'),
(91, '2020-10-30', '07:31:34', '17:44:51'),
(91, '2020-12-07', '07:44:50', '17:11:08'),
(93, '2020-05-13', '07:06:10', '17:15:35'),
(95, '2020-05-20', '07:58:32', '17:10:35'),
(96, '2021-02-26', '07:25:01', '17:17:48'),
(100, '2020-06-01', '07:39:07', '17:45:55');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `Name` varchar(30) NOT NULL,
  `Creation_Date` date NOT NULL,
  `Location` varchar(100) NOT NULL,
  `Manager_Id` bigint(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`Name`, `Creation_Date`, `Location`, `Manager_Id`) VALUES
('Finance', '2020-02-15', '56,Queens Avenue', 322),
('Human Resource', '2020-01-01', '37,Reid\'s Avenue, Colombo 07', 321),
('Information Technology', '2020-04-01', '56,Queen,s Avenue, Colombo 07', 327),
('Marketing', '2020-10-08', '231,Galle Road, Colombo 07', 323),
('Quality Assurance', '2020-05-10', '27,Alfred Place, Colombo 08', 325),
('Research and Development', '2020-07-01', '37,Reid\'s Avenue, Colombo 07', 326),
('Sales', '2020-11-20', '36,Reid;s Avenue, Colombo 07', 324);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `Employee_Id` bigint(12) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Date_of_Birth` date NOT NULL,
  `Gender` char(1) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `Contact` int(10) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Joining_Date` date NOT NULL,
  `Department` varchar(30) DEFAULT NULL,
  `Job_Id` int(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`Employee_Id`, `Name`, `Date_of_Birth`, `Gender`, `Address`, `Contact`, `Email`, `Joining_Date`, `Department`, `Job_Id`) VALUES
(1, 'Abdulla S.A', '2002-11-24', 'M', '31,Main Road, Colombo 14', 714810928, 'Abdullaaurad@gmail.com', '2020-11-23', 'Human Resource', 1),
(2, 'John Doe', '1995-04-15', 'M', '42 Elm Street, Colombo 12', 715903842, 'johndoe@example.com', '2020-01-02', 'Human Resource', 2),
(3, 'Jane Smith', '1990-09-30', 'F', '27 Oak Avenue, Colombo 14', 717123456, 'janesmith@example.com', '2020-01-03', 'Human Resource', 1),
(4, 'Michael Johnson', '1987-06-18', 'M', '55 Maple Lane, Colombo 10', 718374521, 'michaeljohnson@example.com', '2020-01-04', 'Human Resource', 5),
(5, 'Sarah Williams', '1993-03-08', 'F', '18 Cedar Road, Colombo 12', 719598237, 'sarahwilliams@example.com', '2020-01-05', 'Human Resource', 4),
(6, 'David Brown', '1988-12-10', 'M', '39 Oak Street, Colombo 14', 716263845, 'davidbrown@example.com', '2020-01-06', 'Human Resource', 1),
(7, 'Emily Davis', '1992-07-25', 'F', '22 Elm Avenue, Colombo 10', 717771234, 'emilydavis@example.com', '2020-01-07', 'Human Resource', 2),
(8, 'Daniel White', '1989-05-03', 'M', '47 Cedar Road, Colombo 12', 719987654, 'danielwhite@example.com', '2020-01-08', 'Human Resource', 1),
(9, 'Olivia Harris', '1994-08-19', 'F', '33 Main Street, Colombo 14', 715554321, 'oliviaharris@example.com', '2020-01-09', 'Human Resource', 5),
(10, 'James Taylor', '1986-02-14', 'M', '64 Oak Lane, Colombo 12', 718888888, 'jamestaylor@example.com', '2020-01-10', 'Human Resource', 4),
(11, 'Ava Wilson', '1991-10-22', 'F', '29 Elm Road, Colombo 14', 716432109, 'avawilson@example.com', '2020-01-11', 'Human Resource', 2),
(12, 'Liam Martin', '1985-03-01', 'M', '51 Cedar Avenue, Colombo 10', 717777777, 'liammartin@example.com', '2020-01-12', 'Human Resource', 3),
(13, 'Sophia Clark', '1993-12-09', 'F', '35 Main Lane, Colombo 12', 719999999, 'sophiaclark@example.com', '2020-01-13', 'Human Resource', 1),
(14, 'Noah Adams', '1987-11-27', 'M', '59 Oak Road, Colombo 14', 716666666, 'noahadams@example.com', '2020-01-14', 'Human Resource', 5),
(15, 'Isabella Turner', '1990-04-04', 'F', '24 Elm Street, Colombo 12', 715555555, 'isabellaturner@example.com', '2020-01-15', 'Human Resource', 4),
(16, 'Logan Lewis', '1988-06-12', 'M', '45 Cedar Lane, Colombo 14', 714444444, 'loganlewis@example.com', '2020-01-16', 'Human Resource', 2),
(17, 'Mia Hall', '1992-09-18', 'F', '31 Main Avenue, Colombo 10', 718885555, 'miahall@example.com', '2020-01-17', 'Human Resource', 3),
(18, 'Lucas Scott', '1986-01-25', 'M', '62 Oak Street, Colombo 12', 714445555, 'lucasscott@example.com', '2020-01-18', 'Human Resource', 1),
(19, 'Aria Miller', '1994-03-29', 'F', '28 Elm Lane, Colombo 14', 715556666, 'ariamiller@example.com', '2020-01-19', 'Human Resource', 5),
(20, 'Ethan King', '1989-07-16', 'M', '49 Cedar Road, Colombo 12', 717776666, 'ethanking@example.com', '2020-01-20', 'Human Resource', 4),
(21, 'Harper Moore', '1991-05-20', 'F', '26 Main Road, Colombo 14', 718884444, 'harpermoore@example.com', '2020-01-21', 'Human Resource', 2),
(22, 'Mason Young', '1985-11-11', 'M', '53 Oak Lane, Colombo 10', 714447777, 'masonyoung@example.com', '2020-01-22', 'Human Resource', 3),
(23, 'Scarlett Johnson', '1993-08-13', 'F', '36 Elm Road, Colombo 12', 715557777, 'scarlettjohnson@example.com', '2020-01-23', 'Human Resource', 1),
(24, 'Carter Hernandez', '1987-07-26', 'M', '58 Cedar Avenue, Colombo 14', 717775555, 'carterhernandez@example.com', '2020-01-24', 'Human Resource', 5),
(25, 'Luna Baker', '1990-12-07', 'F', '23 Main Street, Colombo 12', 714448888, 'lunabaker@example.com', '2020-01-25', 'Human Resource', 4),
(26, 'Jackson Gonzales', '1988-02-28', 'M', '44 Oak Road, Colombo 14', 715558888, 'jacksongonzales@example.com', '2020-01-26', 'Human Resource', 2),
(27, 'Lily Lopez', '1992-06-17', 'F', '30 Elm Avenue, Colombo 10', 717774444, 'lilylopez@example.com', '2020-01-27', 'Human Resource', 3),
(28, 'Elijah Perez', '1986-04-09', 'M', '61 Cedar Lane, Colombo 12', 714449999, 'elijahperez@example.com', '2020-01-28', 'Human Resource', 1),
(29, 'Zoe Turner', '1994-09-28', 'F', '37 Main Lane, Colombo 14', 717778888, 'zoeturner@example.com', '2020-01-29', 'Human Resource', 5),
(30, 'Benjamin Hall', '1989-10-01', 'M', '50 Elm Street, Colombo 12', 715559999, 'benjaminhall@example.com', '2020-01-30', 'Human Resource', 4),
(31, 'Grace Adams', '1991-03-14', 'F', '25 Cedar Road, Colombo 14', 714447777, 'graceadams@example.com', '2020-01-31', 'Human Resource', 2),
(32, 'Henry King', '1985-07-05', 'M', '52 Oak Street, Colombo 10', 717779999, 'henryking@example.com', '2020-02-01', 'Human Resource', 3),
(33, 'Chloe Moore', '1993-05-29', 'F', '38 Elm Lane, Colombo 12', 714446666, 'chloemoore@example.com', '2020-02-02', 'Human Resource', 1),
(34, 'Sebastian Young', '1987-12-19', 'M', '60 Main Road, Colombo 14', 715557777, 'sebastianyoung@example.com', '2020-02-03', 'Human Resource', 5),
(35, 'Penelope Johnson', '1990-01-02', 'F', '22 Oak Lane, Colombo 12', 717777777, 'penelopejohnson@example.com', '2020-02-04', 'Human Resource', 4),
(36, 'Caleb Hernandez', '1988-04-24', 'M', '43 Cedar Avenue, Colombo 14', 714445555, 'calebhernandez@example.com', '2020-02-05', 'Human Resource', 2),
(37, 'Layla Baker', '1992-11-13', 'F', '29 Elm Street, Colombo 10', 717776666, 'laylabaker@example.com', '2020-02-06', 'Human Resource', 3),
(38, 'Jack Gonzales', '1986-08-08', 'M', '55 Main Avenue, Colombo 12', 714444444, 'jackgonzales@example.com', '2020-02-07', 'Human Resource', 1),
(39, 'Nora Lopez', '1994-02-27', 'F', '40 Cedar Lane, Colombo 14', 717775555, 'noralopez@example.com', '2020-02-08', 'Human Resource', 5),
(40, 'Leo Perez', '1989-09-12', 'M', '48 Elm Road, Colombo 12', 714448888, 'leoperez@example.com', '2020-02-09', 'Human Resource', 4),
(41, 'Hazel Turner', '1991-06-25', 'F', '34 Oak Road, Colombo 14', 715559999, 'hazelturner@example.com', '2020-02-10', 'Human Resource', 2),
(42, 'Grayson Hall', '1985-12-21', 'M', '57 Cedar Road, Colombo 10', 714449999, 'graysonhall@example.com', '2020-02-11', 'Human Resource', 3),
(43, 'Lucy Adams', '1993-08-30', 'F', '41 Main Lane, Colombo 12', 715558888, 'lucyadams@example.com', '2020-02-12', 'Human Resource', 1),
(44, 'Jackson King', '1987-03-06', 'M', '46 Elm Street, Colombo 14', 714447777, 'jacksonking@example.com', '2020-02-13', 'Human Resource', 5),
(45, 'Aria Johnson', '1990-10-09', 'F', '32 Oak Lane, Colombo 12', 715557777, 'ariajohnson@example.com', '2020-02-14', 'Human Resource', 4),
(46, 'Ethan Baker', '1989-11-05', 'M', '54 Cedar Avenue, Colombo 14', 714446666, 'ethanbaker@example.com', '2020-02-15', 'Human Resource', 2),
(47, 'Harper Gonzales', '1991-05-07', 'F', '28 Elm Lane, Colombo 10', 715555555, 'harpergonzales@example.com', '2020-02-16', 'Human Resource', 3),
(48, 'Mason Hernandez', '1985-02-10', 'M', '50 Main Road, Colombo 12', 715554444, 'masonhernandez@example.com', '2020-02-17', 'Human Resource', 1),
(49, 'Luna King', '1994-09-28', 'F', '37 Oak Street, Colombo 14', 714443333, 'lunaking@example.com', '2020-02-18', 'Human Resource', 5),
(50, 'Benjamin Miller', '1989-10-01', 'M', '55 Cedar Road, Colombo 12', 715552222, 'benjaminmiller@example.com', '2020-02-19', 'Human Resource', 4),
(51, 'John Doe', '1990-05-15', 'M', '123 Elm Street, Cityville', 1234567891, 'johndoe@email.com', '2020-01-02', 'Finance', 6),
(52, 'Jane Smith', '1985-08-20', 'F', '456 Oak Avenue, Townsville', 555542628, 'janesmith@email.com', '2020-01-03', 'Finance', 9),
(53, 'Michael Johnson', '1995-03-10', 'M', '789 Maple Road, Villageton', 333333333, 'michaeljohnson@email.com', '2020-01-04', 'Finance', 7),
(54, 'Emily Davis', '1988-12-05', 'F', '101 Pine Lane, Hamletville', 222222222, 'emilydavis@email.com', '2020-01-05', 'Finance', 10),
(55, 'Sophia Adams', '1993-07-18', 'F', '222 Willow Lane, Suburbia', 2415675, 'sophiaadams@email.com', '2020-01-06', 'Finance', 9),
(56, 'William Johnson', '1987-02-09', 'M', '333 Cedar Street, Townsville', 12347965, 'williamjohnson@email.com', '2020-01-07', 'Finance', 10),
(57, 'Olivia Brown', '1989-09-12', 'F', '444 Oak Avenue, Cityville', 77222290, 'oliviabrown@email.com', '2020-01-08', 'Finance', 10),
(58, 'James Wilson', '1982-04-22', 'M', '555 Elm Road, Hamletville', 779991124, 'jameswilson@email.com', '2020-01-09', 'Finance', 10),
(59, 'Charlotte Miller', '1991-12-15', 'F', '666 Pine Lane, Villageton', 758342112, 'charlottemiller@email.com', '2020-01-10', 'Finance', 8),
(60, 'dghfas', '1996-12-31', 'M', 'dfghghd,rdtfjgjg,dftfuyu', 2147483647, 'bvxfvfsfav@gmail.com', '2020-01-11', 'Finance', 8),
(61, 'Ava Harris', '1994-03-15', 'F', '555 Cedar Lane, Townsville', 775544883, 'avaharris@email.com', '2020-01-12', 'Finance', 7),
(62, 'Jackson Clark', '1989-11-20', 'M', '777 Elm Avenue, Cityville', 758342112, 'jacksonclark@email.com', '2020-01-13', 'Finance', 8),
(63, 'Sophia Hall', '1993-07-09', 'F', '111 Pine Lane, Hamletville', 6482874, 'sophiahall@email.com', '2020-01-14', 'Finance', 7),
(64, 'Mason Harris', '1985-04-18', 'M', '888 Cedar Road, Villageton', 55555555, 'masonharris@email.com', '2020-01-15', 'Finance', 7),
(65, 'Olivia Martin', '1986-12-30', 'F', '333 Oak Lane, Suburbia', 2475892, 'oliviamartin@email.com', '2020-01-16', 'Finance', 9),
(66, 'Liam Scott', '1992-10-15', 'M', '222 Elm Road, Townsville', 775544882, 'liamscott@email.com', '2020-01-17', 'Finance', 8),
(67, 'Charlotte Davis', '1984-08-20', 'F', '444 Willow Avenue, Cityville', 722984759, 'charlottedavis@email.com', '2020-01-18', 'Finance', 8),
(68, 'Noah Wilson', '1991-02-25', 'M', '666 Cedar Road, Hamletville', 572348923, 'noahwilson@email.com', '2020-01-19', 'Finance', 10),
(69, 'Ava Thompson', '1987-05-13', 'F', '555 Pine Lane, Villageton', 87893522, 'avathompson@email.com', '2020-01-20', 'Finance', 9),
(70, 'Oliver Garcia', '1990-09-21', 'M', '777 Elm Road, Suburbia', 758342112, 'olivergarcia@email.com', '2020-01-21', 'Finance', 7),
(71, 'Isabella King', '1988-04-04', 'F', '888 Cedar Lane, Townsville', 90856204, 'isabellaking@email.com', '2020-01-22', 'Finance', 9),
(72, 'William Lewis', '1993-06-30', 'M', '111 Willow Avenue, Cityville', 717771234, 'williamlewis@email.com', '2020-01-23', 'Finance', 6),
(73, 'Mia Turner', '1991-12-15', 'F', '999 Oak Lane, Hamletville', 758342112, 'miaturner@email.com', '2020-01-24', 'Finance', 10),
(74, 'Logan Scott', '1982-08-09', 'M', '666 Maple Road, Villageton', 444444444, 'loganscott@email.com', '2020-01-25', 'Finance', 9),
(75, 'Sophia Hall', '1997-03-21', 'F', '555 Cedar Avenue, Suburbia', 88888888, 'sophiahall@email.com', '2020-01-26', 'Finance', 11),
(76, 'Jackson Martinez', '1984-05-28', 'M', '777 Birch Lane, Townsville', 222222222, 'jacksonmartinez@email.com', '2020-01-27', 'Finance', 10),
(77, 'Amelia Turner', '1995-07-09', 'F', '444 Pine Road, Cityville', 1111111111, 'ameliaturner@email.com', '2020-01-28', 'Finance', 8),
(78, 'Benjamin White', '1989-11-22', 'M', '222 Elm Lane, Hamletville', 8927139, 'benjaminwhite@email.com', '2020-01-29', 'Finance', 7),
(79, 'Olivia Davis', '1986-12-05', 'F', '333 Cedar Road, Villageton', 9999999, 'oliviadavis@email.com', '2020-01-30', 'Finance', 10),
(80, 'Lucas Johnson', '1992-01-30', 'M', '111 Oak Avenue, Suburbia', 555185678, 'lucasjohnson@email.com', '2020-02-01', 'Finance', 9),
(81, 'Sophia Adams', '1993-07-18', 'F', '222 Willow Lane, Suburbia', 736781297, 'sophiaadams@email.com', '2020-02-02', 'Finance', 9),
(82, 'William Johnson', '1987-02-09', 'M', '333 Cedar Street, Townsville', 77777777, 'williamjohnson@email.com', '2020-02-03', 'Finance', 10),
(83, 'Olivia Brown', '1989-09-12', 'F', '444 Oak Avenue, Cityville', 444444444, 'oliviabrown@email.com', '2020-02-04', 'Finance', 7),
(84, 'James Wilson', '1982-04-22', 'M', '555 Elm Road, Hamletville', 555555555, 'jameswilson@email.com', '2020-02-05', 'Finance', 9),
(85, 'Charlotte Miller', '1991-12-15', 'F', '666 Pine Lane, Villageton', 1111111111, 'charlottemiller@email.com', '2020-02-06', 'Finance', 7),
(86, 'David Clark', '1985-03-02', 'M', '33, Pine Avenue, Boston', 2147483611, 'david@email.com', '2020-01-16', 'Finance', 7),
(87, 'John Doe', '1995-05-12', 'M', '42, Elm Street, New York', 1234567890, 'johndoe@email.com', '2020-01-02', 'Finance', 7),
(88, 'Jane Smith', '1990-08-17', 'F', '123, Oak Avenue, Los Angeles', 2147483647, 'janesmith@email.com', '2020-01-03', 'Finance', 6),
(89, 'Michael Johnson', '1988-03-29', 'M', '55, Maple Lane, Chicago', 2147483647, 'michael@email.com', '2020-01-04', 'Finance', 9),
(90, 'Emily Wilson', '1993-12-15', 'F', '20, Pine Street, San Francisco', 2147483647, 'emily@email.com', '2020-01-05', 'Finance', 9),
(91, 'Robert Brown', '1987-06-08', 'M', '10, Cedar Avenue, Houston', 2147483647, 'robert@email.com', '2020-01-06', 'Finance', 10),
(92, 'Sarah White', '1991-09-22', 'F', '7, Birch Road, Miami', 2147483647, 'sarah@email.com', '2020-01-07', 'Finance', 6),
(93, 'Daniel Lee', '1997-02-18', 'M', '15, Spruce Drive, Phoenix', 2147483647, 'daniel@email.com', '2020-01-08', 'Finance', 7),
(94, 'Olivia Martinez', '1994-07-04', 'F', '3, Cherry Court, Dallas', 2145555678, 'olivia@email.com', '2020-01-09', 'Finance', 9),
(95, 'William Rodriguez', '1999-04-27', 'M', '29, Willow Lane, Atlanta', 2147483647, 'william@email.com', '2020-01-10', 'Finance', 10),
(96, 'Ava Garcia', '1992-10-19', 'F', '24, Elm Street, Denver', 2147483647, 'ava@email.com', '2020-01-11', 'Finance', 8),
(97, 'James Lopez', '1986-01-31', 'M', '12, Oak Avenue, Seattle', 2065558765, 'james@email.com', '2020-01-12', 'Finance', 8),
(98, 'Sophia Hall', '1996-11-08', 'F', '50, Cedar Road, Las Vegas', 2147483647, 'sophia@email.com', '2020-01-13', 'Finance', 7),
(99, 'Matthew Adams', '1989-04-11', 'M', '18, Maple Court, San Diego', 2147483647, 'matthew@email.com', '2020-01-14', 'Finance', 10),
(100, 'Emma Lewis', '1998-08-26', 'F', '9, Birch Drive, Orlando', 2147483647, 'emma@email.com', '2020-01-15', 'Finance', 8),
(101, 'John Doe', '1990-05-15', 'M', '42, Elm Street, Colombo 7', 987654321, 'johndoe@email.com', '2020-01-01', 'Marketing', 11),
(102, 'Jane Smith', '1988-08-20', 'F', '56, Oak Avenue, Colombo 5', 123456789, 'janesmith@email.com', '2020-01-02', 'Marketing', 12),
(103, 'Mike Johnson', '1995-03-10', 'M', '18, Maple Lane, Colombo 10', 987123456, 'mike@email.com', '2020-01-03', 'Marketing', 13),
(104, 'Emily Brown', '1993-09-28', 'F', '73, Pine Road, Colombo 2', 654321987, 'emily@email.com', '2020-01-04', 'Marketing', 14),
(105, 'Chris Wilson', '2001-12-07', 'M', '29, Cedar Street, Colombo 12', 123987456, 'chris@email.com', '2020-01-05', 'Marketing', 15),
(106, 'Linda Johnson', '1997-06-15', 'F', '88, Rose Street, Colombo 3', 987123789, 'linda@email.com', '2020-01-06', 'Marketing', 12),
(107, 'Robert Davis', '1990-04-25', 'M', '51, Birch Lane, Colombo 6', 654987321, 'robert@email.com', '2020-01-07', 'Marketing', 15),
(108, 'Sophia Anderson', '1993-02-17', 'F', '61, Oak Street, Colombo 11', 123654987, 'sophia@email.com', '2020-01-08', 'Marketing', 14),
(109, 'William Wilson', '1985-10-11', 'M', '22, Elm Road, Colombo 5', 987654987, 'william@email.com', '2020-01-09', 'Marketing', 13),
(110, 'Olivia Harris', '2000-12-05', 'F', '44, Pine Avenue, Colombo 12', 123987654, 'olivia@email.com', '2020-01-10', 'Marketing', 11),
(111, 'James Martin', '1991-08-21', 'M', '77, Cedar Lane, Colombo 9', 987123654, 'james@email.com', '2020-01-11', 'Marketing', 12),
(112, 'Ava Jackson', '1996-04-30', 'F', '33, Maple Street, Colombo 7', 654321987, 'ava@email.com', '2020-01-12', 'Marketing', 15),
(113, 'Michael Clark', '1989-03-12', 'M', '66, Birch Road, Colombo 8', 123654321, 'michael@email.com', '2020-01-13', 'Marketing', 13),
(114, 'Mia Lewis', '1994-01-28', 'F', '55, Oak Lane, Colombo 4', 987789123, 'mia@email.com', '2020-01-14', 'Marketing', 11),
(115, 'David Walker', '1999-09-16', 'M', '49, Elm Avenue, Colombo 3', 123987789, 'david@email.com', '2020-01-15', 'Marketing', 14),
(116, 'Ella Turner', '1992-07-19', 'F', '38, Rose Lane, Colombo 6', 987321654, 'ella@email.com', '2020-01-16', 'Marketing', 12),
(117, 'Joseph White', '1987-05-08', 'M', '31, Cedar Avenue, Colombo 14', 987654321, 'joseph@email.com', '2020-01-17', 'Marketing', 13),
(118, 'Sofia Parker', '1998-11-23', 'F', '72, Pine Road, Colombo 15', 654987123, 'sofia@email.com', '2020-01-18', 'Marketing', 15),
(119, 'Daniel Harris', '1986-03-01', 'M', '58, Maple Lane, Colombo 9', 123654987, 'daniel@email.com', '2020-01-19', 'Marketing', 11),
(120, 'Charlotte King', '1995-09-09', 'F', '27, Oak Street, Colombo 7', 987123654, 'charlotte@email.com', '2020-01-20', 'Marketing', 14),
(121, 'Samuel Turner', '1991-02-14', 'M', '46, Elm Road, Colombo 5', 123987123, 'samuel@email.com', '2020-01-21', 'Marketing', 15),
(122, 'Grace Lewis', '1988-10-29', 'F', '53, Cedar Lane, Colombo 4', 987321987, 'grace@email.com', '2020-01-22', 'Marketing', 12),
(123, 'Andrew Green', '2003-08-07', 'M', '37, Birch Avenue, Colombo 12', 654987789, 'andrew@email.com', '2020-01-23', 'Marketing', 11),
(124, 'Chloe Adams', '1994-12-18', 'F', '64, Rose Road, Colombo 6', 987654321, 'chloe@email.com', '2020-01-24', 'Marketing', 13),
(125, 'Benjamin Nelson', '1987-07-27', 'M', '21, Oak Lane, Colombo 11', 123789456, 'benjamin@email.com', '2020-01-25', 'Marketing', 14),
(151, 'Sophia Johnson', '1995-06-15', 'F', '88, Rose Street, Colombo 3', 987123789, 'sophia@email.com', '2020-01-26', 'Marketing', 12),
(152, 'Mason Davis', '1989-04-25', 'M', '51, Birch Lane, Colombo 6', 654987321, 'mason@email.com', '2020-01-27', 'Marketing', 15),
(153, 'Olivia Anderson', '1990-02-17', 'F', '61, Oak Street, Colombo 11', 123654987, 'olivia@email.com', '2020-01-28', 'Marketing', 14),
(154, 'Liam Wilson', '1987-10-11', 'M', '22, Elm Road, Colombo 5', 987654987, 'liam@email.com', '2020-01-29', 'Marketing', 13),
(155, 'Emma Harris', '1993-12-05', 'F', '44, Pine Avenue, Colombo 12', 123987654, 'emma@email.com', '2020-01-30', 'Marketing', 11),
(156, 'Noah Martin', '2001-08-21', 'M', '77, Cedar Lane, Colombo 9', 987123654, 'noah@email.com', '2020-01-31', 'Marketing', 12),
(157, 'Ava Jackson', '1994-04-30', 'F', '33, Maple Street, Colombo 7', 654321987, 'ava@email.com', '2020-02-01', 'Marketing', 15),
(158, 'Liam Clark', '1988-03-12', 'M', '66, Birch Road, Colombo 8', 123654321, 'liam@email.com', '2020-02-02', 'Marketing', 13),
(159, 'Oliver Lewis', '1997-01-28', 'M', '55, Oak Lane, Colombo 4', 987789123, 'oliver@email.com', '2020-02-03', 'Marketing', 11),
(160, 'Amelia Walker', '1991-09-16', 'F', '49, Elm Avenue, Colombo 3', 123987789, 'amelia@email.com', '2020-02-04', 'Marketing', 14),
(161, 'Employee 1', '1995-06-15', 'M', '42, Elm Street, Colombo 7', 123456789, 'employee1@email.com', '2020-01-01', 'Sales', 15),
(162, 'Employee 2', '1989-04-25', 'F', '56, Oak Avenue, Colombo 5', 234567890, 'employee2@email.com', '2020-01-02', 'Sales', 16),
(163, 'Employee 3', '1990-02-17', 'M', '18, Maple Lane, Colombo 10', 345678901, 'employee3@email.com', '2020-01-03', 'Sales', 17),
(164, 'Employee 4', '1987-10-11', 'F', '73, Pine Road, Colombo 2', 456789012, 'employee4@email.com', '2020-01-04', 'Sales', 18),
(165, 'Employee 5', '1993-12-05', 'M', '29, Cedar Street, Colombo 12', 567890123, 'employee5@email.com', '2020-01-05', 'Sales', 19),
(166, 'Employee 6', '1991-08-21', 'F', '33, Rose Street, Colombo 3', 678901234, 'employee6@email.com', '2020-01-06', 'Sales', 20),
(167, 'Employee 7', '1994-04-30', 'M', '61, Birch Avenue, Colombo 6', 789012345, 'employee7@email.com', '2020-01-07', 'Sales', 15),
(168, 'Employee 8', '1988-03-12', 'F', '42, Elm Street, Colombo 7', 890123456, 'employee8@email.com', '2020-01-08', 'Sales', 16),
(169, 'Employee 9', '1997-01-28', 'M', '77, Cedar Lane, Colombo 9', 901234567, 'employee9@email.com', '2020-01-09', 'Sales', 17),
(170, 'Employee 10', '1991-09-16', 'F', '44, Pine Avenue, Colombo 12', 12345678, 'employee10@email.com', '2020-01-10', 'Sales', 18),
(171, 'Employee 11', '1995-06-15', 'M', '42, Elm Street, Colombo 7', 123456789, 'employee11@email.com', '2020-01-11', 'Sales', 19),
(172, 'Employee 12', '1989-04-25', 'F', '56, Oak Avenue, Colombo 5', 234567890, 'employee12@email.com', '2020-01-12', 'Sales', 20),
(173, 'Employee 13', '1990-02-17', 'M', '18, Maple Lane, Colombo 10', 345678901, 'employee13@email.com', '2020-01-13', 'Sales', 15),
(174, 'Employee 14', '1987-10-11', 'F', '73, Pine Road, Colombo 2', 456789012, 'employee14@email.com', '2020-01-14', 'Sales', 16),
(175, 'Employee 15', '1993-12-05', 'M', '29, Cedar Street, Colombo 12', 567890123, 'employee15@email.com', '2020-01-15', 'Sales', 17),
(176, 'Employee 16', '1991-08-21', 'F', '33, Rose Street, Colombo 3', 678901234, 'employee16@email.com', '2020-01-16', 'Sales', 18),
(177, 'Employee 17', '1994-04-30', 'M', '61, Birch Avenue, Colombo 6', 789012345, 'employee17@email.com', '2020-01-17', 'Sales', 19),
(178, 'Employee 18', '1988-03-12', 'F', '42, Elm Street, Colombo 7', 890123456, 'employee18@email.com', '2020-01-18', 'Sales', 20),
(179, 'Employee 19', '1997-01-28', 'M', '77, Cedar Lane, Colombo 9', 901234567, 'employee19@email.com', '2020-01-19', 'Sales', 15),
(180, 'Employee 20', '1991-09-16', 'F', '44, Pine Avenue, Colombo 12', 12345678, 'employee20@email.com', '2020-01-20', 'Sales', 16),
(181, 'Employee 21', '1995-06-15', 'M', '42, Elm Street, Colombo 7', 123456789, 'employee21@email.com', '2020-01-21', 'Sales', 17),
(182, 'Employee 22', '1989-04-25', 'F', '56, Oak Avenue, Colombo 5', 234567890, 'employee22@email.com', '2020-01-22', 'Sales', 18),
(183, 'Employee 23', '1990-02-17', 'M', '18, Maple Lane, Colombo 10', 345678901, 'employee23@email.com', '2020-12-02', 'Sales', 17),
(184, 'Samuel L. Jackson', '1948-12-21', 'M', '888 Starry Lane, Hollywood', 123456789, 'samuel@email.com', '2020-01-21', 'Sales', 17),
(185, 'Mila Kunis', '1983-08-14', 'F', '999 Tinseltown Rd, Hollywood', 234567890, 'mila@email.com', '2020-01-22', 'Sales', 19),
(186, 'Harrison Ford', '1942-07-13', 'M', '1010 Filmstrip St, Hollywood', 345678901, 'harrison@email.com', '2020-01-23', 'Sales', 20),
(187, 'Emma Stone', '1988-11-06', 'F', '1111 WalkofFame Ave, Hollywood', 456789012, 'emma@email.com', '2020-01-24', 'Sales', 15),
(188, 'Idris Elba', '1972-09-06', 'M', '1212 Action Blvd, Hollywood', 567890123, 'idris@email.com', '2020-01-25', 'Sales', 16),
(189, 'Anne Hathaway', '1982-11-12', 'F', '1313 SilverScreen Rd, Hollywood', 678901234, 'anne@email.com', '2020-01-26', 'Sales', 18),
(190, 'Keanu Reeves', '1964-09-02', 'M', '1414 AList Lane, Hollywood', 789012345, 'keanu@email.com', '2020-01-27', 'Sales', 19),
(191, 'Natalie Portman', '1981-06-09', 'F', '1515 Oscar Blvd, Hollywood', 890123456, 'natalie@email.com', '2020-01-28', 'Sales', 20),
(192, 'Matthew McConaughey', '1969-11-04', 'M', '1616 CelebStreet, Hollywood', 901234567, 'matthew@email.com', '2020-01-29', 'Sales', 15),
(193, 'Dwayne Johnson', '1972-05-02', 'M', '1818 MovieStar Ln, Hollywood', 123456789, 'dwayne@email.com', '2020-01-31', 'Sales', 17),
(194, 'Keira Knightley', '1985-03-26', 'F', '1919 Fame Blvd, Hollywood', 234567890, 'keira@email.com', '2020-02-01', 'Sales', 18),
(195, 'Will Ferrell', '1967-07-16', 'M', '2020 A-List Ave, Hollywood', 345678901, 'will@email.com', '2020-02-02', 'Sales', 19),
(196, 'Anne Hathaway', '1982-11-12', 'F', '2121 Hollywood Rd, Hollywood', 456789012, 'anne@email.com', '2020-02-03', 'Sales', 20),
(197, 'Owen Wilson', '1968-11-18', 'M', '2222 Tinseltown St, Hollywood', 567890123, 'owen@email.com', '2020-02-04', 'Sales', 15),
(198, 'Mila Kunis', '1983-08-14', 'F', '2323 WalkofFame Rd, Hollywood', 678901234, 'mila@email.com', '2020-02-05', 'Sales', 16),
(199, 'Hugh Jackman', '1968-10-12', 'M', '2424 Action Ave, Hollywood', 789012345, 'hugh@email.com', '2020-02-06', 'Sales', 17),
(200, 'Jennifer Lawrence', '1990-08-15', 'F', '2525 Starry Lane, Hollywood', 890123456, 'jennifer@email.com', '2020-02-07', 'Sales', 18),
(201, 'Will Smith', '1968-09-25', 'M', '2626 Blockbuster Blvd, Hollywood', 901234567, 'willsmith@email.com', '2020-02-08', 'Sales', 19),
(202, 'Scarlett Johansson', '1984-11-22', 'F', '2727 CelebStreet, Hollywood', 12345678, 'scarlett@email.com', '2020-02-09', 'Sales', 20),
(203, 'Shah Rukh Khan', '1965-11-02', 'M', 'Bollywood Lane, Mumbai', 123456789, 'srk@email.com', '2020-01-01', 'Quality Assurance', 21),
(204, 'Deepika Padukone', '1986-01-05', 'F', 'Stardom Avenue, Mumbai', 234567890, 'deepika@email.com', '2020-01-02', 'Quality Assurance', 22),
(205, 'Amitabh Bachchan', '1942-10-11', 'M', 'Iconic Road, Mumbai', 345678901, 'amitabh@email.com', '2020-01-03', 'Quality Assurance', 23),
(206, 'Priyanka Chopra', '1982-07-18', 'F', 'Cinema Street, Mumbai', 456789012, 'priyanka@email.com', '2020-01-04', 'Quality Assurance', 24),
(207, 'Aamir Khan', '1965-03-14', 'M', 'Superstar Lane, Mumbai', 567890123, 'aamir@email.com', '2020-01-05', 'Quality Assurance', 25),
(208, 'Kareena Kapoor', '1980-09-21', 'F', 'Filmstar Road, Mumbai', 678901234, 'kareena@email.com', '2020-01-06', 'Quality Assurance', 21),
(209, 'Salman Khan', '1965-12-27', 'M', 'Bollywood Blvd, Mumbai', 789012345, 'salman@email.com', '2020-01-07', 'Quality Assurance', 22),
(210, 'Ranveer Singh', '1985-07-06', 'M', 'Stardom Lane, Mumbai', 890123456, 'ranveer@email.com', '2020-01-08', 'Quality Assurance', 23),
(211, 'Alia Bhatt', '1993-03-15', 'F', 'Cinema Road, Mumbai', 901234567, 'alia@email.com', '2020-01-09', 'Quality Assurance', 24),
(212, 'Hrithik Roshan', '1974-01-10', 'M', 'Blockbuster Ave, Mumbai', 123123123, 'hrithik@email.com', '2020-01-10', 'Quality Assurance', 25),
(213, 'Katrina Kaif', '1983-07-16', 'F', 'Star Lane, Mumbai', 234234234, 'katrina@email.com', '2020-01-11', 'Quality Assurance', 21),
(214, 'Ranbir Kapoor', '1982-09-28', 'M', 'Cine Street, Mumbai', 345345345, 'ranbir@email.com', '2020-01-12', 'Quality Assurance', 22),
(215, 'Kajol Devgan', '1974-08-05', 'F', 'Superstar Road, Mumbai', 456456456, 'kajol@email.com', '2020-01-13', 'Quality Assurance', 23),
(216, 'Ajay Devgan', '1969-04-02', 'M', 'Filmstar Blvd, Mumbai', 567567567, 'ajay@email.com', '2020-01-14', 'Quality Assurance', 24),
(217, 'Anushka Sharma', '1988-05-01', 'F', 'Cinema Avenue, Mumbai', 678678678, 'anushka@email.com', '2020-01-15', 'Quality Assurance', 25),
(218, 'Shahid Kapoor', '1981-02-25', 'M', 'Stardom Street, Mumbai', 789789789, 'shahid@email.com', '2020-01-16', 'Quality Assurance', 21),
(219, 'Priyanka Chopra', '1982-07-18', 'F', 'Mega Lane, Mumbai', 890890890, 'priyankachopra@email.com', '2020-01-17', 'Quality Assurance', 22),
(220, 'Akshay Kumar', '1967-09-09', 'M', 'Celebrity Rd, Mumbai', 901901901, 'akshay@email.com', '2020-01-18', 'Quality Assurance', 23),
(221, 'Aishwarya Rai', '1973-11-01', 'F', 'Iconic Lane, Mumbai', 12012012, 'aishwarya@email.com', '2020-01-19', 'Quality Assurance', 24),
(222, 'Rajkummar Rao', '1984-08-31', 'M', 'Bollywood Blvd, Mumbai', 123456789, 'rajkummar@email.com', '2020-01-20', 'Quality Assurance', 25),
(223, 'Kangana Ranaut', '1987-03-23', 'F', 'Movie Star Ave, Mumbai', 234567890, 'kangana@email.com', '2020-01-21', 'Quality Assurance', 21),
(224, 'Varun Dhawan', '1987-04-24', 'M', 'Star Avenue, Mumbai', 345678901, 'varun@email.com', '2020-01-22', 'Quality Assurance', 22),
(225, 'Taapsee Pannu', '1987-08-01', 'F', 'Blockbuster Street, Mumbai', 456789012, 'taapsee@email.com', '2020-01-23', 'Quality Assurance', 23),
(226, 'Ayushmann Khurrana', '1984-09-14', 'M', 'Cine Lane, Mumbai', 567890123, 'ayushmann@email.com', '2020-01-24', 'Quality Assurance', 24),
(227, 'Deepika Padukone', '1986-01-05', 'F', 'Iconic Road, Mumbai', 678901234, 'deepika@email.com', '2020-01-25', 'Quality Assurance', 25),
(228, 'Ranbir Kapoor', '1982-09-28', 'M', 'Superstar Street, Mumbai', 789012345, 'ranbir@email.com', '2020-01-26', 'Quality Assurance', 21),
(229, 'Kajol Devgan', '1974-08-05', 'F', 'Celebrity Lane, Mumbai', 890123456, 'kajol@email.com', '2020-01-27', 'Quality Assurance', 22),
(230, 'Shahid Kapoor', '1981-02-25', 'M', 'Mega Avenue, Mumbai', 901234567, 'shahid@email.com', '2020-01-28', 'Quality Assurance', 23),
(231, 'Anushka Sharma', '1988-05-01', 'F', 'Cinema Blvd, Mumbai', 12345678, 'anushka@email.com', '2020-01-29', 'Quality Assurance', 24),
(232, 'Ranveer Singh', '1985-07-06', 'M', 'Bollywood Avenue, Mumbai', 123123123, 'ranveer@email.com', '2020-01-30', 'Quality Assurance', 25),
(233, 'Kareena Kapoor', '1980-09-21', 'F', 'Movie Star Lane, Mumbai', 234234234, 'kareena@email.com', '2020-01-31', 'Quality Assurance', 21),
(234, 'Salman Khan', '1965-12-27', 'M', 'Star Lane, Mumbai', 345345345, 'salman@email.com', '2020-02-01', 'Quality Assurance', 22),
(235, 'Rajkummar Rao', '1984-08-31', 'M', 'Blockbuster Blvd, Mumbai', 456456456, 'rajkummar@email.com', '2020-02-02', 'Quality Assurance', 23),
(236, 'Kangana Ranaut', '1987-03-23', 'F', 'Iconic Avenue, Mumbai', 567567567, 'kangana@email.com', '2020-02-03', 'Quality Assurance', 24),
(237, 'Varun Dhawan', '1987-04-24', 'M', 'Mega Street, Mumbai', 678678678, 'varun@email.com', '2020-02-04', 'Quality Assurance', 25),
(238, 'Taapsee Pannu', '1987-08-01', 'F', 'Cine Avenue, Mumbai', 789789789, 'taapsee@email.com', '2020-02-05', 'Quality Assurance', 21),
(239, 'Ayushmann Khurrana', '1984-09-14', 'M', 'Bollywood Lane, Mumbai', 890890890, 'ayushmann@email.com', '2020-02-06', 'Quality Assurance', 22),
(240, 'Deepika Padukone', '1986-01-05', 'F', 'Superstar Blvd, Mumbai', 901901901, 'deepika@email.com', '2020-02-07', 'Quality Assurance', 23),
(241, 'Rajinikanth', '1950-12-12', 'M', 'Kollywood Lane, Chennai', 123456789, 'rajinikanth@email.com', '2020-01-01', 'Research and Development', 26),
(242, 'Kamal Haasan', '1954-11-07', 'M', 'Star Street, Chennai', 234567890, 'kamal@email.com', '2020-01-02', 'Research and Development', 27),
(243, 'Vijay', '1974-06-22', 'M', 'Cine Lane, Chennai', 345678901, 'vijay@email.com', '2020-01-03', 'Research and Development', 28),
(244, 'Nayanthara', '1984-11-18', 'F', 'Superstar Blvd, Chennai', 456789012, 'nayanthara@email.com', '2020-01-04', 'Research and Development', 29),
(245, 'Suriya', '1975-07-23', 'M', 'Blockbuster Ave, Chennai', 567890123, 'suriya@email.com', '2020-01-05', 'Research and Development', 30),
(246, 'Trisha Krishnan', '1983-05-04', 'F', 'Cinema Avenue, Chennai', 678901234, 'trisha@email.com', '2020-01-06', 'Research and Development', 26),
(247, 'Dhanush', '1983-07-28', 'M', 'Mega Street, Chennai', 789012345, 'dhanush@email.com', '2020-01-07', 'Research and Development', 27),
(248, 'Simran', '1976-04-04', 'F', 'Iconic Road, Chennai', 890123456, 'simran@email.com', '2020-01-08', 'Research and Development', 28),
(249, 'Vikram', '1966-04-17', 'M', 'Bollywood Blvd, Chennai', 901234567, 'vikram@email.com', '2020-01-09', 'Research and Development', 29),
(250, 'Dulquer Salmaan', '1986-07-28', 'M', 'Filmstar Lane, Chennai', 123123123, 'dulquer@email.com', '2020-01-10', 'Research and Development', 30),
(251, 'Keerthy Suresh', '1992-10-17', 'F', 'Star Avenue, Chennai', 234234234, 'keerthy@email.com', '2020-01-11', 'Research and Development', 26),
(252, 'Sivakarthikeyan', '1985-02-17', 'M', 'Blockbuster Street, Chennai', 345345345, 'sivakarthikeyan@email.com', '2020-01-12', 'Research and Development', 27),
(253, 'Jyothika', '1977-10-18', 'F', 'Mega Lane, Chennai', 456456456, 'jyothika@email.com', '2020-01-13', 'Research and Development', 28),
(254, 'Vijay Sethupathi', '1978-01-16', 'M', 'Cinema Blvd, Chennai', 567567567, 'vijaysethupathi@email.com', '2020-01-14', 'Research and Development', 29),
(255, 'Anushka Shetty', '1981-11-07', 'F', 'Superstar Road, Chennai', 678678678, 'anushka@email.com', '2020-01-15', 'Research and Development', 30),
(256, 'Prabhas', '1979-10-23', 'M', 'Iconic Lane, Chennai', 789789789, 'prabhas@email.com', '2020-01-16', 'Research and Development', 26),
(257, 'Tamannaah Bhatia', '0000-00-00', 'F', 'Stardom Blvd, Chennai', 890890890, 'tamannaah@email.com', '2020-01-17', 'Research and Development', 27),
(258, 'Ajith Kumar', '1971-05-01', 'M', 'Cine Avenue, Chennai', 901901901, 'ajith@email.com', '2020-01-18', 'Research and Development', 28),
(259, 'Nayanthara', '1984-11-18', 'F', 'Blockbuster Ave, Chennai', 12012012, 'nayanthara@email.com', '2020-01-19', 'Research and Development', 29),
(260, 'Suriya', '1975-07-23', 'M', 'Superstar Lane, Chennai', 123123123, 'suriya@email.com', '2020-01-20', 'Research and Development', 30),
(261, 'Trisha Krishnan', '1983-05-04', 'F', 'Cine Street, Chennai', 234234234, 'trisha@email.com', '2020-01-21', 'Research and Development', 26),
(262, 'Dhanush', '1983-07-28', 'M', 'Iconic Avenue, Chennai', 345345345, 'dhanush@email.com', '2020-01-22', 'Research and Development', 27),
(263, 'Simran', '1976-04-04', 'F', 'Mega Blvd, Chennai', 456456456, 'simran@email.com', '2020-01-23', 'Research and Development', 28),
(264, 'Vikram', '1966-04-17', 'M', 'Bollywood Lane, Chennai', 567567567, 'vikram@email.com', '2020-01-24', 'Research and Development', 29),
(265, 'Dulquer Salmaan', '1986-07-28', 'M', 'Stardom Street, Chennai', 678678678, 'dulquer@email.com', '2020-01-25', 'Research and Development', 30),
(266, 'Keerthy Suresh', '1992-10-17', 'F', 'Blockbuster Rd, Chennai', 789789789, 'keerthy@email.com', '2020-01-26', 'Research and Development', 26),
(267, 'Sivakarthikeyan', '1985-02-17', 'M', 'Star Ave, Chennai', 890890890, 'sivakarthikeyan@email.com', '2020-01-27', 'Research and Development', 27),
(268, 'Jyothika', '1977-10-18', 'F', 'Cinema St, Chennai', 901901901, 'jyothika@email.com', '2020-01-28', 'Research and Development', 28),
(269, 'Vijay Sethupathi', '1978-01-16', 'M', 'Superstar Lane, Chennai', 12012012, 'vijaysethupathi@email.com', '2020-01-29', 'Research and Development', 29),
(270, 'Anushka Shetty', '1981-11-07', 'F', 'Mega Road, Chennai', 123123123, 'anushka@email.com', '2020-01-30', 'Research and Development', 30),
(271, 'Prabhas', '1979-10-23', 'M', 'Blockbuster Blvd, Chennai', 234234234, 'prabhas@email.com', '2020-01-31', 'Research and Development', 26),
(272, 'Tamannaah Bhatia', '0000-00-00', 'F', 'Superstar Street, Chennai', 345345345, 'tamannaah@email.com', '2020-02-01', 'Research and Development', 27),
(273, 'Ajith Kumar', '1971-05-01', 'M', 'Cine Lane, Chennai', 456456456, 'ajith@email.com', '2020-02-02', 'Research and Development', 28),
(274, 'Nayanthara', '1984-11-18', 'F', 'Iconic Avenue, Chennai', 567567567, 'nayanthara@email.com', '2020-02-03', 'Research and Development', 29),
(275, 'Suriya', '1975-07-23', 'M', 'Mega Street, Chennai', 678678678, 'suriya@email.com', '2020-02-04', 'Research and Development', 30),
(276, 'Trisha Krishnan', '1983-05-04', 'F', 'Superstar Road, Chennai', 789789789, 'trisha@email.com', '2020-02-05', 'Research and Development', 26),
(277, 'Dhanush', '1983-07-28', 'M', 'Bollywood Blvd, Chennai', 890890890, 'dhanush@email.com', '2020-02-06', 'Research and Development', 27),
(278, 'Simran', '1976-04-04', 'F', 'Stardom Street, Chennai', 901901901, 'simran@email.com', '2020-02-07', 'Research and Development', 28),
(279, 'Vikram', '1966-04-17', 'M', 'Cine Lane, Chennai', 12012012, 'vikram@email.com', '2020-02-08', 'Research and Development', 29),
(280, 'Dulquer Salmaan', '1986-07-28', 'M', 'Filmstar Ave, Chennai', 123123123, 'dulquer@email.com', '2020-02-09', 'Research and Development', 30),
(281, 'Mervyn Silva', '1944-11-29', 'M', 'Political Star Ave, Colombo', 123456789, 'mervyn@email.com', '2020-01-01', 'Information Technology', 31),
(282, 'Mahinda Rajapaksa', '1945-11-18', 'M', 'Presidential Mansion St, Colombo', 234567890, 'mahinda@email.com', '2020-01-02', 'Information Technology', 32),
(283, 'Chandrika Kumaratunga', '1945-06-29', 'F', 'Ex-President Blvd, Colombo', 345678901, 'chandrika@email.com', '2020-01-03', 'Information Technology', 33),
(284, 'Gotabaya Rajapaksa', '1949-06-20', 'M', 'Presidential Lane, Colombo', 456789012, 'gotabaya@email.com', '2020-01-04', 'Information Technology', 34),
(285, 'Sirimavo Bandaranaike', '1916-04-17', 'F', 'Prime Minister Ave, Colombo', 567890123, 'sirimavo@email.com', '2020-01-05', 'Information Technology', 35),
(286, 'Ranil Wickremesinghe', '1949-03-24', 'M', 'Prime Minister Street, Colombo', 678901234, 'ranil@email.com', '2020-01-06', 'Information Technology', 36),
(287, 'Anura Bandaranaike', '1949-02-15', 'M', 'Political Iconic Blvd, Colombo', 789012345, 'anura@email.com', '2020-01-07', 'Information Technology', 37),
(288, 'Dudley Senanayake', '1911-06-19', 'M', 'Political Superstar Lane, Colombo', 890123456, 'dudley@email.com', '2020-01-08', 'Information Technology', 38),
(289, 'Ranasinghe Premadasa', '1924-06-23', 'M', 'Presidential Blvd, Colombo', 901234567, 'ranasinghe@email.com', '2020-01-09', 'Information Technology', 39),
(290, 'Dinesh Chandimal', '1989-11-18', 'M', 'Cricket Star Ave, Colombo', 123123123, 'dinesh@email.com', '2020-01-10', 'Information Technology', 31),
(291, 'Dimuth Karunaratne', '1988-04-21', 'M', 'Cricket Lane, Colombo', 234234234, 'dimuth@email.com', '2020-01-11', 'Information Technology', 32),
(292, 'Angelo Mathews', '1987-06-02', 'M', 'Cricket Blvd, Colombo', 345345345, 'angelo@email.com', '2020-01-12', 'Information Technology', 33),
(293, 'Lasith Malinga', '1983-08-28', 'M', 'Cricket Lane, Colombo', 456456456, 'malinga@email.com', '2020-01-13', 'Information Technology', 34),
(294, 'Chandika Hathurusingha', '1968-09-11', 'M', 'Cricket St, Colombo', 567567567, 'chandika@email.com', '2020-01-14', 'Information Technology', 35),
(295, 'Muthiah Muralitharan', '1972-04-17', 'M', 'Cricket Blvd, Colombo', 678678678, 'murali@email.com', '2020-01-15', 'Information Technology', 36),
(296, 'Roshan Mahanama', '1966-05-05', 'M', 'Cricket Ave, Colombo', 789789789, 'roshan@email.com', '2020-01-16', 'Information Technology', 37),
(297, 'Russel Arnold', '1973-10-25', 'M', 'Cricket Rd, Colombo', 890890890, 'russel@email.com', '2020-01-17', 'Information Technology', 38),
(298, 'Upul Tharanga', '1985-02-02', 'M', 'Cricket Street, Colombo', 901901901, 'upul@email.com', '2020-01-18', 'Information Technology', 39),
(299, 'Nuwan Kulasekara', '1982-07-22', 'M', 'Cricket Blvd, Colombo', 12012012, 'nuwan@email.com', '2020-01-19', 'Information Technology', 40),
(300, 'Angelo Mathews', '1987-06-02', 'M', 'Cricket Iconic Lane, Colombo', 123123123, 'angelo@email.com', '2020-01-20', 'Information Technology', 31),
(301, 'Lasith Malinga', '1983-08-28', 'M', 'Cricket Mega Ave, Colombo', 234234234, 'malinga@email.com', '2020-01-21', 'Information Technology', 32),
(302, 'Dimuth Karunaratne', '1988-04-21', 'M', 'Cricket Superstar Blvd, Colombo', 345345345, 'dimuth@email.com', '2020-01-22', 'Information Technology', 33),
(303, 'Muthiah Muralitharan', '1972-04-17', 'M', 'Cricket Star Ave, Colombo', 456456456, 'murali@email.com', '2020-01-23', 'Information Technology', 34),
(304, 'Roshan Mahanama', '1966-05-05', 'M', 'Cricket Superstar Blvd, Colombo', 567567567, 'roshan@email.com', '2020-01-24', 'Information Technology', 35),
(305, 'Russel Arnold', '1973-10-25', 'M', 'Cricket Blvd, Colombo', 678678678, 'russel@email.com', '2020-01-25', 'Information Technology', 36),
(306, 'Upul Tharanga', '1985-02-02', 'M', 'Cricket Mega Ave, Colombo', 789789789, 'upul@email.com', '2020-01-26', 'Information Technology', 37),
(307, 'Nuwan Kulasekara', '1982-07-22', 'M', 'Cricket Superstar Blvd, Colombo', 890890890, 'nuwan@email.com', '2020-01-27', 'Information Technology', 38),
(308, 'Chandika Hathurusingha', '1968-09-11', 'M', 'Cricket Star Ave, Colombo', 901901901, 'chandika@email.com', '2020-01-28', 'Information Technology', 39),
(309, 'Mervyn Silva', '1944-11-29', 'M', 'Political Blvd, Colombo', 12012012, 'mervyn@email.com', '2020-01-29', 'Information Technology', 40),
(310, 'Sirimavo Bandaranaike', '1916-04-17', 'F', 'Political Iconic Ave, Colombo', 123123123, 'sirimavo@email.com', '2020-01-30', 'Information Technology', 31),
(311, 'Ranil Wickremesinghe', '1949-03-24', 'M', 'Prime Minister Lane, Colombo', 234234234, 'ranil@email.com', '2020-01-31', 'Information Technology', 32),
(312, 'Anura Bandaranaike', '1949-02-15', 'M', 'Political Blvd, Colombo', 345345345, 'anura@email.com', '2020-02-01', 'Information Technology', 33),
(313, 'Dudley Senanayake', '1911-06-19', 'M', 'Prime Minister Ave, Colombo', 456456456, 'dudley@email.com', '2020-02-02', 'Information Technology', 34),
(314, 'Ranasinghe Premadasa', '1924-06-23', 'M', 'Presidential Blvd, Colombo', 567567567, 'ranasinghe@email.com', '2020-02-03', 'Information Technology', 35),
(315, 'Dinesh Chandimal', '1989-11-18', 'M', 'Cricket Mega Ave, Colombo', 678678678, 'dinesh@email.com', '2020-02-04', 'Information Technology', 36),
(316, 'Dimuth Karunaratne', '1988-04-21', 'M', 'Cricket Star Blvd, Colombo', 789789789, 'dimuth@email.com', '2020-02-05', 'Information Technology', 37),
(317, 'Angelo Mathews', '1987-06-02', 'M', 'Cricket Iconic Ave, Colombo', 890890890, 'angelo@email.com', '2020-02-06', 'Information Technology', 38),
(318, 'Lasith Malinga', '1983-08-28', 'M', 'Cricket Lane, Colombo', 901901901, 'malinga@email.com', '2020-02-07', 'Information Technology', 39),
(319, 'Chandika Hathurusingha', '1968-09-11', 'M', 'Cricket Blvd, Colombo', 12012012, 'chandika@email.com', '2020-02-08', 'Information Technology', 40),
(320, 'Ranjan Ramanayake', '1963-04-11', 'M', 'Filmstar Blvd, Colombo', 123456789, 'ranjan@email.com', '2020-02-09', 'Information Technology', 31),
(321, 'Isaac Newton', '1643-01-04', 'M', 'Gravity Street, Cambridge', 123456789, 'isaac.newton@email.com', '2020-01-01', 'Human Resource', 41),
(322, 'Albert Einstein', '1879-03-14', 'M', 'Relativity Ave, Princeton', 234567890, 'albert.einstein@email.com', '2020-01-02', 'Finance', 41),
(323, 'Marie Curie', '1867-11-07', 'F', 'Radiation Lane, Warsaw', 345678901, 'marie.curie@email.com', '2020-01-03', 'Marketing', 41),
(324, 'Galileo Galilei', '1564-02-15', 'M', 'Astronomy Blvd, Pisa', 456789012, 'galileo.galilei@email.com', '2020-01-04', 'Sales', 41),
(325, 'Charles Darwin', '1809-02-12', 'M', 'Evolution Rd, Shrewsbury', 567890123, 'charles.darwin@email.com', '2020-01-05', 'Quality Assurance', 41),
(326, 'Nikola Tesla', '1856-07-10', 'M', 'Electricity Street, Smiljan', 678901234, 'nikola.tesla@email.com', '2020-01-06', 'Research and Development', 41),
(327, 'Marcello Malpighi', '1628-03-10', 'M', 'Microscopy Blvd, Bologna', 789012345, 'marcello.malpighi@email.com', '2020-01-07', 'Information Technology ', 41);

-- --------------------------------------------------------

--
-- Table structure for table `employee_leave`
--

CREATE TABLE `employee_leave` (
  `Employee_Id` bigint(12) NOT NULL,
  `Commencement_Date` date NOT NULL,
  `Conclusion_Date` date NOT NULL,
  `Type` varchar(30) NOT NULL,
  `Acceptance` varchar(3) NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee_leave`
--

INSERT INTO `employee_leave` (`Employee_Id`, `Commencement_Date`, `Conclusion_Date`, `Type`, `Acceptance`) VALUES
(1, '2020-05-01', '2020-05-31', 'Sick Leave', 'Yes'),
(2, '2020-05-02', '2020-06-01', 'Vacation', 'Yes'),
(2, '2020-07-15', '2020-08-01', 'Sick Leave', 'Yes'),
(3, '2020-05-03', '2020-06-02', 'Parental Leave', 'Yes'),
(4, '2020-05-04', '2020-06-03', 'Maternity Leave', 'Yes'),
(5, '2020-05-05', '2020-06-04', 'Sick Leave', 'No'),
(6, '2020-05-06', '2020-06-05', 'Vacation', 'Yes'),
(8, '2020-05-08', '2020-06-07', 'Maternity Leave', 'Yes'),
(9, '2020-05-09', '2020-06-08', 'Sick Leave', 'Yes'),
(10, '2020-05-10', '2020-06-09', 'Vacation', 'Yes'),
(11, '2020-05-11', '2020-06-10', 'Parental Leave', 'No'),
(12, '2020-05-12', '2020-06-11', 'Maternity Leave', 'Yes'),
(13, '2020-05-13', '2020-06-12', 'Sick Leave', 'Yes'),
(14, '2020-05-14', '2020-06-13', 'Vacation', 'Yes'),
(15, '2020-05-15', '2020-06-14', 'Parental Leave', 'Yes'),
(16, '2020-05-16', '2020-06-15', 'Maternity Leave', 'Yes'),
(17, '2020-05-17', '2020-06-16', 'Sick Leave', 'No'),
(18, '2020-05-18', '2020-06-17', 'Vacation', 'Yes'),
(19, '2020-05-19', '2020-06-18', 'Parental Leave', 'Yes'),
(20, '2020-05-20', '2020-06-19', 'Maternity Leave', 'Yes'),
(21, '2020-05-21', '2020-06-20', 'Sick Leave', 'Yes'),
(22, '2020-05-22', '2020-06-21', 'Vacation', 'Yes'),
(23, '2020-05-23', '2020-06-22', 'Parental Leave', 'No'),
(24, '2020-05-24', '2020-06-23', 'Maternity Leave', 'Yes'),
(25, '2020-05-25', '2020-06-24', 'Sick Leave', 'Yes'),
(26, '2020-05-26', '2020-06-25', 'Vacation', 'Yes'),
(27, '2020-05-27', '2020-06-26', 'Parental Leave', 'Yes'),
(28, '2020-05-28', '2020-06-27', 'Maternity Leave', 'Yes'),
(29, '2020-05-29', '2020-06-28', 'Sick Leave', 'Yes'),
(30, '2020-05-30', '2020-06-29', 'Vacation', 'Yes'),
(31, '2020-05-31', '2020-06-30', 'Parental Leave', 'Yes'),
(32, '2020-06-01', '2020-07-01', 'Maternity Leave', 'Yes'),
(33, '2020-06-02', '2020-07-02', 'Sick Leave', 'Yes'),
(34, '2020-06-03', '2020-07-03', 'Vacation', 'Yes'),
(35, '2020-06-04', '2020-07-04', 'Parental Leave', 'Yes'),
(36, '2020-06-05', '2020-07-05', 'Maternity Leave', 'No'),
(37, '2020-06-06', '2020-07-06', 'Sick Leave', 'Yes'),
(38, '2020-06-07', '2020-07-07', 'Vacation', 'Yes'),
(39, '2020-06-08', '2020-07-08', 'Parental Leave', 'Yes'),
(40, '2020-06-09', '2020-07-09', 'Maternity Leave', 'Yes'),
(41, '2020-06-10', '2020-07-10', 'Sick Leave', 'Yes'),
(42, '2020-06-11', '2020-07-11', 'Vacation', 'Yes'),
(43, '2020-06-12', '2020-07-12', 'Parental Leave', 'Yes'),
(44, '2020-06-13', '2020-07-13', 'Maternity Leave', '<br'),
(45, '2020-06-14', '2020-07-14', 'Sick Leave', 'Yes'),
(46, '2020-06-15', '2020-07-15', 'Vacation', 'Yes'),
(47, '2020-06-16', '2020-07-16', 'Parental Leave', 'Yes'),
(48, '2020-06-17', '2020-07-17', 'Maternity Leave', 'Yes'),
(49, '2020-06-18', '2020-07-18', 'Sick Leave', 'Yes'),
(50, '2020-06-19', '2020-07-19', 'Vacation', 'Yes'),
(51, '2020-06-20', '2020-07-20', 'Parental Leave', 'Yes'),
(52, '2020-06-21', '2020-07-21', 'Maternity Leave', 'Yes'),
(53, '2020-06-22', '2020-07-22', 'Sick Leave', 'Yes'),
(54, '2020-06-23', '2020-07-23', 'Vacation', 'Yes'),
(55, '2020-06-24', '2020-07-24', 'Parental Leave', 'Yes'),
(56, '2020-06-25', '2020-07-25', 'Maternity Leave', 'Yes'),
(57, '2020-06-26', '2020-07-26', 'Sick Leave', 'Yes'),
(58, '2020-06-27', '2020-07-27', 'Vacation', 'Yes'),
(59, '2020-06-28', '2020-07-28', 'Parental Leave', 'Yes'),
(60, '2020-05-07', '2020-06-06', 'Parental Leave', 'Yes'),
(60, '2020-06-29', '2020-07-29', 'Maternity Leave', 'Yes'),
(60, '2020-07-14', '2020-08-13', 'Parental Leave', 'Yes'),
(60, '2020-08-07', '2020-09-06', 'Parental Leave', 'Yes'),
(61, '2020-06-30', '2020-07-30', 'Sick Leave', 'Yes'),
(62, '2020-07-01', '2020-07-31', 'Vacation', 'Yes'),
(63, '2020-07-02', '2020-08-01', 'Parental Leave', 'Yes'),
(64, '2020-07-03', '2020-08-02', 'Maternity Leave', 'Yes'),
(65, '2020-07-04', '2020-08-03', 'Sick Leave', 'Yes'),
(66, '2020-07-05', '2020-08-04', 'Vacation', 'Yes'),
(67, '2020-07-06', '2020-08-05', 'Parental Leave', 'Yes'),
(68, '2020-07-07', '2020-08-06', 'Maternity Leave', 'Yes'),
(69, '2020-07-08', '2020-08-07', 'Sick Leave', 'Yes'),
(70, '2020-07-09', '2020-08-08', 'Vacation', 'Yes'),
(71, '2020-07-10', '2020-08-09', 'Parental Leave', 'Yes'),
(72, '2020-07-11', '2020-08-10', 'Maternity Leave', 'Yes'),
(73, '2020-07-12', '2020-08-11', 'Sick Leave', 'Yes'),
(74, '2020-07-13', '2020-08-12', 'Vacation', 'No'),
(76, '2020-07-15', '2020-08-14', 'Maternity Leave', 'Yes'),
(77, '2020-07-16', '2020-08-15', 'Sick Leave', 'Yes'),
(78, '2020-07-17', '2020-08-16', 'Vacation', 'Yes'),
(79, '2020-07-18', '2020-08-17', 'Parental Leave', 'Yes'),
(80, '2020-07-19', '2020-08-18', 'Maternity Leave', 'Yes'),
(81, '2020-07-20', '2020-08-19', 'Sick Leave', 'Yes'),
(82, '2020-07-21', '2020-08-20', 'Vacation', 'Yes'),
(83, '2020-07-22', '2020-08-21', 'Parental Leave', 'Yes'),
(84, '2020-07-23', '2020-08-22', 'Maternity Leave', 'Yes'),
(85, '2020-07-24', '2020-08-23', 'Sick Leave', 'Yes'),
(86, '2020-07-25', '2020-08-24', 'Vacation', 'Yes'),
(87, '2020-07-26', '2020-08-25', 'Parental Leave', 'Yes'),
(88, '2020-07-27', '2020-08-26', 'Maternity Leave', 'Yes'),
(89, '2020-07-28', '2020-08-27', 'Sick Leave', 'Yes'),
(90, '2020-07-29', '2020-08-28', 'Vacation', 'Yes'),
(91, '2020-07-30', '2020-08-29', 'Parental Leave', 'Yes'),
(92, '2020-07-31', '2020-08-30', 'Maternity Leave', 'Yes'),
(93, '2020-08-01', '2020-08-31', 'Sick Leave', 'Yes'),
(94, '2020-08-02', '2020-09-01', 'Vacation', 'Yes'),
(95, '2020-08-03', '2020-09-02', 'Parental Leave', 'Yes'),
(96, '2020-08-04', '2020-09-03', 'Maternity Leave', 'Yes'),
(97, '2020-08-05', '2020-09-04', 'Sick Leave', 'Yes'),
(98, '2020-08-06', '2020-09-05', 'Vacation', 'Yes'),
(100, '2020-08-08', '2020-09-07', 'Maternity Leave', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE `job` (
  `Job_Id` int(7) NOT NULL,
  `Title` varchar(30) NOT NULL,
  `Description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job`
--

INSERT INTO `job` (`Job_Id`, `Title`, `Description`) VALUES
(1, 'HR Manager', 'Oversees HR functions, including recruitment and employee relations'),
(2, 'Compensation Analyst', 'Manages employee pay and benefits packages'),
(3, 'Training Coordinator', 'Organizes employee training and development programs'),
(4, 'Diversity and Inclusion Specia', 'Promotes workplace diversity and inclusion'),
(5, 'Employee Relations Advisor', 'Resolves employee issues and conflicts'),
(6, 'Financial Analyst', 'Analyzes financial data to support decision-making'),
(7, 'Tax Accountant', 'Prepares tax documents and ensures compliance'),
(8, 'Investment Analyst', 'Manages investment portfolios and strategies'),
(9, 'Risk Management Specialist', 'Identifies and mitigates financial risks'),
(10, 'Financial Controller', 'Oversees financial operations and reporting'),
(11, 'Marketing Manager', 'Develops marketing strategies and oversees campaigns'),
(12, 'Digital Marketing Specialist', 'Focuses on online marketing channels and campaigns'),
(13, 'Market Research Analyst', 'Gathers data to assess market trends and consumer preferences'),
(14, 'Content Writer', 'Creates engaging content for marketing materials'),
(15, 'Brand Ambassador', 'Represents and promotes the company\'s brand image'),
(16, 'Sales Representative', 'Sells products or services to clients and customers'),
(17, 'Sales Manager', 'Leads and supervises the sales team'),
(18, 'Account Executive', 'Manages client relationships and sales accounts'),
(19, 'Business Development Specialis', 'Identifies growth opportunities and expands customer base'),
(20, 'Inside Sales Coordinator', 'Provides support for internal sales activities'),
(21, 'QA Tester', 'Ensures software and products meet quality standards'),
(22, 'Compliance Auditor', 'Assesses regulatory compliance in products and processes'),
(23, 'Quality Control Inspector', 'Monitors production quality and enforces standards'),
(24, 'ISO Compliance Specialist', 'Maintains compliance with ISO quality standards'),
(25, 'Continuous Improvement Analyst', 'Identifies and implements process enhancements'),
(26, 'Research Scientist', 'Conducts experiments and research to innovate and develop new products'),
(27, 'Product Development Engineer', 'Designs and improves products'),
(28, 'R&D Project Manager', 'Manages research and development projects'),
(29, 'Clinical Research Coordinator', 'Organizes clinical trials and research studies'),
(30, 'Innovation Specialist', 'Drives innovation in products and processes'),
(31, 'Software Developer', 'Creates and maintains software applications'),
(32, 'Network Administrator', 'Manages and secures computer networks'),
(33, 'IT Manager', 'Leads the IT department and aligns technology with business goals'),
(34, 'Cybersecurity Analyst', 'Protects digital assets from threats and vulnerabilities'),
(35, 'Data Scientist', 'Analyzes data to gain insights and inform decisions'),
(36, 'Cloud Solutions Architect', 'Designs and manages cloud infrastructure and solutions'),
(37, 'IT Support Specialist', 'Assists employees with technical issues'),
(38, 'DevOps Engineer', 'Streamlines development and IT operations for efficiency'),
(39, 'Database Administrator', 'Manages databases and ensures data integrity'),
(40, 'IT Project Manager', 'Oversees IT projects from planning to implementation'),
(41, 'Staff Manager', 'Supervising the employees under him ');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `User_Name` varchar(50) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Employee_Id` bigint(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`User_Name`, `Password`, `Employee_Id`) VALUES
('AntMan', 'pass18word', 8),
('Aquagirl', 'pass33word', 14),
('Aquaman', 'pass12word', 11),
('Atom', 'pass52word', 16),
('Batman', 'pass3word', 22),
('Batwoman', 'pass40word', 25),
('Beast', 'pass113word', 57),
('Black Adam', 'pass47word', 78),
('Black Canary', 'pass61word', 209),
('Black Lightning', 'pass118word', 97),
('Black Panther', 'pass102word', 115),
('Black Widow', 'pass108word', 72),
('BlackCanary', 'pass26word', 92),
('BlackPanther', 'pass13word', 55),
('BlackWidow', 'pass7word', 33),
('Blue Beetle', 'pass57word', 35),
('BlueBeetle', 'pass36word', 200),
('Boomerang', 'pass200word', 65),
('Booster Gold', 'pass50word', 78),
('CaptainAmerica', 'pass6word', 200),
('Cheetah', 'pass103word', 38),
('Colossus', 'pass42word', 112),
('Crimson Fox', 'pass99word', 28),
('Cyborg', 'pass59word', 113),
('Cyclops', 'pass30word', 31),
('Daredevil', 'pass27word', 110),
('Deadpool', 'pass39word', 18),
('Doctor Doom', 'pass110word', 107),
('DoctorStrange', 'pass14word', 111),
('Elektra', 'pass109word', 48),
('Employee', 'A123456789', 60),
('Firestorm', 'pass100word', 64),
('Flash', 'pass10word', 99),
('FlashGordon', 'pass21word', 44),
('Gambit', 'pass43word', 23),
('GhostRider', 'pass29word', 88),
('Green Goblin', 'pass104word', 91),
('Green Lantern', 'pass46word', 93),
('GreenArrow', 'pass23word', 15),
('GreenLantern', 'pass11word', 75),
('HarleyQuinn', 'pass38word', 123),
('Havok', 'pass115word', 63),
('Hawkeye', 'pass16word', 29),
('Hawkgirl', 'pass45word', 32),
('Hawkman', 'pass101word', 80),
('Hr Staff', 'C123456789', 2),
('Hulk', 'pass9word', 45),
('Huntress', 'pass53word', 12),
('IronMan', 'pass1word', 5),
('JeanGrey', 'pass31word', 76),
('LukeCage', 'pass28word', 5),
('Manager', 'B123456789', 322),
('Moon Knight', 'pass120word', 85),
('Mr. Terrific', 'pass54word', 44),
('Namor', 'pass116word', 28),
('Nightcrawler', 'pass34word', 66),
('Nightwing', 'pass44word', 89),
('Phoenix', 'pass41word', 76),
('Power Girl', 'pass199word', 29),
('Raven', 'pass51word', 201),
('Red Tornado', 'pass49word', 34),
('RedHood', 'pass37word', 29),
('Rogue', 'pass25word', 33),
('Rorschach', 'pass35word', 77),
('S.A.Abdulla', '123456789', 3),
('Scarlet Witch', 'pass114word', 109),
('ScarletWitch', 'pass17word', 92),
('Shang-Chi', 'pass122word', 45),
('Shazam', 'pass32word', 111),
('Silver Surfer', 'pass107word', 55),
('SilverSurfer', 'pass22word', 205),
('Spectre', 'pass119word', 21),
('Starfire', 'pass48word', 6),
('Storm', 'pass24word', 77),
('Supergirl', 'pass19word', 123),
('Superman', 'pass5word', 14),
('Swamp Thing', 'pass62word', 46),
('Thor', 'pass8word', 77),
('Valkyrie', 'pass121word', 208),
('Vision', 'pass105word', 27),
('Vixen', 'pass117word', 83),
('Wasp', 'pass106word', 99),
('Wolverine', 'pass20word', 18),
('Wonder Girl', 'pass60word', 117),
('Wonder Man', 'pass111word', 19),
('WonderBoy', 'pass15word', 66),
('WonderWoman', 'pass4word', 88),
('Zatanna', 'pass55word', 56);

-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

CREATE TABLE `payroll` (
  `Pay_slip_No` int(8) NOT NULL,
  `Date` date NOT NULL,
  `Salary` int(8) NOT NULL,
  `Bonus` int(8) DEFAULT NULL,
  `Allowance` int(8) DEFAULT NULL,
  `Employee_Id` bigint(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payroll`
--

INSERT INTO `payroll` (`Pay_slip_No`, `Date`, `Salary`, `Bonus`, `Allowance`, `Employee_Id`) VALUES
(201, '2020-02-29', 440000, 50000, 10000, 50),
(202, '2020-03-31', 470000, 0, 10000, 89),
(203, '2020-04-30', 440000, 84000, 10000, 64),
(204, '2020-05-31', 240000, 0, 10000, 4),
(205, '2020-06-30', 260000, 27000, 10000, 16),
(206, '2020-07-31', 140000, 0, 10000, 69),
(207, '2020-08-31', 130000, 18000, 10000, 46),
(208, '2020-09-30', 490000, 64000, 10000, 25),
(209, '2020-10-31', 50000, 6000, 10000, 80),
(210, '2020-11-30', 230000, 32000, 10000, 46),
(211, '2020-12-31', 480000, 76000, 10000, 84),
(212, '2021-01-31', 250000, 0, 10000, 5),
(213, '2021-02-28', 210000, 31000, 10000, 36),
(214, '2021-03-31', 170000, 30000, 10000, 36),
(215, '2021-04-30', 290000, 38000, 10000, 99),
(216, '2021-05-31', 150000, 24000, 10000, 25),
(217, '2021-06-30', 100000, 0, 10000, 82),
(218, '2021-07-31', 120000, 13000, 10000, 32),
(219, '2021-08-31', 130000, 0, 10000, 93),
(220, '2021-09-30', 190000, 24000, 10000, 38),
(221, '2021-10-31', 420000, 49000, 10000, 15),
(222, '2021-11-30', 400000, 59000, 10000, 67),
(223, '2021-12-31', 180000, 24000, 10000, 56),
(224, '2022-01-31', 50000, 5000, 10000, 22),
(225, '2022-02-28', 280000, 43000, 10000, 39),
(226, '2022-03-31', 490000, 90000, 10000, 54),
(227, '2022-04-30', 80000, 0, 10000, 13),
(228, '2022-05-31', 150000, 25000, 10000, 9),
(229, '2022-06-30', 240000, 45000, 10000, 92),
(230, '2022-07-31', 210000, 0, 10000, 22),
(231, '2022-08-31', 380000, 67000, 10000, 64),
(232, '2022-09-30', 90000, 0, 10000, 49),
(233, '2022-10-31', 110000, 11000, 10000, 8),
(234, '2022-11-30', 280000, 38000, 10000, 73),
(235, '2022-12-31', 190000, 36000, 10000, 69),
(236, '2023-01-31', 410000, 81000, 10000, 93),
(237, '2023-02-28', 220000, 37000, 10000, 8),
(238, '2023-03-31', 120000, 0, 10000, 27),
(239, '2023-04-30', 60000, 9000, 10000, 63),
(240, '2023-05-31', 130000, 15000, 10000, 54),
(241, '2023-06-30', 140000, 22000, 10000, 74),
(242, '2023-07-31', 480000, 0, 10000, 57),
(243, '2023-08-31', 280000, 35000, 10000, 56),
(244, '2023-09-30', 310000, 48000, 10000, 49),
(245, '2023-10-31', 290000, 38000, 10000, 46),
(246, '2023-11-30', 80000, 0, 10000, 41),
(247, '2023-12-31', 100000, 13000, 10000, 75),
(248, '2024-01-31', 290000, 35000, 10000, 72),
(249, '2024-02-29', 150000, 0, 10000, 38),
(250, '2024-03-31', 460000, 86000, 10000, 63),
(251, '2024-04-30', 170000, 25000, 10000, 18),
(252, '2024-05-31', 280000, 47000, 10000, 80),
(253, '2024-06-30', 350000, 0, 10000, 77),
(254, '2024-07-31', 410000, 0, 10000, 65),
(255, '2024-08-31', 110000, 21000, 10000, 10),
(256, '2024-09-30', 130000, 22000, 10000, 43),
(257, '2024-10-31', 160000, 20000, 10000, 70),
(258, '2024-11-30', 210000, 26000, 10000, 86),
(259, '2024-12-31', 480000, 0, 10000, 56),
(260, '2025-01-31', 130000, 17000, 10000, 71),
(261, '2025-02-28', 180000, 0, 10000, 48),
(262, '2025-03-31', 220000, 37000, 10000, 54),
(263, '2025-04-30', 290000, 32000, 10000, 33),
(264, '2025-05-31', 240000, 0, 10000, 36),
(265, '2025-06-30', 90000, 12000, 10000, 7),
(266, '2025-07-31', 360000, 48000, 10000, 76),
(267, '2025-08-31', 220000, 29000, 10000, 90),
(268, '2025-09-30', 440000, 0, 10000, 78),
(269, '2025-10-31', 350000, 58000, 10000, 56),
(270, '2025-11-30', 380000, 42000, 10000, 16),
(271, '2025-12-31', 280000, 48000, 10000, 78),
(272, '2026-01-31', 260000, 41000, 10000, 95),
(273, '2026-02-28', 350000, 0, 10000, 9),
(274, '2026-03-31', 410000, 0, 10000, 65),
(275, '2026-04-30', 100000, 13000, 10000, 9),
(276, '2026-05-31', 250000, 47000, 10000, 93),
(277, '2026-06-30', 70000, 13000, 10000, 16),
(278, '2026-07-31', 210000, 40000, 10000, 47),
(279, '2026-08-31', 160000, 0, 10000, 41),
(280, '2026-09-30', 250000, 0, 10000, 76),
(281, '2026-10-31', 160000, 31000, 10000, 66),
(282, '2026-11-30', 200000, 0, 10000, 87),
(283, '2026-12-31', 230000, 28000, 10000, 79),
(284, '2027-01-31', 170000, 29000, 10000, 21),
(285, '2027-02-28', 70000, 8000, 10000, 67),
(286, '2027-03-31', 290000, 0, 10000, 24),
(287, '2027-04-30', 340000, 34000, 10000, 56),
(288, '2027-05-31', 120000, 0, 10000, 24),
(289, '2027-06-30', 370000, 52000, 10000, 24),
(290, '2027-07-31', 180000, 19000, 10000, 31),
(291, '2027-08-31', 130000, 20000, 10000, 70),
(292, '2027-09-30', 390000, 0, 10000, 29),
(293, '2027-10-31', 380000, 40000, 10000, 76),
(294, '2027-11-30', 230000, 29000, 10000, 92),
(295, '2027-12-31', 270000, 0, 10000, 47),
(296, '2028-01-31', 420000, 0, 10000, 3),
(297, '2028-02-29', 440000, 58000, 10000, 82),
(298, '2028-03-31', 170000, 20000, 10000, 66),
(299, '2028-04-30', 70000, 0, 10000, 73),
(300, '2028-05-31', 440000, 0, 10000, 45),
(301, '2020-02-29', 400000, 69000, 10000, 73),
(302, '2020-03-31', 460000, 86000, 10000, 24),
(303, '2020-04-30', 310000, 0, 10000, 66),
(304, '2020-05-31', 290000, 30000, 10000, 33),
(305, '2020-06-30', 140000, 22000, 10000, 8),
(306, '2020-07-31', 100000, 16000, 10000, 60),
(307, '2020-08-31', 220000, 36000, 10000, 88),
(308, '2020-09-30', 390000, 63000, 10000, 15),
(309, '2020-10-31', 90000, 10000, 10000, 100),
(310, '2020-11-30', 50000, 7000, 10000, 53),
(311, '2020-12-31', 480000, 69000, 10000, 12),
(312, '2021-01-31', 360000, 0, 10000, 81),
(313, '2021-02-28', 190000, 25000, 10000, 32),
(314, '2021-03-31', 80000, 9000, 10000, 84),
(315, '2021-04-30', 320000, 35000, 10000, 23),
(316, '2021-05-31', 340000, 0, 10000, 41),
(317, '2021-06-30', 320000, 49000, 10000, 60),
(318, '2021-07-31', 110000, 18000, 10000, 97),
(319, '2021-08-31', 470000, 75000, 10000, 1),
(320, '2021-09-30', 480000, 86000, 10000, 96),
(321, '2021-10-31', 310000, 33000, 10000, 20),
(322, '2021-11-30', 80000, 8000, 10000, 27),
(323, '2021-12-31', 180000, 33000, 10000, 7),
(324, '2022-01-31', 90000, 0, 10000, 13),
(325, '2022-02-28', 100000, 0, 10000, 53),
(326, '2022-03-31', 180000, 32000, 10000, 67),
(327, '2022-04-30', 70000, 9000, 10000, 51),
(328, '2022-05-31', 470000, 64000, 10000, 83),
(329, '2022-06-30', 360000, 0, 10000, 17),
(330, '2022-07-31', 230000, 27000, 10000, 11),
(331, '2022-08-31', 210000, 40000, 10000, 100),
(332, '2022-09-30', 430000, 68000, 10000, 35),
(333, '2022-10-31', 410000, 0, 10000, 33),
(334, '2022-11-30', 430000, 0, 10000, 3),
(335, '2022-12-31', 70000, 9000, 10000, 32),
(336, '2023-01-31', 350000, 0, 10000, 73),
(337, '2023-02-28', 120000, 16000, 10000, 95),
(338, '2023-03-31', 200000, 0, 10000, 89),
(339, '2023-04-30', 420000, 55000, 10000, 19),
(340, '2023-05-31', 430000, 53000, 10000, 97),
(341, '2023-06-30', 470000, 82000, 10000, 14),
(342, '2023-07-31', 420000, 42000, 10000, 82),
(343, '2023-08-31', 310000, 0, 10000, 92),
(344, '2023-09-30', 210000, 39000, 10000, 96),
(345, '2023-10-31', 60000, 6000, 10000, 33),
(346, '2023-11-30', 100000, 19000, 10000, 44),
(347, '2023-12-31', 240000, 35000, 10000, 8),
(348, '2024-01-31', 170000, 17000, 10000, 55),
(349, '2024-02-29', 320000, 50000, 10000, 73),
(350, '2024-03-31', 280000, 47000, 10000, 26),
(351, '2024-04-30', 350000, 52000, 10000, 96),
(352, '2024-05-31', 180000, 25000, 10000, 96),
(353, '2024-06-30', 420000, 0, 10000, 1),
(354, '2024-07-31', 90000, 17000, 10000, 9),
(355, '2024-08-31', 190000, 0, 10000, 81),
(356, '2024-09-30', 380000, 67000, 10000, 85),
(357, '2024-10-31', 430000, 53000, 10000, 24),
(358, '2024-11-30', 50000, 5000, 10000, 55),
(359, '2024-12-31', 290000, 56000, 10000, 93),
(360, '2025-01-31', 60000, 6000, 10000, 60),
(361, '2025-02-28', 420000, 53000, 10000, 7),
(362, '2025-03-31', 290000, 52000, 10000, 47),
(363, '2025-04-30', 210000, 41000, 10000, 16),
(364, '2025-05-31', 60000, 6000, 10000, 60),
(365, '2025-06-30', 350000, 49000, 10000, 97),
(366, '2025-07-31', 390000, 0, 10000, 61),
(367, '2025-08-31', 460000, 81000, 10000, 3),
(368, '2025-09-30', 250000, 44000, 10000, 36),
(369, '2025-10-31', 410000, 51000, 10000, 24),
(370, '2025-11-30', 350000, 56000, 10000, 30),
(371, '2025-12-31', 400000, 53000, 10000, 54),
(372, '2026-01-31', 150000, 20000, 10000, 65),
(373, '2026-02-28', 210000, 32000, 10000, 31),
(374, '2026-03-31', 490000, 0, 10000, 93),
(375, '2026-04-30', 70000, 11000, 10000, 92),
(376, '2026-05-31', 450000, 66000, 10000, 34),
(377, '2026-06-30', 50000, 9000, 10000, 9),
(378, '2026-07-31', 440000, 55000, 10000, 89),
(379, '2026-08-31', 140000, 0, 10000, 1),
(380, '2026-09-30', 410000, 41000, 10000, 59),
(381, '2026-10-31', 440000, 71000, 10000, 19),
(382, '2026-11-30', 110000, 11000, 10000, 62),
(383, '2026-12-31', 440000, 45000, 10000, 62),
(384, '2027-01-31', 360000, 44000, 10000, 57),
(385, '2027-02-28', 50000, 9000, 10000, 54),
(386, '2027-03-31', 280000, 0, 10000, 46),
(387, '2027-04-30', 310000, 48000, 10000, 44),
(388, '2027-05-31', 210000, 22000, 10000, 82),
(389, '2027-06-30', 300000, 35000, 10000, 95),
(390, '2027-07-31', 340000, 0, 10000, 5),
(391, '2027-08-31', 180000, 23000, 10000, 75),
(392, '2027-09-30', 340000, 37000, 10000, 71),
(393, '2027-10-31', 400000, 44000, 10000, 82),
(394, '2027-11-30', 170000, 33000, 10000, 13),
(395, '2027-12-31', 280000, 28000, 10000, 11),
(396, '2028-01-31', 430000, 85000, 10000, 20),
(397, '2028-02-29', 480000, 65000, 10000, 79),
(398, '2028-03-31', 240000, 43000, 10000, 51),
(399, '2028-04-30', 160000, 26000, 10000, 13),
(400, '2028-05-31', 260000, 29000, 10000, 71);

-- --------------------------------------------------------

--
-- Table structure for table `vacancy`
--

CREATE TABLE `vacancy` (
  `Vacancy_Id` smallint(5) NOT NULL,
  `Qualification` varchar(100) NOT NULL,
  `Type` varchar(50) NOT NULL,
  `Salary_Range` varchar(50) DEFAULT NULL,
  `Job_Id` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vacancy`
--

INSERT INTO `vacancy` (`Vacancy_Id`, `Qualification`, `Type`, `Salary_Range`, `Job_Id`) VALUES
(1, 'Master\'s in Human Resources Management, 5 years of progressive HR experience, Effective leadership a', 'Full Time', '200000-3000001', 18),
(2, 'Bachelor\'s Degree in any following field Finance, Accounting, Economics, or Business Administration ', 'Full Time', '400000-500000', 6),
(3, 'Bachelor\'s Degree in Accounting, Certified Public Accountant,  Strong analytical skills to review fi', 'Part Time', '1000000-200000', 7),
(4, 'Bachelor\'s Degree in Risk Management, and Finance, Certified Risk Manager .', 'Temporary Positions', '70000-100000', 9),
(5, 'bachelor\'s degree in any of the gievn degrees Computer Science, Statistics, Mathematics, Engineering', 'Full Time', '500000-600000', 35),
(6, 'bachelor\'s degree in any of the gievn degrees Computer Science, Statistics, Mathematics, Engineering', 'Full Time', '500000-600000', 35),
(7, 'Strong understanding of statistical methods and mathematical concepts  Proficiency in data analysis ', 'Part Time', '300000-400000', 35),
(8, 'Certified Information Systems Security Professional, Certified Information Security Manager', 'Temporary Positions', '100000-150000', 34),
(9, 'Certified Ethical Hacker , CompTIA Security', 'Temporary Positions', '100000-150000', 34),
(10, 'Prototyping Skills, Materials Selection: Knowledge of different materials, Quality Control and Testi', 'Freelance Job', '50000', 27),
(11, 'bachelor\'s degree in  Compliance or Regulatory Affairs, depth understanding of laws, regulations, an', 'Part Time', '1000000-200000', 22),
(12, 'bachelor\'s degree in Computer Science or  Information Technology', 'Freelance Job', '40000-60000', 21),
(13, 'bachelor\'s degree in Computer Science or  Information Technology, International Software Testing Qua', 'Full Time', '400000-600000', 21),
(14, 'Bachelor\'s degree in a related field, Knowledge of ISO quality standards, Experience in compliance m', 'Full Time', '50000-80000', 24),
(15, 'Bachelor\'s degree in a related field, Sales and client relationship management experience', 'Full Time', '60000-100000', 18),
(16, 'Bachelor\'s degree in English, Journalism, or a related field, Writing and content creation experienc', 'Full Time', '40000-60000', 14),
(17, 'Bachelor\'s degree in Finance, Risk Management, or a related field, Experience in identifying and mit', 'Full Time', '70000-120000', 9),
(18, 'Bachelor\'s degree in Human Resources, Organizational Development, or a related field, Experience in ', 'Full Time', '50000-80000', 3),
(19, 'Bachelor\'s degree in a related field, Sales and client relationship management experience', 'Full Time', '60000-100000', 18),
(20, 'High school diploma or equivalent, Experience in quality control and enforcing quality standards', 'Full Time', '40000-60000', 23),
(21, 'Bachelor\'s degree in a related field (e.g., Mechanical Engineering, Electrical Engineering), Experie', 'Full Time', '70000-120000', 27),
(22, 'Bachelor\'s degree in a related field, Proven experience in driving innovation in products and proces', 'Full Time', '60000-100000', 30),
(23, 'Bachelor\'s degree in a related field, Cloud architecture and management experience, Cloud certificat', 'Full Time', '80000-140000', 36),
(24, 'Bachelor\'s degree in a related field (e.g., Computer Science, Database Management), Database adminis', 'Full Time', '70000-120000', 39),
(25, 'Bachelor\'s degree in a related field (e.g., Cybersecurity, Information Security), Cybersecurity anal', 'Full Time', '80000-130001', 18);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applicant`
--
ALTER TABLE `applicant`
  ADD PRIMARY KEY (`Application_Id`),
  ADD KEY `Vacancy_Id` (`Vacancy_Id`),
  ADD KEY `Emial` (`Email`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`Employee_Id`,`Date`,`Arrival Time`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`Name`),
  ADD KEY `Manager` (`Manager_Id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`Employee_Id`),
  ADD KEY `fk_department` (`Department`),
  ADD KEY `fk_Role` (`Job_Id`);

--
-- Indexes for table `employee_leave`
--
ALTER TABLE `employee_leave`
  ADD PRIMARY KEY (`Employee_Id`,`Commencement_Date`);

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`Job_Id`),
  ADD UNIQUE KEY `Title` (`Title`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`User_Name`),
  ADD KEY `Employee_login` (`Employee_Id`);

--
-- Indexes for table `payroll`
--
ALTER TABLE `payroll`
  ADD PRIMARY KEY (`Pay_slip_No`),
  ADD KEY `Employee_Id` (`Employee_Id`);

--
-- Indexes for table `vacancy`
--
ALTER TABLE `vacancy`
  ADD PRIMARY KEY (`Vacancy_Id`),
  ADD KEY `Job_Id` (`Job_Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applicant`
--
ALTER TABLE `applicant`
  MODIFY `Application_Id` smallint(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `Employee_Id` bigint(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=328;

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `Job_Id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `payroll`
--
ALTER TABLE `payroll`
  MODIFY `Pay_slip_No` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=402;

--
-- AUTO_INCREMENT for table `vacancy`
--
ALTER TABLE `vacancy`
  MODIFY `Vacancy_Id` smallint(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `applicant`
--
ALTER TABLE `applicant`
  ADD CONSTRAINT `fk_vacancy` FOREIGN KEY (`Vacancy_Id`) REFERENCES `vacancy` (`Vacancy_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `fk_employee` FOREIGN KEY (`Employee_Id`) REFERENCES `employee` (`Employee_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `fk_Manager` FOREIGN KEY (`Manager_Id`) REFERENCES `employee` (`Employee_Id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `fk_Role` FOREIGN KEY (`Job_Id`) REFERENCES `job` (`Job_Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_department` FOREIGN KEY (`Department`) REFERENCES `department` (`Name`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `employee_leave`
--
ALTER TABLE `employee_leave`
  ADD CONSTRAINT `fk_employee_nr` FOREIGN KEY (`Employee_Id`) REFERENCES `employee` (`Employee_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `fk_employee_login` FOREIGN KEY (`Employee_Id`) REFERENCES `employee` (`Employee_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payroll`
--
ALTER TABLE `payroll`
  ADD CONSTRAINT `fk_employee_pay` FOREIGN KEY (`Employee_Id`) REFERENCES `employee` (`Employee_Id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vacancy`
--
ALTER TABLE `vacancy`
  ADD CONSTRAINT `fk_Job` FOREIGN KEY (`Job_Id`) REFERENCES `job` (`Job_Id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
