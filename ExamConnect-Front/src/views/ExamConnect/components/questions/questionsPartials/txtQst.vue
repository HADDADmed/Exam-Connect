<script>
import userAnswersService from '../../../../../services/userAnswers.service';
export default {
     data() {
          return {
               answer: {
                    exam_id: this.$route.query.exam_id,
                    question_id: "",
                    userAnswerText: "",
               },
          };
     },
     props: {
          index: Number,
          isAdmin: Boolean,
          question: Object,
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
              userAnswersService.createAnswer(this.answer)
          });
     },
};
</script>

<template>
     <!-- Creating the Question body -->
     <div style="margin: 0px 0px 30px 30px" class="row">
          <div class="col-md-11">
               <div class="form-group">
                    <textarea
                         style="border: 1px solid black"
                         class="form-control form-control-alt"
                         rows="3"
                         :placeholder="
                              isAdmin
                                   ? 'readonly ...'
                                   : 'Enter your answer here...'
                         "
                         :readonly="isAdmin"
                         v-model="answer.userAnswerText"
                    ></textarea>
               </div>
          </div>
     </div>
     <div
          @click="
               () => {
                    console.log(answer);
               }
          "
          class="btn btn-primary"
     >
          sos
     </div>
</template>

<style></style>
