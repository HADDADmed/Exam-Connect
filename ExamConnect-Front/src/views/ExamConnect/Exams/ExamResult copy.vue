<script>
import qstVue from "../components/questions/qst.vue";
import UserAnswersService from "../../../services/userAnswers.service";
import { useTemplateStore } from "@/stores/template";

export default {
     data() {
          return {
               exam_id: this.$route.query.exam_id,
               user_id: this.$route.query.user_id,
               user: JSON.parse(localStorage.getItem("user")),
               examStatist: {},
               userAnswers: {},
               loading: false,
               textQuestionsScore: "pendingReview",
               IMAGES_PATH: this.globalService.getImagesUrl(),
               store: useTemplateStore(),
          };
     },
     mounted() {
          this.getAllAnswersByExamUserId();
     },
     methods: {
          getAllAnswersByExamUserId() {
               UserAnswersService.getAllAnswersByExamUserId(
                    this.exam_id,
                    this.user_id
               ).then(
                    (response) => {
                         this.userAnswers = response.data;
                         this.examStatist = response.data.examStatist;
                         console.log("userAnswers :");
                         console.log(this.userAnswers);

                         if (
                              this.examStatist.correctQuestions +
                                   this.examStatist.wrongQuestions ==
                              this.examStatist.totalImage +
                                   this.examStatist.totalQcm +
                                   this.examStatist.totalText
                         ) {
                              if (
                                   this.userAnswers.exam_status ==
                                   "pendingReview"
                              ) {
                                   this.checkSuccess();
                               } else {
                                   if (
                                        this.examStatist.correctQuestions <
                                        (this.examStatist.totalImage +
                                             this.examStatist.totalQcm +
                                             this.examStatist.totalText) /
                                             2
                                   ) {
                                        this.textQuestionsScore = "failed";
                                   } else {
                                        this.textQuestionsScore = "success";
                                   }
                              }
                         }
                    },
                    (error) => {
                         console.log(error);
                    }
               );
          },
          checkSuccess(){
               if (
                    this.examStatist.correctQuestions <
                                        (this.examStatist.totalImage +
                                             this.examStatist.totalQcm +
                                             this.examStatist.totalText) /
                                             2
                                   ) {
                                        this.textQuestionsScore = "failed";
                                        UserAnswersService.submitFinalReview(
                                             this.userAnswers.exam_user_id,
                                             4,
                                             this.userAnswers.exam_id,
                                             this.userAnswers.user_id
                                        );
                                   } else {
                                        this.textQuestionsScore = "success";
                                        UserAnswersService.submitFinalReview(
                                             this.userAnswers.exam_user_id,
                                             5,
                                             this.userAnswers.exam_id,
                                             this.userAnswers.user_id
                                        );
                                   }

                                   this.globalService.toasterShowSuccess(
                                        "Review submited successfuly !"
                                   );
          },
          submitReview() {
               this.emitter.emit("reviewSubmited", { mssg: "reviewSubmited" });
               this.loading = true;
               setTimeout(() => {
                    this.loading = false;
                    UserAnswersService.getAllAnswersByExamUserId(
                         this.exam_id,
                         this.user_id
                    ).then(
                         (response) => {
                              this.userAnswers = response.data;
                              this.examStatist = response.data.examStatist;
                              if (
                                   this.examStatist.correctQuestions +
                                        this.examStatist.wrongQuestions ==
                                   this.examStatist.totalImage +
                                        this.examStatist.totalQcm +
                                        this.examStatist.totalText
                              ) {
                                   this.checkSuccess()
                              }
                         },
                         (error) => {
                              console.log(error);
                         }
                    );
               }, 2000);
               // this.textQuestionsScore = 'submited';
          },
     },
     components: {
          qstVue,
     },
};
</script>

<template>
     <!-- Page Content -->

     <!-- Hero -->
     <div class="bg-body-light">
          <div class="content content-full">
               <div class="py-3 text-center">
                    <h1 class="fw-bold mb-2">{{ userAnswers.exam_title }}</h1>
                    <h3 class="fs-base lh-base fw-medium mb-0">
                         <!-- display the time string version -->
                         answers of user : {{ userAnswers.user_fullName }}
                    </h3>
                    <h3>
                         Score for QCM and Image Questions:
                         <span class="badge bg-success">
                              {{ examStatist.correctQcmAndImage }} /
                              {{
                                   examStatist.totalQcm + examStatist.totalImage
                              }}
                         </span>
                    </h3>
                    <h3>
                         Score for Text Questions:
                         <span
                              v-if="textQuestionsScore !== 'pendingReview'"
                              class="badge bg-success"
                         >
                              {{ examStatist.correctTextQuestions }} /
                              {{ examStatist.totalText }}
                         </span>
                         <span
                              v-else
                              class="badge bg-danger-light"
                              style="color: black"
                         >
                              <strong>{{ examStatist.pendingReview }}</strong>
                              text questions are Pending your Review
                         </span>
                    </h3>

                    <h3>
                         Total Score: <br />
                         <span
                              v-if="textQuestionsScore == 'pendingReview'"
                              class="badge bg-danger-light"
                              style="color: black"
                         >
                              some questions are Pending your Review
                         </span>
                         <span
                              v-else
                              :class="
                                   textQuestionsScore == 'success'
                                        ? 'badge bg-success'
                                        : 'badge bg-danger'
                              "
                              style="font-size: 50px"
                         >
                              {{
                                   examStatist.correctQcmAndImage +
                                   examStatist.correctTextQuestions
                              }}
                              /
                              {{
                                   this.examStatist.totalImage +
                                   this.examStatist.totalQcm +
                                   this.examStatist.totalText
                              }}
                         </span>
                    </h3>
               </div>
               <div class="d-flex justify-content-center">
                    <div
                         style=""
                         v-if="loading"
                         class="spinner-border text-primary"
                         role="status"
                    >
                         <span class="visually-hidden">Loading...</span>
                    </div>
               </div>
               <div
                    v-if="textQuestionsScore == 'pendingReview'"
                    class="d-flex justify-content-center"
               >
                    <div
                         style="width: 400px"
                         class="btn btn-primary m-5 rounded rounded-pill"
                         @click="submitReview()"
                    >
                         Submit Review
                    </div>

                    <!-- loading spinner bootsrtrap  -->
               </div>
               <div v-else class="d-flex justify-content-end">
                    <!-- Trigger offcanvas -->
                    <button
                         class="btn btn-lg btn-alt-danger rounded-circle text-center"
                         type="button"
                         data-bs-toggle="offcanvas"
                         data-bs-target="#offcanvasRight"
                         aria-controls="offcanvasRight"
                         style="
                              width: 60px;
                              height: 60px;
                              margin-top: 0px;
                              background-color: #273d54;
                         "
                    >
                         <i
                              class="fa-solid fa-clock-rotate-left"
                              style="color: white; font-size: 30px"
                         ></i>
                    </button>
                    <!-- END Trigger offcanvas -->
               </div>
               <!-- Right Aligned -->
               <div class="block block-rounded">
                    <div>
                         <!-- Offcanvas Right -->
                         <div
                              class="offcanvas offcanvas-end bg-body-extra-light"
                              tabindex="-1"
                              id="offcanvasRight"
                              aria-labelledby="offcanvasRightLabel"
                         >
                              <div class="offcanvas-header bg-body-light">
                                   <h5
                                        class="offcanvas-title"
                                        id="offcanvasRightLabel"
                                   ></h5>
                                   <button
                                        type="button"
                                        class="btn-close"
                                        data-bs-dismiss="offcanvas"
                                        aria-label="Close"
                                   ></button>
                              </div>

                              <div class="offcanvas-b ody">
                                   <h2 style="margin: 30px">
                                        History Of Status :
                                   </h2>
                                   <!-- Small Table -->
                                   <BaseBlock>
                                        <table
                                             class="table table-sm table-vcenter"
                                        >
                                             <thead>
                                                  <tr>
                                                       <th
                                                            class="text-center"
                                                            style="width: 50px"
                                                       >
                                                            #ID
                                                       </th>
                                                       <th>Date of Change</th>
                                                       <th
                                                            class="d-none d-sm-table-cell"
                                                            style="width: 15%"
                                                       >
                                                            status
                                                       </th>
                                                  </tr>
                                             </thead>
                                             <tbody>
                                                  <tr
                                                       v-for="status in userAnswers.historyOfStatus"
                                                  >
                                                       <th
                                                            class="text-center"
                                                            scope="row"
                                                       >
                                                            {{
                                                                 status.exam_user_status_id
                                                            }}
                                                       </th>
                                                       <td
                                                            class="fw-semibold fs-sm"
                                                       >
                                                            <a
                                                                 href="javascript:void(0)"
                                                                 >{{
                                                                      globalService.getfullDateTime(
                                                                           status.exam_user_status_createdAt
                                                                      )
                                                                 }}</a
                                                            >
                                                       </td>
                                                       <td
                                                            class="d-none d-sm-table-cell"
                                                       >
                                                            <span
                                                                 class="badge badge-lg rounded rounded-pill"
                                                                 :class="
                                                                      status.exam_status_name ===
                                                                      'notStarted'
                                                                           ? 'bg-warning'
                                                                           : status.exam_status_name ===
                                                                                  'inProgress' ||
                                                                             status.exam_status_name ===
                                                                                  'passed'
                                                                           ? 'bg-success'
                                                                           : 'bg-danger'
                                                                 "
                                                            >
                                                                 {{
                                                                      status.exam_status_name
                                                                 }}
                                                            </span>
                                                       </td>
                                                  </tr>
                                             </tbody>
                                        </table>
                                   </BaseBlock>
                                   <!-- END Small Table -->
                              </div>
                         </div>
                         <!-- END Offcanvas Right -->
                    </div>
               </div>
               <!-- END Right Aligned -->
          </div>
     </div>
     <!-- END Hero -->

     <!-- START Page Content -->
     <div class="content">
          <div
               v-for="(question, index) in userAnswers.questions"
               class="col-12"
          >
               <qstVue
                    :question="question"
                    :isAdmin="true"
                    :index="index"
                    :result="true"
               ></qstVue>
          </div>
     </div>

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
