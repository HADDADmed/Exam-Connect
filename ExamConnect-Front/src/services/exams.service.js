

// create a file that contain all services regarding the exams


import axios from "axios";
import QuestionsService from "./questions.service";

const API_URL = "http://localhost:3000/api/exams/";

class ExamsService {

    getAllExams() {
        return axios.get(API_URL);
    }

    getExamById(id) {
        return axios.get(API_URL +'exam/'+id);
    }
    async createExam(exam) {
        try {

           const questionsCount = exam.questions.qcmQuestions + exam.questions.textQuestions + exam.questions.imageQuestions;
          // Fetch all question IDs
          const response = await QuestionsService.getAllQuestionsIds();
         
          const questionsIds = response.data;
          const qcmQuestionsIds = questionsIds.filter((question) => question.isQcm === 1);
          const textQuestionsIds = questionsIds.filter((question) => question.isQcm === 0);
          const imageQuestionsIds = questionsIds.filter((question) => question.isQcm === 2);


      
          // Pick random questions from each category of questions (qcm, text, image) based on the number of questions of each category
          const qcmQuestions =   this.getRandomQuestions(qcmQuestionsIds, exam.questions.qcmQuestions);
          const textQuestions =  this.getRandomQuestions(textQuestionsIds, exam.questions.textQuestions);
          const imageQuestions = this.getRandomQuestions(imageQuestionsIds, exam.questions.imageQuestions);
          // Create the exam object
          const questions = qcmQuestions.concat(textQuestions, imageQuestions);
                
          // usesrs list 
          const usersSelected = exam.usersSelected;

         //remap the usersSelected array to have only ids 

          usersSelected.map((user) => {
            return {
              id: user.id,
            }
          });

          const examObject = {
            examTitle: exam.examTitle,
            questionsCount: questionsCount,
            startTime: exam.startTime,
            endTime: exam.endTime,
            duration_minutes: exam.duration_minutes,
            questions: questions,
            usersSelected: usersSelected,
          };
          
          return await axios.post(API_URL, examObject);
        } catch (error) {
          console.error("Error creating exam:", error);
          throw error;
        }
      }
      
       getRandomQuestions(questionIds, count) {
        const randomQuestions = [];
        while (count > 0 && questionIds.length > 0) {
          const randomIndex = Math.floor(Math.random() * questionIds.length);
          randomQuestions.push(questionIds.splice(randomIndex, 1)[0]);
          count--;
        }
        return randomQuestions;
      }




      
}


export default new ExamsService();


