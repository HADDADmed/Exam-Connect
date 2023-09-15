<script>
import ExamsService from "../../../services/exams.service";
export default {
  data() {
    return {
      os: [
        {
          id: 1,
          isQcm: true,
          isImage: false,
        },
        {
          id: 2,
          isQcm: false,
          isImage: false,
        },
        {
          id: 3,
          isQcm: true,
          isImage: true,
          images: [
            {
              id: 1,
              url: "/assets/media/photos/photo1@2x.jpg",
            },
            {
              id: 2,
              url: "/assets/media/photos/photo1@2x.jpg",
            },
            {
              id: 3,
              url: "/assets/media/photos/photo1@2x.jpg",
            },
          ],
        },
        {
          id: 4,
          isQcm: false,
        },
        {
          id: 5,
          isQcm: true,
          isImage: false,
        },
        {
          id: 6,
          isQcm: false,
        },
        {
          id: 7,
          isQcm: true,
          isImage: true,
          images: [
            {
              id: 4,
              url: "/assets/media/photos/photo1@2x.jpg",
            },
            {
              id: 5,
              url: "/assets/media/photos/photo1@2x.jpg",
            },
            {
              id: 6,
              url: "/assets/media/photos/photo1@2x.jpg",
            },
          ],
        },
        {
          id: 8,
          isQcm: false,
        },
        {
          id: 9,
          isQcm: true,
        },
        {
          id: 10,
          isQcm: false,
        },
      ],
      exam_id: this.$route.query.exam_id,
      hover: false,
      exam: {},
      currentTime: new Date().toLocaleTimeString(),
    };
  },
  mounted() {
    ExamsService.getExamById(this.exam_id).then((res) => {
      this.exam = res.data;
      console.log(this.exam);
    });
    setInterval(() => {
      this.currentTime = new Date().toLocaleTimeString();
    }, 1000);
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
  <div class="content">
    <!-- Dummy content -->
    <div v-for="(question, index) in exam.questions" class="col-12">
      <BaseBlock v-if="question.isQcm">
        <div v-if="question.isQcm === 1">
          <h2 class="content-heading">Question {{ index + 1 }} :</h2>
          <!-- creating the Question body -->
          <h4>{{ question.question_text }}</h4>
          <div class="m-5">
            <div v-for="(option, index2) in question.options" class="m-3">
              <div class="m-3">
                <input
                  type="radio"
                  class="form-check-input"
                  :class="option.isTrue ? 'is-valid' : 'is-invalid'"
                  :id="'option_' + option.id"
                  :name="'question_' + index"
                  :checked="option.isTrue"
                  :value="option.id"
                  disabled
                />
                <label class="qst" :for="'option_' + option.id" >
                  <strong style="font-size: 18px"> {{ index2 + 1 }} -</strong>
                  {{ option.option_question_text }}
                </label>
              </div>
            </div>
          </div>
        </div>

        <div v-else>
          <!-- creating the Question body -->
          <h2 class="content-heading">Question {{ index + 1 }} :</h2>
          <h4>{{ question.question_text }}</h4>
          <div class="d-flex">
            <div v-for="(option, index2) in question.options">
              <div class="m-5">
                <div class="form-check form-block">
                  <input
                    type="radio"
                    class="form-check-input"
                    :class="option.isTrue ? 'is-valid' : 'is-invalid'"
                    :id="'example-radio-block' + option.id"
                    :name="'example-radio-block-group-' + question.id"
                    :checked="option.isTrue"
                    disabled
                  />
                  <label
                    class="form-check-label"
                    :for="'example-radio-block' + option.id"
                  >
                    <span class="d-block fw-normal text-center my-3">
                      <div style="width: 100%">
                        <img
                          style="width: 100%"
                          :src="option.option_question_text"
                          alt="image"
                        />
                      </div>
                    </span>
                  </label>
                </div>
              </div>
            </div>
          </div>
        </div>
      </BaseBlock>

      <BaseBlock v-else>
      <!-- Creating the Question body -->
      <h2 class="content-heading">Question {{ index + 1 }} :</h2>
      <h4 class="mb-4" v-html="question.question_text"></h4>
    </BaseBlock>

    </div>
    <!-- END Dummy content -->
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
