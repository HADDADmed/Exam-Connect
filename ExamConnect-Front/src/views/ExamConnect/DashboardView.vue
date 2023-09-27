<script>
import ExamsService from "../../services/exams.service";
import { useTemplateStore } from "@/stores/template";

export default {
     data() {
          return {
               userExams: [],
               user: this.globalService.getCurrentUser(),
               users: [],
          };
     },
     methods: {
          getAllUserExams() {
               ExamsService.getAllUserExams().then((response) => {
                    this.users = response.data;
                
               });
          },
          getUserExamsById() {
               ExamsService.getUserExamsById().then((response) => {
                    this.userExams = response.data;
                    
               });
          },
     },
     mounted() {
          if (!this.user.isAdmin) {
               const store = useTemplateStore();
               // Set default elements for this layout
               store.setLayout({
                    header: true,
                    sidebar: false,
                    sideOverlay: false,
                    footer: true,
               });
               // Set various template options for this layout variation
               store.headerStyle({ mode: "dark" });
               store.mainContent({ mode: "boxed" });
               this.getUserExamsById();
          } else this.getAllUserExams();
     },
};
</script>

<template>
     <div v-if="user.isAdmin" class="content">
          <!-- Hero -->
          <div v-if="user.isAdmin" class="content">
               <div
                    class="d-flex flex-column flex-md-row justify-content-md-between align-items-md-center py-2 text-center text-md-start"
               >
                    <div class="flex-grow-1 mb-1 mb-md-0">
                         <h1 class="h3 fw-bold mb-2">Dashboard</h1>
                         <h2 class="h6 fw-medium fw-medium text-muted mb-0">
                              Welcome
                              <span style="color: red"
                                   ><strong>ADMIN</strong></span
                              >
                              to your dashboard
                         </h2>
                    </div>
               </div>
          </div>
          <!-- END Hero -->
          <!-- Full Table -->
          <BaseBlock title="Users">
               <template #options>
                    <button type="button" class="btn-block-option">
                         <i class="si si-settings"></i>
                    </button>
               </template>

               <div class="table-responsive">
                    <table class="table table-bordered table-vcenter">
                         <thead>
                              <tr>
                                   <th class="text-center" style="width: 100px">
                                        <i class="far fa-user"></i>
                                   </th>
                                   <th style="width: 5%; font-size: 10px">
                                        user_id,exam_id
                                   </th>
                                   <th style="width: 15%">full Name</th>
                                   <th style="width: 20%">Exam Title</th>
                                   <th style="width: 25%">Email</th>
                                   <th style="width: 15%">Status</th>
                                   <th class="text-center" style="width: 100px">
                                        Actions
                                   </th>
                              </tr>
                         </thead>
                         <tbody>
                              <tr v-for="user in users" :key="user.user_id">
                                   <td class="text-center">
                                        <img
                                             class="img-avatar img-avatar48"
                                             :src="`/assets/media/avatars/avatar1.jpg`"
                                             alt="Avatar"
                                        />
                                   </td>
                                   <td class="fw-semibold fs-sm">
                                        {{ user.user_id }},{{ user.exam_id }}
                                   </td>
                                   <td class="fw-semibold fs-sm">
                                        {{ user.fullName }}
                                   </td>
                                   <td class="fw-semibold fs-sm">
                                        {{ user.ExamTitle }}
                                   </td>
                                   <td class="fs-sm">
                                        <a
                                             :href="`mailto:${user.email}`"
                                             class="text-body"
                                        >
                                             {{ user.email }}
                                        </a>
                                   </td>
                                   <td
                                        class="text-center"
                                        style="margin: 20px 20px 20px 5px"
                                        :class="
                                             user.status == 'pendingReview' ||
                                             user.status == 'notStarted'
                                                  ? `fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-warning text-light `
                                                  : user.status ==
                                                         'inProgress' ||
                                                    user.status == 'passed'
                                                  ? `fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-success  `
                                                  : `fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-danger text-light`
                                        "
                                   >
                                        {{ user.status }}
                                   </td>
                                   <td class="text-center">
                                        <div class="btn-group">
                                             <button
                                                  v-if="
                                                       user.status !==
                                                            'notStarted' &&
                                                       user.status !==
                                                            'inProgress'
                                                  "
                                                  type="button"
                                                  class="btn btn-sm rounded rounded-pill btn-alt-secondary"
                                                  @click="
                                                       () => {
                                                            $router.push({
                                                                 name: 'examconnect-exam-results',
                                                                 query: {
                                                                      exam_id: user.exam_id,
                                                                      user_id: user.user_id,
                                                                 },
                                                            });
                                                       }
                                                  "
                                             >
                                                  <span
                                                       v-if="
                                                            user.status ===
                                                            'pendingReview'
                                                       "
                                                  >
                                                       Review
                                                  </span>
                                                  <span
                                                       v-else-if="
                                                            user.status ===
                                                                 'passed' ||
                                                            user.status ===
                                                                 'failed'
                                                       "
                                                  >
                                                       Result
                                                  </span>
                                             </button>
                                        </div>
                                   </td>
                              </tr>
                         </tbody>
                    </table>
               </div>
          </BaseBlock>
          <!-- END Full Table -->
     </div>

     <div v-if="!user.isAdmin">
          <div class="content">
               <div
                    class="d-flex flex-column flex-md-row justify-content-md-between align-items-md-center py-2 text-center text-md-start"
               >
                    <div class="flex-grow-1 mb-1 mb-md-0">
                         <h1 class="h3 fw-bold mb-2">Dashboard</h1>
                         <h2 class="h6 fw-medium fw-medium text-muted mb-0">
                              Welcome
                              <span style="color: green"
                                   ><strong>{{
                                        userExams.fullName
                                   }}</strong></span
                              >
                              to your dashboard
                         </h2>
                    </div>
               </div>
          </div>
          <div class="content">
               <!-- Hover Table -->
               <BaseBlock title="Exams">
                    <template #options> </template>

                    <table class="table table-vcenter">
                         <thead>
                              <tr>
                                   <th class="text-center" style="width: 50px">
                                        #
                                   </th>
                                   <th>Exame Title</th>
                                   <th
                                        class="d-none d-sm-table-cell"
                                        style="width: 15%"
                                   >
                                        Status
                                   </th>
                                   <th class="text-center" style="width: 100px">
                                        Actions
                                   </th>
                              </tr>
                         </thead>
                         <tbody>
                              <tr v-for="exam in userExams.exams">
                                   <th class="text-center" scope="row">
                                        {{ exam.exam_id }}
                                   </th>
                                   <td class="fw-semibold fs-sm">
                                        <a href="javascript:void(0)">{{
                                             exam.ExamTitle
                                        }}</a>
                                   </td>
                                   <td
                                        class="text-center"
                                        style="margin: 20px 20px 20px 5px"
                                        :class="
                                             exam.status == 'pendingReview' ||
                                             exam.status == 'notStarted'
                                                  ? `fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-warning text-light `
                                                  : exam.status ==
                                                         'inProgress' ||
                                                    exam.status == 'passed'
                                                  ? `fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-success  `
                                                  : `fs-xs fw-semibold d-inline-block py-1 px-3 rounded-pill bg-danger text-light`
                                        "
                                   >
                                        {{ exam.status }}
                                   </td>
                                   <td class="text-center">
                                        <div class="btn-group">
                                             <button
                                                  v-if="
                                                       !(
                                                            exam.status ==
                                                                 'inProgress' ||
                                                            exam.status ==
                                                                 'pendingReview'
                                                       )
                                                  "
                                                  type="button"
                                                  class="btn btn-sm rounded rounded-pill btn-alt-secondary"
                                                  @click="
                                                       () => {
                                                            if (
                                                                 exam.status ==
                                                                      'passed' ||
                                                                 exam.status ==
                                                                      'failed'
                                                            ) {
                                                                 $router.push({
                                                                      name: 'examconnect-exam-results',
                                                                      query: {
                                                                           exam_id: exam.exam_id,
                                                                           user_id: userExams.id,
                                                                      },
                                                                 });
                                                            } else
                                                                 $router.push({
                                                                      name: 'examconnect-user-exam',
                                                                      query: {
                                                                           exam_id: exam.exam_id,
                                                                           user_id: userExams.id,
                                                                      },
                                                                 });
                                                       }
                                                  "
                                             >
                                                  <span
                                                       v-if="
                                                            exam.status ===
                                                                 'passed' ||
                                                            exam.status ===
                                                                 'failed'
                                                       "
                                                  >
                                                       Result
                                                  </span>

                                                  <span
                                                       v-if="
                                                            exam.status ==
                                                            'notStarted'
                                                       "
                                                  >
                                                       Start
                                                  </span>
                                             </button>
                                        </div>
                                   </td>
                              </tr>
                         </tbody>
                    </table>
               </BaseBlock>
               <!-- END Hover Table -->
          </div>
     </div>
</template>

<style>
.fixed-size-image {
     width: 200px;
     height: 150px;
     object-fit: cover;
}
</style>
