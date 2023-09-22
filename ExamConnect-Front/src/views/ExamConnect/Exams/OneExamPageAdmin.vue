<script>
import ExamsService from "../../../services/exams.service";
import qstVue from "../components/questions/qst.vue";
import ClipboardJS from 'clipboard';

export default {
     data() {
          return {
               exam_id: this.$route.query.exam_id,
               hover: false,
               exam: {},
               currentTime: new Date().toLocaleTimeString(),
               IMAGES_PATH: "http://localhost:3000/public/images/",
               generatedLink: "",
          };
     },
     mounted() {
          ExamsService.getExamById(this.exam_id).then((res) => {
               this.exam = res.data;
          });
          setInterval(() => {
               this.currentTime = new Date().toLocaleTimeString();
          }, 1000);
     },methods: {
          copyLink() {
      const clipboard = new ClipboardJS('#button-addon2', {
        text: () => this.generatedLink,
      });

      clipboard.on('success', () => {
        this.globalService.toasterShowSuccess('Link copied to clipboard');
        clipboard.destroy(); // Cleanup after the copy is successful
      });

      clipboard.on('error', () => {
        this.globalService.toasterShowError('Failed to copy link to clipboard');
        clipboard.destroy(); // Cleanup after an error
      });

     },generateLink(){
        console.log("generatedLink");
        console.log(this.$route);
          this.generatedLink = "http://localhost:5173/#/?exam_id_live="+this.exam_id;

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
                         {{ globalService.getTimeWithoutSeconds(exam.endTime) }}
                         in
                         {{ globalService.getDate(exam.startTime) }}
                    </h2>
               </div>
          </div>
     </div>
     <!-- END Hero -->
     <div style="background-color: white" class="m-5">
          <div class="content">
               <div class="py-3 text-center">
                    <div style="display: grid; place-items: center">
                         <div class="col-7">
                              <!-- Small Table -->
                              <BaseBlock>
                                   <table class="table table-sm table-vcenter">
                                        <thead>
                                             <tr>
                                                  <th  style="width: 50px">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;#ID
                                                  </th>
                                                  <th>fullName</th>
                                                  <th style="width: 15%">
                                                       exam_status
                                                  </th>
                                             </tr>
                                        </thead>
                                        <tbody>
                                             <tr v-for="user in exam.users">
                                                  <th
                                                       class="text-center"
                                                       scope="row"
                                                  ><div
                                                                 class="spinner-grow spinner-grow-sm  text-success"
                                                                 role="status"
                                                                 v-if="
                                                                      user.exam_status ===
                                                                      'inProgress'"
                                                            >
                                                                 <span
                                                                      class="visually-hidden"
                                                                      >Loading...</span
                                                                 >
                                                            </div>
                                                            <span v-else>
                                                              &nbsp;&nbsp;&nbsp;&nbsp;
                                                            </span >
                                                       {{ user.id }}
                                                  </th>
                                         <td class="fw-semibold fs-sm">
                                                       <a
                                                            href="javascript:void(0)"
                                                       >
                                                            {{ user.fullName }}
                                                       </a>
                                                  </td>
                                                  <td style=" ">
                                                    
                                                       <div
                                                            class="badge rounded rounded-pill"
                                                            :class="
                                                                 user.exam_status ===
                                                                 'notStarted'
                                                                      ? 'bg-warning'
                                                                      : user.exam_status ===
                                                                        'inProgress'
                                                                      ? 'bg-success'
                                                                      : 'bg-danger'
                                                            "
                                                        >
                                                           
                                                            {{
                                                                 user.exam_status
                                                            }}
                                                       </div>
                                                  </td>
                                                  <td
                                                       v-if="
                                                            user.exam_status ===
                                                            'pendingReview'
                                                       "
                                                       class="text-center"
                                                  >
                                                       <div class="btn-group">
                                                            <button
                                                                 type="button"
                                                                 class="btn btn-sm rounded rounded-pill btn-alt-secondary"
                                                                 @click="()=>{
                                                                      $router.push({
                                                                           name: 'examconnect-exam-results',
                                                                           query: {
                                                                                exam_id: exam_id,
                                                                                user_id: user.id,
                                                                           },
                                                                      });
                                                                 }"
                                                            >
                                                                Review
                                                            </button>
                                                       </div>
                                                  </td>
                                             </tr>
                                        </tbody>
                                   </table>


                                  </BaseBlock>
                                  <div class="btn btn-success rounded rounded-pill mb-5" @click="generateLink()">
                                          Genreate link for this exam 
                                  </div>

                                  <div>
                                        <div class="input-group mb-3">
                                              <input
                                                  type="text"
                                                  class="form-control"
                                                  placeholder="Recipient's username"
                                                  aria-label="Recipient's username"
                                                  aria-describedby="button-addon2"
                                                  v-model="generatedLink"
                                                  readonly
                                              />
                                              <button
                                                  class="btn btn-outline-secondary"
                                                  type="button"
                                                  id="button-addon2"
                                                  @click="copyLink()"
                                              >
                                                  Copy
                                              </button>
                                        </div>
                                  </div>
                              <!-- END Small Table -->
                         </div>
                    </div>
               </div>
          </div>
     </div>

     <!-- START Page Content -->
     <div class="content">
          <div v-for="(question, index) in exam.questions" class="col-12">
               <qstVue
                    :question="question"
                    :isAdmin="true"
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
