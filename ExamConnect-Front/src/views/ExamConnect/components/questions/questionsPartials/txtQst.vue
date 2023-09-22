<script>
import userAnswersService from "../../../../../services/userAnswers.service";
export default {
     data() {
          return {
               answer: {
                    exam_id: this.$route.query.exam_id,
                    question_id: "",
                    userAnswerText: "",
                    review: 'pendingReview',
               },
          };
     },
     props: {
          index: Number,
          isAdmin: Boolean,
          question: Object,
          result: Boolean,
     },methods: {
      changeReview(review ) {
                this.answer.review = review;

                if (review == "success") {
                     this.answer.userAnswerText = this.question.userAnswerText;
                } else {
                     this.answer.userAnswerText = "";
                }
            },
     },
     mounted() {
          this.answer.question_id = this.question.question_id;
          this.emitter.on("examSubmited", (data) => {
               console.log(
                    "question_id : " +
                         this.answer.question_id +
                         " userAnswerText : " +
                         this.answer.userAnswerText
               );
               userAnswersService.createAnswer(this.answer);
          });
     },
};
</script>

<template>
     <!-- Creating the Question body -->
     <div style="margin: 0px 0px 30px 30px" class="row">
          <div class="col-md-11  ">

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
               <div v-if="answer.review == 'pendingReview'" class="d-flex justify-content-around">
                    <button class="btn btn-success btn-lg rounded rounded-pill m-5" style="width: 250px;" @click="changeReview('success')" >True</button>
                    <br/>
                    <button class="btn btn-danger btn-lg rounded rounded-pill m-5 " style="width: 250px;" @click="changeReview('failed')" >False</button>
               </div>
               <div v-else style="display: grid; place-items: center;">
                  <div v-if="answer.review !== 'failed'"> 
                    <i
                          class="fa fa-check"
                          style="color: green; font-size: 100px"
                    >

                    </i>
                  </div>
                  <div v-else> 
                    <i
                          class="fa fa-xmark"
                          style="color: red; font-size: 100px"
                    >

                    </i>
                  </div>

                  <div class="btn btn-primary" @click=" changeReview('pendingReview' )">
                    edit review
                  </div>
               </div>
          </div>
     </div>
      
</template>

<style></style>
