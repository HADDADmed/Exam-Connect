questions
<script>
import imgQst from "./questionsPartials/imgQst.vue";
import qcmQst from "./questionsPartials/qcmQst.vue";
import txtQst from "./questionsPartials/txtQst.vue";
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
};
</script>

<template>
     <BaseBlock :title="'Question ' + (index + 1) + ' :'">
          <template v-if="options" #options>
               <div
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
                                   @click="
                                        () => {
                                             console.log('edit');
                                        }
                                   "
                                   class="dropdown-item fw-medium d-flex align-items-center justify-content-center"
                                   href="javascript:void(0)"
                                   v-if="!exam_id"
                              >
                                   <i class="fa-solid fa-pen-to-square"></i>
                                   &nbsp;&nbsp;&nbsp;EDIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                              </a>
                              <a
                                   @click="
                                        () => {
                                             console.log('delete');
                                        }
                                   "
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
          <div class="mb-4" v-html="question.question_text"></div>

          <div v-if="question.isQcm === 1">
               <qcmQst
                    :question="question"
                    :isAdmin="userVue"
                    :index="index"
               ></qcmQst>
          </div>

          <div v-else-if="question.isQcm === 2">
               <imgQst
                    :question="question"
                    :isAdmin="userVue"
                    :index="index"
               ></imgQst>
          </div>

          <div v-else>
               <txtQst
                    :question="question"
                    :isAdmin="userVue"
                    :index="index"
               ></txtQst>
          </div>
     </BaseBlock>
</template>

<style></style>
