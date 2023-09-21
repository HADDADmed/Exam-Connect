<script>
import userAnswersService from '../../../../../services/userAnswers.service';
export default {
     data() {
          return {
               answer: {
                    exam_id: this.$route.query.exam_id,
                    question_id: "",
                    questionOption_id: "",
                    isTrue: "",
               },
          };
     },
     methods: {
          onAnswerChange(option_id, isTrue) {
               this.answer.questionOption_id = option_id;
               this.answer.isTrue = isTrue;
          },
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
                         " option_id : " +
                         this.answer.questionOption_id +
                         " isTrue : " +
                         this.answer.isTrue
               );
               userAnswersService.createAnswer(this.answer)
          });
     },
};
</script>

<template>
     <div v-if="isAdmin">
          <div class="m-5">
               <div class="m-3">
                    <div
                         v-for="(option, index2) in question.options"
                         class="m-3"
                    >
                         <div class="m-3">
                              <label class="custom-radio">
                                   <span
                                        class="radio-dot"
                                        :class="
                                             option.isTrue
                                                  ? 'selected'
                                                  : 'nonselected'
                                        "
                                   ></span>
                                   <span
                                        style="font-size: larger"
                                        class="question-text d-flex"
                                   >
                                        <div>
                                             <strong style="font-size: 18px"
                                                  >{{
                                                       index2 + 1
                                                  }}.&nbsp;</strong
                                             >
                                        </div>
                                        <div
                                             v-html="option.question_text"
                                        ></div>
                                   </span>
                              </label>
                         </div>
                    </div>
               </div>
          </div>
     </div>
     <div v-else>
          <div class="m-5">
               <div v-for="(option, index2) in question.options" class="m-3">
                    <div class="m-3" style="display: flex; align-items: center">
                         <input
                              type="radio"
                              class="form-check-input radio-dot"
                              style="width: 30px; height: 30px"
                              :id="'option_' + option.option_id"
                              :name="'question_' + index"
                              :value="option.option_id"
                              @change="
                                   onAnswerChange(
                                         option.option_id,
                                        option.isTrue
                                   )
                              "
                         />
                         <label class="qst" :for="'option_' + option.id">
                              <span
                                   style="font-size: larger"
                                   class="question-text d-flex"
                              >
                                   <div>
                                        <strong style="font-size: 18px"
                                             >{{ index2 + 1 }}.&nbsp;</strong
                                        >
                                   </div>
                                   <div v-html="option.question_text"></div>
                              </span>
                         </label>
                    </div>
               </div>
          </div>
     </div>
</template>

<style>
/* Custom radio button styles */
/* Custom radio button styles */
.custom-radio {
     display: flex;
     align-items: center;
     cursor: pointer;
}

.radio-dot {
     width: 30px; /* Adjust the width and height as needed */
     height: 30px;
     border: 2px solid #000;
     border-radius: 50%;
     margin-right: 10px;
     flex-shrink: 0;
     display: flex;
     justify-content: center;
     align-items: center;
     font-size: larger; /* Make the checkmark larger */
     margin-top: -10px;
}

/* Style the radio button when it's selected */
.radio-dot.selected {
     background-color: green;
     border-color: black;
     box-shadow: 0px 0px 15px 7px green;
     transition: background-color 0.3s, box-shadow 0.3s; /* Add transitions for smooth change */
}
.radio-dot.nonselected {
     /* background-color: #ff7276; */
     border-color: black;
     box-shadow: 0px 0px 15px red;
     transition: background-color 0.3s, box-shadow 0.3s; /* Add transitions for smooth change */
}

/* Style label text */
.qst {
     font: bold 18px/1.4 Helvetica, Verdana, sans-serif; /* Adjusted line-height */
}
</style>
