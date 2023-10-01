<script>
import QuestionsService from "../../../services/questions.service";
import qstVue from "../components/questions/qst.vue";
export default {
     data() {
          return {
               questions: [],
               questionsFiltred: [],
               questionsFiltredCount: 0,
               orderSearch: false,
               filterTearm: this.$route.query.filterTearm,
               searchTerms: '',
               IMAGES_PATH: this.globalService.getImagesUrl(),
               spiner: true,
          };
     },
     components: {
          qstVue,
     },
     methods: {
          fetchQuestions() {
               QuestionsService.getAllQuestions().then((response) => {
                    this.questions = response.data;
                    if (this.filterTearm) this.filterByType(this.filterTearm);
                    else this.questionsFiltred = response.data;
               });
          },
          filterByType(type) {
               this.questionsFiltred = this.questions;
               if (type == "all") return;
               this.questionsFiltred = this.questions.filter((question) => {
                    return question.isQcm == type;
               });
          },
          filterBySearchTerms(newVal) {
               const terms = newVal.split(' ');
                 this.questionsFiltred = this.questions.filter((question) => {
                    return terms.every(term => {
                         return (
                              question.question_text.toLowerCase().includes(term.toLowerCase())
                         );
                    });
               });
           },
     },
     mounted() {
          //listen to event
          this.emitter.on("questionDeleted", (data) => {
               this.questions = this.questions.filter((q) => q.id != data.id);
               this.questionsFiltred = this.questionsFiltred.filter((q) => q.id != data.id);
          });
          this.fetchQuestions();
          setTimeout(() => {
               this.spiner = false;
          }, 1000);
     },
     watch: {
          searchTerms(newVal) {
               this.filterBySearchTerms(newVal);
          }
     },
};
</script>

<template>
     <!-- Page Content -->

     <!-- Hero -->
     <div class="bg-body-light">
          <div class="content content-full">
               <div class="py-3 text-center">
                    <h1 class="fw-bold mb-2">All Questions</h1>
               </div>
          </div>
     </div>
     <!-- END Hero -->
     <!-- Page Content -->
     <div class="content">
          <BaseBlock :title="`600 Questions in Total`" content-full class="animated zoomIn" :header-bg="true" transparent>
               <template #options>
                    <div class="space-x-1 bg-light">
                         <button type="button" class="btn btn-sm btn-alt-secondary" @click="() => {
                              orderSearch = !orderSearch;
                         }
                              ">
                              <i class="fa fa-search"></i>
                         </button>
                         <div class="dropdown d-inline-block">
                              <button type="button" class="btn btn-sm btn-alt-secondary" id="dropdown-recent-orders-filters"
                                   data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                   <i class="fa fa-fw fa-flask"></i>
                                   Filters
                                   <i class="fa fa-angle-down ms-1"></i>
                              </button>
                              <div class="dropdown-menu dropdown-menu-md dropdown-menu-end fs-sm"
                                   aria-labelledby="dropdown-recent-orders-filters">
                                   <a @click="filterByType(0)"
                                        class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                        href="javascript:void(0)">
                                        Text Questions
                                        <span class="badge bg-primary rounded-pill">110</span>
                                   </a>
                                   <a @click="filterByType(1)"
                                        class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                        href="javascript:void(0)">
                                        QCM Questions
                                        <span class="badge bg-primary rounded-pill">115</span>
                                   </a>
                                   <a @click="filterByType(2)"
                                        class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                        href="javascript:void(0)">
                                        Image Questions
                                        <span class="badge bg-primary rounded-pill">115</span>
                                   </a>
                                   <a @click="filterByType('all')"
                                        class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                        href="javascript:void(0)">
                                        All
                                        <span class="badge bg-primary rounded-pill">600</span>
                                   </a>
                              </div>
                         </div>
                    </div>
               </template>

               <template #content>
                    <div v-if="spiner" style="height: 300px; display:grid; place-items: center;">
                         <div class="col-6 col-md-3">
                              <i class="fa fa-4x fa-cog fa-spin"></i>
                         </div>
                    </div>
                    <div v-else>
                         <div v-if="orderSearch" id="one-dashboard-search-orders" class="block-content border-bottom">
                              <!-- Search Form -->
                              <form @submit.prevent>
                                   <div class="push">
                                        <div class="input-group">
                                             <input type="text" class="form-control form-control-alt"
                                                  id="one-ecom-orders-search" name="one-ecom-orders-search"
                                                  placeholder="Search Questions ..." v-model="searchTerms" />
                                             <span class="input-group-text bg-body border-0">
                                                  <i class="fa fa-search"></i>
                                             </span>
                                        </div>
                                   </div>
                              </form>
                              <!-- END Search Form -->
                         </div>
                         <div class="content">
                              <div v-for="(question, index) in questionsFiltred" class="col-12">
                                   <qstVue :question="question" :isAdmin="true" :index="index"></qstVue>
                              </div>
                         </div>
                    </div>
               </template>
          </BaseBlock>
     </div>
     <!-- END Page Content -->

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
