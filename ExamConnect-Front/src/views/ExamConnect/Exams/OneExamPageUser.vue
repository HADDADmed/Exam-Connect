<script>
import { bottom } from "@popperjs/core";
import ExamsService from "../../../services/exams.service";
import qstVue from "../components/questions/qst.vue";
export default {
     data() {
          return {
               exam_id: this.$route.query.exam_id,
               hover: false,
               exam: {},
               timer: null,
               timerEnd: false,
               currentTime: new Date().toLocaleTimeString(),
               IMAGES_PATH: this.globalService.getImagesUrl(),
               shouldShowConfirm: true,
               timerInterval: null,
               userAnswers: [
                    {
                         userAnswerText: "",
                         question_id: "",
                         questionOption_id: "",
                         isTrue: "",
                    },
               ],
          };
     },
     methods: {
          sendEvent(name = "examSubmited") {
               this.globalService.toasterShowSuccess(
                    "Exam submited successfuly !"
               );
               this.stopTimer();
               this.emitter.emit("examSubmited", { msg: "examSubmited" });
               ExamsService.startOrEnd(this.exam_id, "end").then((res) => {
                    this.globalService.toasterShowSuccess(
                         "Exam submited successfuly !"
                    );
                    this.globalService
                         .showConfirmMessage(
                              "<strong>Time is over !</strong> <br> the exam  submited successfuly your exam is pending Review !",
                              "Time is over !",
                              "leave !",
                              false
                         )
                         .then((res) => {
                              if (res.value) {
                                   this.$router.push({ name: name });
                                   this.shouldShowConfirm = false; // Allow the page refresh
                              }
                         });
               });
           },
          handleBeforeUnload(event) {
               if (this.shouldShowConfirm) {
                    this.leaving();
                    event.preventDefault(); // Prevent the default behavior of page refresh
                    event.returnValue =
                         "<h2>Warning<h2> Leaving the exam now means you won't have another chance !"; // Set a custom message to prompt the user
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
          stopTimer() {
               clearInterval(this.timerInterval);
               this.timerEnd = true;
               this.shouldShowConfirm = false;
          },
     },
     mounted() {
          ExamsService.getExamById(this.exam_id).then((res) => {
               this.exam = res.data;
               this.timer = Number(this.exam.duration_minutes) * 60 - 1;
          });
          this.emitter.on("examSubmitednav", (data) => {
               this.sendEvent(data.name);
          });

          this.globalService
               .showConfirmMessage(
                    `<div style="color:red; display:flex; font-size:27px; font-weight:800;" > Leaving the current exam means you won't have another chance ! <br> the exam will be submited automaticly after the timer end <br> or u can click submit when you finish !</div>`,
                    `<h1 style=" font-weight:900;" >Becarfull !! </h1>`,
                    "UNDERSTAND !",
                    false
               )
               .then((res) => {
                    if (res.value) {
                         ExamsService.startOrEnd(this.exam_id, "start").then(
                              (res) => {
                                   this.globalService.toasterShowSuccess(
                                        "Exam started !"
                                   );
                                   this.timerInterval = setInterval(() => {
                                        this.timer--;
                                        if (this.timer === 0) {
                                             this.globalService.toasterShowError(
                                                  "Time is over !"
                                             );
                                             this.stopTimer();
                                             this.emitter.emit("examSubmited", {
                                                  msg: "examSubmited",
                                             });
                                             ExamsService.startOrEnd(
                                                  this.exam_id,
                                                  "end"
                                             ).then((res) => {
                                                  this.globalService
                                                       .showConfirmMessage(
                                                            "<strong>Time is over !</strong> <br> the exam  submited successfuly your exam is pending Review !",
                                                            "Time is over !",
                                                            "leave !",
                                                            false
                                                       )
                                                       .then((res) => {
                                                            if (res.value) {
                                                                 this.$router.push(
                                                                      {
                                                                           name: "examSubmited",
                                                                      }
                                                                 );
                                                                 this.shouldShowConfirm = false; // Allow the page refresh
                                                            }
                                                       });
                                             });
                                        }
                                   }, 1000);
                              }
                         );
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
          :class="timer <= 15 ? (timer <= 7 ? 'timerEndEnd' : 'timerEnd') : ''"
     >
          <span class="timerValue">{{
               globalService.secondsToHours(timer)
          }}</span>
     </div>
     <div class="m-2 submit btn btn-success" @click="sendEvent()">
          <span class="timerValue"> SUBMIT </span>
     </div>
     <!-- Hero -->
     <div class="bg-body-light">
          <div class="content content-full">
               <div class="py-3 text-center">
                    <h1 class="fw-bold mb-2">{{ exam.ExamTitle }}</h1>
                    <h2 class="fs-base lh-base fw-medium text-muted mb-0">
                         <!-- display the time string version -->
                        you have {{ globalService.minutesToHours(exam.duration_minutes) }} to finish the exam
                    </h2>
               </div>
          </div>
     </div>
     <!-- END Hero -->
     <!-- START Page Content -->
     <div class="content">
          <div v-for="(question, index) in exam.questions" class="col-12">
               <qstVue
                    v-model="userAnswers[index]"
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
     transition: all 0.1s ease;
     animation: none;
}

.timerEnd {
     background-color: red;
     animation: blink 1s infinite; /* Add animation properties for blinking */
}

.timerEndEnd {
     background-color: red;
     animation: blink 0.3s infinite; /* Add animation properties for blinking */
}

@keyframes blink {
     0% {
          background-color: red;
          color: white;
     }
     50% {
          background-color: white;
          color: red;
     }
     100% {
          background-color: red;
          color: white;
     }
}
.submit {
     width: 80px;
     background-color: green;
     border: green 3px solid;
     border-radius: 10px;
     padding: 10px;
     font-size: 16px;
     font-weight: bold;
     color: white;
     display: flex;
     flex-direction: column;
     align-items: center;
     justify-content: center;
     position: fixed;
     top: 310px;
     transition: all 0.3s ease; /* Add a transition for a smooth effect */
}
.submit:hover {
     background-color: #fff;
     color: green;
     transform: scale(1.2);
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
