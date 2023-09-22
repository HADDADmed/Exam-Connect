<script>
 import qstVue from "../components/questions/qst.vue";
 import UserAnswersService from "../../../services/userAnswers.service";
 
export default {
     data() {
          return {
               exam_id: this.$route.query.exam_id,
               user_id: this.$route.query.user_id,
               examStatist: {},
               userAnswers: {},
               textQuestionsScore: 'pendingReview',
               IMAGES_PATH: "http://localhost:3000/public/images/",
           };
     },
     mounted() {
          this.getAllAnswersByExamUserId()
     },methods: {
         getAllAnswersByExamUserId(){
            UserAnswersService.getAllAnswersByExamUserId(this.exam_id,this.user_id).then(
                (response) => {
                     this.userAnswers = response.data;
                     this.examStatist = response.data.examStatist;

                },
                (error) => {
                     console.log(error);
                }
              );
         },submitReview(){

               UserAnswersService.submitReview(this.exam_id,this.user_id).then(
                    (response) => {
                          this.textQuestionsScore = response.data.textQuestionsScore;
                     },
                    (error) => {
                          console.log(error);
                    }
               );

         }
         
     },
     components: {
          qstVue,
     },
};
</script>

<template>
     <!-- Page Content -->

     <!-- Hero -->
     <div class="bg-body-light">
          <div class="content content-full">
               <div class="py-3 text-center">
                    <h1 class="fw-bold mb-2">{{ userAnswers.exam_title }}</h1>
                    <h3 class="fs-base lh-base fw-medium  mb-0">
                         <!-- display the time string version -->
                        answers of user : {{ userAnswers.user_fullName }} 
                    </h3>
                         <h3>
                              Score for QCM Questions:
                              <span class="badge bg-success">
                                   {{ examStatist.correctQuestions }} / {{ examStatist.totalQcm + examStatist.totalImage }}
                              </span>
                         </h3>
                         <h3>
                              Score for Text Questions:
                              <span v-if="textQuestionsScore !== 'pendingReview' " class="badge bg-success">
                                   {{ examStatist.correctQuestions }} / {{ examStatist.totalText }}
                              </span>
                              <span v-else class="badge bg-success">
                                   Pending your Review
                              </span>
                         </h3>

                         <h3>
                              Total Score:
                              <span v-if="textQuestionsScore !== 'pendingReview' " class="badge bg-success">
                                   {{ examStatist.correctQuestions }} / {{ examStatist.total }}
                              </span>
                              <span v-else class="badge bg-success">
                                   Pending your Review
                              </span>
                         </h3>
               </div>
               <div class="d-flex justify-content-center " >
               
                    <div style=" width: 400px;" class="btn btn-primary m-5 rounded rounded-pill" @click="submitReview()">
                                       Submit Review    
                         </div>
               </div>
          </div>
     </div>
     <!-- END Hero -->

       

     <!-- START Page Content -->
     <div class="content">
          <div v-for="(question, index) in userAnswers.questions" class="col-12">
               <qstVue
                    :question="question"
                    :isAdmin="true"
                    :index="index"
                    :result="true"
               ></qstVue>
          </div>
     </div>

    
     <!-- END Page Content -->
</template>

<style>
 
.form-check-input {
     width: 25px;
     height: 25px;
     margin-right: 20px;
}
.qst {
     font-size: 16px;
     font-weight: 600;
     margin-top: 5px;
}
</style>
