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
-- Structure de la table `question`
--

CREATE TABLE `question` (
  `id` int(11) NOT NULL,
  `question_text` text DEFAULT NULL,
  `isQCM` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




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







CREATE TABLE `exam_question` (
  `id`  int(11) ,
  `question_id` int(11) DEFAULT NULL,
  `exam_id` int(11) DEFAULT NULL,
  FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE,
  FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

 
--
-- Index for the table `exam_question`
--
ALTER TABLE `exam_question`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `exam_question`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;
 
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


 
-- --------------------------------------------------------


 
-- --------------------------------------------------------

--
-- Index pour les tables déchargées
--


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

























----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------








--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`fullName`, `email`, `password`, `isAdmin`) VALUES
('HADDAD MOHAMMED', 'haddad@gmail.com', '123', 1),
('John Doe', 'johndoe@gmail.com', '123', 0),
('Jane Smith', 'janesmith@yahoo.com', '123', 0),
('Michael Johnson', 'michaelj@gmail.com', '123', 0),
('Emily Davis', 'emilydavis@hotmail.com', '123', 0),
('William Brown', 'williambrown@gmail.com', '123', 0),
('Sophia Lee', 'sophialee@gmail.com', '123', 0),
('James Wilson', 'jameswilson@yahoo.com', '123', 0),
('Olivia Anderson', 'oliviaa@gmail.com', '123', 0),
('Benjamin Jackson', 'benjaminj@gmail.com', '123', 0),
('Ava Harris', 'avaharris@hotmail.com', '123', 0),
('Liam Martinez', 'liammartinez@gmail.com', '123', 0),
('Mia White', 'miawhite@yahoo.com', '123', 0),
('Ethan Taylor', 'ethtaylor@gmail.com', '123', 0),
('Emma Lewis', 'emmalewis@gmail.com', '123', 0),
('Noah Clark', 'noahclark@yahoo.com', '123', 0);




--
-- Déchargement des données de la table `question`
--


----30 qst  isQCM == 1 (Multiple Choice Questions)

INSERT INTO `question` (`question_text`, `isQCM`, `createdAt`) VALUES
('<h2><strong>Which HTML tag is used to create a hyperlink?</strong></h2>', 1, '2023-09-18 10:00:00'),
('<p><strong>What is the correct HTML element for inserting a line break?</strong></p>', 1, '2023-09-18 10:10:00'),
('<h2><strong>What does CSS stand for?</strong></h2>', 1, '2023-09-18 10:20:00'),
('<p><strong>What is the purpose of the "alt" attribute in an HTML image tag?</strong></p>', 1, '2023-09-18 10:30:00'),
('<h2><strong>Which CSS property is used to change the text color?</strong></h2>', 1, '2023-09-18 10:40:00'),
('<p><strong>What is JavaScript primarily used for in web development?</strong></p>', 1, '2023-09-18 10:50:00'),
('<h2><strong>What does SEO stand for in web development?</strong></h2>', 1, '2023-09-18 11:00:00'),
('<p><strong>Which programming language is commonly used for back-end web development?</strong></p>', 1, '2023-09-18 11:10:00'),
('<h2><strong>What is the purpose of the "SMTP" protocol in email marketing?</strong></h2>', 1, '2023-09-18 11:20:00'),
('<p><strong>Explain the concept of "responsive web design" and its benefits.</strong></p>', 1, '2023-09-18 11:30:00');


INSERT INTO `question` (`question_text`, `isQCM`, `createdAt`) VALUES
('<h2><strong>What is the primary purpose of HTML in web development?</strong></h2>', 1, '2023-09-18 16:00:00'),
('<p><strong>Which HTML tag is used for creating a numbered list?</strong></p>', 1, '2023-09-18 16:10:00'),
('<h2><strong>What does CSS stand for in styling web pages?</strong></h2>', 1, '2023-09-18 16:20:00'),
('<p><strong>Which CSS property is used for adjusting the spacing between letters in text?</strong></p>', 1, '2023-09-18 16:30:00'),
('<h2><strong>What is the purpose of JavaScript in web development?</strong></h2>', 1, '2023-09-18 16:40:00'),
('<p><strong>What does SEO stand for in the context of online visibility?</strong></p>', 1, '2023-09-18 16:50:00'),
('<h2><strong>Which programming language is primarily used for building interactive web applications?</strong></h2>', 1, '2023-09-18 17:00:00'),
('<p><strong>What is the function of the "src" attribute in an HTML <img> tag?</strong></p>', 1, '2023-09-18 17:10:00'),
('<h2><strong>Which HTML tag is used to create an unordered list?</strong></h2>', 1, '2023-09-18 17:20:00'),
('<p><strong>What is the default value of the "display" property in CSS for most HTML elements?</strong></p>', 1, '2023-09-18 17:30:00');



INSERT INTO `question` (`question_text`, `isQCM`, `createdAt`) VALUES
('<h2><strong>Which HTML tag is used for creating a table in a web page?</strong></h2>', 1, '2023-09-18 18:00:00'),
('<p><strong>What does CSS provide in web development to enhance the layout of web pages?</strong></p>', 1, '2023-09-18 18:10:00'),
('<h2><strong>What is the purpose of JavaScript functions in coding?</strong></h2>', 1, '2023-09-18 18:20:00'),
('<p><strong>Which CSS property is used for controlling the size of an element s box?</strong></p>', 1, '2023-09-18 18:30:00'),
('<h2><strong>What is the primary function of search engines in online marketing?</strong></h2>', 1, '2023-09-18 18:40:00'),
('<p><strong>What is the role of a web server in server-side web development?</strong></p>', 1, '2023-09-18 18:50:00'),
('<h2><strong>Which programming language is commonly used for building responsive web applications?</strong></h2>', 1, '2023-09-18 19:00:00'),
('<p><strong>What does the "href" attribute define in an HTML <a> tag?</strong></p>', 1, '2023-09-18 19:10:00'),
('<h2><strong>What is the purpose of the "DOCTYPE" declaration in HTML documents?</strong></h2>', 1, '2023-09-18 19:20:00'),
('<p><strong>Which HTML tag is used for creating a form in web development?</strong></p>', 1, '2023-09-18 19:30:00');





-- 15 qst isQCM == 0 (Text-Based Answer Questions)

INSERT INTO `question` (`question_text`, `isQCM`, `createdAt`) VALUES
('<h2><strong>Calculate the Area of a Circle</strong></h2><p>Write a function that calculates the area of a circle given its radius.</p><h4><strong>Instructions :</strong></h4><ul><li>Use the formula: Area = π * (radius * radius)</li><li>Return the calculated area.</li></ul>', 0, '2023-09-18 20:00:00'),
('<h2><strong>Find the Sum of Even Numbers</strong></h2><p>Write a function that finds the sum of all even numbers in an array.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the array and add even numbers to the sum.</li><li>Return the total sum.</li></ul>', 0, '2023-09-18 20:10:00'),
('<h2><strong>Reverse a String</strong></h2><p>Write a function that reverses a given string.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the string and build a reversed version of it.</li><li>Return the reversed string.</li></ul>', 0, '2023-09-18 20:20:00'),
('<h2><strong>Calculate the Factorial of a Number</strong></h2><p>Write a function that calculates the factorial of a non-negative integer.</p><h4><strong>Instructions :</strong></h4><ul><li>Use a loop to multiply numbers from 1 to n.</li><li>Return the factorial value.</li></ul>', 0, '2023-09-18 20:30:00'),
('<h2><strong>Count Vowels in a String</strong></h2><p>Write a function that counts the number of vowels in a given string.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the string and count vowels (a, e, i, o, u).</li><li>Return the count.</li></ul>', 0, '2023-09-18 20:40:00'),
('<h2><strong>Find the Largest Number in an Array</strong></h2><p>Write a function that finds the largest number in an array of numbers.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the array and track the largest number.</li><li>Return the largest number found.</li></ul>', 0, '2023-09-18 20:50:00'),
('<h2><strong>Check for Prime Numbers</strong></h2><p>Write a function that checks if a given number is prime or not.</p><h4><strong>Instructions :</strong></h4><ul><li>Check for divisibility by numbers up to the square root of the given number.</li><li>Return true if the number is prime, otherwise false.</li></ul>', 0, '2023-09-18 21:00:00'),
('<h2><strong>Calculate the Fibonacci Sequence</strong></h2><p>Write a function that generates the Fibonacci sequence up to a specified length.</p><h4><strong>Instructions :</strong></h4><ul><li>Generate the sequence by adding the last two numbers.</li><li>Return the sequence as an array.</li></ul>', 0, '2023-09-18 21:10:00'),
('<h2><strong>Find the Longest Word</strong></h2><p>Write a function that finds the longest word in a given sentence.</p><h4><strong>Instructions :</strong></h4><ul><li>Split the sentence into words and track the longest word.</li><li>Return the longest word found.</li></ul>', 0, '2023-09-18 21:20:00'),
('<h2><strong>Reverse an Array</strong></h2><p>Write a function that reverses the elements of an array.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the array and reverse the order of elements.</li><li>Return the reversed array.</li></ul>', 0, '2023-09-18 21:30:00');

-----

INSERT INTO `question` (`question_text`, `isQCM`, `createdAt`) VALUES
('<h2><strong>Calculate the Area of a Triangle</strong></h2><p>Write a function that calculates the area of a triangle given its base and height.</p><h4><strong>Instructions :</strong></h4><ul><li>Use the formula: Area = (base * height) / 2</li><li>Return the calculated area.</li></ul>', 0, '2023-09-18 21:40:00'),
('<h2><strong>Count the Occurrences of a Character</strong></h2><p>Write a function that counts the occurrences of a specific character in a string.</p><h4><strong>Instructions :</strong></h4><ul><li>Iterate through the string and count the occurrences of the character.</li><li>Return the count.</li></ul>', 0, '2023-09-18 21:50:00'),
('<h2><strong>Find the Median of an Array</strong></h2><p>Write a function that finds the median value of a sorted array.</p><h4><strong>Instructions :</strong></h4><ul><li>Determine if the array has an odd or even number of elements and find the median accordingly.</li><li>Return the median value.</li></ul>', 0, '2023-09-18 22:00:00'),
('<h2><strong>Check for Palindromes</strong></h2><p>Write a function that checks if a given string is a palindrome (reads the same forwards and backwards).</p><h4><strong>Instructions :</strong></h4><ul><li>Remove non-alphanumeric characters and convert to lowercase for comparison.</li><li>Return true if the string is a palindrome, otherwise false.</li></ul>', 0, '2023-09-18 22:10:00'),
('<h2><strong>Calculate the Square Root</strong></h2><p>Write a function that calculates the square root of a positive number.</p><h4><strong>Instructions :</strong></h4><ul><li>Use an iterative method or a built-in function to calculate the square root.</li><li>Return the square root value.</li></ul>', 0, '2023-09-18 22:20:00');




-- 10 Computer Science Questions with isQCM == 2 (Images as Options) 
INSERT INTO `question` (`question_text`, `isQCM`, `createdAt`) VALUES
('<h2><strong>Choose the Correct Programming Language Logo:</strong></h2><p>Select the image that shows the Python programming language logo.</p>', 2, '2023-09-19 10:00:00'),
('<h2><strong>Identify the Correct Computer Component:</strong></h2><p>Choose the image that represents a graphics card (GPU).</p>', 2, '2023-09-19 10:10:00'),
('<h2><strong>Pick the Correct Code Snippet:</strong></h2><p>Select the image that shows a code snippet written in the Python programming language.</p>', 2, '2023-09-19 10:20:00'),
('<h2><strong>Identify the Correct Database Management System Logo:</strong></h2><p>Choose the image that shows the MySQL database management system logo.</p>', 2, '2023-09-19 10:30:00'),
('<h2><strong>Pick the Correct Web Development Framework Logo:</strong></h2><p>Select the image that shows the React.js web development framework logo.</p>', 2, '2023-09-19 10:40:00'),
('<h2><strong>Identify the Correct Networking Device:</strong></h2><p>Choose the image that represents a router.</p>', 2, '2023-09-19 10:50:00'),
('<h2><strong>Pick the Correct Cloud Computing Service Logo:</strong></h2><p>Select the image that shows the Amazon Web Services (AWS) logo.</p>', 2, '2023-09-19 11:00:00'),
('<h2><strong>Choose the Correct Cybersecurity Concept:</strong></h2><p>Select the image that represents a firewall in cybersecurity.</p>', 2, '2023-09-19 11:10:00'),
('<h2><strong>Identify the Correct Data Science Tool Logo:</strong></h2><p>Choose the image that shows the Python data science libraries (e.g., NumPy, pandas) logo.</p>', 2, '2023-09-19 11:20:00'),
('<h2><strong>Pick the Correct Software Development Methodology:</strong></h2><p>Select the image that represents the Agile software development methodology.</p>', 2, '2023-09-19 11:30:00');
--


-- 55 qst 


 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(1, '<a>', 1),
(1, '<h1>', 0),
(1, '<div>', 0),
(1, '<p>', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(2, '<br>', 1),
(2, '<lb>', 0),
(2, '<newline>', 0),
(2, '<linebreak>', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(3, 'Cascading Style Sheets', 1),
(3, 'Computer Style System', 0),
(3, 'Creative Style Sheet', 0),
(3, 'Custom Style System', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(4, 'It defines the alternative text for an image.', 1),
(4, 'It sets the image\'s background color.', 0),
(4, 'It specifies the image\'s alignment.', 0),
(4, 'It controls the image\'s width and height.', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(5, 'text-color', 0),
(5, 'color', 1),
(5, 'text-style', 0),
(5, 'font-color', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(6, 'Creating database tables', 0),
(6, 'Styling web pages', 0),
(6, 'Adding interactivity to websites', 1),
(6, 'Sending emails', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(7, 'Search Engine Optimization', 1),
(7, 'Social Engagement Optimization', 0),
(7, 'Software Engineering Online', 0),
(7, 'Secure E-commerce Operations', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(8, 'HTML', 0),
(8, 'CSS', 0),
(8, 'JavaScript', 0),
(8, 'Python', 1);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(9, 'Simple Mail Transfer Protocol (SMTP) is used for sending emails.', 1),
(9, 'SMTP is used to receive emails.', 0),
(9, 'SMTP is used to format web pages.', 0),
(9, 'SMTP is used to create databases.', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(10, 'Responsive web design ensures that websites always have the same layout.', 0),
(10, 'Responsive web design means making websites look exactly the same on all devices.', 0),
(10, 'Responsive web design adapts web page layouts for different screen sizes, improving user experience.', 1),
(10, 'Responsive web design only works on desktop computers.', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(11, 'To structure the content and layout of web pages.', 1),
(11, 'To create interactive web applications.', 0),
(11, 'To define the visual styling of web pages.', 0),
(11, 'To manage server-side data storage.', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(12, '<ol>', 1),
(12, '<ul>', 0),
(12, '<li>', 0),
(12, '<nl>', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(13, 'Cascading Style Sheets', 1),
(13, 'Computer Style System', 0),
(13, 'Creative Style Sheet', 0),
(13, 'Custom Style System', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(14, 'letter-spacing', 1),
(14, 'word-spacing', 0),
(14, 'line-height', 0),
(14, 'text-align', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(15, 'To add interactivity and functionality to web pages.', 1),
(15, 'To define the visual style of web pages.', 0),
(15, 'To store data on the server.', 0),
(15, 'To send emails to users.', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(16, 'Search Engine Optimization', 1),
(16, 'Social Engagement Optimization', 0),
(16, 'Software Engineering Online', 0),
(16, 'Secure E-commerce Operations', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(17, 'JavaScript', 1),
(17, 'Java', 0),
(17, 'Python', 0),
(17, 'C++', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(18, 'It specifies the source file for the image.', 1),
(18, 'It sets the image\'s dimensions.', 0),
(18, 'It defines the image\'s alignment.', 0),
(18, 'It controls the image\'s opacity.', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(19, '<ul>', 1),
(19, '<ol>', 0),
(19, '<li>', 0),
(19, '<dl>', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(20, 'inline-block', 0),
(20, 'block', 0),
(20, 'none', 0),
(20, 'inline', 1);


 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(21, '<table>', 1),
(21, '<tr>', 0),
(21, '<td>', 0),
(21, '<div>', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(22, 'Layout enhancement', 0),
(22, 'Content management', 0),
(22, 'Styling and presentation', 1),
(22, 'Server communication', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(23, 'To define reusable code blocks.', 0),
(23, 'To declare variables.', 0),
(23, 'To group code statements into a single unit.', 1),
(23, 'To create random numbers.', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(24, 'box-sizing', 1),
(24, 'box-width', 0),
(24, 'box-height', 0),
(24, 'box-layout', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(25, 'Information retrieval', 1),
(25, 'Social media management', 0),
(25, 'Content creation', 0),
(25, 'Data storage', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(26, 'To handle client-side requests and responses.', 0),
(26, 'To host web applications.', 0),
(26, 'To process and respond to client requests.', 1),
(26, 'To store user data.', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(27, 'JavaScript', 1),
(27, 'Python', 0),
(27, 'Ruby', 0),
(27, 'C#', 0);






 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(28, 'It defines the destination URL for the link.', 1),
(28, 'It specifies the link type.', 0),
(28, 'It sets the link `s text color.', 0),
(28, 'It defines the link`s position on the page.', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(29, 'To specify the document type and version.', 1),
(29, 'To define the background color of the page.', 0),
(29, 'To set the font size for the entire document.', 0),
(29, 'To control the layout of the webpage.', 0);

 INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(30, '<form>', 1),
(30, '<input>', 0),
(30, '<button>', 0),
(30, '<label>', 0);






INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(46, 'qst_option__19-8-2023_12-12-5__355735425.jpg', 1),
(46, 'qst_option__19-8-2023_12-12-5__33520977.jpg', 0),
(46, 'qst_option__19-8-2023_12-5-46__797642122.jpg', 0),

(47, 'qst_option__19-8-2023_12-12-5__33520977.jpg', 1),
(47, 'qst_option__19-8-2023_12-5-46__353949019.jpg', 0),
(47, 'qst_option__19-8-2023_11-27-37__523200814.jpg', 0),

(48, 'qst_option__19-8-2023_12-12-5__353949019.jpg', 1),
(48, 'qst_option__19-8-2023_12-5-46__33520977.jpg', 0),
(48, 'qst_option__19-8-2023_11-27-37__523200814.jpg', 0),

(49, 'qst_option__19-8-2023_12-12-5__523200814.jpg', 1),
(49, 'qst_option__19-8-2023_12-5-46__33520977.jpg', 0),
(49, 'qst_option__19-8-2023_11-27-37__353949019.jpg', 0),
  
(50, 'qst_option__19-8-2023_12-12-5__33520977.jpg', 1),
(50, 'qst_option__19-8-2023_12-5-46__353949019.jpg', 0),
(50, 'qst_option__19-8-2023_11-27-37__523200814.jpg', 0);



INSERT INTO `questionoption` (`question_id`, `question_text`, `isTrue`)
VALUES
(52, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 1),
(52, 'qst_option__19-8-2023_12-5-46__33520977.jpg', 0),
(52, 'qst_option__19-8-2023_11-27-37__371580902.jpg', 0),

(53, 'qst_option__19-8-2023_12-12-5__371580902.jpg', 1),
(53, 'qst_option__19-8-2023_12-5-46__33520977.jpg', 0),
(53, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0),

(54, 'qst_option__19-8-2023_12-12-5__33520977.jpg', 1),
(54, 'qst_option__19-8-2023_12-5-46__371580902.jpg', 0),
(54, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0),

(55, 'qst_option__19-8-2023_12-12-5__33520977.jpg', 1),
(55, 'qst_option__19-8-2023_12-5-46__371580902.jpg', 0),
(55, 'qst_option__18-8-2023_12-23-44__924770461.jpg', 0);


