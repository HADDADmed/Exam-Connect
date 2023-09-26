# ExamConnect

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)


## Overview

ExamConnect is a comprehensive solution for managing test exams within an enterprise. It provides administrators with the tools to create, assign, and evaluate exams, while users can take exams and access their results. This README provides an overview of the application's features, technologies used, installation instructions, and usage guidelines.

## Features

- **User Management (CRUD):** Admins can manage user accounts, categorizing them as either admin or non-admin users.

- **Question Management (CRUD) :** Admins can create different types of questions, including text questions, multiple-choice questions (MCQ), and MCQ with images.

- **Database Integration:** Questions are stored in an SQL database for easy retrieval and management.

- **Exam Creation:** Admins can create exams, specifying the types and quantities of questions, exam duration, start and end date/time, and users to assign the exam to.

- **Exam Link Generation:** Unique links are generated for each user assigned to an exam.

- **User Exam Experience:** Users can access exams through generated links, answer questions within a specified time frame, and submit their responses.

- **Submission and Status Update:** User responses are stored in the database, and the status of the exam changes from "notStarted" to "inProgress" when the user is currently answering the exam and to "pendingReview" upon submission .

- **Automatic Result Calculation:** For text questions, admin manually reviews and scores responses; for MCQ questions, results are calculated automatically.

- **Result Communication:** Admins can send result links to users for accessing their scores and feedback.

- **Security:** JWT is used for authentication and authorization, ensuring data privacy and exam integrity.

- **Scalability:** The application is designed to handle a growing number of users, questions, and exams.

- **User-Friendly Interface:** The application features an intuitive and user-friendly interface for both admins and users.
<!--
- **Reporting and Analytics:** Admins can gain insights into exam performance and user progress through reporting features.

- **Data Backup and Recovery:** Regular data backups are implemented to prevent data loss.

- **Notifications:** Users receive reminders about upcoming exams and submission deadlines.

- **Feedback Mechanism:** Users can provide feedback on their exam experience.

- **Documentation and Support:** Comprehensive documentation and user support are provided. -->

- **Maintenance and Updates:** The application is regularly updated and maintained for bug fixes and feature enhancements.

## Technologies Used

- **Backend:**

  - Node.js and Express.js
  - JWT for authentication and security
  - SQL Database for data storage
  - Vue Multer for image uploads

- **Frontend:**
  - Vue.js for dynamic user interfaces
  - Pinia for state management
  - CKEditor for rich text editing
  - Bootstrap for styling
  - FontAwesome for scalable vector icons
  - Vue Toaster for notifications
  - Chart.js for data visualization
  - Clipboard for clipboard management

## Installation

To install and run ExamConnect, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/HADDADmed/Exam-Connect.git
   cd ExamConnect
   ```
2. Install the dependencies:
   ```bash
    cd ExamConnect-Back
    npm install
    cd ExamConnect-Front
    npm install
    ```
3. Create a `.env` file in the `ExamConnect-Back` directory and add the following environment variables:
   ```bash
   PORT=3000
   JWT_SECRET=your_secret_key
   ```
 
4. Create a `.env` file in the `ExamConnect-Front` directory and add the following environment variables:
   ```bash
    VUE_APP_API_URL=http://localhost:3000
    ```
5. Create a MySQL database named `examconnect` and import the `examconnect.sql` file in the `ExamConnect-Back/src/DataBaseConf/DataBaseFileImports` directory.

6. Run the application:
   ```bash
    npm start
    ```
7. Open the application in your browser at the generated link .

