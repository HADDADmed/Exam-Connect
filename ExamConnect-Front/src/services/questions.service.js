import axios from "axios";
import GlobalService from "./global.service";

 
const API_URL = "http://localhost:3000/api/questions/";

class QuestionsService {
  getAllQuestions() {
    return axios.get(API_URL);
  }

  getAllQuestionsIds() {
    return axios.get(API_URL + "ids");
  }

  createQuestion(question) {
    var questionObj = {};
    if (question.isQcm === 0 || question.isQcm === 2) {
      questionObj = {
        isQcm: question.isQcm,
        qstText: question.qstText,
        qstOptionCounter: question.qstOptionCounter,
        examId: question.examId,
      };
    } else if (question.isQcm === 1) {
      questionObj = {
        isQcm: question.isQcm,
        qstText: question.qstText,
        qstOptionCounter: question.qstOptionCounter,
        qstOptions: question.qstOptions,
        examId: question.examId,
      };
    } else if(question.isQcm === 1) {
      console.log("ERROR : isQcm is not 0 or 1 or 2"); 
    }

    axios
      .post(API_URL, questionObj)
      .then((response) => {
        const qstId = response.data.insertId;
        // Check if isQcm is 2
        if (question.isQcm === 2) {
          question.qstOptions = question.qstOptions.map((option) => {
            return {};
          });
          // Append the qstImages array as files to the FormData
          let counter = 0;
          question.qstImages.forEach((imageObj, index) => {
            const formData = new FormData();
            formData.append(`image`, imageObj.image);
            formData.append(`isTrue`, imageObj.isTrue);
            formData.append(`qstId`, qstId);

            // Send the FormData to the backend with the appropriate endpoint
            axios
              .post(API_URL + "imageQuestion", formData, {
                headers: {
                  "Content-Type": "multipart/form-data", // Important to set the content type
                },
              })
              .then((response) => {
                counter++;
                console.log(response);
              })
              .catch((error) => {
                console.log(error);
              });
          });

          GlobalService.toasterShowSuccess('Question with '+counter+' images created successfully !');
        }
      })
      .catch((error) => {
        console.log(error);
      });


  }

  getQuestionsCountsByType() {
    return axios.get(API_URL + "counts");
  }

  
}

export default new QuestionsService();
