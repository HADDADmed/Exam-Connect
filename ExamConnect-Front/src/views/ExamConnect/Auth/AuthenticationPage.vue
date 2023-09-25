<script setup>
import { reactive, computed } from "vue";
import { useRouter, useRoute } from "vue-router";
import { useTemplateStore } from "@/stores/template";
import AuthService from "@/services/auth.service";
import GlobalService from "../../../services/global.service";
import ExamsService from "../../../services/exams.service";
// Vuelidate, for more info and examples you can check out https://github.com/vuelidate/vuelidate
import useVuelidate from "@vuelidate/core";
import { required, minLength } from "@vuelidate/validators";

// Main store and Router
const store = useTemplateStore();
const router = useRouter();
const route = useRoute();

const exam_id_live = route.query.exam_id_live;

if (exam_id_live) console.log(exam_id_live);
else console.log("no exam_id_live");

// Input state variables
const state = reactive({
     username: null,
     password: null,
});

// Validation rules
const rules = computed(() => {
     return {
          username: {
               required,
               minLength: minLength(5),
          },
          password: {
               required,
               minLength: minLength(3),
          },
     };
});

// Use vuelidate
const v$ = useVuelidate(rules, state);

// On form submission
async function onSubmit() {
     const result = await v$.value.$validate();

     if (!result) {
          // notify user form is invalid
          return;
     }
     AuthService.login(state.username, state.password).then(
          (response) => {
               localStorage.setItem("accessToken", response.data.accessToken);
               localStorage.setItem("user", JSON.stringify(response.data.user));
               GlobalService.toasterShowSuccess("Login successful !");
               if (exam_id_live) {
                    if (response.data.user.isAdmin) {
                         router.push({
                              name: "examconnect-exams-exam",
                              query: { exam_id: exam_id_live },
                         });
                    } else {
                         //check if the user are authorized to access the exam

                         ExamsService.checkAutorisationToExam(
                              exam_id_live
                         ).then(
                              (response) => {
                                   // check the status of the response
                                   if (response.status === 200) {
                                        if (
                                             response.data.user_exam.status ==
                                             "notStarted"
                                        ) {
                                             router.push({
                                                  name: "examconnect-user-exam",
                                                  query: {
                                                       exam_id: exam_id_live,
                                                  },
                                             });
                                        } else if (
                                             response.data.user_exam.status ==
                                             "pendingReview"
                                        ) {
                                             router.push({
                                                  name: "examSubmited",
                                             });
                                        } else if (
                                             response.data.user_exam.status ==
                                                  "passed" ||
                                             response.data.user_exam.status ==
                                                  "failed"
                                        ) {
                                             router.push({
                                                  name: "examconnect-exam-results",
                                                  query: {
                                                       exam_id: response.data
                                                            .user_exam.exam_id,
                                                       user_id: response.data
                                                            .user_exam.user_id,
                                                  },
                                             });
                                        }
                                   } else {
                                        router.push({ name: "user-error-404" });
                                   }
                              },
                              (error) => {
                                   console.log(error);
                              }
                         );

                         router.push({
                              name: "examconnect-user-exam",
                              query: { exam_id: exam_id_live },
                         });
                    }
               } else {
                    if (response.data.user.isAdmin) {
                         router.push({ name: "examconnect-dashboard" });
                    } else {
                         router.push({ name: "user-error-404" });
                    }
               }
          },
          (error) => {
               console.log(error);
          }
     );

     // Go to dashboard
}
</script>

<template>
     <!-- Page Content -->
     <div class="hero-static d-flex align-items-center">
          <div class="content">
               <div class="row justify-content-center push">
                    <div class="col-md-8 col-lg-6 col-xl-4">
                         <!-- Sign In Block -->
                         <BaseBlock title="Sign In" class="mb-0">
                              <template #options> </template>

                              <div class="p-sm-3 px-lg-4 px-xxl-5 py-lg-5">
                                   <h1 class="h2 mb-1">Exam-connect</h1>
                                   <p class="fw-medium text-muted">
                                        please login.
                                   </p>

                                   <!-- Sign In Form -->
                                   <form @submit.prevent="onSubmit">
                                        <div class="py-3">
                                             <div class="mb-4">
                                                  <input
                                                       type="text"
                                                       class="form-control form-control-alt form-control-lg"
                                                       id="login-username"
                                                       name="login-username"
                                                       placeholder="Username"
                                                       :class="{
                                                            'is-invalid':
                                                                 v$.username
                                                                      .$errors
                                                                      .length,
                                                       }"
                                                       v-model="state.username"
                                                       @blur="
                                                            v$.username.$touch
                                                       "
                                                  />
                                                  <div
                                                       v-if="
                                                            v$.username.$errors
                                                                 .length
                                                       "
                                                       class="invalid-feedback animated fadeIn"
                                                  >
                                                       Please enter your
                                                       username
                                                  </div>
                                             </div>
                                             <div class="mb-4">
                                                  <input
                                                       type="password"
                                                       class="form-control form-control-alt form-control-lg"
                                                       id="login-password"
                                                       name="login-password"
                                                       placeholder="Password"
                                                       :class="{
                                                            'is-invalid':
                                                                 v$.password
                                                                      .$errors
                                                                      .length,
                                                       }"
                                                       v-model="state.password"
                                                       @blur="
                                                            v$.password.$touch
                                                       "
                                                  />
                                                  <div
                                                       v-if="
                                                            v$.password.$errors
                                                                 .length
                                                       "
                                                       class="invalid-feedback animated fadeIn"
                                                  >
                                                       Please enter your
                                                       password
                                                  </div>
                                             </div>
                                        </div>
                                        <div class="row mb-4">
                                             <div class="col-md-6 col-xl-5">
                                                  <button
                                                       type="submit"
                                                       class="btn w-100 btn-alt-primary"
                                                  >
                                                       <i
                                                            class="fa fa-fw fa-sign-in-alt me-1 opacity-50"
                                                       ></i>
                                                       Sign In
                                                  </button>
                                             </div>
                                        </div>
                                   </form>
                                   <!-- END Sign In Form -->
                              </div>
                         </BaseBlock>
                         <!-- END Sign In Block -->
                    </div>
               </div>
               <div class="fs-sm text-muted text-center">
                    <strong>{{
                         store.app.name + " " + store.app.version
                    }}</strong>
                    &copy;
                    {{ store.app.copyright }}
               </div>
          </div>
     </div>
     <!-- END Page Content -->
</template>
