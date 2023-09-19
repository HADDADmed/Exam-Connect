<script>
export default {
  data() {
    return {
      IMAGES_PATH: "http://localhost:3000/public/images/",
    };
  },
  props: {
    index: Number,
    isAdmin: Boolean,
    question: Object,
  },
};
</script>

<template>

  <div v-if="isAdmin">
   
    <div class="d-flex flex-wrap justify-content-center">
      <div
        v-for="(option, index2) in question.options"
        class="m-5"
        :key="index"
      >
        <div style="width: 250px">
          <div class="form-check form-block">
            <label
              class="form-check-label"
              :for="'example-radio-block' + option.id"
            >
              <span class="d-block fw-normal text-center my-3">
                <div
                  style="
                    width: 100%;
                    height: 100%;
                    box-shadow: 0px 0px 10px transparent; /* Initial box shadow */
                    transition: background-color 0.3s, box-shadow 0.3s; /* Add transitions for smooth change */
                    position: relative; /* To position the icon */
                  "
                  :style="
                    option.isTrue
                      ? ' box-shadow: 0px 0px 50px 15px green;' /* Change styles when true */
                      : ' box-shadow: 0px 0px 20px red;'
                  "
                >
                  <!-- Set a fixed height for uniformity -->
                  <img
                    style="
                      width: 100%;
                      height: 100%;
                      object-fit: cover;
                      opacity: 1; /* Set the opacity to 1 (fully opaque) */
                    "
                    :src="IMAGES_PATH + option.question_text"
                    alt="image"
                  />

                  <!-- Add an icon (e.g., a checkmark) -->
                  <div
                    v-if="option.isTrue"
                    style="
                      position: absolute;
                      top: 10px;
                      right: 10px;
                      color: white; /* Icon color */
                      font-size: 24px; /* Icon size */
                    "
                  >
                    <i class="fa-solid fa-circle" style="color: #22c016"></i>
                    <!-- Checkmark symbol or any other icon -->
                  </div>
                  <div
                    v-else
                    style="
                      position: absolute;
                      top: 10px;
                      right: 10px;
                      color: white; /* Icon color */
                      font-size: 24px; /* Icon size */
                    "
                  >
                    <i class="fa-solid fa-circle" style="color: red"></i>
                    <!-- Checkmark symbol or any other icon -->
                  </div>
                </div>
              </span>
            </label>
          </div>
        </div>
      </div>
      <div class="d-flex flex-wrap justify-content-center"></div>
    </div>
  </div>


  <div v-else>
 
          <div class="d-flex flex-wrap justify-content-center">
            <div
              v-for="(option, index2) in question.options"
              class="m-5"
              :key="index"
            >
              <div style="width: 250px">
                <div class="form-check form-block">
                <input
                  type="radio"
                  class="form-check-input"
                  :id="'example-radio-block' + option.id"
                  :name="'example-radio-block-group-' + question.id"
                />
                <label
                  class="form-check-label"
                  :for="'example-radio-block' + option.id"
                >
                  <span class="d-block fw-normal text-center my-3">
                    <div style="width: 100%; height: 200px">
                      <!-- Set a fixed height for uniformity -->
                      <img
                        style="width: 100%; height: 100%; object-fit: cover"
                        :src="IMAGES_PATH + option.question_text"
                        alt="image"
                      />
                    </div>
                  </span>
                </label>
              </div>
              </div>
            </div>
            <div class="d-flex flex-wrap justify-content-center"></div>
          </div>
       
   </div>


</template>
