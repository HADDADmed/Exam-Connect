<script>
import ExamsService from "../../../services/exams.service";
export default {
     data() {
          return {
               bgClass: ["bg-city", "bg-flat", "bg-amethyst", "bg-smooth", "bg-default", "bg-modern", "bg-warning", "bg-success", "bg-info", "bg-danger", "bg-gray-dark", "bg-primary",],
               exams: [],
               examsFiltred: [],
               examsFiltredDate: [],
               examsCount: 0,
               examsFiltredCount: 0,
               filterTearm: "",
               dateFilter: 'all',
               orderSearch: false,
               spiner: false,
               examsByDateCount:{
                    total: 0 ,
                    today: 0,
                    last7Days: 0,
                    last30Days: 0,
                    last3Months: 0,
                    thisYear: 0,
               }
          };
     }, methods: {
          async fetchExams() {
               await ExamsService.getAllExams().then((response) => {
                    const examsCustom = response.data.map((exam) => {

                         return {
                              ...exam,
                              qcmQuestions: exam.questions.filter((q) => q.isQcm === 1).length,
                              textQuestions: exam.questions.filter((q) => q.isQcm === 0).length,
                              imageQuestions: exam.questions.filter((q) => q.isQcm === 2).length,
                              createdAt: new Date(exam.createdAt).toLocaleDateString(),
                              examDuration: exam.duration_minutes,
                         };
                    });
                    this.exams = examsCustom;
                    this.examsFiltred = examsCustom;
                    this.examsCount = examsCustom.length;
                    this.examsFiltredCount = this.examsFiltred.length;


                    this.examsByDateCount.total = this.exams.length;
                    this.examsByDateCount.today = this.exams.filter((exam) => {
                         const today = new Date();
                         return (
                              new Date(exam.createdAt).getDate() === today.getDate()
                         );
                    }).length;

                    this.examsByDateCount.last7Days = this.exams.filter((exam) => {
                         const today = new Date();
                         const lastWeek = new Date(
                              today.getFullYear(),
                              today.getMonth(),
                              today.getDate() - 7
                         );
                         return (
                              new Date(exam.createdAt) >= lastWeek &&
                              new Date(exam.createdAt) <= today
                         );
                    }).length;
                    this.examsByDateCount.last3Months  = this.exams.filter((exam) => {
                         const today = new Date();
                         const last3Month = new Date(
                              today.getFullYear(),
                              today.getMonth() - 3,
                              today.getDate()
                         );
                         return (
                              new Date(exam.createdAt) >= last3Month &&
                              new Date(exam.createdAt) <= today
                         );
                    }).length;

                    this.examsByDateCount.last30Days = this.exams.filter((exam) => {
                         const today = new Date();
                         const lastMonth = new Date(
                              today.getFullYear(),
                              today.getMonth() - 1,
                              today.getDate()
                         );
                         return (
                              new Date(exam.createdAt) >= lastMonth &&
                              new Date(exam.createdAt) <= today
                         );
                    }).length;

                    this.examsByDateCount.thisYear = this.exams.filter((exam) => {
                         const today = new Date();
                         const thisYear = new Date(
                              today.getFullYear(),
                              today.getMonth() - 12,
                              today.getDate()
                         )
                         return (
                              new Date(exam.createdAt) >= thisYear &&
                              new Date(exam.createdAt) <= today
                         );
                    }).length;
               });
          },
          filterDate(dateFilter) {
               //  filter the array of exams by the createAt date of each one by a terme like "last 7 days" or "last 30 days"
               const today = new Date();
               const lastWeek = new Date(
                    today.getFullYear(),
                    today.getMonth(),
                    today.getDate() - 7
               );
               const lastMonth = new Date(
                    today.getFullYear(),
                    today.getMonth() - 1,
                    today.getDate()
               );
               const last3Month = new Date(
                    today.getFullYear(),
                    today.getMonth() - 3,
                    today.getDate()
               );
               const thisYear = new Date(
                    today.getFullYear(),
                    today.getMonth() - 12,
                    today.getDate()
               )
               this.dateFilter = dateFilter;
               if (dateFilter === 0) // today filter
               {
                    this.examsFiltred = this.exams.filter((exam) => {
                         return (
                              new Date(exam.createdAt).getDate() === today.getDate()
                         );
                    });
               } else
                    if (dateFilter === 1) {
                         this.examsFiltred = this.exams.filter((exam) => {
                              return (
                                   new Date(exam.createdAt) >= lastWeek &&
                                   new Date(exam.createdAt) <= today
                              );
                         });
                    } else if (dateFilter === 2) {
                         this.examsFiltred = this.exams.filter((exam) => {
                              return (
                                   new Date(exam.createdAt) >= lastMonth &&
                                   new Date(exam.createdAt) <= today
                              );
                         });
                    } else if (dateFilter === 3) {
                         this.examsFiltred = this.exams.filter((exam) => {
                              return (
                                   new Date(exam.createdAt) >= last3Month &&
                                   new Date(exam.createdAt) <= today
                              );
                         });
                    } else if (dateFilter === 4) {
                         this.examsFiltred = this.exams.filter((exam) => {
                              return (
                                   new Date(exam.createdAt) >= thisYear &&
                                   new Date(exam.createdAt) <= today
                              );
                         });
                    } else {
                         this.examsFiltred = this.exams;
                    }
               this.examsFiltredCount = this.examsFiltred.length;
               this.examsFiltredDate = this.examsFiltred;
               // the 0 is for today filter
               // the 1 is for last 7 days
               // the 2 is for last 30 days
               // the 3 is for last 3 months
               // the 4 is for this year
          },
          search(newValue) {
               // split search string into individual words to search for each one individually
               const words = newValue.split(" ");          // filter the array of exams by checking if the ExamTitle includes all the words in the search string

               if ((this.dateFilter == 'all')) this.examsFiltred = this.exams;
               else this.examsFiltred = this.examsFiltredDate;

               this.examsFiltred = this.examsFiltred.filter((exam) => {
                    return words.every((word) => {
                         return exam.ExamTitle.toLowerCase().includes(word.toLowerCase());
                    });
               });


               this.examsFiltredCount = this.examsFiltred.length;
          },
     },
     mounted() {
          this.fetchExams()
     },
     watch: {
          filterTearm(newValue) {
               this.search(newValue);
          },
     },
};
</script>

<template>
     <!-- Hero Content -->
     <div class="bg-primary-dark">
          <div class="content content-full text-center pt-7 pb-5">
               <h1 class="h2 text-white mb-2">List of All Exams.</h1>
               <h2 class="h4 fw-normal text-white-75">
                    <strong> {{ examsCount }}</strong> exam in Total .
               </h2>
          </div>
     </div>
     <!-- END Hero Content -->
     <BaseBlock :title="`${examsFiltredCount} exam in Total .`" content-full class="animated zoomIn    "
          style="margin: 20px 40px -20px 40px;  " header-class="bg-city-light rounded " :headerBg="false">
          <template #options>
               <div class="space-x-1 bg-light rounded rounded-pill">
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
                              <a @click="filterDate('all')"
                                   class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                   href="javascript:void(0)">
                                   All time
                                   <span class="badge bg-primary rounded-pill">{{ examsByDateCount.total }}</span>
                              </a>
                              <div class="dropdown-divider"></div>
                              <a @click="filterDate(0)"
                                   class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                   href="javascript:void(0)">
                                   today
                                   <span class="badge bg-primary rounded-pill">{{examsByDateCount.today}}</span>
                              </a>
                              <a @click="filterDate(1)"
                                   class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                   href="javascript:void(0)">
                                   Last 7 days
                                   <span class="badge bg-primary rounded-pill">{{examsByDateCount.last7Days}}</span>
                              </a>
                              <a @click="filterDate(2)"
                                   class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                   href="javascript:void(0)">
                                   Last 30 days
                                   <span class="badge bg-primary rounded-pill">{{examsByDateCount.last30Days}}</span>
                              </a>
                              <a @click="filterDate(3)"
                                   class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                   href="javascript:void(0)">
                                   Last 3 months
                                   <span class="badge bg-primary rounded-pill">{{examsByDateCount.last3Months}}</span>
                              </a>
                              <div class="dropdown-divider"></div>
                              <a @click="filterDate(4)"
                                   class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                   href="javascript:void(0)">
                                   This year
                                   <span class="badge bg-primary rounded-pill">{{examsByDateCount.thisYear}}</span>
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
                                        <input type="text" class="form-control form-control-alt" id="one-ecom-orders-search"
                                             name="one-ecom-orders-search" placeholder="Search Exam By Title ..."
                                             v-model="filterTearm" />
                                        <span class="input-group-text bg-body border-0">
                                             <i class="fa fa-search"></i>
                                        </span>
                                   </div>
                              </div>
                         </form>
                         <!-- END Search Form -->
                    </div>

               </div>
          </template>
     </BaseBlock>



     <!-- Page Content -->
     <div class="content content-boxed">
          <div class="row items-push py-4">
               <!-- Course -->
               <div v-for="exam in examsFiltred" class="col-md-6 col-lg-4 col-xl-3">
                    <RouterLink :to="{
                         name: 'examconnect-exams-exam',
                         query: { exam_id: exam.exam_id },
                    }" custom v-slot="{ href, navigate }">
                         <BaseBlock :href="href" @click="navigate" tag="a" link-pop class="h-100 mb-0">
                              <template #options>
                                   <div class="space-x-1 bg-light">
                                        <button type="button" class="btn btn-sm btn-alt-secondary" @click="() => {
                                             orderSearch = !orderSearch;
                                        }
                                             ">
                                             <i class="fa fa-search"></i>
                                        </button>
                                        <div class="dropdown d-inline-block">
                                             <button type="button" class="btn btn-sm btn-alt-secondary"
                                                  id="dropdown-recent-orders-filters" data-bs-toggle="dropdown"
                                                  aria-haspopup="true" aria-expanded="false">
                                                  <i class="fa fa-fw fa-flask"></i>
                                                  Filters
                                                  <i class="fa fa-angle-down ms-1"></i>
                                             </button>
                                             <div class="dropdown-menu dropdown-menu-md dropdown-menu-end fs-sm"
                                                  aria-labelledby="dropdown-recent-orders-filters">
                                                  <a @click="filter(0)"
                                                       class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                                       href="javascript:void(0)">
                                                       Text Questions
                                                       <span class="badge bg-primary rounded-pill">110</span>
                                                  </a>
                                                  <a @click="filter(1)"
                                                       class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                                       href="javascript:void(0)">
                                                       QCM Questions
                                                       <span class="badge bg-primary rounded-pill">115</span>
                                                  </a>
                                                  <a @click="filter(2)"
                                                       class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                                       href="javascript:void(0)">
                                                       Image Questions
                                                       <span class="badge bg-primary rounded-pill">115</span>
                                                  </a>
                                                  <a @click="filter('all')"
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
                                   <div class="block-content block-content-full text-center" :class="bgClass[
                                        Math.floor(
                                             Math.random() *
                                             bgClass.length
                                        )
                                   ]
                                        ">
                                        <div style="font-size: 40px ; width: 250px"
                                             class="item item-2x item-square bg-white-10 py-3 my-3 mx-auto">
                                             <h5 style="margin-top: 20px; font-size: 25px; font-weight: 900;">
                                                  {{ exam.ExamTitle }}
                                             </h5>
                                        </div>
                                        <div class="fs-sm text-white-75">
                                             {{ exam.questionsCount }} Questions
                                             &bull;
                                             {{
                                                  globalService.minutesToHours(
                                                       exam.examDuration
                                                  )
                                             }}
                                        </div>
                                   </div>
                                   <div class="block-content block-content-full">
                                        <div class="fs-sm text-muted">
                                             <strong> Created At :</strong> {{ exam.createdAt }}
                                        </div>

                                        <br>
                                        <div style="font-size: large">
                                             <strong>{{ exam.qcmQuestions }}
                                             </strong>
                                             QCM Question<span v-if="exam.qcmQuestions >= 2">s</span>
                                        </div>
                                        <div style="font-size: large">
                                             <strong>{{ exam.textQuestions }}
                                             </strong>
                                             Text Question<span v-if="exam.textQuestions >= 2">s</span>
                                        </div>
                                        <div style="font-size: large">
                                             <strong>{{ exam.imageQuestions }}
                                             </strong>
                                             Image Question<span v-if="exam.imageQuestions >= 2">s</span>
                                        </div>
                                        <br>
                                        <div class="mb-1">
                                             <strong>{{ exam.usersCount }}
                                             </strong>
                                             user<span v-if="exam.usersCount >= 2">s</span> asigned

                                        </div>
                                   </div>

                              </template>
                         </BaseBlock>
                    </RouterLink>
               </div>
               <!-- END Course -->
          </div>
     </div>
     <!-- END Page Content -->
</template>
