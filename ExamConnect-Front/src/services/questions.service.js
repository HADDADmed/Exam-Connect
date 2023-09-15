

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
            // Check if isQcm is 2
            if (question.isQcm === 2) {
                // Map qstOptions array to only include isTrue property
                question.qstOptions = question.qstOptions.map((option) => {
                    return {};
                });
        
                const images = question.qstImages.map((imageObj) => {
                    return imageObj.image;
                });

                const formatData2  = new FormData();
                formatData2.append('qstImages', images );

                // Images_onUpload() {
                //     const mypostparameters= new FormData()
                //      mypostparameters.append('image', this.Images.selectedFile, this.Images.selectedFile.name);
                //      mypostparameters.append('USERID', 21);
                //      axios.post('/uploadmyfile', mypostparameters);
                //     }


                // // puhing the isTrue property to the image object in the qstImages array
                // question.qstImages.forEach((imageObj, index) => {
                //     // is true dose not exist in the imageobt.image and we need to add it
                //     imageObj.image = { isTrue: imageObj.isTrue };
                //     }
                // );


                console.log("question 1: ");
                console.log(question);
                // Create a new FormData object
                const formData = new FormData();
                



                // Append the qstImages array as files to the FormData
                question.qstImages.forEach((imageObj, index) => {
                    formData.append(`qstImages[${index}].image`, imageObj.image);
                    formData.append(`qstImages[${index}].isTrue`, imageObj.isTrue);
                });
        
                // Append other properties of the question object to the FormData
                Object.keys(question).forEach((key) => {
                    if (key !== 'qstImages') {
                        formData.append(key, question[key]);
                    }
                });
        
                console.log("question 1: ");
                console.log(question);

                console.log("formData: ");
                console.log(formData);
        
                // Send the FormData to the backend with the appropriate endpoint
                return axios.post(API_URL + 'imageQuestion', formatData2, {
                    headers: {
                        'Content-Type': 'multipart/form-data', // Important to set the content type
                    },
                });
            } else {
                console.log("question 2: ");
                console.log(question);
        
                // If isQcm is not 2, send the original question object to the default endpoint
                return axios.post(API_URL, question);
            }
        }
        
    
    }


export default new QuestionsService();
