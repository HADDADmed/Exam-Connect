<script>
 import qstVue from "../components/questions/qst.vue";
 
export default {
     data() {
          return {
               exam_id: this.$route.query.exam_id,
               userAnswers: {},
               IMAGES_PATH: "http://localhost:3000/public/images/",
               generatedLink: "",
          };
     },
     mounted() {
          
     },methods: {
         

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
                        answers of user : {{ userAnswers.user_fullName }}
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
                    :isAdmin="true"
                    :index="index"
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
