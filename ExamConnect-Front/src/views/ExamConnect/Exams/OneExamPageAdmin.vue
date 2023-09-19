<script>
import ExamsService from "../../../services/exams.service";
import qstVue from "../components/questions/qst.vue";
export default {
  data() {
    return {
      exam_id: this.$route.query.exam_id,
      hover: false,
      exam: {},
      currentTime: new Date().toLocaleTimeString(),
      IMAGES_PATH: "http://localhost:3000/public/images/",
    };
  },
  mounted() {
    ExamsService.getExamById(this.exam_id).then((res) => {
      this.exam = res.data;
     });
    setInterval(() => {
      this.currentTime = new Date().toLocaleTimeString();
    }, 1000);
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
          {{ globalService.getTimeWithoutSeconds(exam.startTime) }} and will end
          at {{ globalService.getTimeWithoutSeconds(exam.endTime) }} in
          {{ globalService.getDate(exam.startTime) }}
        </h2>
      </div>
    </div>
  </div>
  <!-- END Hero -->
  <!-- START Page Content -->
  <div class="content">
    <div v-for="(question, index) in exam.questions" class="col-12">
      <qstVue :question="question" :isAdmin="true" :index="index"></qstVue>
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
