

import axios from 'axios';

const API_URL = 'http://localhost:3000/api/questions/';

class QuestionsService {
    
        getAllQuestions() {
            return axios.get(API_URL);
        }
        
        getAllQuestionsIds() {
            return axios.get(API_URL + 'ids');
        }
        
        createQuestion(question) {
            return axios.post(API_URL, question);
        }
    
    }


export default new QuestionsService();
