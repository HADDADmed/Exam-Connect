<script>
import ExamsService from "../../../services/exams.service";
export default {
  data() {
    return {
      bgClass: ["bg-city","bg-flat","bg-amethyst","bg-smooth","bg-default","bg-modern","bg-warning","bg-success","bg-info","bg-danger","bg-gray-dark","bg-primary",],
      exams: [],
    };
  },
  mounted() {
    ExamsService.getAllExams().then((response) => {
      const examsCustom = response.data.map((exam) => {
        const startTime = new Date(exam.startTime);
        const endTime = new Date(exam.endTime);

        // Calculate the time difference in milliseconds
        const timeDifference = endTime - startTime;
        // Convert milliseconds to hours and minutes
        const hours = Math.floor(timeDifference / (1000 * 60 * 60));
        const minutes = Math.floor(
          (timeDifference % (1000 * 60 * 60)) / (1000 * 60)
        );

        const examDuration = `${hours} hours ${minutes} minutes`;
        return {
          ...exam,
          qcmQuestions: exam.questions.filter((q) => q.isQcm === 1).length,
          textQuestions: exam.questions.filter((q) => q.isQcm === 0).length,
          imageQuestions: exam.questions.filter((q) => q.isQcm === 2).length,
          createdAt: new Date(exam.createdAt).toLocaleDateString(),
          examDuration: examDuration,
        };
      });
      console.log(examsCustom);
      this.exams = examsCustom;
    });
  },
};
</script>

<template>
  <!-- Hero Content -->
  <div class="bg-primary-dark">
    <div class="content content-full text-center pt-7 pb-5">
      <h1 class="h2 text-white mb-2">List of All Exams.</h1>
      <h2 class="h4 fw-normal text-white-75">
        <strong> 15</strong> exam in Total .
      </h2>
      <!-- <a class="btn btn-primary px-4 py-2" href="javascript:void(0)"
        >Subscribe from $9/month</a
      > -->
    </div>
  </div>
  <!-- END Hero Content -->

  <!-- Page Content -->
  <div class="content content-boxed">
    <div class="row items-push py-4">
      <!-- Course -->
      <div v-for="exam in exams" class="col-md-6 col-lg-4 col-xl-3">
        <RouterLink
          :to="{
            name: 'examconnect-exams-exam',
            query: { exam_id: exam.exam_id },
          }"
          custom
          v-slot="{ href, navigate }"
        >
          <BaseBlock
            :href="href"
            @click="navigate"
            tag="a"
            link-pop
            class="h-100 mb-0"
          >
            <template #content>
              <div
                class="block-content block-content-full text-center"
                :class="bgClass[Math.floor(Math.random() * bgClass.length)]"
              >
                <div
                  style="font-size: 40px"
                  class="item item-2x item-circle bg-white-10 py-3 my-3 mx-auto"
                >
                  <h5 style="margin-top: 20px">
                    <strong>18</strong> users Answer
                  </h5>
                </div>
                <div class="fs-sm text-white-75">
                  {{ exam.questionsCount }} Questions &bull;
                  {{ exam.examDuration }}
                </div>
              </div>
              <div class="block-content block-content-full">
                <h4 class="h5 mb-1">{{exam.ExamTitle}}</h4>
                <div class="fs-sm text-muted">{{exam.createdAt}}</div>
                <div style="font-size: large"><strong>{{exam.qcmQuestions}} </strong> QCM Questions</div>
                <div style="font-size: large"><strong>{{ exam.textQuestions}} </strong> Text Questions</div>
                <div style="font-size: large"><strong>{{exam.imageQuestions}} </strong> Image Questions</div>
              </div>
            </template>
          </BaseBlock>
        </RouterLink>
      </div>
      <!-- END Course -->
    </div>
  </div>
  <!-- END Page Content -->
</template>
