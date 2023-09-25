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
                         console.log(this.examStatist);
                         if (
                              this.examStatist.correctQuestions +
                                   this.examStatist.wrongQuestions ==
                              this.examStatist.total
                         ) {
                              if (
                                   this.examStatist.correctQuestions <
                                   this.examStatist.total / 2
                              ) {
                                   this.textQuestionsScore = "failed";
                                   console.log("failed");
                              } else {
                                   this.textQuestionsScore = "success";
                                   console.log("success");
                              }
                         }
                    },
                    (error) => {
                         console.log(error);
                    }
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
                                   this.examStatist.total
                              ) {
                                   if (
                                        this.examStatist.correctQuestions <
                                        this.examStatist.total / 2
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
                              {{ examStatist.total }}
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
