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
-- Database: `appdetest`
--

-- --------------------------------------------------------

--
-- Table structure for table `choix`
--

CREATE TABLE `choix` (
  `id` int(11) NOT NULL,
  `text_question` text DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `choix`
--

INSERT INTO `choix` (`id`, `text_question`, `question_id`, `status`) VALUES
(206, '1', 267, 'inactive'),
(207, '2', 267, 'active'),
(208, '1693224903808-456166539-photo2.jpg', 268, 'inactive'),
(209, '1693224910432-582332582-photo3.jpg', 268, 'active'),
(222, '199', 288, 'inactive'),
(223, '198', 288, 'active'),
(230, '515', 301, 'inactive'),
(231, '616', 301, 'active'),
(232, '1693404005316-649010837-photo37.jpg', 302, 'active'),
(233, '1693404018391-354158374-photo34.jpg', 302, 'inactive'),
(234, 'abc', 304, 'inactive'),
(235, 'ab', 304, 'active'),
(236, '1693469608550-425705046-photo14.jpg', 305, 'active'),
(237, '1693469622712-908421211-photo15.jpg', 305, 'inactive');

-- --------------------------------------------------------

--
-- Table structure for table `examens`
--

CREATE TABLE `examens` (
  `id` int(11) NOT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `nombre_qsts` int(11) DEFAULT NULL,
  `date_heure_debut` varchar(255) DEFAULT NULL,
  `date_heure_fin` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `examens`
--

INSERT INTO `examens` (`id`, `titre`, `nombre_qsts`, `date_heure_debut`, `date_heure_fin`) VALUES
(40, 'test N3', 5, '2023-09-01T18:00', '2023-09-01T19:00'),
(42, 'test N4', 2, '2023-09-01T09:15', '2023-09-01T09:45'),
(45, 'test N°5', 3, '2023-09-03T11:00', '2023-09-03T00:30'),
(47, 'test N° 1', 3, '2023-09-06T14:00', '2023-09-06T15:30'),
(48, 'examen1', 4, '2023-09-05T17:00', '2023-09-05T19:00'),
(49, 'hhhh', 5, '2023-09-06T16:55', '2023-09-06T16:58');

-- --------------------------------------------------------

--
-- Table structure for table `examens_utilisateurs`
--

CREATE TABLE `examens_utilisateurs` (
  `ID` int(11) NOT NULL,
  `Examen_ID` int(11) DEFAULT NULL,
  `Utilisateur_ID` int(11) DEFAULT NULL,
  `Date_Attribution` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `examen_question`
--

CREATE TABLE `examen_question` (
  `id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `examen_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `examen_question`
--

INSERT INTO `examen_question` (`id`, `question_id`, `examen_id`) VALUES
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

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `texte_question` text DEFAULT NULL,
  `type_question` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `texte_question`, `type_question`) VALUES
(266, 'question numero un?', 'text'),
(267, 'question numero deux?', 'choice'),
(268, 'question numero trois ?', 'choice'),
(287, 'question numero quatre?', 'text'),
(288, 'question numero cinq?', 'choice'),
(301, 'question numero sept?', 'choice'),
(302, 'question numero huit?', 'choice'),
(303, 'question numero dix?', 'text'),
(304, 'question numero onze?', 'choice'),
(305, 'question numero douze?', 'choice');

-- --------------------------------------------------------

--
-- Table structure for table `reponses`
--

CREATE TABLE `reponses` (
  `id` int(11) NOT NULL,
  `utilisateur_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `texte_reponse` text DEFAULT NULL,
  `est_correcte` tinyint(1) DEFAULT NULL,
  `choix_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mot_de_passe` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT 3
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `nom`, `prenom`, `email`, `mot_de_passe`, `level`) VALUES
(15, 'ibtissam', 'ibtissame', 'ibtissamtrs@gamil.com', '123654', 3),
(17, 'fer', 'fer', 'fff@gmail', 'dedd', 3),
(18, 'sara', 'sara', 'sara@gmail.com', '159263', 3),
(19, 'name 1 ', 'name N', 'nameN@gmail.com', '748159263', 3),
(20, 'name 2', 'name N', 'namen@gmail.com', '1596288', 3),
(21, 'name 3', 'name N', 'namem@gmail.com', '159628812', 3),
(22, 'name N1', 'trsname', 'ibtissamtrs@gamil.com', '147852', 3),
(23, 'zaid', 'zaid', 'zaid@gamil.com', '123', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `choix`
--
ALTER TABLE `choix`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_question_id` (`question_id`);

--
-- Indexes for table `examens`
--
ALTER TABLE `examens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `examens_utilisateurs`
--
ALTER TABLE `examens_utilisateurs`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Examen_ID` (`Examen_ID`),
  ADD KEY `Utilisateur_ID` (`Utilisateur_ID`);

--
-- Indexes for table `examen_question`
--
ALTER TABLE `examen_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_qst_id` (`question_id`),
  ADD KEY `fk_exmn_id` (`examen_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reponses`
--
ALTER TABLE `reponses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utilisateur_id` (`utilisateur_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `fk_choix_id` (`choix_id`);

--
-- Indexes for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `choix`
--
ALTER TABLE `choix`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT for table `examens`
--
ALTER TABLE `examens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `examens_utilisateurs`
--
ALTER TABLE `examens_utilisateurs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `examen_question`
--
ALTER TABLE `examen_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=306;

--
-- AUTO_INCREMENT for table `reponses`
--
ALTER TABLE `reponses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `choix`
--
ALTER TABLE `choix`
  ADD CONSTRAINT `fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `examens_utilisateurs`
--
ALTER TABLE `examens_utilisateurs`
  ADD CONSTRAINT `examens_utilisateurs_ibfk_1` FOREIGN KEY (`Examen_ID`) REFERENCES `examens` (`id`),
  ADD CONSTRAINT `examens_utilisateurs_ibfk_2` FOREIGN KEY (`Utilisateur_ID`) REFERENCES `utilisateur` (`id`);

--
-- Constraints for table `examen_question`
--
ALTER TABLE `examen_question`
  ADD CONSTRAINT `fk_exmn_id` FOREIGN KEY (`examen_id`) REFERENCES `examens` (`id`),
  ADD CONSTRAINT `fk_qst_id` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`);

--
-- Constraints for table `reponses`
--
ALTER TABLE `reponses`
  ADD CONSTRAINT `fk_choix_id` FOREIGN KEY (`choix_id`) REFERENCES `choix` (`id`),
  ADD CONSTRAINT `reponses_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateur` (`id`),
  ADD CONSTRAINT `reponses_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
