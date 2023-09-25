<script>
import userAnswersService from "../../../../../services/userAnswers.service";
export default {
     data() {
          return {
               answer: {
                    exam_id: this.$route.query.exam_id,
                    question_id: "",
                    questionPassed: 'notAnswered',
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
          result: Boolean,
     },
     mounted() {
          this.answer.question_id = this.question.question_id;
            this.question.options.forEach((option) => {
               if (option.isChecked){
                    this.answer.questionPassed = 'failed'
                    if(option.isTrue){
                         this.answer.questionPassed = 'passed';
                         return
                     }
               }
          });

          this.emitter.on("examSubmited", (data) => {
               console.log("examSubmited listned qcm: ");
               console.log(this.answer);
               userAnswersService.createAnswer(this.answer);
          });
     },
};
</script>

<template>
     <div v-if="isAdmin">
          <div v-if="!result" class="m-5">
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

          <div v-else class="m-5">
               <div class="m-3">
                    <div v-if="answer.questionPassed == 'passed'" class="result d-flex justify-content-center">
                         <span class="passed"> 1 / 1 </span>
                    </div>
                    <div v-else-if="answer.questionPassed == 'failed'" class="result d-flex justify-content-center">
                         <span class="failed"> 0 / 1 </span>
                    </div>
                    <div v-else class="result d-flex justify-content-center">
                         <span class="failed">Not Answerd !</span>
                    </div>
                    <div
                         v-for="(option, index2) in question.options"
                         class="m-3"
                    >
                         <div class="m-3">
                              <label class="custom-radio">
                                   <span
                                        class="radio-dot"
                                        :class="
                                             option.isChecked && option.isTrue
                                                  ? 'checked'
                                                  : option.isChecked == 1 &&
                                                    option.isTrue == 0
                                                  ? 'nonchecked'
                                                  : option.isTrue == 1
                                                  ? 'checked'
                                                  : ''
                                        "
                                        :style="
                                             option.isChecked
                                                  ? 'background-color: darkblue'
                                                  : ''
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
                    <div>
                         <div
                              class="m-3"
                              style="display: flex; align-items: center"
                         >
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

.radio-dot.checked {
     border-color: black;
     box-shadow: 0px 0px 15px 10px green;
     transition: background-color 0.3s, box-shadow 0.3s; /* Add transitions for smooth change */
}
.radio-dot.nonchecked {
     border-color: black;
     box-shadow: 0px 0px 15px 10px red;
     transition: background-color 0.3s, box-shadow 0.3s; /* Add transitions for smooth change */
}
/* Style label text */
.qst {
     font: bold 18px/1.4 Helvetica, Verdana, sans-serif; /* Adjusted line-height */
}
.result {
     font: bold 25px/1.4 Helvetica, Verdana, sans-serif; /* Adjusted line-height */
     margin-top: 10px;
}
.passed {
     color: green;
}
.failed {
     color: red;
}
</style>
