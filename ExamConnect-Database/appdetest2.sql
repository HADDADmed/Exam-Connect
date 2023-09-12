-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 04, 2023 at 06:53 PM
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
-- Database: `ExamBridge`
--

-- --------------------------------------------------------

--
-- Table structure for table `QuestionOption`
--

 
CREATE TABLE `QuestionOption` ( 
  `id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `question_text` text DEFAULT NULL,
  `isTrue`  BOOLEAN NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Dumping data for table `QuestionOption`
--


INSERT INTO `QuestionOption` (`id`, `question_text`, `question_id`, `isTrue`) VALUES
(206, '1', 267, 0),
(207, '2', 267, 1),
(208, '1693224903808-456166539-photo2.jpg', 268, 0),
(209, '1693224910432-582332582-photo3.jpg', 268, 1),
(222, '199', 288, 0),
(223, '198', 288, 1),
(230, '515', 301, 0),
(231, '616', 301, 1),
(232, '1693404005316-649010837-photo37.jpg', 302, 1),
(233, '1693404018391-354158374-photo34.jpg', 302, 0),
(234, 'abc', 304, 0),
(235, 'ab', 304, 1),
(236, '1693469608550-425705046-photo14.jpg', 305, 1),
(237, '1693469622712-908421211-photo15.jpg', 305, 0);

-- --------------------------------------------------------

--
-- Table structure for table `exam`
--

CREATE TABLE `Exam` (
  `id` int(11) NOT NULL,
  `ExamTitle` varchar(255) DEFAULT NULL,
  `questionsCount` int(11) DEFAULT NULL,
  `startTime` varchar(255) DEFAULT NULL,
  `endTime` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Exam`
--

INSERT INTO `Exam` (`id`, `examTitle`, `questionsCount`, `startTime`, `endTime`) VALUES
(40, 'exam N3', 5, '2023-09-01T18:00', '2023-09-01T19:00'),
(42, 'exam N4', 2, '2023-09-01T09:15', '2023-09-01T09:45'),
(45, 'exam N°5', 3, '2023-09-03T11:00', '2023-09-03T00:30'),
(47, 'exam N° 1', 3, '2023-09-06T14:00', '2023-09-06T15:30'),
(48, 'examen1', 4, '2023-09-05T17:00', '2023-09-05T19:00'),
(49, 'hhhh', 5, '2023-09-06T16:55', '2023-09-06T16:58');

-- --------------------------------------------------------

--
-- Table structure for table `exam_user`
--

CREATE TABLE `exam_user` (
  `id` int(11) NOT NULL,
  `exam_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `exam_question`
--

CREATE TABLE `exam_question` (
  `id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `exam_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `exam_question`
--

INSERT INTO `exam_question` (`id`, `question_id`, `exam_id`) VALUES
(36, 268, 40),
(37, 287, 40),
(38, 267, 40),
(39, 288, 40),
(40, 301, 40),
(42, 303, 42),
(43, 266, 42),
(44, 304, 45),
(45, 288, 45),
(46, 267, 45),
(49, 288, 47),
(50, 287, 47),
(51, 302, 47),
(52, 268, 48),
(53, 267, 48),
(54, 288, 48),
(55, 287, 48),
(56, 304, 49),
(57, 302, 49),
(58, 305, 49),
(59, 266, 49),
(60, 287, 49);

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `Question` (
  `id` int(11) NOT NULL,
  `question_text` text DEFAULT NULL,
  `isQCM` BOOLEAN NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `question` (`id`, `question_text`, `isQCM`) VALUES
(266, 'question numero un?', 0),
(267, 'question numero deux?', 1),
(268, 'question numero trois ?', 1),
(287, 'question numero quatre?', 0),
(288, 'question numero cinq?', 1),
(301, 'question numero sept?', 1),
(302, 'question numero huit?', 1),
(303, 'question numero dix?', 0),
(304, 'question numero onze?', 1),
(305, 'question numero douze?', 1);

-- --------------------------------------------------------

--
-- Table structure for table `UserAnswear`
--

CREATE TABLE `UserAnswear` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `userAnsweartext` text DEFAULT NULL,
  `isTrue` BOOLEAN DEFAULT NULL,
  `QuestionOption_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `id` int(11) NOT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `User`
-- 

INSERT INTO `User` (`id`, `fullName`, `email`, `password`, `level`) VALUES
(15, 'ibtissam ibtissame', 'ibtissamtrs@gamil.com', '123654', 3),
(17, 'fer fer','fff@gmail', 'dedd', 3),
(18, 'sara sara','sara@gmail.com', '159263', 3),
(19, 'name name N ','nameN@gmail.com', '748159263', 3),
(20, 'name 2name','namen@gmail.com', '1596288', 3),
(21, 'name 3name','namem@gmail.com', '159628812', 3),
(22, 'name N1name','ibtissamtrs@gamil.com', '147852', 3),
(23, 'zaid name','zaid@gamil.com', '123', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `QuestionOption`
--
ALTER TABLE `QuestionOption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_question_id` (`question_id`);

--
-- Indexes for table `exam`
--
ALTER TABLE `Exam`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exam_user`
--
ALTER TABLE `exam_user`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `exam_id` (`exam_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `exam_question`
--
ALTER TABLE `exam_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_qst_id` (`question_id`),
  ADD KEY `fk_exmn_id` (`exam_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `UserAnswear`
--
ALTER TABLE `UserAnswear`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `fk_QuestionOption_id` (`QuestionOption_id`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `QuestionOption`
--
ALTER TABLE `QuestionOption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT for table `exam`
--
ALTER TABLE `Exam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `exam_user`
--
ALTER TABLE `exam_user`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exam_question`
--
ALTER TABLE `exam_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=306;

--
-- AUTO_INCREMENT for table `UserAnswear`
--
ALTER TABLE `UserAnswear`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `QuestionOption`
--
ALTER TABLE `QuestionOption`
  ADD CONSTRAINT `fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `exam_user`
--
ALTER TABLE `exam_user`
  ADD CONSTRAINT `exam_user_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  ADD CONSTRAINT `exam_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);

--
-- Constraints for table `exam_question`
--
ALTER TABLE `exam_question`
  ADD CONSTRAINT `fk_tst_id` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  ADD CONSTRAINT `fk_qst_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`);

--
-- Constraints for table `UserAnswear`
--
ALTER TABLE `UserAnswear`
  ADD CONSTRAINT `fk_QuestionOption_id` FOREIGN KEY (`QuestionOption_id`) REFERENCES `QuestionOption` (`id`),
  ADD CONSTRAINT `UserAnswear_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`),
  ADD CONSTRAINT `UserAnswear_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
