<script>
import ExamsService from "../../../services/exams.service";
import QuestionsService from "../../../services/questions.service";
import UserService from "../../../services/users.service";
export default {
     data() {
          return {
               exam: {
                    examTitle: "",
                    duration_minutes: 5,
                    questions: {
                         qcmQuestions: 0,
                         textQuestions: 0,
                         imageQuestions: 0,
                    },
                    usersSelected: [],
               },
               qstsCount: {},
               users: [],
               filteredUsers: [],
                orderSearch: false,
               searchTerm: "",
          };
     },
     methods: {
          save() {

                if(this.exam.examTitle == ""){
                    this.globalService.toasterShowError(
                         `You must enter a Title`
                    );
                    return;
                }
                if(this.exam.questions.qcmQuestions == 0 && this.exam.questions.textQuestions == 0 && this.exam.questions.imageQuestions == 0){
                    this.globalService.toasterShowError(
                         `You must chose at least one question`
                    );
                    return;
                }else if(this.exam.usersSelected.length == 0){
                    this.globalService.toasterShowError(
                         `You must chose at least one user`
                    );
                    return;
                }
               ExamsService.createExam(this.exam).then((response) => {

                    this.globalService.toasterShowSuccess(
                         `"${this.exam.examTitle}" Exam Created Successfully`
                    );
                    this.$router.push({ name: "examconnect-exams-list" });
               });
          },
          getCounts() {
               QuestionsService.getQuestionsCountsByType().then((response) => {
                    this.qstsCount = response.data;
               });
          },
          getUsers() {
               UserService.getAllUsers().then((response) => {
                    // remove the admin from the list
                    response.data = response.data.filter(
                         (user) => !user.isAdmin
                    );
                    this.users = response.data;
                    this.filteredUsers = response.data;
               });
          },
          search(value) {
               this.filteredUsers = this.users;
               this.filteredUsers = this.filteredUsers.filter((user) =>
                    user.fullName.toLowerCase().includes(value.toLowerCase())
               );
          },
          addUser(id) {
               this.exam.usersSelected.push(
                    this.users.find((user) => user.id == id)
               );
               this.users = this.users.filter((user) => user.id != id);
               this.search(this.searchTerm);
          },
          removeUser(id) {
               this.users.push(
                    this.exam.usersSelected.find((user) => user.id == id)
               );
               this.exam.usersSelected = this.exam.usersSelected.filter(
                    (user) => user.id != id
               );
               this.search(this.searchTerm);
          },
     },
     watch: {
          searchTerm(newValue, oldValue) {
               this.search(newValue);
          },
     },
     components: {},
     mounted() {
          this.getUsers();
          this.getCounts();
     },
};
</script>

<template>
     <!-- Hero -->
     <div class="bg-body-light">
          <div class="content content-full">
               <div class="py-3 text-center">
                    <h1 class="fw-bold mb-2">Create a new Exam</h1>
                    <h2 class="fs-base lh-base fw-medium text-muted mb-0">
                         You can chose how many questions you want from each
                         type
                    </h2>
               </div>
          </div>
     </div>
     <!-- END Hero -->

     <!-- Page Content -->
     <div class="content">
          <!-- Tiptap -->

          <BaseBlock title=" new exam " content-full>
               <div>
                    <div>
                         <div>
                              <div
                                   class="form-floating mb-4 col-12 animated bounceInDown"
                              >
                                   <input
                                        type="text"
                                        class="form-control form-control-alt border border-primary"
                                        id="example-text-input-floating"
                                        name="example-text-input-floating"
                                        v-model="exam.examTitle"
                                   />
                                   <label for="example-text-input-floating"
                                        >Title</label
                                   >
                              </div>
                              <div class="d-flex justify-content-center">
                                   <div class="mb-4 col-2 mb-4">
                                        <label
                                             class="form-label mb-2"
                                             for="startTime"
                                             >Duration minutes:</label
                                        >
                                        <input
                                             type="number"
                                             min="5"
                                             class="form-control mb-4 col-5 animated form-control-alt border border-danger bounceInLeft"
                                             id="startTime"
                                             v-model="exam.duration_minutes"
                                        />
 
                                   </div>
                                   
                              </div>
                              <!-- Questions count -->
                              <div class="d-flex justify-content-center">
                                   <div class="badge bg-primary m-2">
                                        {{ qstsCount.qcmQstsCount }} QCM
                                        Questions
                                   </div>
                                   <div class="badge bg-primary m-2">
                                        {{ qstsCount.textQstsCount }} Text
                                        Questions
                                   </div>
                                   <div class="badge bg-primary m-2">
                                        {{ qstsCount.imgQstsCount }} Images
                                        Questions
                                   </div>
                              </div>
                              <div class="d-flex m-5 justify-content-center">
                                   <div class="d-flex">
                                        <div
                                             style="
                                                  margin-right: 20px;
                                                  margin-top: 5px;
                                             "
                                        >
                                             <strong> QCM Questions :</strong>
                                        </div>
                                        <div class="mb-4 col-3">
                                             <input
                                                  type="number"
                                                  class="form-control form-control-alt form-control border border-success animated bounceInRight"
                                                  min="1"
                                                  :max="qstsCount.qcmQstsCount"
                                                  v-model="
                                                       exam.questions
                                                            .qcmQuestions
                                                  "
                                             />
                                        </div>
                                   </div>

                                   <div class="d-flex">
                                        <div
                                             style="
                                                  margin-right: 20px;
                                                  margin-top: 5px;
                                             "
                                        >
                                             <strong>Text Questions :</strong>
                                        </div>
                                        <div class="mb-4 col-3">
                                             <input
                                                  type="number"
                                                  class="form-control form-control-alt form-control border border-success animated bounceInRight"
                                                  min="1"
                                                  :max="qstsCount.textQstsCount"
                                                  v-model="
                                                       exam.questions
                                                            .textQuestions
                                                  "
                                             />
                                        </div>
                                   </div>

                                   <div class="d-flex">
                                        <div
                                             style="
                                                  margin-right: 20px;
                                                  margin-top: 5px;
                                             "
                                        >
                                             <strong>Image Questions :</strong>
                                        </div>
                                        <div class="mb-4 col-3">
                                             <input
                                                  type="number"
                                                  class="form-control form-control-alt form-control border border-success animated bounceInRight"
                                                  min="1"
                                                  :max="qstsCount.imgQstsCount"
                                                  v-model="
                                                       exam.questions
                                                            .imageQuestions
                                                  "
                                             />
                                        </div>
                                   </div>
                              </div>
                              <div
                                   style="margin-top: -50px"
                                   class="d-flex justify-content-center"
                              >
                                   <div class="badge bg-success m-2">
                                        {{ exam.questions.qcmQuestions }} QCM
                                        Questions
                                   </div>
                                   <div class="badge bg-success m-2">
                                        {{ exam.questions.textQuestions }} Text
                                        Questions
                                   </div>
                                   <div class="badge bg-success m-2">
                                        {{ exam.questions.imageQuestions }}
                                        Images Questions
                                   </div>
                              </div>
                         </div>
                    </div>
               </div>
               <!-- Small Table -->
               <div
                    style="
                         display: grid;
                         place-items: center;
                         font: bold 23px/1.4 Helvetica, Verdana, sans-serif;
                         margin: 30px 0px 3px 0px;
                    "
               >
                    Scrol down to add the users that will be asigned to the exam
               </div>
               <div class="col-12 mb-4 d-flex justify-content-center">
                    <BaseBlock>
                         <table class="table table-sm table-vcenter">
                              <thead>
                                   <tr>
                                        <th
                                             class="text-center"
                                             style="width: 50px"
                                        >
                                             #ID
                                        </th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th
                                             class="text-center"
                                             style="width: 100px"
                                        >
                                             Remove
                                        </th>
                                   </tr>
                              </thead>
                              <tbody>
                                   <tr
                                        v-for="user in exam.usersSelected"
                                        :key="user.id"
                                   >
                                        <th class="text-center" scope="row">
                                             {{ user.id }}
                                        </th>
                                        <td class="fw-semibold fs-sm">
                                             <a href="javascript:void(0)">{{
                                                  user.fullName
                                             }}</a>
                                        </td>
                                        <td class="fw-semibold fs-sm">
                                             <a href="javascript:void(0)">{{
                                                  user.email
                                             }}</a>
                                        </td>
                                        <td class="text-center">
                                             <div class="btn-group">
                                                  <button
                                                       @click="
                                                            removeUser(user.id)
                                                       "
                                                       type="button"
                                                       class="btn btn-sm btn-alt-secondary"
                                                  >
                                                       <i
                                                            class="fa fa-fw fa-times"
                                                       ></i>
                                                  </button>
                                             </div>
                                        </td>
                                   </tr>
                              </tbody>
                         </table>
                    </BaseBlock>
               </div>
               <!-- END Small Table -->

               <div
                    style="margin-top: 30px"
                    class="d-flex justify-content-center mb-4"
               >
                    <button
                         @click="save()"
                         class="btn btn-lg rounded-pill btn-success"
                    >
                         Save
                    </button>
               </div>
          </BaseBlock>

          <!-- Partial Table -->
          <BaseBlock title="chose users  that will be asigned to the exam">
               <template #options>
                    <span
                         style="
                              font: bold 15px/1.4 Helvetica, Verdana, sans-serif;
                         "
                    >
                         Search User By Name
                    </span>
                    <button
                         type="button"
                         class="btn-block-option"
                         @click="orderSearch = !orderSearch"
                    >
                         <i class="fa fa-search"></i>
                    </button>
               </template>
               <div
                    v-if="orderSearch"
                    id="one-dashboard-search-orders"
                    class="block-content border-bottom"
               >
                    <!-- Search Form -->
                    <form>
                         <div class="push">
                              <div class="input-group">
                                   <input
                                        type="text"
                                        class="form-control form-control-alt"
                                        id="one-ecom-orders-search"
                                        name="one-ecom-orders-search"
                                        placeholder="Search User by name ... "
                                        v-model="searchTerm"
                                   />
                                   <span
                                        class="input-group-text bg-body border-0"
                                   >
                                        <i class="fa fa-search"></i>
                                   </span>
                              </div>
                         </div>
                    </form>
                    <!-- END Search Form -->
               </div>

               <table class="table table-bordered table-striped table-vcenter">
                    <thead>
                         <tr>
                              <th class="text-center" style="width: 100px">
                                   Select
                              </th>
                              <th class="text-center" style="width: 100px">
                                   <i class="far fa-user"></i>
                              </th>
                              <th>Name</th>
                              <th
                                   class="d-none d-md-table-cell"
                                   style="width: 30%"
                              >
                                   Email
                              </th>
                         </tr>
                    </thead>
                    <tbody>
                         <tr v-for="user in filteredUsers" :key="user.id">
                              <td class="text-center">
                                   <button
                                        type="button"
                                        class="btn btn-lg btn-alt-secondary"
                                        @click="addUser(user.id)"
                                   >
                                        <i class="fa-solid fa-user-plus"></i>
                                   </button>
                              </td>
                              <td class="text-center">
                                   <img
                                        class="img-avatar img-avatar48"
                                        :src="`/assets/media/avatars/avatar0.jpg`"
                                        alt="Avatar"
                                   />
                              </td>
                              <td class="fw-semibold fs-sm">
                                   {{ user.fullName }}
                              </td>
                              <td class="d-none d-md-table-cell fs-sm">
                                   {{ user.email }}
                              </td>
                         </tr>
                    </tbody>
               </table>
          </BaseBlock>
          <!-- END Partial Table -->
     </div>
     <!-- END Page Content -->
</template>
