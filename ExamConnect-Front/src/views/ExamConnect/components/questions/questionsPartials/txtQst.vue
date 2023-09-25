<script>
import userAnswersService from "../../../../../services/userAnswers.service";
export default {
     data() {
          return {
               answer: {
                    exam_id: this.$route.query.exam_id,
                    user_id: this.$route.query.user_id,
                    question_id: "",
                    userAnswerText: "",
                    review: null,
               },
          };
     },
     props: {
          index: Number,
          isAdmin: Boolean,
          question: Object,
          result: Boolean,
     },
     methods: {
          changeReview(review) {
               this.answer.review = review;
          },
     },
     mounted() {
          this.answer.question_id = this.question.question_id;
          if (this.question.isTrue != null) {
               this.answer.review = this.question.isTrue == 1 ? 'success' : "failed";
          }
          this.emitter.on("examSubmited", (data) => {
               console.log("examSubmited listned text: ");
               console.log(this.answer);
               userAnswersService.createAnswer(this.answer);
          });

          this.emitter.on("reviewSubmited" , (data) => {

                 userAnswersService.submitReview(this.answer.review,this.answer.exam_id,this.answer.user_id, this.answer.question_id);
          }
          
          );
     },
};
</script>

<template>
     <!-- Creating the Question body -->
     <div style="margin: 0px 0px 30px 30px" class="row">
          <div class="col-md-11">
               <div class="form-group flex-grow-1">
                    <textarea
                         v-if="!question.userAnswerText"
                         class="form-control"
                         rows="3"
                         :placeholder="
                              isAdmin
                                   ? 'Readonly ...'
                                   : 'Enter your answer here...'
                         "
                         :readonly="isAdmin"
                         v-model="answer.userAnswerText"
                    ></textarea>
                    <textarea
                         v-else
                         class="form-control"
                         rows="3"
                         :placeholder="
                              isAdmin
                                   ? 'Readonly ...'
                                   : 'Enter your answer here...'
                         "
                         readonly
                         :value="question.userAnswerText"
                    ></textarea>
               </div>
               <div v-if="question.isTrue == null && isAdmin ">
                    <div
                         v-if="answer.review == null"
                         class="d-flex justify-content-around"
                    >
                         <button
                              class="btn btn-success btn-lg rounded rounded-pill m-5"
                              style="width: 250px; "
                              @click="changeReview('success')"
                         >
                              True
                         </button>
                         <br />
                         <button
                              class="btn btn-danger btn-lg rounded rounded-pill m-5"
                              style="width: 250px"
                              @click="changeReview('failed')"
                         >
                              False
                         </button>
                    </div>
                    
               </div>
               <div style="display: grid; place-items: center">
                         <div v-if="answer.review == 'success'">
                              <i
                                   class="fa fa-check"
                                   style="color: green; font-size: 100px"
                              >
                              </i>
                              <br>
                              <div
                               v-if="question.isTrue == null"
                                   class="btn btn-primary"
                                   style="margin-left: -10px;"
                                   @click="changeReview(null)"
                              >
                                   edit review
                              </div>
                         </div>
                         <div v-else-if="answer.review == 'failed'">
                              <i
                                   class="fa fa-xmark"
                                   style="color: red; font-size: 100px"
                              >
                              </i>
                              <br> 
                              <div v-if="question.isTrue == null"
                                   class="btn btn-primary"
                                   style="margin-left: -14px;"
                                   @click="changeReview(null)"
                              >
                                   edit review
                              </div>
                         </div>
                    </div>
          </div>
     </div>
</template>

<style></style>
