-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 19 sep. 2023 à 15:51
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `examconnect`
--

-- --------------------------------------------------------

--
-- Structure de la table `exam`
--

CREATE TABLE `exam` (
  `id` int(11) NOT NULL,
  `ExamTitle` varchar(255) DEFAULT NULL,
  `questionsCount` int(11) DEFAULT NULL,
  `startTime` varchar(255) DEFAULT NULL,
  `endTime` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `exam`
--

INSERT INTO `exam` (`id`, `ExamTitle`, `questionsCount`, `startTime`, `endTime`, `createdAt`) VALUES
(40, 'exam N3', 5, '2023-09-01T18:00', '2023-09-01T19:00', '2023-09-12 16:13:06'),
(45, 'exam N°5', 3, '2023-09-03T11:00', '2023-09-03T00:30', '2023-09-12 16:13:06'),
(47, 'exam N° 1', 3, '2023-09-06T14:00', '2023-09-06T15:30', '2023-09-12 16:13:06'),
(48, 'examen1', 4, '2023-09-05T17:00', '2023-09-05T19:00', '2023-09-12 16:13:06'),
(49, 'hhhh', 5, '2023-09-06T16:55', '2023-09-06T16:58', '2023-09-12 16:13:06'),
(53, 'hjdsh', 7, '2023-09-14T16:40', '2023-09-12T16:40', '2023-09-14 16:40:37'),
(54, 'sdajfhjsakdyh', 7, '2023-09-07T16:44', '2023-09-20T16:44', '2023-09-14 16:44:57'),
(55, 'Hello sdfkljshdf', 7, '2023-09-15T16:48', '2023-09-22T16:48', '2023-09-14 16:48:46'),
(56, 'xzfsxdzvcfsd', 9, '2023-09-13T16:55', '2023-09-13T16:55', '2023-09-14 16:55:43'),
(57, 'first post test ', 9, '2023-09-24T16:57', '2023-09-21T16:57', '2023-09-14 16:57:29'),
(58, 'Post test ', 14, '2023-09-17T19:40', '2023-09-12T19:40', '2023-09-18 16:40:30');

-- --------------------------------------------------------

--
-- Structure de la table `exam_question`
--

CREATE TABLE `exam_question` (
  `id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `exam_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `exam_question`
--

INSERT INTO `exam_question` (`id`, `question_id`, `exam_id`) VALUES
(36, 268, 40),
(37, 287, 40),
(38, 267, 40),
(39, 288, 40),
(40, 301, 40),
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
(60, 287, 49),
(64, 301, 53),
(65, 308, 53),
(66, 267, 53),
(67, 304, 54),
(68, 288, 54),
(69, 267, 54),
(70, 267, 55),
(71, 304, 55),
(72, 308, 55),
(73, 267, 56),
(74, 308, 56),
(75, 301, 56),
(76, 288, 56),
(77, 303, 56),
(78, 287, 56),
(79, 266, 56),
(80, 305, 56),
(81, 302, 56),
(82, 301, 57),
(83, 308, 57),
(84, 304, 57),
(85, 267, 57),
(86, 303, 57),
(87, 287, 57),
(88, 266, 57),
(89, 305, 57),
(90, 268, 57),
(91, 310, 57),
(93, 319, 57),
(94, 320, 57),
(96, 343, 57),
(97, 288, 58),
(98, 304, 58),
(99, 308, 58),
(100, 267, 58),
(102, 301, 58),
(103, 309, 58),
(104, 310, 58),
(105, 320, 58),
(106, 336, 58),
(107, 340, 58),
(110, 322, 58);

-- --------------------------------------------------------

--
-- Structure de la table `exam_user`
--

CREATE TABLE `exam_user` (
  `ID` int(11) NOT NULL,
  `exam_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `question`
--

CREATE TABLE `question` (
  `id` int(11) NOT NULL,
  `question_text` text DEFAULT NULL,
  `isQCM` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `question`
--

INSERT INTO `question` (`id`, `question_text`, `isQCM`, `createdAt`) VALUES
(266, 'question numero un?', 0, '2023-09-13 12:08:23'),
(267, 'question numero deux?', 1, '2023-09-13 12:08:23'),
(268, 'question numero trois ?', 2, '2023-09-13 12:08:23'),
(287, 'question numero quatre?', 0, '2023-09-13 12:08:23'),
(288, 'question numero cinq?', 1, '2023-09-13 12:08:23'),
(301, 'question numero sept?', 1, '2023-09-13 12:08:23'),
(302, 'question numero huit?', 2, '2023-09-13 12:08:23'),
(303, 'question numero dix?', 0, '2023-09-13 12:08:23'),
(304, 'question numero onze?', 1, '2023-09-13 12:08:23'),
(305, 'question numero douze?', 2, '2023-09-13 12:08:23'),
(308, 'whqt is the most powerfull Framwork ??', 1, '2023-09-14 12:11:04'),
(309, '<blockquote><h3><strong>This the first post question pleans answear by writing a text&nbsp;</strong></h3></blockquote><p><strong>So what we called dshjdh sdhgshg ghdsghsgd hsdg</strong></p>', 0, '2023-09-15 12:41:18'),
(310, '<h2><strong>Convert Minutes into Seconds</strong></h2><p>Write a function that takes an integer minutes and converts it to seconds.</p><h4><strong>Examples :</strong></h4><blockquote><p><br>convert(5) ➞ 300\n</p><p>\nconvert(3) ➞ 180\n</p><p>\nconvert(2) ➞ 120</p></blockquote><h4><strong>Notes :</strong></h4><ul><li>Don t forget to <i><strong>return </strong></i>the result.</li></ul><p><br>&nbsp;</p>', 0, '2023-09-15 12:45:48'),
(319, '<p><strong>asdfsafsdafsdaf</strong></p>', 2, '2023-09-18 10:37:15'),
(320, '<h3>This is the first Question test post from the front end pleas work !</h3>', 2, '2023-09-18 11:32:21'),
(321, '<p><strong>gjkhgjhgdkjsgafjhgdsjh jh ds jkhdsja?</strong></p>', 2, '2023-09-18 11:49:41'),
(322, '<p><strong>gjkhgjhgdkjsgafjhgdsjh jh ds jkhdsja?</strong></p>', 2, '2023-09-18 11:50:00'),
(323, '<p><strong>gjkhgjhgdkjsgafjhgdsjh jh ds jkhdsja?</strong></p>', 2, '2023-09-18 11:51:16'),
(324, '<p><strong>gjkhgjhgdkjsgafjhgdsjh jh ds jkhdsja?</strong></p>', 2, '2023-09-18 11:52:45'),
(329, '<p><strong>gjkhgjhgdkjsgafjhgdsjh jh ds jkhdsja?</strong></p>', 2, '2023-09-18 12:05:24'),
(330, '<p><strong>gjkhgjhgdkjsgafjhgdsjh jh ds jkhdsja?</strong></p>', 2, '2023-09-18 12:05:37'),
(331, '<p><strong>gjkhgjhgdkjsgafjhgdsjh jh ds jkhdsja?</strong></p>', 2, '2023-09-18 12:06:19'),
(332, '<p>sdafdasfdasfs</p>', 2, '2023-09-18 12:08:45'),
(336, '<p>sdafdasfdasfs</p>', 2, '2023-09-18 12:16:47'),
(339, '<p>sdafdasfdasfs</p>', 2, '2023-09-18 12:18:11'),
(340, '<p>sdafdasfdasfs</p>', 2, '2023-09-18 12:19:19'),
(341, '<p>sdafdasfdasfs</p>', 2, '2023-09-18 12:20:00'),
(342, '<p>sdafdasfdasfs</p>', 2, '2023-09-18 12:20:38'),
(343, '<h3>this is the last test post from frontend &nbsp;how r u !</h3><p><i><strong>chose one from the folowing images &nbsp;:</strong></i></p>', 2, '2023-09-18 12:23:44'),
(344, '<p><strong>Helo kfhjkdashfjkhdfjh jsdajjkfhjksdhf jhsdafjhkfjhasdf klha fjhljdskafh j ?</strong></p>', 2, '2023-09-19 11:14:15'),
(345, '<p><strong>Hello this the last tets from hdg skmshjhajhjdhjshd jshdjshdjh ?</strong></p>', 2, '2023-09-19 11:27:37'),
(346, '<p><strong>test for images validations and alsso for wuery params ~~</strong></p>', 2, '2023-09-19 12:05:46'),
(347, '<p><strong>test post ~~~~</strong></p>', 2, '2023-09-19 12:12:05'),
(348, '<h4>Test Add Qcm Question ~~~~~~</h4>', 1, '2023-09-19 12:32:29'),
(349, '<p><strong>asdafdsfddsfadsfdasf</strong></p>', 1, '2023-09-19 12:33:33'),
(350, '<p><strong>sdahfjkdshfjh asdf</strong></p><p><strong>dsalkfhkdjsahf sdaf</strong></p>', 1, '2023-09-19 12:50:56'),
(351, '<p><strong>test not inlin ejhsdafjkhsdafj hdsjafhjkdshf</strong></p>', 1, '2023-09-19 12:51:49');

-- --------------------------------------------------------

--
-- Structure de la table `questionoption`
--

CREATE TABLE `questionoption` (
  `id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `question_text` text DEFAULT NULL,
  `isTrue` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `questionoption`
--

INSERT INTO `questionoption` (`id`, `question_id`, `question_text`, `isTrue`) VALUES
(206, 267, 'This is a first option !', 0),
(207, 267, 'chjdsah sdahfjkhds jkdasjkhkjdsa fhjkdsh afkjasdhf ', 1),
(208, 268, 'qst_option__18-8-2023_12-23-44__219459431.jpg', 0),
(209, 268, 'qst_option__18-8-2023_12-23-44__219459431.jpg', 1),
(222, 288, 'sdfajhfjkasdhfklsdah dsf', 0),
(223, 288, 'sdafkjdasklfjukosdaujf ', 1),
(230, 301, 'la;ksfjydijuysdafjiuy asduf', 0),
(231, 301, 'asdkjyfjkasdyhfj yhdsa f', 1),
(232, 302, '18_8_2023_12_18_11for_qst_option__399492063.jpg', 1),
(233, 302, 'qst_option__18-8-2023_12-23-44__219459431.jpg', 0),
(234, 304, 'ladjusfklu iukdsafu n ouj dsfj', 0),
(235, 304, 'lkxhuz vfu kjhdsfajfdajns odikjsafh', 1),
(236, 305, 'qst_option__18-8-2023_12-23-44__219459431.jpg', 1),
(237, 305, '18_8_2023_12_18_11for_qst_option__399492063.jpg', 0),
(244, 308, '1-first Option hjhaJH its true', 1),
(245, 308, '2-first Option hjhaJH its  ', 0),
(246, 308, '3-first Option hjhaJH its  ', 0),
(247, 268, '18_8_2023_12_18_11for_qst_option__399492063.jpg', 0),
(248, 268, '18_8_2023_12_18_11for_qst_option__399492063.jpg', 0),
(249, 267, 'This is a thyshusaytdui option !', 0),
(250, 267, 'This is a aioasuid jasdjkyhjsd yasuifyiuasdyfuadsyuidsfay option !', 0),
(251, 267, 'Hello sadjuasjdy iasyiasyuf  option !', 0),
(266, 319, '1695029835256-193382101.jpg', 0),
(267, 319, '1695029835257-861069165.jpg', 0),
(268, 320, 'image_for_qst_option_function toLocaleString() { [native code] }_457366800.jpg', 0),
(269, 320, 'image_for_qst_option_function toLocaleString() { [native code] }_12048788.jpg', 0),
(270, 320, 'image_for_qst_option_function toLocaleString() { [native code] }_589635542.jpg', 0),
(271, 320, 'image_for_qst_option_function toLocaleString() { [native code] }_740163941.jpg', 1),
(272, 320, 'image_for_qst_option_function toLocaleString() { [native code] }_973777585.jpg', 0),
(273, 321, 'image_for_qst_option_function toLocaleString() { [native code] }_482918875.jpg', 0),
(274, 321, 'image_for_qst_option_function toLocaleString() { [native code] }_793206558.jpg', 0),
(275, 321, 'image_for_qst_option_function toLocaleString() { [native code] }_577677319.jpg', 0),
(276, 322, 'image_for_qst_option_function toLocaleString() { [native code] }_118014618.jpg', 0),
(277, 322, 'image_for_qst_option_function toLocaleString() { [native code] }_941393387.jpg', 0),
(278, 322, 'image_for_qst_option_function toLocaleString() { [native code] }_693550495.jpg', 0),
(279, 323, 'image_for_qst_option_function toLocaleString() { [native code] }_700104689.jpg', 1),
(280, 323, 'image_for_qst_option_function toLocaleString() { [native code] }_245104231.jpg', 1),
(281, 323, 'image_for_qst_option_function toLocaleString() { [native code] }_863330975.jpg', 1),
(282, 324, 'image_for_qst_option_function toLocaleString() { [native code] }_260797998.jpg', 0),
(283, 324, 'image_for_qst_option_function toLocaleString() { [native code] }_28824886.jpg', 0),
(284, 324, 'image_for_qst_option_function toLocaleString() { [native code] }_702472444.jpg', 1),
(285, 329, 'image_for_qst_option_function toLocaleString() { [native code] }_661594664.jpg', 0),
(286, 329, 'image_for_qst_option_function toLocaleString() { [native code] }_709960252.jpg', 1),
(287, 329, 'image_for_qst_option_function toLocaleString() { [native code] }_757715918.jpg', 0),
(288, 330, 'image_for_qst_option_function toLocaleString() { [native code] }_363205229.jpg', 1),
(289, 330, 'image_for_qst_option_function toLocaleString() { [native code] }_341059302.jpg', 0),
(290, 330, 'image_for_qst_option_function toLocaleString() { [native code] }_760541364.jpg', 0),
(291, 331, 'image_for_qst_option_function toLocaleString() { [native code] }_617764119.jpg', 0),
(292, 331, 'image_for_qst_option_function toLocaleString() { [native code] }_788312873.jpg', 0),
(293, 331, 'image_for_qst_option_function toLocaleString() { [native code] }_694754946.jpg', 1),
(294, 332, 'for_qst_option_function toLocaleString() { [native code] }_444037788.jpg', 0),
(295, 332, 'for_qst_option_function toLocaleString() { [native code] }_848647728.jpg', 0),
(296, 332, 'for_qst_option_function toLocaleString() { [native code] }_654434330.jpg', 0),
(297, 336, 'for_qst_option__936064634.jpg', 0),
(298, 336, 'for_qst_option__637004050.jpg', 0),
(299, 336, 'for_qst_option__33629931.jpg', 0),
(300, 339, '18_8_2023_12_18_11for_qst_option__786294734.jpg', 0),
(301, 339, '18_8_2023_12_18_11for_qst_option__399492063.jpg', 0),
(302, 339, '18_8_2023_12_18_11for_qst_option__951574369.jpg', 0),
(303, 340, '18-8-2023_12-19-19qst_option_18-8-2023_12-19-19_469656198.jpg', 0),
(304, 340, '18-8-2023_12-19-19qst_option_18-8-2023_12-19-19_423860792.jpg', 0),
(305, 340, '18-8-2023_12-19-19qst_option_18-8-2023_12-19-19_111691523.jpg', 0),
(306, 341, 'qst_option__18-8-2023_12-20-0_590645323.jpg', 0),
(307, 341, 'qst_option__18-8-2023_12-20-0_974409296.jpg', 0),
(308, 341, 'qst_option__18-8-2023_12-20-0_375460989.jpg', 0),
(309, 342, 'qst_option__18-8-2023_12-20-38__478011420.jpg', 0),
(310, 342, 'qst_option__18-8-2023_12-20-38__698176283.jpg', 0),
(311, 342, 'qst_option__18-8-2023_12-20-38__930145142.jpg', 0),
(312, 343, 'qst_option__18-8-2023_12-23-44__347861594.jpg', 0),
(313, 343, 'qst_option__18-8-2023_12-23-44__215266550.jpg', 0),
(314, 343, 'qst_option__18-8-2023_12-23-44__393900492.jpg', 0),
(315, 343, 'qst_option__18-8-2023_12-23-44__219459431.jpg', 1),
(316, 343, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0),
(317, 343, 'qst_option__18-8-2023_12-23-44__175715442.jpg', 0),
(318, 344, 'qst_option__19-8-2023_11-14-15__577703764.jpg', 0),
(319, 344, 'qst_option__19-8-2023_11-14-15__79463093.jpg', 0),
(320, 344, 'qst_option__19-8-2023_11-14-15__228105252.jpg', 0),
(321, 345, 'qst_option__19-8-2023_11-27-37__322769153.jpg', 0),
(322, 345, 'qst_option__19-8-2023_11-27-37__523200814.jpg', 0),
(323, 345, 'qst_option__19-8-2023_11-27-37__371580902.jpg', 0),
(324, 346, 'qst_option__19-8-2023_12-5-46__17307198.jpg', 1),
(325, 346, 'qst_option__19-8-2023_12-5-46__353949019.jpg', 0),
(326, 346, 'qst_option__19-8-2023_12-5-46__797642122.jpg', 0),
(327, 347, 'qst_option__19-8-2023_12-12-5__33520977.jpg', 1),
(328, 347, 'qst_option__19-8-2023_12-12-5__355735425.jpg', 0),
(329, 348, '<p>first option ~~~~~~~~</p>', 0),
(330, 348, '<p>seconde option ~~~~~~~~</p>', 1),
(331, 348, '<p>third option ~~~~~~~~</p>', 0),
(332, 349, '<p><i>sdfsdfsd</i></p>', 0),
(333, 349, '<i>dsfsdfsdf</i>', 1),
(334, 351, '<p>dsafhdjsdfgdsgsdfgfdsghdsfgh</p><p>fdsgdfsghsdfhdfshsdgh</p><p>sdfhgfdshdfhdg</p>', 1),
(335, 351, '<p><p>sdfgdsgsdfgfdsghdsfgh</p><p>fdsgdfsghsdfhdfshsdgh</p><p>sdfhgfdshdfhdg</p><p>', 0);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `fullName`, `email`, `password`, `isAdmin`) VALUES
(1, 'HADDAD MOHAMMED', 'haddad@gmail.com', '123', 1),
(15, 'ibtissam ibtissame', 'ibtissamtrs@gamil.com', '123654', 0),
(17, 'fer fer', 'fff@gmail', 'dedd', 0),
(18, 'sara sara', 'sara@gmail.com', '159263', 0),
(19, 'name name N ', 'nameN@gmail.com', '748159263', 0),
(25, 'post post', 'post@gmail.com', '12345678qQ', 0);

-- --------------------------------------------------------

--
-- Structure de la table `useranswear`
--

CREATE TABLE `useranswear` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `userAnsweartext` text DEFAULT NULL,
  `isTrue` tinyint(1) DEFAULT NULL,
  `QuestionOption_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `exam`
--
ALTER TABLE `exam`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `exam_question`
--
ALTER TABLE `exam_question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_qst_id` (`question_id`),
  ADD KEY `fk_exmn_id` (`exam_id`);

--
-- Index pour la table `exam_user`
--
ALTER TABLE `exam_user`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `exam_id` (`exam_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `questionoption`
--
ALTER TABLE `questionoption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_question_id` (`question_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `useranswear`
--
ALTER TABLE `useranswear`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `fk_QuestionOption_id` (`QuestionOption_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `exam`
--
ALTER TABLE `exam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT pour la table `exam_question`
--
ALTER TABLE `exam_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT pour la table `exam_user`
--
ALTER TABLE `exam_user`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `question`
--
ALTER TABLE `question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=352;

--
-- AUTO_INCREMENT pour la table `questionoption`
--
ALTER TABLE `questionoption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=336;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `useranswear`
--
ALTER TABLE `useranswear`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `exam_question`
--
ALTER TABLE `exam_question`
  ADD CONSTRAINT `fk_qst_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  ADD CONSTRAINT `fk_tst_id` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`);

--
-- Contraintes pour la table `exam_user`
--
ALTER TABLE `exam_user`
  ADD CONSTRAINT `exam_user_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  ADD CONSTRAINT `exam_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `questionoption`
--
ALTER TABLE `questionoption`
  ADD CONSTRAINT `fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE SET NULL;

--
-- Contraintes pour la table `useranswear`
--
ALTER TABLE `useranswear`
  ADD CONSTRAINT `UserAnswear_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `UserAnswear_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  ADD CONSTRAINT `fk_QuestionOption_id` FOREIGN KEY (`QuestionOption_id`) REFERENCES `questionoption` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
