<script>
import userAnswersService from "../../../../../services/userAnswers.service";
export default {
     data() {
          return {
               IMAGES_PATH: this.globalService.getImagesUrl(),
               answer: {
                    exam_id: this.$route.query.exam_id,
                    question_id: "",
                    questionOption_id: "",
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
          onAnswerChange(question_id, option_id, isTrue) {
               this.answer.questionOption_id = option_id;
          },
     },
     mounted() {
          this.answer.question_id = this.question.question_id;
          this.emitter.on("examSubmited", (data) => {
               userAnswersService.createAnswer(this.answer);
          });
     },
};
</script>

<template>
     <div v-if="isAdmin">
          <div class="d-flex flex-wrap justify-content-center">
               <div
                    v-if="!result"
                    v-for="(option, index2) in question.options"
                    class="m-5"
                    :key="index"
               >
                    <div style="width: 250px">
                         <div class="form-check form-block">
                              <label
                                   class="form-check-label"
                                   :for="'example-radio-block' + option.id"
                              >
                                   <span
                                        class="d-block fw-normal text-center my-3"
                                   >
                                        <div
                                             style="
                                                  width: 100%;
                                                  height: 100%;
                                                  box-shadow: 0px 0px 10px
                                                       transparent; /* Initial box shadow */
                                                  transition: background-color
                                                            0.3s,
                                                       box-shadow 0.3s; /* Add transitions for smooth change */
                                                  position: relative; /* To position the icon */
                                             "
                                             :style="
                                                  option.isTrue
                                                       ? ' box-shadow: 0px 0px 50px 15px green;' /* Change styles when true */
                                                       : ' box-shadow: 0px 0px 20px red;'
                                             "
                                        >
                                             <!-- Set a fixed height for uniformity -->
                                             <img
                                                  style="
                                                       width: 100%;
                                                       height: 100%;
                                                       object-fit: cover;
                                                       opacity: 1; /* Set the opacity to 1 (fully opaque) */
                                                  "
                                                  :src="
                                                       IMAGES_PATH +
                                                       option.question_text
                                                  "
                                                  alt="image"
                                             />

                                             <!-- Add an icon (e.g., a checkmark) -->
                                             <div
                                                  v-if="option.isTrue"
                                                  style="
                                                       position: absolute;
                                                       top: 10px;
                                                       right: 10px;
                                                       color: white; /* Icon color */
                                                       font-size: 24px; /* Icon size */
                                                  "
                                             >
                                                  <i
                                                       class="fa-solid fa-circle"
                                                       style="color: #22c016"
                                                  ></i>
                                                  <!-- Checkmark symbol or any other icon -->
                                             </div>
                                             <div
                                                  v-else
                                                  style="
                                                       position: absolute;
                                                       top: 10px;
                                                       right: 10px;
                                                       color: white; /* Icon color */
                                                       font-size: 24px; /* Icon size */
                                                  "
                                             >
                                                  <i
                                                       class="fa-solid fa-circle"
                                                       style="color: red"
                                                  ></i>
                                                  <!-- Checkmark symbol or any other icon -->
                                             </div>
                                        </div>
                                   </span>
                              </label>
                         </div>
                    </div>
               </div>

               <div
                    v-else
                    v-for="(option, index2) in question.options"
                    class="m-5"
               >
                    <div style="width: 250px">
                         <div class="form-check form-block">
                              <label
                                   class="form-check-label"
                                   :for="'example-radio-block' + option.id"
                              >
                                   <span
                                        class="d-block fw-normal text-center my-3"
                                   >
                                        <div
                                             style="
                                                  width: 100%;
                                                  height: 100%;
                                                  box-shadow: 0px 0px 10px
                                                       transparent; /* Initial box shadow */
                                                  transition: background-color
                                                            0.3s,
                                                       box-shadow 0.3s; /* Add transitions for smooth change */
                                                  position: relative; /* To position the icon */
                                             "
                                             :style="
                                                  (option.isChecked && option.isTrue) 
                                                       ? 'box-shadow: 0px 0px 30px 20px green;'
                                                       : option.isChecked
                                                       ? ' box-shadow: 0px 0px 30px 20px red;'
                                                       : option.isTrue
                                                       ?'box-shadow: 0px 0px 10px 5px green;'
                                                       : ''

                                             "
                                             :class="
                                                  option.iChecked
                                                       ? 'checked'
                                                       : option.isChecked== 1 &&
                                                         option.isTrue == 0
                                                       ? 'nonchecked'
                                                       : ''
                                             "
                                        >
                                             <!-- Set a fixed height for uniformity -->
                                             <img
                                                  style="
                                                       width: 100%;
                                                       height: 100%;
                                                       object-fit: cover;
                                                       opacity: 1; /* Set the opacity to 1 (fully opaque) */
                                                  "
                                                  :src="
                                                       IMAGES_PATH +
                                                       option.question_text
                                                  "
                                                  alt="image"
                                             />

                                             <!-- Add an icon (e.g., a checkmark) -->
                                             <div
                                                  v-if="option.isChecked"
                                                  style="
                                                       position: absolute;
                                                       top: 10px;
                                                       right: 10px;
                                                       color: white; /* Icon color */
                                                       font-size: 24px; /* Icon size */
                                                  "
                                             >
                                                  <i
                                                       class="fa-solid fa-circle"
                                                       style="color: white"
                                                  ></i>
                                                  <!-- Checkmark symbol or any other icon -->
                                             </div>
                                        </div>
                                   </span>
                              </label>
                         </div>
                    </div>
               </div>
          </div>
     </div>

     <div v-else>
          <div class="d-flex flex-wrap justify-content-center">
               <div
                    v-for="(option, index2) in question.options"
                    class="m-5"
                    :key="index"
               >
                    <div style="width: 250px">
                         <div class="form-check form-block">
                              <input
                                   type="radio"
                                   class="form-check-input"
                                   :id="
                                        'example-radio-block-' +
                                        option.option_id
                                   "
                                   :name="'example-radio-block-group-' + index"
                                   @change="
                                        onAnswerChange(
                                             question.question_id,
                                             option.option_id,
                                             option.isTrue
                                        )
                                   "
                              />
                              <label
                                   class="form-check-label"
                                   :for="
                                        'example-radio-block-' +
                                        option.option_id
                                   "
                              >
                                   <span
                                        class="d-block fw-normal text-center my-3"
                                   >
                                        <div style="width: 100%; height: 200px">
                                             <!-- Set a fixed height for uniformity -->
                                             <img
                                                  style="
                                                       width: 100%;
                                                       height: 100%;
                                                       object-fit: cover;
                                                  "
                                                  :src="
                                                       IMAGES_PATH +
                                                       option.question_text
                                                  "
                                                  alt="image"
                                             />
                                        </div>
                                   </span>
                              </label>
                         </div>
                    </div>
               </div>
               <div class="d-flex flex-wrap justify-content-center"></div>
          </div>
     </div>
</template>

<style>

.checked{
     box-shadow: 0px 0px 5px 6px green;
}


.nonchecked {
     box-shadow: 0px 0px 5px 6px red;
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
