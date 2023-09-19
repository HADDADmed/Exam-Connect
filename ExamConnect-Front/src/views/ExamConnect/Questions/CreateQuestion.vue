<script>
import CKEditor from "@ckeditor/ckeditor5-vue";
import ClassicEditor from "@ckeditor/ckeditor5-build-classic";
import QuestionsService from "../../../services/questions.service";
export default {
  data() {
    return {
      editorData: "<p>Content of the editor.</p>",
      editorConfig: {},
      ClassicEditor: ClassicEditor,
      isImages: false,
      question: {
        isQcm: 0,
        qstText: "",
        qstOptionCounter: 1,
        qstOptions: [
          {
            qstText: "",
            isTrue: false,
          },
        ],
        qstImages: [
          {
            qstImage: "",
            isTrue: false,
            preview: null,
            image: null,
            preview_list: [],
            image_list: [],
          },
        ],
      },
    };
  },
  methods: {
    addQstOption() {
      this.question.qstOptions.push({
        qstText: "",
        isTrue: false,
      });
    },
    addQstImage() {
      this.question.qstImages.push({
        qstText: "",
        isTrue: false,
        preview: null,
        image: null,
      });
    },
    saveQst() {
      if (this.question.isQcm == 2) {
        if (this.question.qstImages.length < 2) {
          this.globalService.toasterShowWarning("Please add at least 2 images");
        } else {
          // check if there is a null image and if  all the images are false using foreach
          var isNull = false;
          var isAllFalse = true;
          this.question.qstImages.forEach((element) => {
            if (element.image == null) {
              isNull = true;
              return;
            }
            if (element.isTrue == true) {
              isAllFalse = false;
            }
          });

          if (isNull) {
            this.globalService.toasterShowWarning(
              "Please select an image for each option"
            );
            return;
          }
          if (isAllFalse) {
            this.globalService.toasterShowWarning(
              "Please select at least one true image"
            );
            return;
          }
        }

      }else  if (this.question.isQcm == 1) {
        if (this.question.qstOptions.length < 2) {
          this.globalService.toasterShowWarning("Please add at least 2 images");
        } else {
          // check if there is a null image and if  all the images are false using foreach
           var isAllFalse = true;
          this.question.qstOptions.forEach((element) => {
            if (element.isTrue == true) {
              isAllFalse = false;
              return
            }
          });
          if (isAllFalse) {
            this.globalService.toasterShowWarning(
              "Please select at least one true option"
            );
            return;
          }
        }
        //This is test for Push with query params ?
      }
      QuestionsService.createQuestion(this.question);
      this.$router.push({
        name: "examconnect-questions-list",
        query: { filterTearm: this.question.isQcm },
      });
    },
    previewImage(event, index) {
      var input = event.target;
      if (input.files) {
        var reader = new FileReader();
        reader.onload = (e) => {
          this.question.qstImages[index].preview = e.target.result;
        };
        this.question.qstImages[index].image = input.files[0];
        reader.readAsDataURL(input.files[0]);
      }
    },
    reset(index = null) {
      if (index != null) {
        this.question.qstImages[index].preview = null;
        this.question.qstImages[index].image = null;
        this.question.qstImages[index].preview_list = [];
        this.question.qstImages[index].image_list = [];
      } else {
        for (let i = 0; i < this.question.qstImages.length; i++) {
          this.question.qstImages[i].preview = null;
          this.question.qstImages[i].image = null;
          this.question.qstImages[i].preview_list = [];
          this.question.qstImages[i].image_list = [];
        }
      }
    },
  },
  components: {
    ckeditor: CKEditor.component,
  },
};
</script>

<style scoped>
.ck-editor .container {
  width: 500px !important;
  height: 900px !important;
}
.ck-editor__editable {
  height: 500px;
}
</style>

<template>
  <!-- Hero -->
  <div class="bg-body-light">
    <div class="content content-full">
      <div class="py-3 text-center">
        <h1 class="fw-bold mb-2">Create a new Qst</h1>
        <h2 class="fs-base lh-base fw-medium text-muted mb-0">
          You can chose between a text question or a QCM question
        </h2>
      </div>
    </div>
  </div>
  <!-- END Hero -->

  <!-- Page Content -->
  <div class="content">
    <!-- Tiptap -->
    <BaseBlock title="add New QST    " content-full>
      <div class="d-flex justify-content-end m-3">
        <div class="space-x-2">
          <div class="form-check form-switch form-check d-flex">
            <div style="margin-right: 65px">
              <strong>Text Question</strong>
            </div>
            <input
              @click="question.isQcm = question.isQcm == 1 ? 0 : 1"
              class="form-check-input"
              type="checkbox"
              value=""
              id="example-switch-inline1"
              name="example-switch-inline1"
              :checked="question.isQcm"
            />
            <div>
              <strong>QCM Question</strong>
            </div>
          </div>
        </div>
      </div>

      <div>
        <div>The Question Content :</div>
        <div>
          <ckeditor
            :editor="ClassicEditor"
            :config="editorConfig"
            v-model="question.qstText"
          />
        </div>
      </div>
      <div v-if="question.isQcm">
        <div>
          <div class="d-flex justify-content-start m-4">
            <div class="space-x-2">
              <div class="form-check form-switch form-check d-flex">
                <div style="margin-right: 65px">
                  <strong>Image Options</strong>
                </div>
                <input
                  @click="question.isQcm = question.isQcm == 1 ? 2 : 1"
                  class="form-check-input"
                  type="checkbox"
                  value=""
                  id="example-switch-inline1"
                  name="example-switch-inline1"
                  :checked="!question.isQcm"
                />
                <div>
                  <strong>Text Options</strong>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div>
          <div v-if="question.isQcm && question.isQcm == 2">
            <div id="app" class="container my-3">
              <div class="row">
                <div class="col-md-5 offset-md-1">
                  <form>
                    <div class="form-group">
                      <div v-for="(n, index) in question.qstImages">
                        <div
                          class="d-flex justify-content-between"
                          style="margin-left: 50px"
                        >
                          <div
                            class="card"
                            style="width: 18rem"
                            v-if="question.qstImages[index].preview"
                          >
                            <img
                              :src="question.qstImages[index].preview"
                              class="img-fluid card-img-top"
                            />
                            <div class="card-body">
                              <p class="mb-0 card-text">
                                file name:
                                {{ question.qstImages[index].image.name }}
                              </p>
                              <p class="mb-0 card-text">
                                size:
                                {{
                                  question.qstImages[index].image.size / 1024
                                }}KB
                              </p>
                            </div>
                          </div>

                          <div
                            style="width: 50px; height: 50px; margin-top: 10px"
                            v-if="question.qstImages[index].preview"
                          >
                            <input
                              type="radio"
                              class="btn-check"
                              :name="'options-outlined-' + index"
                              :id="'true-outlined-' + index"
                              v-model="question.qstImages[index].isTrue"
                              :value="true"
                            />
                            <label
                              class="btn btn-outline-success"
                              :for="'true-outlined-' + index"
                              >&nbsp;True</label
                            >

                            <input
                              type="radio"
                              class="btn-check"
                              :name="'options-outlined-' + index"
                              :id="'false-outlined-' + index"
                              v-model="question.qstImages[index].isTrue"
                              :value="false"
                            />
                            <label
                              class="btn btn-outline-danger"
                              :for="'false-outlined-' + index"
                              >False</label
                            >
                          </div>
                        </div>

                        <div class="d-flex justify-content-center">
                          <input
                            class="form-control form-control-file m-3"
                            type="file"
                            :id="'image-' + index"
                            accept="image/*"
                            name="image"
                            @change="previewImage($event, index)"
                          />
                        </div>

                        <div
                          class="btn btn-secondary text-center rounded rounded-circle m-3"
                          style="width: 50px; height: 50px"
                          @click="
                            () => {
                              question.qstImages.splice(index, 1);
                            }
                          "
                        >
                          <i
                            style="margin-top: 10px"
                            class="fa fa-trash text-center"
                            aria-hidden="true"
                          ></i>
                        </div>
                        <button
                          class="btn btn-secondary rounded rounded-pill"
                          @click="reset(index)"
                        >
                          Clear
                        </button>
                      </div>

                      <div>
                        <div>
                          <div class="d-flex justify-content-center m-5">
                            <div
                              class="btn btn-secondary rounded rounded-pill"
                              @click="
                                () => {
                                  question.qstOptionCounter++;
                                  addQstImage();
                                }
                              "
                            >
                              add new Image option
                            </div>
                            <button
                              class="btn btn-secondary rounded rounded-pill"
                              @click="reset"
                            >
                              Clear All
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
          <div v-else>
            <div
              v-for="(n, index) in question.qstOptions"
              :key="index"
              class="m-5 d-flex justify-content-around"
            >
              <div class="col-md-10">
                <ckeditor
                  :editor="ClassicEditor"
                  :config="editorConfig"
                  v-model="question.qstOptions[index].qstText"
                />
              </div>

              <div style="width: 50px; height: 50px; margin-top: 10px">
                <input
                  type="radio"
                  class="btn-check"
                  :name="'options-outlined-' + index"
                  :id="'true-outlined-' + index"
                  v-model="question.qstOptions[index].isTrue"
                  :value="true"
                />
                <label
                  class="btn btn-outline-success"
                  :for="'true-outlined-' + index"
                  >&nbsp;True</label
                >

                <input
                  type="radio"
                  class="btn-check"
                  :name="'options-outlined-' + index"
                  :id="'false-outlined-' + index"
                  v-model="question.qstOptions[index].isTrue"
                  :value="false"
                />
                <label
                  class="btn btn-outline-danger"
                  :for="'false-outlined-' + index"
                  >False</label
                >
              </div>

              <div
                class="btn btn-secondary text-center rounded rounded-circle m-3"
                style="width: 50px; height: 50px"
                @click="
                  () => {
                    question.qstOptions.splice(index, 1);
                    question.qstOptionCounter--;
                  }
                "
              >
                <i
                  style="margin-top: 10px"
                  class="fa fa-trash text-center"
                  aria-hidden="true"
                ></i>
              </div>
            </div>

            <div class="d-flex justify-content-center m-5">
              <div
                class="btn btn-secondary rounded rounded-pill"
                @click="
                  () => {
                    question.qstOptionCounter++;
                    addQstOption();
                  }
                "
              >
                add new Qst option
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="d-flex justify-content-center m-5">
        <button @click="saveQst()" class="btn btn-lg rounded-pill btn-success">
          Save
        </button>
      </div>
    </BaseBlock>

    <!-- END Tiptap -->
  </div>
  <!-- END Page Content -->
</template>
