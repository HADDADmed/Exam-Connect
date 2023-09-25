-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 25 sep. 2023 à 19:46
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
  `duration_minutes` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `exam`
--

INSERT INTO `exam` (`id`, `ExamTitle`, `questionsCount`, `startTime`, `endTime`, `duration_minutes`, `createdAt`) VALUES
(31, 'Last test Exam ', 6, '2023-09-08T18:16', '2023-09-15T18:16', 10, '2023-09-25 18:17:05');

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
(296, 14, 31),
(297, 17, 31),
(298, 39, 31),
(299, 41, 31),
(300, 47, 31),
(301, 51, 31);

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
(17, 31, 31, '2023-09-25 18:17:05', 'notStarted'),
(18, 31, 30, '2023-09-25 18:17:05', 'failed'),
(19, 31, 27, '2023-09-25 18:17:05', 'failed');

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
(63, 1, 17, '2023-09-25 18:17:05'),
(64, 1, 18, '2023-09-25 18:17:05'),
(65, 1, 19, '2023-09-25 18:17:05'),
(66, 2, 19, '2023-09-25 18:17:45'),
(67, 3, 19, '2023-09-25 18:18:05'),
(68, 4, 19, '2023-09-25 18:19:10'),
(69, 2, 18, '2023-09-25 18:22:37'),
(70, 3, 18, '2023-09-25 18:23:50'),
(71, 4, 18, '2023-09-25 18:26:22');

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
(60, '<h3>What is the correct HTML element for inserting a line break?</h3>', 1, '2023-09-19 18:45:20');

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
(166, 60, '<p>&lt;linebreak&gt;</p>', 0),
(167, 60, '<p>&lt;lb&gt;</p>', 0),
(168, 60, '<p>&lt;br&gt;</p>', 1),
(169, 60, '<p>&lt;newline&gt;</p>', 0);

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
(27, 'John Doe', 'johndoe@gmail.com', '123', 0),
(28, 'Jane Smith', 'janesmith@yahoo.com', '123', 0),
(29, 'Michael Johnson', 'michaelj@gmail.com', '123', 0),
(30, 'Emily Davis', 'emilydavis@hotmail.com', '123', 0),
(31, 'William Brown', 'williambrown@gmail.com', '123', 0),
(32, 'Sophia Lee', 'sophialee@gmail.com', '123', 0),
(33, 'James Wilson', 'jameswilson@yahoo.com', '123', 0),
(34, 'Olivia Anderson', 'oliviaa@gmail.com', '123', 0),
(35, 'Benjamin Jackson', 'benjaminj@gmail.com', '123', 0),
(36, 'Ava Harris', 'avaharris@hotmail.com', '123', 0),
(37, 'Liam Martinez', 'liammartinez@gmail.com', '123', 0),
(38, 'Mia White', 'miawhite@yahoo.com', '123', 0),
(39, 'Ethan Taylor', 'ethtaylor@gmail.com', '123', 0),
(40, 'Emma Lewis', 'emmalewis@gmail.com', '123', 0),
(41, 'Noah Clark', 'noahclark@yahoo.com', '123', 0);

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
(128, 27, 31, 41, NULL, 1, 'http://localhost:5173/#/?exam_id_live=31'),
(129, 27, 31, 39, NULL, 0, 'http://localhost:5173/#/?exam_id_live=31'),
(130, 27, 31, 14, 81, 0, NULL),
(131, 27, 31, 17, 94, 0, NULL),
(132, 27, 31, 51, 148, 1, NULL),
(133, 27, 31, 47, 5, 0, NULL),
(134, 30, 31, 39, NULL, 1, 'emilydavis@hotmail.comemilydavis@hotmail.com'),
(135, 30, 31, 41, NULL, 0, 'emilydavis@hotmail.comemilydavis@hotmail.comemilydavis@hotmail.com'),
(136, 30, 31, 14, 81, 0, NULL),
(137, 30, 31, 17, 93, 0, NULL),
(138, 30, 31, 47, 4, 1, NULL),
(139, 30, 31, 51, 149, 0, NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT pour la table `exam_question`
--
ALTER TABLE `exam_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=302;

--
-- AUTO_INCREMENT pour la table `exam_status`
--
ALTER TABLE `exam_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `exam_user`
--
ALTER TABLE `exam_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `exam_user_status`
--
ALTER TABLE `exam_user_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT pour la table `question`
--
ALTER TABLE `question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT pour la table `questionoption`
--
ALTER TABLE `questionoption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT pour la table `useranswer`
--
ALTER TABLE `useranswer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

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
