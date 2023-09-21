import axios from "axios";

const API_URL = "http://localhost:3000/api/userAnswers/";

class UserAnswersService {


    createAnswer(answer) {
        return axios.post(API_URL, answer);
    }

    getAllAnswersByExamId(exam_id, user_id) {
        return axios.post(API_URL + "user/"+ user_id +"/exam"+exam_id);
    }
}

export default new UserAnswersService();
