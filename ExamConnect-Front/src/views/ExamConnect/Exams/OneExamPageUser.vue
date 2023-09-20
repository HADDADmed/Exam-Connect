<script>
import ExamsService from "../../../services/exams.service";
import qstVue from "../components/questions/qst.vue";
export default {
     data() {
          return {
               exam_id: this.$route.query.exam_id,
               hover: false,
               exam: {},
               timer: null,
               currentTime: new Date().toLocaleTimeString(),
               IMAGES_PATH: "http://localhost:3000/public/images/",
               shouldShowConfirm: true,
          };
     },
     methods: {
          handleBeforeUnload(event) {
               this.leaving();
               if (this.shouldShowConfirm) {
                    event.preventDefault(); // Prevent the default behavior of page refresh
                    event.returnValue =
                         "Warning: Leaving the exam now means you won't have another chance !"; // Set a custom message to prompt the user
               }
          },

          leaving() {
               this.globalService
                    .showConfirmMessage(
                         "Leaving the exam now means you won't have another chance !",
                         "Are you sure you want to leave?",
                         "leave exam",
                         true,
                         "cancel"
                    )
                    .then((res) => {
                         if (res.value) {
                              console.log("Leaving");
                              this.shouldShowConfirm = false; // Allow the page refresh
                         } else {
                              console.log("Not leaving");
                              this.shouldShowConfirm = true; // Show the confirmation dialog on next attempt to leave
                         }
                    });
          },
     },
     mounted() {
          ExamsService.getExamById(this.exam_id).then((res) => {
               this.exam = res.data;
               this.timer = Number(this.exam.duration_minutes) * 60 -1;
          });

          this.globalService.showConfirmMessage(
               "Leaving the current exam means you won't have another chance !  \n the exam will be submited automaticly after the timer end \n or u can click submit when you finish !",
               "Becarfull !!!!",
               "UNDERSTAND !",
               false
          ).then((res) => {
               if (res.value) {
              setInterval(() => {
                      this.timer--;
                  }, 1000);
                }
          });
          
     },
     components: {
          qstVue,
     },
     created() {
          window.addEventListener("beforeunload", this.handleBeforeUnload);
     },

     beforeUnmount() {
          window.removeEventListener("beforeunload", this.handleBeforeUnload);
     },
};
</script>

<template>
     <!-- Page Content -->
     <div
          class="m-2 timer"
          @mouseover="hover = true"
          @mouseleave="hover = false"
     >
           <span  class="timerValue">{{
               globalService.secondsToHours(timer)
          }}</span>
     </div>
     <!-- Hero -->
     <div class="bg-body-light">
          <div class="content content-full">
               <div class="py-3 text-center">
                    <h1 class="fw-bold mb-2">{{ exam.ExamTitle }}</h1>
                    <h2 class="fs-base lh-base fw-medium text-muted mb-0">
                         <!-- display the time string version -->
                         this exam start at
                         {{
                              globalService.getTimeWithoutSeconds(
                                   exam.startTime
                              )
                         }}
                         and will end at
                         {{
                              globalService.getTimeWithoutSeconds(exam.endTime)
                         }}
                         in
                         {{ globalService.getDate(exam.startTime) }}
                    </h2>
               </div>
          </div>
     </div>
     <!-- END Hero -->
     <!-- START Page Content -->
     <div class="content">
          <div v-for="(question, index) in exam.questions" class="col-12">
               <qstVue
                    :question="question"
                    :isAdmin="false"
                    :index="index"
               ></qstVue>
          </div>
     </div>

     <!-- END Page Content -->
</template>

<style>
.timer {
     width: 80px;
     background-color: #f5f5f5;
     border: red 3px solid;
     border-radius: 10px;
     padding: 10px;
     font-size: 16px;
     font-weight: bold;
     color: #000;
     display: flex;
     flex-direction: column;
     align-items: center;
     justify-content: center;
     position: fixed;
     top: 255px;
     transition: all 0.3s ease; /* Add a transition for a smooth effect */
}
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
