import axios from "axios";
import GlobalService from "./global.service";
const API_URL = GlobalService.getApiUrl() + "userAnswers/";

class UserAnswersService {
     createAnswer(answer) {
          return axios.post(API_URL, answer);
     }

     getAllAnswersByExamUserId(exam_id, user_id) {
          return axios.get(API_URL + "user/" + user_id + "/exam/" + exam_id);
     }

     submitReview(review, exam_id, user_id, question_id) {
          return axios.post(API_URL + "review", {
               review: review,
               user_id: user_id,
               exam_id: exam_id,
               question_id: question_id,
          });
     }

     submitFinalReview(exam_user_id, status_id, exam_id, user_id) {
          return axios.post(API_URL + "finalReview", {
               exam_user_id: exam_user_id,
               status_id: status_id,
               user_id: user_id,
               exam_id: exam_id,
          });
     }

     getqstResult(isPassed) {
          return `
       <div v-if="${isPassed == 'passed'}" class="result d-flex justify-content-center">
            <span class="passed"> 1 / 1 </span>
        </div>
        <div v-else-if="${isPassed == 'failed'}" class="result d-flex justify-content-center">
            <span class="failed"> 0 / 1 </span>
        </div>
        <div v-else class="result d-flex justify-content-center">
            <span class="failed">Not Answerd !</span>
        </div>
       `;
     }
}

export default new UserAnswersService();
