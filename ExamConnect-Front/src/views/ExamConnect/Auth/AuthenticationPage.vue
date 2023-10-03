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
import { useUserStore } from '@/stores/user'; // Replace with the actual path to your store file

// Main store and Router
const store = useTemplateStore();
const router = useRouter();
const route = useRoute();
const userStore = useUserStore();
const exam_id_live = route.query.exam_id_live;


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
               userStore.setUser(response.data.user);
               userStore.setAccessToken(response.data.accessToken);
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

                         ExamsService.checkAutorisationToExam(exam_id_live);
                         router.push({
                              name: "examconnect-user-exam",
                              query: { exam_id: exam_id_live },
                         });
                    }
               } else router.push({ name: "examconnect-dashboard" });


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
       <div class="w-100">
         <!-- Sign In Section -->
         <div class="bg-body-extra-light">
           <div class="content content-full">
             <div class="row g-0 justify-content-center">
               <div class="col-md-8 col-lg-6 col-xl-4 py-4 px-4 px-lg-5">
                 <!-- Header -->
                 <div class="text-center">

                   <h1 class="h4 mb-1">Sign In</h1>
                    <h2 class="h6 fw-normal mb-3 text-muted">
                      Welcome to ExamConnect
                    </h2>
                 </div>
                 <!-- END Header -->

                 <!-- Sign In Form -->
                 <form @submit.prevent="onSubmit">
                   <div class="py-3">
                     <div class="mb-4">
                       <input
                         type="text"
                         class="form-control form-control-lg form-control-alt"
                         id="login-username"
                         name="login-username"
                         placeholder="Username"
                         :class="{
                           'is-invalid': v$.username.$errors.length,
                         }"
                         v-model="state.username"
                         @blur="v$.username.$touch"
                       />
                       <div
                         v-if="v$.username.$errors.length"
                         class="invalid-feedback animated fadeIn"
                       >
                         Please enter your username
                       </div>
                     </div>
                     <div class="mb-4">
                       <input
                         type="password"
                         class="form-control form-control-lg form-control-alt"
                         id="login-password"
                         name="login-password"
                         placeholder="Password"
                         v-model="state.password"
                         :class="{
                           'is-invalid': v$.password.$errors.length,
                         }"
                          @blur="v$.password.$touch"
                       />
                       <div
                         v-if="v$.password.$errors.length"
                         class="invalid-feedback animated fadeIn"
                       >
                         Please enter your password
                       </div>
                     </div>
                     <div class="mb-4">
                       <div
                         class="d-md-flex align-items-md-center justify-content-md-between"
                       >


                       </div>
                     </div>
                   </div>
                   <div class="row justify-content-center">
                     <div class="col-lg-6 col-xxl-5">
                       <button type="submit" class="btn w-100 btn-alt-primary rounded rounded-pill">
                         <i class="fa fa-fw fa-sign-in-alt me-1 opacity-50"></i>
                         Sign In
                       </button>
                     </div>
                   </div>
                 </form>
                 <!-- END Sign In Form -->
               </div>
             </div>
           </div>
         </div>
         <!-- END Sign In Section -->

         <!-- Footer -->
         <div class="fs-sm text-center text-muted py-3">
           <strong>{{ store.app.name + " " + store.app.version }}</strong> &copy;
           {{ store.app.copyright }}
         </div>
         <!-- END Footer -->
       </div>
     </div>
     <!-- END Page Content -->
   </template>
