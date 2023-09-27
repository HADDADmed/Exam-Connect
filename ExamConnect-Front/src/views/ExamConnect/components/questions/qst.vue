questions
<script>
import imgQst from "./questionsPartials/imgQst.vue";
import qcmQst from "./questionsPartials/qcmQst.vue";
import txtQst from "./questionsPartials/txtQst.vue";
import QuestionsService from "../../../../services/questions.service";
export default {
     data() {
          return {
               options: false,
               userVue: false,
               exam_id: this.$route.query.exam_id,
          };
     },
     props: {
          index: Number,
          isAdmin: Boolean,
          question: Object,
          result: Boolean,
     },
     components: {
          imgQst,
          qcmQst,
          txtQst,
     },
     mounted() {
          if (this.isAdmin) {
               this.options = true;
               this.userVue = true;
          }
     },
     methods: {
          deleteQuestion(id) {
               QuestionsService.deleteQuestionById(id).then(
                    () => {
                         // emit event to parent
                         this.emitter.emit("questionDeleted", { id: id });
                    },
                    (error) => {
                         console.log(error);
                    }
               );
          },
     },
};
</script>

<template>
     <BaseBlock :title="'Question ' + (index + 1) + ' :'">
          <template v-if="options" #options>
               <div
                    v-if="!result"
                    class="space-x-1 bg-primary-light btn btn-sm rounded rounded-pill"
               >
                    <div class="dropdown d-inline-block">
                         <button
                              type="button"
                              class="btn btn-sm rounded rounded-pill"
                              id="dropdown-recent-orders-filters"
                              data-bs-toggle="dropdown"
                              aria-haspopup="true"
                              aria-expanded="false"
                              style="color: white"
                         >
                              <i class="fa-solid fa-gear"></i>
                              ACTIONS
                              <i class="fa fa-angle-down ms-1"></i>
                         </button>
                         <div
                              class="dropdown-menu dropdown-menu-md dropdown-menuend- fs-sm"
                              aria-labelledby="dropdown-recent-orders-filters"
                         >
                              <a
                                   @click="deleteQuestion(question.id)"
                                   class="dropdown-item fw-medium d-flex align-items-center justify-content-center"
                                   href="javascript:void(0)"
                                   style="color: #ff0000"
                                   v-if="!exam_id"
                              >
                                   <i
                                        class="fa-solid fa-trash-can"
                                        style="color: #ff0000"
                                   ></i>
                                   &nbsp;DELTETE
                              </a>
                              <a
                                   @click="
                                        () => {
                                             userVue = !userVue;
                                        }
                                   "
                                   class="dropdown-item fw-medium d-flex align-items-center justify-content-center"
                                   href="javascript:void(0)"
                                   style="color: #005eff"
                              >
                                   <i
                                        class="fa-solid fa-eye"
                                        style="color: #005eff"
                                   ></i>
                                   <span v-if="userVue"> &nbsp;USER VUE </span>
                                   <span v-else> &nbsp;ADMIN VUE </span>
                              </a>
                         </div>
                    </div>
               </div>
          </template>

          <div class="d-flextest">
               <div
                    class="question-text mb-4"
                    v-html="question.question_text"
               ></div>

               <div
                    class="result-container"
                    v-if="question.isTrue == 0 || question.isTrue == 1"
               >
                    <div v-if="question.isTrue" class="result passed">
                         <span style="font-size: 50px">1 / 1</span>
                    </div>
                    <div v-else-if="question.isTrue == 0" class="result failed">
                         <span style="font-size: 50px">0 / 1</span>
                    </div>
                    <div v-else class="result pending-review">
                         <span style="font-size: 50px">Pending review</span>
                    </div>
               </div>
          </div>

          <div v-if="question.isQcm === 1">
               <qcmQst
                    :question="question"
                    :isAdmin="userVue"
                    :index="index"
                    :result="result"
               ></qcmQst>
          </div>

          <div v-else-if="question.isQcm === 2">
               <imgQst
                    :question="question"
                    :isAdmin="userVue"
                    :index="index"
                    :result="result"
               ></imgQst>
          </div>

          <div v-else>
               <txtQst
                    :question="question"
                    :isAdmin="userVue"
                    :index="index"
                    :result="result"
               ></txtQst>
          </div>
     </BaseBlock>
</template>

<style>

.d-flextest {
    display: flex;
    align-items: center; /* Center vertically within the container */
}

.question-text {
    flex: 1; /* Allow the question text div to take up available space */
}

.result-container {
    margin-left: 20px;  
    overflow: hidden;
    display: flex;
    flex-direction: column;
    align-items: center; /* Center result vertically */
    margin: 10px 200px 10px 10px;
}

.result {
    text-align: center;
}

.passed {
    color: green;
}

.failed {
    color: red;
}

.pending-review {
    color: orange;
}

</style>
