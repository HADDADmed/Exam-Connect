-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 03 oct. 2023 à 12:56
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.2.0

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
  `duration_minutes` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `exam`
--

INSERT INTO `exam` (`id`, `ExamTitle`, `questionsCount`, `startTime`, `endTime`, `duration_minutes`, `createdAt`) VALUES
(32, 'Test exam ', 6, '2023-09-28T22:28', '2023-09-19T22:28', 5, '2023-09-25 22:28:39'),
(33, 'test', 8, '2023-09-18T21:08', '2023-09-29T21:08', 5, '2023-09-26 21:09:07'),
(34, 'test ggg', 6, '2023-09-14T21:15', '2023-09-11T21:15', 30, '2023-09-26 21:15:28'),
(35, 'Test Exam', 7, '2023-09-30T21:24', '2023-09-21T21:24', 10, '2023-09-26 21:25:31'),
(36, 'djkkf', 6, NULL, NULL, 5, '2023-09-28 20:30:52'),
(37, 'Exam test ', 8, NULL, NULL, 10, '2023-09-28 20:36:36'),
(38, 'Exam Test For mailers ', 30, NULL, NULL, 60, '2023-09-28 21:59:44'),
(39, 'Exam 123 Test ', 30, NULL, NULL, 5, '2023-09-28 22:18:44'),
(40, 'test Exam ', 13, NULL, NULL, 10, '2023-09-29 22:05:08'),
(41, 'Test Exam For Beginers ', 15, NULL, NULL, 10, '2023-09-30 10:33:58'),
(42, 'test Alpha ', 7, NULL, NULL, 12, '2023-09-30 16:24:57'),
(43, 'Test Exam For Messi ', 16, NULL, NULL, 5, '2023-09-30 23:32:04'),
(44, 'Test Test For Ronaldo ', 10, NULL, NULL, 5, '2023-10-01 12:55:03'),
(45, 'Test for ziad ', 10, NULL, NULL, 11, '2023-10-02 11:30:03'),
(46, 'Ouail', 12, NULL, NULL, 11, '2023-10-02 12:23:12'),
(47, 'Exam For Bilal ', 10, NULL, NULL, 10, '2023-10-03 10:53:45'),
(48, 'bakr', 10, NULL, NULL, 5, '2023-10-03 11:02:10');

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
(302, 3, 32),
(303, 27, 32),
(304, 32, 32),
(305, 31, 32),
(306, 51, 32),
(307, 46, 32),
(308, 3, 33),
(309, 25, 33),
(310, 17, 33),
(311, 27, 33),
(312, 31, 33),
(313, 41, 33),
(314, 52, 33),
(315, 47, 33),
(316, 23, 34),
(317, 3, 34),
(318, 34, 34),
(319, 36, 34),
(320, 51, 34),
(321, 55, 34),
(322, 20, 35),
(323, 10, 35),
(324, 59, 35),
(325, 39, 35),
(326, 51, 35),
(327, 50, 35),
(328, 52, 35),
(329, 16, 36),
(330, 7, 36),
(331, 33, 36),
(332, 43, 36),
(333, 49, 36),
(334, 75, 36),
(335, 3, 37),
(336, 15, 37),
(337, 26, 37),
(338, 57, 37),
(339, 33, 37),
(340, 44, 37),
(341, 55, 37),
(342, 47, 37),
(343, 26, 38),
(344, 24, 38),
(345, 28, 38),
(346, 22, 38),
(347, 29, 38),
(348, 6, 38),
(349, 13, 38),
(350, 5, 38),
(351, 58, 38),
(352, 18, 38),
(353, 43, 38),
(354, 39, 38),
(355, 45, 38),
(356, 34, 38),
(357, 42, 38),
(358, 35, 38),
(359, 36, 38),
(360, 41, 38),
(361, 31, 38),
(362, 32, 38),
(363, 48, 38),
(364, 52, 38),
(365, 76, 38),
(366, 46, 38),
(367, 50, 38),
(368, 55, 38),
(369, 49, 38),
(370, 47, 38),
(371, 75, 38),
(372, 51, 38),
(373, 58, 39),
(374, 13, 39),
(375, 25, 39),
(376, 29, 39),
(377, 5, 39),
(378, 28, 39),
(379, 4, 39),
(380, 57, 39),
(381, 27, 39),
(382, 56, 39),
(383, 37, 39),
(384, 45, 39),
(385, 35, 39),
(386, 40, 39),
(387, 36, 39),
(388, 43, 39),
(389, 32, 39),
(390, 42, 39),
(391, 33, 39),
(392, 81, 39),
(393, 48, 39),
(394, 55, 39),
(395, 49, 39),
(396, 76, 39),
(397, 51, 39),
(398, 46, 39),
(399, 52, 39),
(400, 47, 39),
(401, 50, 39),
(402, 75, 39),
(403, 23, 40),
(404, 5, 40),
(405, 27, 40),
(406, 16, 40),
(407, 10, 40),
(408, 6, 40),
(409, 40, 40),
(410, 45, 40),
(411, 81, 40),
(412, 32, 40),
(413, 51, 40),
(414, 49, 40),
(415, 48, 40),
(416, 15, 41),
(417, 23, 41),
(418, 10, 41),
(419, 26, 41),
(420, 14, 41),
(421, 33, 41),
(422, 37, 41),
(423, 40, 41),
(424, 34, 41),
(425, 31, 41),
(426, 50, 41),
(427, 52, 41),
(428, 47, 41),
(429, 48, 41),
(430, 76, 41),
(431, 3, 42),
(432, 22, 42),
(433, 26, 42),
(434, 25, 42),
(435, 31, 42),
(436, 42, 42),
(437, 37, 42),
(438, 17, 43),
(439, 28, 43),
(440, 14, 43),
(441, 18, 43),
(442, 36, 43),
(443, 41, 43),
(444, 45, 43),
(445, 42, 43),
(446, 37, 43),
(447, 81, 43),
(448, 44, 43),
(449, 40, 43),
(450, 39, 43),
(451, 51, 43),
(452, 49, 43),
(453, 76, 43),
(454, 23, 44),
(455, 20, 44),
(456, 11, 44),
(457, 25, 44),
(458, 81, 44),
(459, 34, 44),
(460, 44, 44),
(461, 55, 44),
(462, 46, 44),
(463, 52, 44),
(464, 15, 45),
(465, 57, 45),
(466, 20, 45),
(467, 8, 45),
(468, 18, 45),
(469, 56, 45),
(470, 23, 45),
(471, 11, 45),
(472, 26, 45),
(473, 28, 45),
(474, 23, 46),
(475, 29, 46),
(476, 15, 46),
(477, 18, 46),
(478, 20, 46),
(479, 8, 46),
(480, 58, 46),
(481, 42, 46),
(482, 38, 46),
(483, 39, 46),
(484, 47, 46),
(485, 75, 46),
(486, 27, 47),
(487, 58, 47),
(488, 23, 47),
(489, 57, 47),
(490, 17, 47),
(491, 26, 47),
(492, 3, 47),
(493, 8, 47),
(494, 11, 47),
(495, 16, 47),
(496, 29, 48),
(497, 3, 48),
(498, 56, 48),
(499, 59, 48),
(500, 5, 48),
(501, 25, 48),
(502, 11, 48),
(503, 58, 48),
(504, 22, 48),
(505, 28, 48);

-- --------------------------------------------------------

--
-- Structure de la table `exam_status`
--

CREATE TABLE `exam_status` (
  `id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `exam_status`
--

INSERT INTO `exam_status` (`id`, `status`, `description`) VALUES
(1, 'notStarted', 'The exam has not yet started. User have not initiated the exam.'),
(2, 'inProgress', 'The exam is currently in progress. User is actively answering questions.'),
(3, 'pendingReview', 'The exam is pending review. It has been completed by the User and is awaiting evaluation.'),
(4, 'failed', 'The exam has been failed. The user did not meet the passing criteria.'),
(5, 'passed', 'The exam has been passed. The user successfully met the passing criteria.');

-- --------------------------------------------------------

--
-- Structure de la table `exam_user`
--

CREATE TABLE `exam_user` (
  `id` int(11) NOT NULL,
  `exam_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT current_timestamp(),
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `exam_user`
--

INSERT INTO `exam_user` (`id`, `exam_id`, `user_id`, `createdAt`, `status`) VALUES
(20, 32, 27, '2023-09-25 22:28:39', 'passed'),
(21, 33, 27, '2023-09-26 21:09:07', 'passed'),
(22, 33, 29, '2023-09-26 21:09:07', 'notStarted'),
(23, 34, 27, '2023-09-26 21:15:28', 'passed'),
(24, 34, 29, '2023-09-26 21:15:28', 'notStarted'),
(25, 35, 27, '2023-09-26 21:25:31', 'failed'),
(26, 35, 31, '2023-09-26 21:25:31', 'notStarted'),
(27, 36, 27, '2023-09-28 20:30:52', 'notStarted'),
(28, 36, 28, '2023-09-28 20:30:52', 'notStarted'),
(29, 37, 27, '2023-09-28 20:36:36', 'failed'),
(30, 37, 29, '2023-09-28 20:36:36', 'notStarted'),
(31, 37, 32, '2023-09-28 20:36:36', 'notStarted'),
(32, 38, 27, '2023-09-28 21:59:44', 'inProgress'),
(33, 39, 27, '2023-09-28 22:18:44', 'passed'),
(34, 40, 27, '2023-09-29 22:05:08', 'failed'),
(35, 40, 30, '2023-09-29 22:05:08', 'notStarted'),
(36, 40, 29, '2023-09-29 22:05:08', 'notStarted'),
(37, 40, 28, '2023-09-29 22:05:08', 'notStarted'),
(38, 40, 31, '2023-09-29 22:05:08', 'notStarted'),
(39, 41, 27, '2023-09-30 10:33:59', 'passed'),
(40, 42, 27, '2023-09-30 16:24:57', 'notStarted'),
(41, 43, 27, '2023-09-30 23:32:04', 'passed'),
(42, 44, 27, '2023-10-01 12:55:03', 'pendingReview'),
(43, 45, 27, '2023-10-02 11:30:03', 'passed'),
(44, 46, 27, '2023-10-02 12:23:12', 'failed'),
(45, 46, 28, '2023-10-02 12:23:12', 'notStarted'),
(46, 47, 42, '2023-10-03 10:53:45', 'passed'),
(47, 48, 27, '2023-10-03 11:02:10', 'passed');

-- --------------------------------------------------------

--
-- Structure de la table `exam_user_status`
--

CREATE TABLE `exam_user_status` (
  `id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `exam_user_id` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `exam_user_status`
--

INSERT INTO `exam_user_status` (`id`, `status_id`, `exam_user_id`, `createdAt`) VALUES
(75, 1, 20, '2023-09-25 22:28:39'),
(76, 2, 20, '2023-09-25 22:30:29'),
(77, 3, 20, '2023-09-25 22:30:46'),
(78, 5, 20, '2023-09-25 22:33:19'),
(79, 1, 21, '2023-09-26 21:09:07'),
(80, 1, 22, '2023-09-26 21:09:07'),
(81, 2, 21, '2023-09-26 21:09:46'),
(82, 3, 21, '2023-09-26 21:11:09'),
(83, 5, 21, '2023-09-26 21:12:12'),
(84, 1, 23, '2023-09-26 21:15:28'),
(85, 1, 24, '2023-09-26 21:15:28'),
(86, 2, 23, '2023-09-26 21:16:22'),
(87, 3, 23, '2023-09-26 21:17:22'),
(88, 5, 23, '2023-09-26 21:18:43'),
(89, 1, 25, '2023-09-26 21:25:31'),
(90, 1, 26, '2023-09-26 21:25:31'),
(91, 2, 25, '2023-09-26 21:26:31'),
(92, 3, 25, '2023-09-26 21:27:29'),
(93, 1, 27, '2023-09-28 20:30:52'),
(94, 1, 28, '2023-09-28 20:30:52'),
(95, 1, 29, '2023-09-28 20:36:36'),
(96, 1, 30, '2023-09-28 20:36:36'),
(97, 1, 31, '2023-09-28 20:36:36'),
(98, 2, 29, '2023-09-28 20:39:58'),
(99, 3, 29, '2023-09-28 20:42:02'),
(100, 4, 29, '2023-09-28 20:42:51'),
(101, 4, 25, '2023-09-28 21:57:21'),
(102, 1, 32, '2023-09-28 21:59:44'),
(103, 2, 32, '2023-09-28 22:05:10'),
(104, 1, 33, '2023-09-28 22:18:44'),
(105, 2, 33, '2023-09-28 22:19:15'),
(106, 3, 33, '2023-09-28 22:21:03'),
(107, 5, 33, '2023-09-28 22:23:01'),
(108, 1, 34, '2023-09-29 22:05:08'),
(109, 1, 35, '2023-09-29 22:05:08'),
(110, 1, 36, '2023-09-29 22:05:08'),
(111, 1, 37, '2023-09-29 22:05:08'),
(112, 1, 38, '2023-09-29 22:05:08'),
(113, 2, 34, '2023-09-29 22:07:12'),
(114, 3, 34, '2023-09-29 22:08:07'),
(115, 4, 34, '2023-09-29 22:09:53'),
(116, 1, 39, '2023-09-30 10:33:59'),
(117, 2, 39, '2023-09-30 10:34:34'),
(118, 3, 39, '2023-09-30 10:37:14'),
(119, 5, 39, '2023-09-30 10:38:05'),
(120, 1, 40, '2023-09-30 16:24:57'),
(121, 1, 41, '2023-09-30 23:32:04'),
(122, 2, 41, '2023-09-30 23:48:41'),
(123, 3, 41, '2023-09-30 23:49:48'),
(124, 5, 41, '2023-09-30 23:52:35'),
(125, 1, 42, '2023-10-01 12:55:03'),
(126, 2, 42, '2023-10-02 11:10:20'),
(127, 3, 42, '2023-10-02 11:12:54'),
(128, 1, 43, '2023-10-02 11:30:03'),
(129, 2, 43, '2023-10-02 12:12:51'),
(130, 3, 43, '2023-10-02 12:15:22'),
(131, 5, 43, '2023-10-02 12:15:37'),
(132, 1, 44, '2023-10-02 12:23:12'),
(133, 1, 45, '2023-10-02 12:23:12'),
(134, 2, 44, '2023-10-02 12:25:34'),
(135, 3, 44, '2023-10-02 12:26:12'),
(136, 4, 44, '2023-10-02 12:26:59'),
(137, 1, 46, '2023-10-03 10:53:45'),
(138, 2, 46, '2023-10-03 10:55:18'),
(139, 3, 46, '2023-10-03 10:58:44'),
(140, 5, 46, '2023-10-03 10:59:08'),
(141, 1, 47, '2023-10-03 11:02:10'),
(142, 2, 47, '2023-10-03 11:03:13'),
(143, 3, 47, '2023-10-03 11:05:10'),
(144, 5, 47, '2023-10-03 11:05:20');

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
(3, '<h2><strong>What does CSS stand for?</strong></h2>', 1, '2023-09-18 10:20:00'),
(4, '<p><strong>What is the purpose of the \"alt\" attribute in an HTML image tag?</strong></p>', 1, '2023-09-18 10:30:00'),
(5, '<h2><strong>Which CSS property is used to change the text color?</strong></h2>', 1, '2023-09-18 10:40:00'),
(6, '<p><strong>What is JavaScript primarily used for in web development?</strong></p>', 1, '2023-09-18 10:50:00'),
(7, '<h2><strong>What does SEO stand for in web development?</strong></h2>', 1, '2023-09-18 11:00:00'),
(8, '<p><strong>Which programming language is commonly used for back-end web development?</strong></p>', 1, '2023-09-18 11:10:00'),
(9, '<h2><strong>What is the purpose of the \"SMTP\" protocol in email marketing?</strong></h2>', 1, '2023-09-18 11:20:00'),
(10, '<p><strong>Explain the concept of \"responsive web design\" and its benefits.</strong></p>', 1, '2023-09-18 11:30:00'),
(11, '<h2><strong>What is the primary purpose of HTML in web development?</strong></h2>', 1, '2023-09-18 16:00:00'),
(13, '<h2><strong>What does CSS stand for in styling web pages?</strong></h2>', 1, '2023-09-18 16:20:00'),
(14, '<p><strong>Which CSS property is used for adjusting the spacing between letters in text?</strong></p>', 1, '2023-09-18 16:30:00'),
(15, '<h2><strong>What is the purpose of JavaScript in web development?</strong></h2>', 1, '2023-09-18 16:40:00'),
(16, '<p><strong>What does SEO stand for in the context of online visibility?</strong></p>', 1, '2023-09-18 16:50:00'),
(17, '<h2><strong>Which programming language is primarily used for building interactive web applications?</strong></h2>', 1, '2023-09-18 17:00:00'),
(18, '<p><strong>What is the function of the \"src\" attribute in an HTML <img> tag?</strong></p>', 1, '2023-09-18 17:10:00'),
(20, '<p><strong>What is the default value of the \"display\" property in CSS for most HTML elements?</strong></p>', 1, '2023-09-18 17:30:00'),
(22, '<p><strong>What does CSS provide in web development to enhance the layout of web pages?</strong></p>', 1, '2023-09-18 18:10:00'),
(23, '<h2><strong>What is the purpose of JavaScript functions in coding?</strong></h2>', 1, '2023-09-18 18:20:00'),
(24, '<p><strong>Which CSS property is used for controlling the size of an element s box?</strong></p>', 1, '2023-09-18 18:30:00'),
(25, '<h2><strong>What is the primary function of search engines in online marketing?</strong></h2>', 1, '2023-09-18 18:40:00'),
(26, '<p><strong>What is the role of a web server in server-side web development?</strong></p>', 1, '2023-09-18 18:50:00'),
(27, '<h2><strong>Which programming language is commonly used for building responsive web applications?</strong></h2>', 1, '2023-09-18 19:00:00'),
(28, '<p><strong>What does the \"href\" attribute define in an HTML <a> tag?</strong></p>', 1, '2023-09-18 19:10:00'),
(29, '<h2><strong>What is the purpose of the \"DOCTYPE\" declaration in HTML documents?</strong></h2>', 1, '2023-09-18 19:20:00'),
(31, '<h2><strong>Calculate the Area of a Circle</strong></h2><p>Write a function that calculates the area of a circle given its radius.</p><h4><strong>Instructions :</strong></h4><ul><li>Use the formula: Area = π * (radius * radius)</li><li>Return the calculated area.</li></ul>', 0, '2023-09-18 20:00:00'),
(32, '<h2><strong>Find the Sum of Even Numbers</strong></h2><p>Write a function that finds the sum of all even numbers in an array.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the array and add even numbers to the sum.</li><li>Return the total sum.</li></ul>', 0, '2023-09-18 20:10:00'),
(33, '<h2><strong>Reverse a String</strong></h2><p>Write a function that reverses a given string.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the string and build a reversed version of it.</li><li>Return the reversed string.</li></ul>', 0, '2023-09-18 20:20:00'),
(34, '<h2><strong>Calculate the Factorial of a Number</strong></h2><p>Write a function that calculates the factorial of a non-negative integer.</p><h4><strong>Instructions :</strong></h4><ul><li>Use a loop to multiply numbers from 1 to n.</li><li>Return the factorial value.</li></ul>', 0, '2023-09-18 20:30:00'),
(35, '<h2><strong>Count Vowels in a String</strong></h2><p>Write a function that counts the number of vowels in a given string.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the string and count vowels (a, e, i, o, u).</li><li>Return the count.</li></ul>', 0, '2023-09-18 20:40:00'),
(36, '<h2><strong>Find the Largest Number in an Array</strong></h2><p>Write a function that finds the largest number in an array of numbers.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the array and track the largest number.</li><li>Return the largest number found.</li></ul>', 0, '2023-09-18 20:50:00'),
(37, '<h2><strong>Check for Prime Numbers</strong></h2><p>Write a function that checks if a given number is prime or not.</p><h4><strong>Instructions :</strong></h4><ul><li>Check for divisibility by numbers up to the square root of the given number.</li><li>Return true if the number is prime, otherwise false.</li></ul>', 0, '2023-09-18 21:00:00'),
(38, '<h2><strong>Calculate the Fibonacci Sequence</strong></h2><p>Write a function that generates the Fibonacci sequence up to a specified length.</p><h4><strong>Instructions :</strong></h4><ul><li>Generate the sequence by adding the last two numbers.</li><li>Return the sequence as an array.</li></ul>', 0, '2023-09-18 21:10:00'),
(39, '<h2><strong>Find the Longest Word</strong></h2><p>Write a function that finds the longest word in a given sentence.</p><h4><strong>Instructions :</strong></h4><ul><li>Split the sentence into words and track the longest word.</li><li>Return the longest word found.</li></ul>', 0, '2023-09-18 21:20:00'),
(40, '<h2><strong>Reverse an Array</strong></h2><p>Write a function that reverses the elements of an array.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the array and reverse the order of elements.</li><li>Return the reversed array.</li></ul>', 0, '2023-09-18 21:30:00'),
(41, '<h2><strong>Calculate the Area of a Triangle</strong></h2><p>Write a function that calculates the area of a triangle given its base and height.</p><h4><strong>Instructions :</strong></h4><ul><li>Use the formula: Area = (base * height) / 2</li><li>Return the calculated area.</li></ul>', 0, '2023-09-18 21:40:00'),
(42, '<h2><strong>Count the Occurrences of a Character</strong></h2><p>Write a function that counts the occurrences of a specific character in a string.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the string and count the occurrences of the character.</li><li>Return the count.</li></ul>', 0, '2023-09-18 21:50:00'),
(43, '<h2><strong>Find the Median of an Array</strong></h2><p>Write a function that finds the median value of a sorted array.</p><h4><strong>Instructions :</strong></h4><ul><li>Determine if the array has an odd or even number of elements and find the median accordingly.</li><li>Return the median value.</li></ul>', 0, '2023-09-18 22:00:00'),
(44, '<h2><strong>Check for Palindromes</strong></h2><p>Write a function that checks if a given string is a palindrome (reads the same forwards and backwards).</p><h4><strong>Instructions :</strong></h4><ul><li>Remove non-alphanumeric characters and convert to lowercase for comparison.</li><li>Return true if the string is a palindrome, otherwise false.</li></ul>', 0, '2023-09-18 22:10:00'),
(45, '<h2><strong>Calculate the Square Root</strong></h2><p>Write a function that calculates the square root of a positive number.</p><h4><strong>Instructions :</strong></h4><ul><li>Use an iterative method or a built-in function to calculate the square root.</li><li>Return the square root value.</li></ul>', 0, '2023-09-18 22:20:00'),
(46, '<h2><strong>Choose the Correct Programming Language Logo:</strong></h2><p>Select the image that shows the Python programming language logo.</p>', 2, '2023-09-19 10:00:00'),
(47, '<h2><strong>Identify the Correct Computer Component:</strong></h2><p>Choose the image that represents a graphics card (GPU).</p>', 2, '2023-09-19 10:10:00'),
(48, '<h2><strong>Pick the Correct Code Snippet:</strong></h2><p>Select the image that shows a code snippet written in the Python programming language.</p>', 2, '2023-09-19 10:20:00'),
(49, '<h2><strong>Identify the Correct Database Management System Logo:</strong></h2><p>Choose the image that shows the MySQL database management system logo.</p>', 2, '2023-09-19 10:30:00'),
(50, '<h2><strong>Pick the Correct Web Development Framework Logo:</strong></h2><p>Select the image that shows the React.js web development framework logo.</p>', 2, '2023-09-19 10:40:00'),
(51, '<h2><strong>Identify the Correct Networking Device:</strong></h2><p>Choose the image that represents a router.</p>', 2, '2023-09-19 10:50:00'),
(52, '<h2><strong>Pick the Correct Cloud Computing Service Logo:</strong></h2><p>Select the image that shows the Amazon Web Services (AWS) logo.</p>', 2, '2023-09-19 11:00:00'),
(55, '<h2><strong>Pick the Correct Software Development Methodology:</strong></h2><p>Select the image that represents the Agile software development methodology.</p>', 2, '2023-09-19 11:30:00'),
(56, '<h3><strong>Which HTML tag is used to create a hyperlink?</strong></h3>', 1, '2023-09-19 18:39:16'),
(57, '<h3><strong>Which HTML tag is used for creating a form in web development?</strong></h3>', 1, '2023-09-19 18:41:55'),
(58, '<h3><strong>Which HTML tag is used for creating a table in a web page?</strong></h3><p><br>&nbsp;</p>', 1, '2023-09-19 18:43:15'),
(59, '<h3>Which HTML tag is used to create an unordered list?</h3>', 1, '2023-09-19 18:44:11'),
(75, '<p>dfwadfe</p>', 2, '2023-09-28 20:29:45'),
(76, '<p>Question 1 ??</p>', 2, '2023-09-28 20:35:19'),
(81, '<p>klsjfakljdsaklfjlkasd ?</p>', 0, '2023-09-28 22:16:06'),
(83, '<h3><i><strong>Test dioqsudoiq d?</strong></i></h3><p><i><strong>jvjydycud</strong></i></p>', 2, '2023-10-02 12:19:59');

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
(1, 46, 'qst_option__19-8-2023_12-12-5__355735425.jpg', 1),
(2, 46, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0),
(3, 46, 'qst_option__19-8-2023_12-5-46__797642122.jpg', 0),
(4, 47, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 1),
(5, 47, 'qst_option__18-8-2023_12-20-0_590645323.jpg', 0),
(6, 47, 'qst_option__18-8-2023_12-20-38__698176283.jpg', 0),
(7, 48, 'qst_option__18-8-2023_12-20-0_590645323.jpg', 1),
(8, 48, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0),
(9, 48, 'qst_option__18-8-2023_12-20-38__698176283.jpg', 0),
(10, 49, 'qst_option__18-8-2023_12-20-38__698176283.jpg', 1),
(11, 49, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0),
(12, 49, 'qst_option__18-8-2023_12-20-0_590645323.jpg', 0),
(13, 50, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 1),
(14, 50, 'qst_option__18-8-2023_12-20-0_590645323.jpg', 0),
(15, 50, 'qst_option__18-8-2023_12-20-0_590645323.jpg', 0),
(16, 52, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 1),
(17, 52, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0),
(18, 52, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0),
(25, 55, 'qst_option__18-8-2023_12-20-38__698176283.jpg', 1),
(26, 55, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0),
(27, 55, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0),
(36, 3, 'Cascading Style Sheets', 1),
(37, 3, 'Computer Style System', 0),
(38, 3, 'Creative Style Sheet', 0),
(39, 3, 'Custom Style System', 0),
(40, 4, 'It defines the alternative text for an image.', 1),
(41, 4, 'It sets the image\'s background color.', 0),
(42, 4, 'It specifies the image\'s alignment.', 0),
(43, 4, 'It controls the image\'s width and height.', 0),
(44, 5, 'text-color', 0),
(45, 5, 'color', 1),
(46, 5, 'text-style', 0),
(47, 5, 'font-color', 0),
(48, 6, 'Creating database tables', 0),
(49, 6, 'Styling web pages', 0),
(50, 6, 'Adding interactivity to websites', 1),
(51, 6, 'Sending emails', 0),
(52, 7, 'Search Engine Optimization', 1),
(53, 7, 'Social Engagement Optimization', 0),
(54, 7, 'Software Engineering Online', 0),
(55, 7, 'Secure E-commerce Operations', 0),
(56, 8, 'HTML', 0),
(57, 8, 'CSS', 0),
(58, 8, 'JavaScript', 0),
(59, 8, 'Python', 1),
(60, 9, 'Simple Mail Transfer Protocol (SMTP) is used for sending emails.', 1),
(61, 9, 'SMTP is used to receive emails.', 0),
(62, 9, 'SMTP is used to format web pages.', 0),
(63, 9, 'SMTP is used to create databases.', 0),
(64, 10, 'Responsive web design ensures that websites always have the same layout.', 0),
(65, 10, 'Responsive web design means making websites look exactly the same on all devices.', 0),
(66, 10, 'Responsive web design adapts web page layouts for different screen sizes, improving user experience.', 1),
(67, 10, 'Responsive web design only works on desktop computers.', 0),
(68, 11, 'To structure the content and layout of web pages.', 1),
(69, 11, 'To create interactive web applications.', 0),
(70, 11, 'To define the visual styling of web pages.', 0),
(71, 11, 'To manage server-side data storage.', 0),
(76, 13, 'Cascading Style Sheets', 1),
(77, 13, 'Computer Style System', 0),
(78, 13, 'Creative Style Sheet', 0),
(79, 13, 'Custom Style System', 0),
(80, 14, 'letter-spacing', 1),
(81, 14, 'word-spacing', 0),
(82, 14, 'line-height', 0),
(83, 14, 'text-align', 0),
(84, 15, 'To add interactivity and functionality to web pages.', 1),
(85, 15, 'To define the visual style of web pages.', 0),
(86, 15, 'To store data on the server.', 0),
(87, 15, 'To send emails to users.', 0),
(88, 16, 'Search Engine Optimization', 1),
(89, 16, 'Social Engagement Optimization', 0),
(90, 16, 'Software Engineering Online', 0),
(91, 16, 'Secure E-commerce Operations', 0),
(92, 17, 'JavaScript', 1),
(93, 17, 'Java', 0),
(94, 17, 'Python', 0),
(95, 17, 'C++', 0),
(96, 18, 'It specifies the source file for the image.', 1),
(97, 18, 'It sets the image\'s dimensions.', 0),
(98, 18, 'It defines the image\'s alignment.', 0),
(99, 18, 'It controls the image\'s opacity.', 0),
(104, 20, 'inline-block', 0),
(105, 20, 'block', 0),
(106, 20, 'none', 0),
(107, 20, 'inline', 1),
(112, 22, 'Layout enhancement', 0),
(113, 22, 'Content management', 0),
(114, 22, 'Styling and presentation', 1),
(115, 22, 'Server communication', 0),
(116, 23, 'To define reusable code blocks.', 0),
(117, 23, 'To declare variables.', 0),
(118, 23, 'To group code statements into a single unit.', 1),
(119, 23, 'To create random numbers.', 0),
(120, 24, 'box-sizing', 1),
(121, 24, 'box-width', 0),
(122, 24, 'box-height', 0),
(123, 24, 'box-layout', 0),
(124, 25, 'Information retrieval', 1),
(125, 25, 'Social media management', 0),
(126, 25, 'Content creation', 0),
(127, 25, 'Data storage', 0),
(128, 26, 'To handle client-side requests and responses.', 0),
(129, 26, 'To host web applications.', 0),
(130, 26, 'To process and respond to client requests.', 1),
(131, 26, 'To store user data.', 0),
(132, 27, 'JavaScript', 1),
(133, 27, 'Python', 0),
(134, 27, 'Ruby', 0),
(135, 27, 'C#', 0),
(136, 28, 'It defines the destination URL for the link.', 1),
(137, 28, 'It specifies the link type.', 0),
(138, 28, 'It sets the link `s text color.', 0),
(139, 28, 'It defines the link`s position on the page.', 0),
(140, 29, 'To specify the document type and version.', 1),
(141, 29, 'To define the background color of the page.', 0),
(142, 29, 'To set the font size for the entire document.', 0),
(143, 29, 'To control the layout of the webpage.', 0),
(148, 51, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 1),
(149, 51, 'qst_option__19-8-2023_12-5-46__17307198.jpg', 0),
(150, 56, '<p>&lt;a&gt;</p>', 1),
(151, 56, '<p>&lt;ul&gt;</p>', 0),
(152, 56, '<p>&lt;li&gt;</p>', 0),
(153, 56, '<p>&lt;form&gt;</p>', 0),
(154, 57, '<p>&lt;form&gt;</p>', 1),
(155, 57, '<p>&lt;input&gt;</p>', 0),
(156, 57, '<p>&lt;form-input&gt;</p>', 0),
(157, 57, '<p>&lt;form-class&gt;</p>', 0),
(158, 58, '<p>&lt;table&gt;</p>', 1),
(159, 58, '<p>&lt;tr&gt;</p>', 0),
(160, 58, '<p>&lt;td&gt;</p>', 0),
(161, 58, '<p>&lt;div&gt;</p>', 0),
(162, 59, '<p>&lt;ol&gt;</p>', 0),
(163, 59, '<p>&lt;ul&gt;</p>', 1),
(164, 59, '<p>&lt;li&gt;</p>', 0),
(165, 59, '<p>&lt;dl&gt;</p>', 0),
(194, 75, '419764228-28-8-2023.jpg', 1),
(195, 75, '801838575-28-8-2023.jpg', 0),
(196, 76, '611470669-28-8-2023.jpg', 1),
(197, 76, '285108320-28-8-2023.jpg', 0),
(202, 83, '437995248-2-9-2023.jpg', 0),
(203, 83, '270537061-2-9-2023.jpg', 1);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `fullName` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `fullName`, `email`, `password`, `isAdmin`, `createdAt`) VALUES
(1, 'HADDAD MOHAMMED', 'haddad@gmail.com', '123', 1, '2023-10-01 12:09:34'),
(27, 'John Doe', 'johndoe@gmail.com', '123', 0, '2023-10-01 12:09:34'),
(28, 'Jane Smith', 'janesmith@yahoo.com', '123', 0, '2023-10-01 12:09:34'),
(29, 'Michael Johnson', 'michaelj@gmail.com', '123', 0, '2023-10-01 12:09:34'),
(30, 'Emily Davis', 'emilydavis@hotmail.com', '123', 0, '2023-10-01 12:09:34'),
(31, 'William Brown', 'williambrown@gmail.com', '123', 0, '2023-10-01 12:09:34'),
(32, 'Sophia Lee', 'sophialee@gmail.com', '123', 0, '2023-10-01 12:09:34'),
(33, 'James Wilson', 'jameswilson@yahoo.com', '123', 0, '2023-10-01 12:09:34'),
(34, 'Olivia Anderson', 'oliviaa@gmail.com', '123', 0, '2023-10-01 12:09:34'),
(35, 'Benjamin Jackson', 'benjaminj@gmail.com', '123', 0, '2023-10-01 12:09:34'),
(36, 'Ava Harris', 'avaharris@hotmail.com', '123', 0, '2023-10-01 12:09:34'),
(37, 'Liam Martinez', 'liammartinez@gmail.com', '123', 0, '2023-10-01 12:09:34'),
(38, 'Mia White', 'miawhite@yahoo.com', '123', 0, '2023-10-01 12:09:34'),
(39, 'Ethan Taylor', 'ethtaylor@gmail.com', '123', 0, '2023-10-01 12:09:34'),
(40, 'Emma Lewis', 'emmalewis@gmail.com', '123', 0, '2023-10-01 12:09:34'),
(41, 'Noah Clark', 'noahclark@yahoo.com', '123', 0, '2023-10-01 12:09:34'),
(42, 'Bilal Chekhchou', 'bilal@gmail.com', '12345678qQ', 0, '2023-10-03 10:53:07');

-- --------------------------------------------------------

--
-- Structure de la table `useranswer`
--

CREATE TABLE `useranswer` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `questionOption_id` int(11) DEFAULT NULL,
  `isTrue` tinyint(1) DEFAULT NULL,
  `userAnswerText` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `useranswer`
--

INSERT INTO `useranswer` (`id`, `user_id`, `exam_id`, `question_id`, `questionOption_id`, `isTrue`, `userAnswerText`) VALUES
(146, 27, 32, 3, 36, 1, NULL),
(147, 27, 32, 32, NULL, 0, 'johndoe@gmail.com'),
(148, 27, 32, 31, NULL, 1, 'johndoe@gmail.com'),
(149, 27, 32, 46, 2, 0, NULL),
(150, 27, 32, 51, 148, 1, NULL),
(151, 27, 32, 27, 132, 1, NULL),
(152, 27, 33, 31, NULL, 0, 'http://localhost:5173/#/?exam_id_live=33'),
(153, 27, 33, 41, NULL, 1, 'http://localhost:5173/#/?exam_id_live=33'),
(154, 27, 33, 3, 36, 1, NULL),
(155, 27, 33, 25, 124, 1, NULL),
(156, 27, 33, 27, 133, 0, NULL),
(157, 27, 33, 17, 93, 0, NULL),
(158, 27, 33, 52, 16, 1, NULL),
(159, 27, 33, 47, 5, 0, NULL),
(160, 27, 32, 32, NULL, NULL, NULL),
(161, 27, 32, 27, NULL, NULL, NULL),
(162, 27, 32, 46, NULL, NULL, NULL),
(163, 27, 32, 31, NULL, NULL, NULL),
(164, 27, 32, 51, NULL, NULL, NULL),
(165, 27, 32, 3, NULL, NULL, NULL),
(166, 27, 34, 23, 116, 0, NULL),
(167, 27, 34, 34, NULL, 1, 'http://localhost:5173/#/?exam_id_live=34'),
(168, 27, 34, 36, NULL, 0, 'http://localhost:5173/#/?exam_id_live=34'),
(169, 27, 34, 3, 36, 1, NULL),
(170, 27, 34, 51, 149, 0, NULL),
(171, 27, 34, 55, 25, 1, NULL),
(172, 27, 35, 20, 104, 0, NULL),
(173, 27, 35, 10, 67, 0, NULL),
(174, 27, 35, 50, 13, 1, NULL),
(175, 27, 35, 52, 18, 0, NULL),
(176, 27, 35, 51, 149, 0, NULL),
(177, 27, 35, 59, 162, 0, NULL),
(178, 27, 35, 39, NULL, 1, 'http://localhost:5173/#/?exam_id_live=35http://localhost:5173/#/?exam_id_live=35'),
(179, 27, 37, 33, NULL, 1, 'http://localhuost:5173/#/?exam_id_live=37jhtqwyt euwtewqrytqertue wfyuewliuqf'),
(180, 27, 37, 44, NULL, 0, 'rthttp://localhost:5173/#/?exam_id_live=37jqwudyt ewtdyt'),
(181, 27, 37, 3, 36, 1, NULL),
(182, 27, 37, 15, 85, 0, NULL),
(183, 27, 37, 26, 130, 1, NULL),
(184, 27, 37, 57, 155, 0, NULL),
(185, 27, 37, 55, 27, 0, NULL),
(186, 27, 37, 47, 5, 0, NULL),
(187, 27, 39, 58, 158, 1, NULL),
(188, 27, 39, 29, 140, 1, NULL),
(189, 27, 39, 5, 44, 0, NULL),
(190, 27, 39, 13, 76, 1, NULL),
(191, 27, 39, 28, 139, 0, NULL),
(192, 27, 39, 4, 40, 1, NULL),
(193, 27, 39, 57, 154, 1, NULL),
(194, 27, 39, 37, NULL, 1, 'PrimeNumbers (){\n\n}'),
(195, 27, 39, 27, 132, 1, NULL),
(196, 27, 39, 45, NULL, 1, 'k,wjfkljwafhttp://localhost:5174/#/examconnect/?exam_id_live=39http://localhost:5174/#/examconnect/?exam_id_live=39'),
(197, 27, 39, 25, 126, 0, NULL),
(198, 27, 39, 56, 150, 1, NULL),
(199, 27, 39, 35, NULL, 1, 'qwldjoidu http://localhost:5174/#/examconnect/?exam_id_live=39'),
(200, 27, 39, 40, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=39'),
(201, 27, 39, 36, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=39http://localhost:5174/#/examconnect/?exam_id_live=39'),
(202, 27, 39, 43, NULL, 0, 'http://localhost:5174/#/examconnect/?exam_id_live=39http://localhost:5174/#/examconnect/?exam_id_live=39'),
(203, 27, 39, 32, NULL, 0, ',qwdyuiyhttp://localhost:5174/#/examconnect/?exam_id_live=39http://localhost:5174/#/examconnect/?exam_id_live=39'),
(204, 27, 39, 42, NULL, 0, 'http://localhost:5174/#/examconnect/?exam_id_live=39http://localhost:5174/#/examconnect/?exam_id_live=39http://localhost:5174/#/examconnect/?exam_id_live=39'),
(205, 27, 39, 33, NULL, 0, 'http://localhost:5174/#/examconnect/?exam_id_live=39http://localhost:5174/#/examconnect/?exam_id_live=39'),
(206, 27, 39, 81, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=39http://localhost:5174/#/examconnect/?exam_id_live=39http://localhost:5174/#/examconnect/?exam_id_live=39http://localhost:5174/#/examconnect/?exam_id_live=39'),
(207, 27, 39, 48, 7, 1, NULL),
(208, 27, 39, 55, 26, 0, NULL),
(209, 27, 39, 49, 10, 1, NULL),
(210, 27, 39, 76, 197, 0, NULL),
(211, 27, 39, 51, 148, 1, NULL),
(212, 27, 39, 46, 3, 0, NULL),
(213, 27, 39, 52, 16, 1, NULL),
(214, 27, 39, 47, 5, 0, NULL),
(215, 27, 39, 50, 13, 1, NULL),
(216, 27, 39, 75, 194, 1, NULL),
(217, 27, 40, 23, 116, 0, NULL),
(218, 27, 40, 5, 46, 0, NULL),
(219, 27, 40, 27, 135, 0, NULL),
(220, 27, 40, 16, 91, 0, NULL),
(221, 27, 40, 10, 67, 0, NULL),
(222, 27, 40, 6, 48, 0, NULL),
(223, 27, 40, 40, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=40http://localhost:5174/#/examconnect/?exam_id_live=40'),
(224, 27, 40, 45, NULL, 0, 'http://localhost:5174/#/examconnect/?exam_id_live=40http://localhost:5174/#/examconnect/?exam_id_live=40'),
(225, 27, 40, 81, NULL, 0, 'http://localhost:5174/#/examconnect/?exam_id_live=40http://localhost:5174/#/examconnect/?exam_id_live=40http://localhost:5174/#/examconnect/?exam_id_live=40'),
(226, 27, 40, 32, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=40http://localhost:5174/#/examconnect/?exam_id_live=40'),
(227, 27, 40, 51, 149, 0, NULL),
(228, 27, 40, 49, 10, 1, NULL),
(229, 27, 40, 48, 7, 1, NULL),
(230, 27, 41, 33, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=41http://localhost:5174/#/examconnect/?exam_id_live=41http://localhost:5174/#/examconnect/?exam_id_live=41'),
(231, 27, 41, 37, NULL, 0, 'http://localhost:5174/#/examconnect/?exam_id_live=41http://localhost:5174/#/examconnect/?exam_id_live=41http://localhost:5174/#/examconnect/?exam_id_live=41'),
(232, 27, 41, 40, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=41http://localhost:5174/#/examconnect/?exam_id_live=41'),
(233, 27, 41, 15, 84, 1, NULL),
(234, 27, 41, 14, 82, 0, NULL),
(235, 27, 41, 23, 118, 1, NULL),
(236, 27, 41, 34, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=41http://localhost:5174/#/examconnect/?exam_id_live=41'),
(237, 27, 41, 31, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=41http://localhost:5174/#/examconnect/?exam_id_live=41http://localhost:5174/#/examconnect/?exam_id_live=41'),
(238, 27, 41, 50, 13, 1, NULL),
(239, 27, 41, 10, 65, 0, NULL),
(240, 27, 41, 26, 129, 0, NULL),
(241, 27, 41, 52, 17, 0, NULL),
(242, 27, 41, 47, 5, 0, NULL),
(243, 27, 41, 48, 8, 0, NULL),
(244, 27, 41, 76, 196, 1, NULL),
(245, 27, 43, 45, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43'),
(246, 27, 43, 42, NULL, 0, 'http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43'),
(247, 27, 43, 41, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43'),
(248, 27, 43, 37, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43'),
(249, 27, 43, 17, 92, 1, NULL),
(250, 27, 43, 28, 136, 1, NULL),
(251, 27, 43, 81, NULL, 0, 'http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43'),
(252, 27, 43, 44, NULL, 0, 'http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43'),
(253, 27, 43, 40, NULL, 0, 'http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43'),
(254, 27, 43, 14, 81, 0, NULL),
(255, 27, 43, 36, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43'),
(256, 27, 43, 39, NULL, 1, 'http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43http://localhost:5174/#/examconnect/?exam_id_live=43'),
(257, 27, 43, 18, 99, 0, NULL),
(258, 27, 43, 51, 148, 1, NULL),
(259, 27, 43, 49, 12, 0, NULL),
(260, 27, 43, 76, 196, 1, NULL),
(261, 27, 44, 11, 68, 1, NULL),
(262, 27, 44, 20, 105, 0, NULL),
(263, 27, 44, 23, 116, 0, NULL),
(264, 27, 44, 52, 17, 0, NULL),
(265, 27, 44, 46, 2, 0, NULL),
(266, 27, 44, 25, 124, 1, NULL),
(267, 27, 44, 81, NULL, NULL, 'http://localhost:5173/#/examconnect/?exam_id_live=44'),
(268, 27, 44, 34, NULL, NULL, 'http://localhost:5173/#/examconnect/?exam_id_live=44http://localhost:5173/#/examconnect/?exam_id_live=44'),
(269, 27, 44, 44, NULL, NULL, 'http://localhost:5173/#/examconnect/?exam_id_live=44'),
(270, 27, 44, 55, 26, 0, NULL),
(271, 27, 45, 15, 84, 1, NULL),
(272, 27, 45, 8, 59, 1, NULL),
(273, 27, 45, 57, 154, 1, NULL),
(274, 27, 45, 18, 96, 1, NULL),
(275, 27, 45, 20, 107, 1, NULL),
(276, 27, 45, 56, 150, 1, NULL),
(277, 27, 45, 23, 116, 0, NULL),
(278, 27, 45, 11, 68, 1, NULL),
(279, 27, 45, 26, 128, 0, NULL),
(280, 27, 45, 28, 136, 1, NULL),
(281, 27, 46, 23, 116, 0, NULL),
(282, 27, 46, 29, 143, 0, NULL),
(283, 27, 46, 18, 98, 0, NULL),
(284, 27, 46, 20, 105, 0, NULL),
(285, 27, 46, 15, 87, 0, NULL),
(286, 27, 46, 8, 58, 0, NULL),
(287, 27, 46, 42, NULL, 1, 'http://localhost:5173/#/examconnect/?exam_id_live=46'),
(288, 27, 46, 58, 158, 1, NULL),
(289, 27, 46, 38, NULL, 1, 'http://localhost:5173/#/examconnect/?exam_id_live=46'),
(290, 27, 46, 39, NULL, 1, NULL),
(291, 27, 46, 47, 4, 1, NULL),
(292, 27, 46, 75, 195, 0, NULL),
(293, 42, 47, 58, 159, 0, NULL),
(294, 42, 47, 11, 68, 1, NULL),
(295, 42, 47, 27, 132, 1, NULL),
(296, 42, 47, 16, 90, 0, NULL),
(297, 42, 47, 23, 116, 0, NULL),
(298, 42, 47, 3, 36, 1, NULL),
(299, 42, 47, 8, 59, 1, NULL),
(300, 42, 47, 57, 154, 1, NULL),
(301, 42, 47, 17, 92, 1, NULL),
(302, 42, 47, 26, 128, 0, NULL),
(303, 27, 48, 29, 140, 1, NULL),
(304, 27, 48, 3, 36, 1, NULL),
(305, 27, 48, 11, 68, 1, NULL),
(306, 27, 48, 58, 158, 1, NULL),
(307, 27, 48, 56, 150, 1, NULL),
(308, 27, 48, 22, 114, 1, NULL),
(309, 27, 48, 59, 164, 0, NULL),
(310, 27, 48, 28, 136, 1, NULL),
(311, 27, 48, 5, 45, 1, NULL),
(312, 27, 48, 25, 125, 0, NULL);

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
-- Index pour la table `exam_status`
--
ALTER TABLE `exam_status`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `exam_user`
--
ALTER TABLE `exam_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `exam_user_status`
--
ALTER TABLE `exam_user_status`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_user_id` (`exam_user_id`),
  ADD KEY `status_id` (`status_id`);

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
-- Index pour la table `useranswer`
--
ALTER TABLE `useranswer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `fk_QuestionOption_id` (`questionOption_id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `exam`
--
ALTER TABLE `exam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT pour la table `exam_question`
--
ALTER TABLE `exam_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=506;

--
-- AUTO_INCREMENT pour la table `exam_status`
--
ALTER TABLE `exam_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `exam_user`
--
ALTER TABLE `exam_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT pour la table `exam_user_status`
--
ALTER TABLE `exam_user_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT pour la table `question`
--
ALTER TABLE `question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT pour la table `questionoption`
--
ALTER TABLE `questionoption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `useranswer`
--
ALTER TABLE `useranswer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=313;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `exam_question`
--
ALTER TABLE `exam_question`
  ADD CONSTRAINT `fk_qst_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tst_id` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `exam_user`
--
ALTER TABLE `exam_user`
  ADD CONSTRAINT `exam_user_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exam_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `exam_user_status`
--
ALTER TABLE `exam_user_status`
  ADD CONSTRAINT `exam_user_id` FOREIGN KEY (`exam_user_id`) REFERENCES `exam_user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `status_id` FOREIGN KEY (`status_id`) REFERENCES `exam_status` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `questionoption`
--
ALTER TABLE `questionoption`
  ADD CONSTRAINT `fk_question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `useranswer`
--
ALTER TABLE `useranswer`
  ADD CONSTRAINT `UserAnswear_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `UserAnswear_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exam_id` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_QuestionOption_id` FOREIGN KEY (`questionOption_id`) REFERENCES `questionoption` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
