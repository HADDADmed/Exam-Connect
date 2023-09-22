import axios from "axios";

const API_URL = "http://localhost:3000/api/userAnswers/";

class UserAnswersService {


    createAnswer(answer) {
        return axios.post(API_URL, answer);
    }

    getAllAnswersByExamUserId(exam_id, user_id) {
        return axios.get(API_URL + "user/"+ user_id +"/exam/"+exam_id);
    }

    submitReview(review , exam_id, user_id) {
        return axios.post(API_URL + "review", {
            review: review,
            user_id: user_id,
            question_id: exam_id,
        });
    }

}

export default new UserAnswersService();
