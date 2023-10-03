<script setup>
import { onMounted, reactive, ref } from "vue";

// vue-chartjs, for more info and examples you can check out https://vue-chartjs.org/ and http://www.chartjs.org/docs/ -->
import { Line, Pie } from "vue-chartjs";
import { Chart, registerables } from "chart.js";
import DashboardService from "@/services/dashboard.service.js";
Chart.register(...registerables);
// Set Global Chart.js configuration
Chart.defaults.color = "#818d96";
Chart.defaults.font.weight = "600";
Chart.defaults.scale.grid.color = "rgba(0, 0, 0, .05)";
Chart.defaults.scale.grid.zeroLineColor = "rgba(0, 0, 0, .1)";
Chart.defaults.scale.beginAtZero = true;
Chart.defaults.elements.line.borderWidth = 2;
Chart.defaults.elements.point.radius = 4;
Chart.defaults.elements.point.hoverRadius = 6;
Chart.defaults.plugins.tooltip.radius = 3;
Chart.defaults.plugins.legend.labels.boxWidth = 15;


const showPassword = ref([]);

var chartPolarPieDonutData = ref({
     labels: ["", "", "", ""],
     datasets: [
          {
               data: ["", "", "", ""],
               backgroundColor: ["", "", "", ""],
               hoverBackgroundColor: ["", "", "", ""],
          },
     ],
});

var chartPolarPieDonutDataquestions = ref({
     labels: ["", "", ""],
     datasets: [
          {
               data: ["", "", ""],
               backgroundColor: ["", "", ""],
               hoverBackgroundColor: ["", "", ""],
          },
     ],
});


// Helper variables
const orderSearch = ref(false);

// Chart Total Orders data
const totalFailedExams = reactive({
     labels: [
          "MON",
          "TUE",
          "WED",
          "THU",
          "FRI",
          "SAT",
          "SUN",
          "MON",
          "TUE",
          "WED",
          "THU",
          "FRI",
          "SAT",
          "SUN",
     ],
     datasets: [
          {
               label: "Total Failed Exams",
               fill: true,
               backgroundColor: "rgba(220, 38, 38, .15)",
               borderColor: "transparent",
               pointBackgroundColor: "rgba(220, 38, 38, 1)",
               pointBorderColor: "#fff",
               pointHoverBackgroundColor: "#fff",
               pointHoverBorderColor: "rgba(220, 38, 38, 1)",
               data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          },
     ],
});

// Chart Total Orders options
const totalFailedOptions = reactive({
     maintainAspectRatio: false,
     tension: 0.4,
     scales: {
          x: {
               display: false,
          },
          y: {
               display: false,
          },
     },
     interaction: {
          intersect: false,
     },
     plugins: {
          legend: {
               display: false,
          },
          tooltip: {
               callbacks: {
                    label: function (context) {
                         return " " + context.parsed.y + " failed exams";
                    },
               },
          },
     },
});
// Chart Total Earnings data
const totalPassedExamsData = reactive({
     labels: [
          "MON",
          "TUE",
          "WED",
          "THU",
          "FRI",
          "SAT",
          "SUN",
          "MON",
          "TUE",
          "WED",
          "THU",
          "FRI",
          "SAT",
          "SUN",
     ],
     datasets: [
          {
               label: "Total Passed Exams",
               fill: true,
               backgroundColor: "rgba(101, 163, 13, .15)",
               borderColor: "transparent",
               pointBackgroundColor: "rgba(101, 163, 13, 1)",
               pointBorderColor: "#fff",
               pointHoverBackgroundColor: "#fff",
               pointHoverBorderColor: "rgba(101, 163, 13, 1)",
               data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
          },
     ],
});

// Chart Total Earnings options
const totalPassedExamsOptions = reactive({
     maintainAspectRatio: false,
     tension: 0.4,
     scales: {
          x: {
               display: false,
          },
          y: {
               display: false,
          },
     },
     interaction: {
          intersect: false,
     },
     plugins: {
          legend: {
               display: false,
          },
          tooltip: {
               callbacks: {
                    label: function (context) {
                         return " " + context.parsed.y;
                    },
               },
          },
     },
});

let user_exams = ref([]);
let examsStatistics = ref({
     notStarted: 0,
     inProgress: 0,
     pendingReview: 0,
     failed: 0,
     passed: 0,
     totalUserExams: 0,
     totalExams: 0,
});
async function getExamsStatistics() {
     try {
          DashboardService.getExamsStatistics().then((response) => {
               user_exams.value = response.data.user_exams;
               examsStatistics.value.totalUserExams = user_exams.value.length;
               examsStatistics.value.totalExams =
                    user_exams.value[0].total_exams;
               user_exams.value.forEach((row) => {
                    if (row.user_exam_status === "notStarted") {
                         examsStatistics.value.notStarted++;
                    } else if (row.user_exam_status === "inProgress") {
                         examsStatistics.value.inProgress++;
                    } else if (row.user_exam_status === "pendingReview") {
                         examsStatistics.value.pendingReview++;
                    } else if (row.user_exam_status === "failed") {
                         examsStatistics.value.failed++;
                    } else if (row.user_exam_status === "passed") {
                         examsStatistics.value.passed++;
                    }
               });

               chartPolarPieDonutData.value = {
                    labels: ["NOTSTARTED", "PENDINGREVIEW", "FAILED", "PASSED"],
                    datasets: [
                         {
                              data: [
                                   examsStatistics.value.notStarted,
                                   examsStatistics.value.pendingReview,
                                   examsStatistics.value.failed,
                                   examsStatistics.value.passed,
                              ],
                              backgroundColor: [
                                   "	rgb(255,215,0,0.75)", // New color for "notStarted"
                                   "	rgb(30,144,255,0.75)", // New color for "pendingReview"
                                   "	rgb(255,0,0,0.75)", // New color for "failed"
                                   "	rgb(0,255,0,0.75)", // New color for "passed"
                              ],
                              hoverBackgroundColor: [
                                   "	rgb(255,215,0,0.75)", // New hover color for "notStarted"
                                   "	rgb(30,144,255,0.75)", // New hover color for "pendingReview"
                                   "	rgb(255,0,0,0.75)", // New hover color for "failed"
                                   "	rgb(0,255,0,0.75)", // New hover color for "passed"
                              ],
                         },
                    ],
               };

          });
     } catch (error) {
          console.log(error);
     }
}


let questionsStatistics = ref({});

async function getQuestionsStatistics() {
     try {
          DashboardService.getQuestionsStatistics().then((response) => {
               questionsStatistics.value = response.data.questionsStatistics;
               chartPolarPieDonutDataquestions.value = {
                    labels: ["MCQ Questions", "IMAGES Questions", "TEXT Questions"],
                    datasets: [
                         {
                              data: [
                                   questionsStatistics.value.qcmQuestions,
                                   questionsStatistics.value.imgQuestions,
                                   questionsStatistics.value.textQuestions,
                              ],
                              backgroundColor: [
                                   "rgb(255,182,193)", // New color for "notStarted"
                                   "rgb(0,255,255", // New color for "pendingReview"
                                   "rgb(169,169,169)", // New color for "failed"
                              ],
                              hoverBackgroundColor: [
                                   "rgb(255,182,193)", // New hover color for "notStarted"
                                   "rgb(0,255,255", // New hover color for "pendingReview"
                                   "rgb(169,169,169)", // New hover color for "failed"
                              ],
                         },
                    ],
               };

          });
     } catch (error) {
          console.log(error);
     }
}



let users = ref([]);
async function getUsers() {
     try {
          DashboardService.getUsersStatistics().then((response) => {
               users.value = response.data.users;
               users.value.forEach((row) => {
                    showPassword.value.push(false);
               });
           });
     } catch (error) {
          console.log(error);
     }
}

onMounted(() => {
     getExamsStatistics();
     setTimeout(() => {
          getQuestionsStatistics();
          setTimeout(() => {
               getUsers();
          }, 1000);
     }, 1500);
});
</script>

<template>
     <div class="header">
          <!-- Hero -->
          <div class="content">
               <div
                    class="d-flex flex-column flex-md-row justify-content-md-between align-items-md-center py-2 text-center text-md-start">
                    <div class="flex-grow-1 mb-1 mb-md-0">
                         <h2 class="h6 fw-medium fw-medium text-muted mb-0">
                              Welcome
                              <span style="color: red"><strong>ADMIM</strong></span>
                              , everything looks great.
                         </h2>
                    </div>
               </div>
          </div>
          <!-- END Hero -->
     </div>

     <div class="header">
          <!-- Hero -->
          <div class="content">
               <div
                    class="d-flex flex-column flex-md-row justify-content-md-between align-items-md-center py-2 text-center text-md-start">
                    <div class="flex-grow-1 mb-1 mb-md-0">
                         <h1 class="h3 fw-bold mb-2">Exams</h1>
                         <h2 class="h6 fw-medium fw-medium text-muted mb-0">
                              EXAMS STATISTICS
                         </h2>
                    </div>
                    <div class="mt-3 mt-md-0 ms-md-3 space-x-1">

                         <div class="dropdown d-inline-block">
                              <button type="button" class="btn btn-sm btn-alt-secondary space-x-1"
                                   id="dropdown-analytics-overview" data-bs-toggle="dropdown" aria-haspopup="true"
                                   aria-expanded="false">
                                   <i class="fa fa-fw fa-calendar-alt opacity-50"></i>
                                   <span>All time</span>
                                   <i class="fa fa-fw fa-angle-down"></i>
                              </button>
                              <div class="dropdown-menu dropdown-menu-end fs-sm"
                                   aria-labelledby="dropdown-analytics-overview">
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last 30 days</a>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last month</a>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last 3 months</a>
                                   <div class="dropdown-divider"></div>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">This year</a>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last Year</a>
                                   <div class="dropdown-divider"></div>
                                   <a class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                        href="javascript:void(0)">
                                        <span>All time</span>
                                        <i class="fa fa-check"></i>
                                   </a>
                              </div>
                         </div>
                    </div>
               </div>
          </div>
          <!-- END Hero -->
     </div>

     <!-- Page Content -->
     <div class="content">
          <div class="examsStat">
               <!-- Overview -->
               <div class="row items-push">
                    <div class="col-sm-6 col-xxl-3">
                         <!-- Pending Orders -->
                         <BaseBlock class="d-flex flex-column h-100 mb-0">
                              <template #content>
                                   <div
                                        class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
                                        <dl class="mb-0">
                                             <dt class="fs-3 fw-bold">{{ examsStatistics.notStarted }}</dt>
                                             <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">
                                                  User Exam Not Started
                                             </dd>
                                        </dl>
                                        <div class="item item-rounded-lg bg-body-light">
                                             <i class="fa-solid fa-hourglass-start"></i>
                                        </div>
                                   </div>
                                   <div class="bg-body-light rounded-bottom">
                                        <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             <span>View all the Not Started User
                                                  Exams
                                             </span>
                                             <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
                                        </a>
                                   </div>
                              </template>
                         </BaseBlock>
                         <!-- END Pending Orders -->
                    </div>
                    <div class="col-sm-6 col-xxl-3">
                         <!-- New Customers -->
                         <BaseBlock class="d-flex flex-column h-100 mb-0">
                              <template #content>
                                   <div
                                        class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
                                        <dl class="mb-0">
                                             <dt class="fs-3 fw-bold">{{ examsStatistics.pendingReview }}</dt>
                                             <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">
                                                  User Exam Pending your Review
                                             </dd>
                                        </dl>
                                        <div class="item item-rounded-lg bg-body-light">
                                             <i class="fa-solid fa-hourglass-end"></i>
                                        </div>
                                   </div>
                                   <div class="bg-body-light rounded-bottom">
                                        <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             <span>View all Pending Review User
                                                  Exams</span>
                                             <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
                                        </a>
                                   </div>
                              </template>
                         </BaseBlock>
                         <!-- END New Customers -->
                    </div>
                    <div class="col-sm-6 col-xxl-3">
                         <!-- Messages -->
                         <BaseBlock class="d-flex flex-column h-100 mb-0">
                              <template #content>
                                   <div
                                        class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
                                        <dl class="mb-0">
                                             <dt class="fs-3 fw-bold">{{ examsStatistics.totalExams }}</dt>
                                             <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">
                                                  User Exam In Total
                                             </dd>
                                        </dl>
                                        <div class="item item-rounded-lg bg-body-light">
                                             <i class="fa-solid fa-chalkboard-user"></i>
                                        </div>
                                   </div>
                                   <div class="bg-body-light rounded-bottom">
                                        <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             <span>View all User Exams</span>
                                             <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
                                        </a>
                                   </div>
                              </template>
                         </BaseBlock>
                         <!-- END Messages -->
                    </div>
                    <div class="col-sm-6 col-xxl-3">
                         <!-- Conversion Rate -->
                         <BaseBlock class="d-flex flex-column h-100 mb-0">
                              <template #content>
                                   <div
                                        class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
                                        <dl class="mb-0">
                                             <dt class="fs-3 fw-bold">{{ examsStatistics.totalUserExams }}</dt>
                                             <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">
                                                  Exam in Total
                                             </dd>
                                        </dl>
                                        <div class="item item-rounded-lg bg-body-light">
                                             <i class="fa-solid fa-chalkboard"></i>
                                        </div>
                                   </div>
                                   <div class="bg-body-light rounded-bottom">
                                        <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             <span>View All Exams</span>
                                             <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
                                        </a>
                                   </div>
                              </template>
                         </BaseBlock>
                         <!-- END Conversion Rate-->
                    </div>
               </div>
               <!-- END Overview -->

               <!-- Statistics -->
               <div class="row">
                    <div class="col-xl-8 col-xxl-9 d-flex flex-column">
                         <!-- Earnings Summary -->
                         <BaseBlock class="flex-grow-1 d-flex flex-column">
                              <template #options>
                                   <button type="button" class="btn-block-option">
                                        <i class="si si-settings"></i>
                                   </button>
                              </template>

                              <template #content>
                                   <!-- Pie Chart -->
                                   <BaseBlock content-full content-class="text-center">
                                        <div class="py-3 px-xxl-7">
                                             <Pie :data="chartPolarPieDonutData" :options="{
                                                  maintainAspectRatio: false,
                                             }" style="height: 350px" />
                                        </div>
                                   </BaseBlock>
                              </template>
                         </BaseBlock>
                         <!-- END Earnings Summary -->
                    </div>
                    <div class="col-xl-4 col-xxl-3 d-flex flex-column">
                         <!-- Last 2 Weeks -->
                         <div class="row items-push flex-grow-1">
                              <div class="col-md-6 col-xl-12">
                                   <BaseBlock class="d-flex flex-column h-100 mb-0">
                                        <template #content>
                                             <div class="block-content flex-grow-1 d-flex justify-content-between">
                                                  <dl class="mb-0">
                                                       <dt class="fs-3 fw-bold">
                                                            {{ examsStatistics.failed }}
                                                            <i class="fa-solid fa-circle-xmark" style="
                                                                      color: #ff0000;
                                                                 "></i>
                                                       </dt>
                                                       <dd class="fs-sm fw-medium text-muted mb-0">
                                                            Total Failed Exams
                                                       </dd>
                                                  </dl>
                                                  <div></div>
                                             </div>
                                             <div class="block-content p-1 text-center overflow-hidden">
                                                  <Line :data="totalFailedExams" :options="totalFailedOptions
                                                       " style="height: 90px" />
                                             </div>

                                             <div class="bg-body-light rounded-bottom">
                                                  <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between"
                                                       href="javascript:void(0)">
                                                       <span>View all The Failed
                                                            Exams
                                                       </span>
                                                       <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
                                                  </a>
                                             </div>
                                        </template>
                                   </BaseBlock>
                              </div>
                              <div class="col-md-6 col-xl-12">
                                   <BaseBlock class="d-flex flex-column h-100 mb-0">
                                        <template #content>
                                             <div class="block-content flex-grow-1 d-flex justify-content-between">
                                                  <dl class="mb-0">
                                                       <dt class="fs-3 fw-bold">
                                                            {{ examsStatistics.passed }}
                                                            <i class="fa-solid fa-circle-check" style="
                                                                      color: #59ff00;
                                                                 "></i>
                                                       </dt>
                                                       <dd class="fs-sm fw-medium text-muted mb-0">
                                                            Total Passed Exams
                                                       </dd>
                                                  </dl>
                                                  <div></div>
                                             </div>
                                             <div class="block-content p-1 text-center overflow-hidden">
                                                  <Line :data="totalPassedExamsData
                                                       " :options="totalPassedExamsOptions
          " style="height: 90px" />
                                             </div>
                                             <div class="bg-body-light rounded-bottom">
                                                  <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between"
                                                       href="javascript:void(0)">
                                                       <span>View all the Passed
                                                            Exams
                                                       </span>
                                                       <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
                                                  </a>
                                             </div>
                                        </template>
                                   </BaseBlock>
                              </div>
                         </div>
                         <!-- END Last 2 Weeks -->
                    </div>
               </div>
               <!-- END Statistics -->
          </div>
     </div>

     <div class="header">
          <!-- Hero -->
          <div class="content">
               <div
                    class="d-flex flex-column flex-md-row justify-content-md-between align-items-md-center py-2 text-center text-md-start">
                    <div class="flex-grow-1 mb-1 mb-md-0">
                         <h1 class="h3 fw-bold mb-2">Questions</h1>
                         <h2 class="h6 fw-medium fw-medium text-muted mb-0">
                              QUESTIONS STATISTICS
                         </h2>
                    </div>
                    <div class="mt-3 mt-md-0 ms-md-3 space-x-1">

                         <div class="dropdown d-inline-block">
                              <button type="button" class="btn btn-sm btn-alt-secondary space-x-1"
                                   id="dropdown-analytics-overview" data-bs-toggle="dropdown" aria-haspopup="true"
                                   aria-expanded="false">
                                   <i class="fa fa-fw fa-calendar-alt opacity-50"></i>
                                   <span>All time</span>
                                   <i class="fa fa-fw fa-angle-down"></i>
                              </button>
                              <div class="dropdown-menu dropdown-menu-end fs-sm"
                                   aria-labelledby="dropdown-analytics-overview">
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last 30 days</a>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last month</a>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last 3 months</a>
                                   <div class="dropdown-divider"></div>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">This year</a>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last Year</a>
                                   <div class="dropdown-divider"></div>
                                   <a class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                        href="javascript:void(0)">
                                        <span>All time</span>
                                        <i class="fa fa-check"></i>
                                   </a>
                              </div>
                         </div>
                    </div>
               </div>
          </div>
          <!-- END Hero -->
     </div>

     <div class="content">
          <div class="questionsStat">
               <!-- TEST -->
               <!-- Overview -->
               <div class="row items-push">
                    <div class="col-sm-6 col-xxl-3">
                         <!-- Pending Orders -->
                         <BaseBlock class="d-flex flex-column h-100 mb-0">
                              <template #content>
                                   <div
                                        class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
                                        <dl class="mb-0">
                                             <dt class="fs-3 fw-bold">{{ questionsStatistics.qcmQuestions }}</dt>
                                             <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">
                                                  MCQ (QCM) Questions
                                             </dd>
                                        </dl>
                                        <div class="item item-rounded-lg bg-body-light">
                                             <i class="fa-solid fa-circle-question"></i>
                                        </div>
                                   </div>
                                   <div class="bg-body-light rounded-bottom">
                                        <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             <span>View all MCQ (QCM)
                                                  Questions</span>
                                             <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
                                        </a>
                                   </div>
                              </template>
                         </BaseBlock>
                         <!-- END Pending Orders -->
                    </div>
                    <div class="col-sm-6 col-xxl-3">
                         <!-- New Customers -->
                         <BaseBlock class="d-flex flex-column h-100 mb-0">
                              <template #content>
                                   <div
                                        class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
                                        <dl class="mb-0">
                                             <dt class="fs-3 fw-bold">{{ questionsStatistics.textQuestions }}</dt>
                                             <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">
                                                  Text Questions
                                             </dd>
                                        </dl>
                                        <div class="item item-rounded-lg bg-body-light">
                                             <i class="fa-solid fa-pencil"></i>
                                        </div>
                                   </div>
                                   <div class="bg-body-light rounded-bottom">
                                        <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             <span>View all the Text Questions
                                             </span>
                                             <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
                                        </a>
                                   </div>
                              </template>
                         </BaseBlock>
                         <!-- END New Customers -->
                    </div>
                    <div class="col-sm-6 col-xxl-3">
                         <!-- Messages -->
                         <BaseBlock class="d-flex flex-column h-100 mb-0">
                              <template #content>
                                   <div
                                        class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
                                        <dl class="mb-0">
                                             <dt class="fs-3 fw-bold">{{ questionsStatistics.imgQuestions }}</dt>
                                             <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">
                                                  Image Questions
                                             </dd>
                                        </dl>
                                        <div class="item item-rounded-lg bg-body-light">
                                             <i class="fa-solid fa-circle-question"></i>
                                        </div>
                                   </div>
                                   <div class="bg-body-light rounded-bottom">
                                        <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             <span>View all Images
                                                  Questions</span>
                                             <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
                                        </a>
                                   </div>
                              </template>
                         </BaseBlock>
                         <!-- END Messages -->
                    </div>
                    <div class="col-sm-6 col-xxl-3">
                         <!-- Conversion Rate -->
                         <BaseBlock class="d-flex flex-column h-100 mb-0">
                              <template #content>
                                   <div
                                        class="block-content block-content-full flex-grow-1 d-flex justify-content-between align-items-center">
                                        <dl class="mb-0">
                                             <dt class="fs-3 fw-bold">{{ questionsStatistics.total_questions }}</dt>
                                             <dd class="fs-sm fw-medium fs-sm fw-medium text-muted mb-0">
                                                  Questions in Total
                                             </dd>
                                        </dl>
                                        <div class="item item-rounded-lg bg-body-light">
                                             <i class="fa fa-chart-bar fs-3 text-primary"></i>
                                        </div>
                                   </div>
                                   <div class="bg-body-light rounded-bottom">
                                        <a class="block-content block-content-full block-content-sm fs-sm fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             <span>View statistics</span>
                                             <i class="fa fa-arrow-alt-circle-right ms-1 opacity-25 fs-base"></i>
                                        </a>
                                   </div>
                              </template>
                         </BaseBlock>
                         <!-- END Conversion Rate-->
                    </div>
               </div>
               <!-- END Overview -->

               <!-- Statistics -->
               <div class="row">
                    <!-- <div :class="whoseAuthenticated=='USER'?'d-flex justify-content-center align-item-center':'col-xl-8 col-xxl-9 d-flex flex-column'"> -->

                    <div class="col-xl-12 col-xxl-12 d-flex flex-column">
                         <!-- Earnings Summary -->
                         <BaseBlock class="flex-grow-1 d-flex flex-column">
                              <template #options>
                                   <button type="button" class="btn-block-option">
                                        <i class="si si-settings"></i>
                                   </button>
                              </template>

                              <template #content>
                                   <BaseBlock content-full content-class="text-center">
                                        <div class="py-3 px-xxl-7">
                                             <Pie :data="chartPolarPieDonutDataquestions
                                                  " :options="{
          maintainAspectRatio: false,
     }" style="height: 350px" />
                                        </div>
                                   </BaseBlock>
                              </template>
                         </BaseBlock>
                         <!-- END Earnings Summary -->
                    </div>
               </div>
               <!-- END Statistics -->

               <!-- ENDTEST  -->
          </div>
     </div>
     <div class="header">
          <!-- Hero -->
          <div class="content">
               <div
                    class="d-flex flex-column flex-md-row justify-content-md-between align-items-md-center py-2 text-center text-md-start">
                    <div class="flex-grow-1 mb-1 mb-md-0">
                         <h1 class="h3 fw-bold mb-2">Users</h1>
                         <h2 class="h6 fw-medium fw-medium text-muted mb-0">
                              USERS OVERVIEW
                         </h2>
                    </div>
                    <div class="mt-3 mt-md-0 ms-md-3 space-x-1">
                         <a href="javascript:void(0)" class="btn btn-sm btn-alt-secondary space-x-1">
                              <i class="fa fa-cogs opacity-50"></i>
                              <span>Settings</span>
                         </a>
                         <div class="dropdown d-inline-block">
                              <button type="button" class="btn btn-sm btn-alt-secondary space-x-1"
                                   id="dropdown-analytics-overview" data-bs-toggle="dropdown" aria-haspopup="true"
                                   aria-expanded="false">
                                   <i class="fa fa-fw fa-calendar-alt opacity-50"></i>
                                   <span>All time</span>
                                   <i class="fa fa-fw fa-angle-down"></i>
                              </button>
                              <div class="dropdown-menu dropdown-menu-end fs-sm"
                                   aria-labelledby="dropdown-analytics-overview">
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last 30 days</a>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last month</a>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last 3 months</a>
                                   <div class="dropdown-divider"></div>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">This year</a>
                                   <a class="dropdown-item fw-medium" href="javascript:void(0)">Last Year</a>
                                   <div class="dropdown-divider"></div>
                                   <a class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                        href="javascript:void(0)">
                                        <span>All time</span>
                                        <i class="fa fa-check"></i>
                                   </a>
                              </div>
                         </div>
                    </div>
               </div>
          </div>
          <!-- END Hero -->
     </div>

     <div class="content">
          <div class="users">
               <!-- Recent Orders -->
               <BaseBlock title="Users">
                    <template #options>
                         <div class="space-x-1">
                              <button type="button" class="btn btn-sm btn-alt-secondary" @click="() => {
                                   orderSearch = !orderSearch;
                              }
                                   ">
                                   <i class="fa fa-search"></i>
                              </button>
                              <div class="dropdown d-inline-block">
                                   <button type="button" class="btn btn-sm btn-alt-secondary"
                                        id="dropdown-recent-orders-filters" data-bs-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        <i class="fa fa-fw fa-flask"></i>
                                        Filters
                                        <i class="fa fa-angle-down ms-1"></i>
                                   </button>
                                   <div class="dropdown-menu dropdown-menu-md dropdown-menu-end fs-sm"
                                        aria-labelledby="dropdown-recent-orders-filters">
                                        <a class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             Pending
                                             <span class="badge bg-primary rounded-pill">20</span>
                                        </a>
                                        <a class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             Active
                                             <span class="badge bg-primary rounded-pill">72</span>
                                        </a>
                                        <a class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             Completed
                                             <span class="badge bg-primary rounded-pill">890</span>
                                        </a>
                                        <a class="dropdown-item fw-medium d-flex align-items-center justify-content-between"
                                             href="javascript:void(0)">
                                             All
                                             <span class="badge bg-primary rounded-pill">997</span>
                                        </a>
                                   </div>
                              </div>
                         </div>
                    </template>

                    <template #content>
                         <div v-if="orderSearch" id="one-dashboard-search-orders" class="block-content border-bottom">
                              <!-- Search Form -->
                              <form @submit.prevent>
                                   <div class="push">
                                        <div class="input-group">
                                             <input type="text" class="form-control form-control-alt"
                                                  id="one-ecom-orders-search" name="one-ecom-orders-search"
                                                  placeholder="Search all orders.." />
                                             <span class="input-group-text bg-body border-0">
                                                  <i class="fa fa-search"></i>
                                             </span>
                                        </div>
                                   </div>
                              </form>
                              <!-- END Search Form -->
                         </div>
                         <div class="block-content block-content-full">
                              <!-- Recent Orders Table -->
                              <div class="table-responsive">
                                   <table class="table table-hover table-vcenter">
                                        <thead>
                                             <tr>
                                                  <th class="text-center" style="width: 100px">
                                                       <i class="far fa-user"></i>
                                                  </th>
                                                  <th>#ID</th>
                                                  <th class=" d-xl-table-cell">
                                                       Full Name
                                                  </th>
                                                  <th class="d-none d-xl-table-cell">
                                                       Email
                                                  </th>
                                                   <th class="d-none d-sm-table-cell ">
                                                       Total exams
                                                  </th>
                                                  <th class="d-none d-sm-table-cell ">
                                                       password
                                                  </th>
                                                  <th class="d-none d-sm-table-cell text-center">
                                                       Created
                                                  </th>

                                             </tr>
                                        </thead>
                                        <tbody class="fs-sm">
                                             <!-- tr with a loop and index-->
                                             <tr v-for="(user,index) in users" :key="index">
                                                  <td class="text-center">
                                                       <img class="img-avatar img-avatar48"
                                                            :src="`/assets/media/avatars/avatar0.jpg`" alt="Avatar" />
                                                  </td>
                                                  <td>
                                                       <a class="fw-bold " href="javascript:void(0)">
                                                            #{{user.id}}
                                                       </a>

                                                  </td>
                                                  <td class="d-none d-xl-table-cell">
                                                       <a class="fw-bold" href="javascript:void(0)">{{user.fullName}}</a>
                                                  </td>
                                                  <td>
                                                       {{ user.email }}
                                                  </td>

                                                  <td class="d-none d-sm-table-cell " style="font-size: 20px;">
                                                       <span class="badge badge-lg bg-primary rounded rounded-pill " style="margin-left:10px;"  > {{user.total_user_exams}}</span>
                                                  </td>
                                                  <td class="d-none d-sm-table-cell " style="font-size: 20px;">
                                                        <div style="cursor:pointer;"  v-if="!showPassword[index]" class="d-flex ">
                                                            <div style="margin: 0px 5px 0px 0px; font-size:20px;">
                                                                 <span v-for="n in user.password.length">*</span>
                                                            </div>
                                                            <!--eye icon -->
                                                            <i @click="showPassword[index] = !showPassword[index]" style="font-size:25px;" class="fa fa-eye" ></i>
                                                        </div>
                                                        <div style="cursor:pointer;"  v-else class="d-flex ">
                                                            <div style="margin: -2px 5px 0px 0px; font-size:18px;">
                                                                <span >{{user.password}}</span>
                                                             </div>
                                                            <!--eye-slash icon -->
                                                            <i @click="showPassword[index] = !showPassword[index]"  style="font-size:25px;"  class="fa fa-eye-slash" ></i>
                                                       </div>
                                                  </td>
                                                  <td class="d-none d-sm-table-cell  text-center">
                                                       <strong>{{globalService.getfullDateTime(user.createdAt)}}</strong>
                                                  </td>
                                             </tr>

                                        </tbody>
                                   </table>
                              </div>
                              <!-- END Recent Orders Table -->
                         </div>

                    </template>
               </BaseBlock>
               <!-- END Recent Orders -->
          </div>
     </div>
     <!-- END Page Content -->
</template>
