import { createRouter, createWebHashHistory } from "vue-router";
import GlobalService from "@/services/global.service";
import NProgress from "nprogress/nprogress.js";




function guardMyRoutes(to, from, next) {
     const user = GlobalService.getCurrentUser();
     const accessToken = GlobalService.getCurrentAccessToken();
     if(to.name !== 'examconnect-authentication' && !accessToken){
          if(to.query.exam_id_live){
               next({ name: 'examconnect-authentication', query: { exam_id_live: to.query.exam_id_live } })
          }
         else next({ name: 'examconnect-authentication' })
     }else if(to.name === 'examconnect-authentication' && accessToken){
         localStorage.removeItem('accessToken')
         localStorage.removeItem('user')
         next({ name: 'examconnect-authentication' })
     }else{
         next()
     }
 }
 

 

function lazyLoadVue(view, folder = null) {
     if (folder)
          return () => import(`@/views/examconnect/${folder}/${view}.vue`);
     else return () => import(`@/views/examconnect/${view}.vue`);
}
function lazyLoadLayout(params) {
     return () => import(`@/layouts/variations/${params}.vue`);
}

// Set all routes
const routes = [
     /*
  |
  |--------------------------------------------------------------------------
  | Landing Routes
  |--------------------------------------------------------------------------
  |
  */
     {
          path: "/signin",
          name: "examconnect-authentication",
          component: lazyLoadVue("AuthenticationPage", "Auth"),
     },
     {
          path: "/examconnect",
          redirect: "/examconnect/examconnect-dashboard",
          component: lazyLoadLayout("Backend"),
          children: [
               {
                    path: "/",
                    name: "landing",
                    component: lazyLoadVue("DashboardView"),
               },
               {
                    path: "examconnect-dashboard",
                    name: "examconnect-dashboard",
                    component: lazyLoadVue("DashboardView"),
               },
               {
                    path: "exams/examconnect-exams-list",
                    name: "examconnect-exams-list",
                    component: lazyLoadVue("ExamsList", "Exams"),
               },
               {
                    path: "exams/examconnect-exams-create",
                    name: "examconnect-exams-create",
                    component: lazyLoadVue("CreateExam", "Exams"),
               },
               {
                    path: "exams/examconnect-exams-exam",
                    name: "examconnect-exams-exam",
                    component: lazyLoadVue("OneExamPageAdmin", "Exams"),
               },
               {
                    path: "questions/examconnect-questions-list",
                    name: "examconnect-questions-list",
                    component: lazyLoadVue("QuestionsList", "Questions"),
               },
               {
                    path: "questions/examconnect-questions-create",
                    name: "examconnect-questions-create",
                    component: lazyLoadVue("CreateQuestion", "Questions"),
               },
               {
                    path: "Users/examconnect-users-list",
                    name: "examconnect-users-list",
                    component: lazyLoadVue("UsersList", "Users"),
               },
               {
                    path: "Users/examconnect-users-create",
                    name: "examconnect-users-create",
                    component: lazyLoadVue("CreateUser", "Users"),
               },
               {
                    path: "Users/examconnect-exam-results",
                    name: "examconnect-exam-results",
                    component: lazyLoadVue("ExamResult", "Exams"),
               },
          ],
     },

     /*
  |
  |--------------------------------------------------------------------------
  | Backend Boxed Routes
  |--------------------------------------------------------------------------
  |
  */
     {
          path: "/examconnect-user",
          component: lazyLoadLayout("Backend"),
          children: [
               {
                    path: "examconnect-user-exam",
                    name: "examconnect-user-exam",
                    component: lazyLoadVue("OneExamPageUser", "Exams"),
               },
               {
                    path: "404",
                    name: "user-error-404",
                    component: lazyLoadVue("404Vue", "Erors"),
               },
               {
                    path: "401",
                    name: "user-error-401",
                    component: lazyLoadVue("401Vue", "Erors"),
               },
               {
                    path: "user-error-examSubmited",
                    name: "examSubmited",
                    component: lazyLoadVue("examSubmited", "Erors"),
               },
          ],
     },
];

// Create Router
const router = createRouter({
     history: createWebHashHistory(),
     linkActiveClass: "active",
     linkExactActiveClass: "",
     scrollBehavior() {
          return { left: 0, top: 0 };
     },
     routes,
});

// Router Guards
router.beforeEach(guardMyRoutes);

// NProgress
/*eslint-disable no-unused-vars*/
NProgress.configure({ showSpinner: false });

router.beforeResolve((to, from, next) => {
     if (to.name) {
          NProgress.start();
     }

     next();
});

router.afterEach(() => {
     NProgress.done();
});
/*eslint-enable no-unused-vars*/

export default router;
