<script>
import axios from "axios";

export default {
  data() {
    return {
      newQuestion: {
        text: "",
        type: "text",
        answers: [],
        correctChoiceIndex: -1,
      },
      addedQuestions: [],
    };
  },
  methods: {
    addChoice() {
      this.newQuestion.answers.push("");
    },
    removeChoice(index) {
      this.newQuestion.answers.splice(index, 1);
    },
    updateChoice(event, index) {
      this.newQuestion.answers[index].value = event.target.value;
    },

    updateImageChoice(event, index) {
      const file = event.target.files[0];
      if (file) {
        this.uploadImage(file).then((imageUrl) => {
          this.newQuestion.answers[index] = {
            type: "image",
            source: imageUrl,
          };
        });
      }
    },
    async uploadImage(file) {
      try {
        const formData = new FormData();
        formData.append("image", file);
        const response = await axios.post(
          "http://localhost:3000/upload-image",
          formData
        );
        return response.data.imageUrl;
      } catch (error) {
        console.error("Erreur lors du téléchargement de l'image:", error);
        return "";
      }
    },
    async submitQuestion() {
      try {
        const questionData = {
          text_question: this.newQuestion.text,
          type_question: this.newQuestion.type,
        };

        if (this.newQuestion.type === "text") {
          questionData.choices = [];
          questionData.correctChoiceIndex = -1;
        } else if (this.newQuestion.type === "choice") {
          questionData.choices = [...this.newQuestion.answers];
          questionData.correctChoiceIndex = this.newQuestion.correctChoiceIndex;
        }

        const response = await axios.post(
          "http://localhost:3000/questions",
          questionData
        );

        const questionId = response.data.question_id;
        console.log("Question ajoutée avec succès");

        this.addedQuestions.push({
          text: this.newQuestion.text,
          type: this.newQuestion.type,
          answers: [...this.newQuestion.answers],
        });

        this.newQuestion.text = "";
        this.newQuestion.type = "text";
        this.newQuestion.answers = [];
        this.newQuestion.correctChoiceIndex = -1;

        if (this.newQuestion.type === "choice") {
          await axios.post(
            `http://localhost:3000/questions/${questionId}/choices`,
            {
              choices:
                this.addedQuestions[this.addedQuestions.length - 1].answers,
              correctChoiceIndex: this.newQuestion.correctChoiceIndex,
            }
          );
        }
      } catch (error) {
        console.error("Erreur lors de l'ajout de la question:", error);
      }
    },

    addChoiceWithType(choiceType) {
      if (choiceType === "text") {
        this.newQuestion.answers.push({ type: "text", value: "" });
      } else if (choiceType === "image") {
        this.newQuestion.answers.push({ type: "image", source: "" });
      }
    },
  },
};
</script>

<template>
  <div class="content">
    <!-- Ajouter des Question  -->
    <BaseBlock title="Ajouter une nouvelle question">
      <div class="row">
        <div class="col-lg-4">
          <p class="fs-sm text-muted">
            Créez une nouvelle question en remplissant les champs ci-dessous.
          </p>
        </div>
        <div class="col-lg-8 space-y-5">
          <form @submit.prevent>
            <div class="mb-4">
              <label class="form-label" for="questionText"
                >Texte de la question:</label
              >
              <input
                type="text"
                class="form-control"
                id="questionText"
                v-model="newQuestion.text"
              />
            </div>
            <div class="mb-4">
              <label class="form-label" for="questionType"
                >Type de question:</label
              >
              <select
                class="form-select"
                id="questionType"
                v-model="newQuestion.type"
              >
                <option value="text">Texte</option>
                <option value="choice">Choix à choix multiples</option>
              </select>
            </div>
            <div v-if="newQuestion.type === 'choice'">
              <button
                class="btn btn-outline-success mb-3"
                @click="addChoiceWithType('text')"
              >
                Ajouter un choix de texte
              </button>
              <button
                class="btn btn-outline-success mb-3 ms-3"
                @click="addChoiceWithType('image')"
              >
                Ajouter un choix d'image
              </button>
              <div v-for="(choice, index) in newQuestion.answers" :key="index">
                <div v-if="choice.type === 'text'">
                  <input
                    type="text"
                    class="form-control"
                    v-model="choice.value"
                    @input="updateChoice($event, index)"
                  />
                </div>
                <div
                  v-else-if="choice.type === 'image'"
                  class="image-choice-container"
                >
                  <input
                    type="file"
                    accept="image/*"
                    @change="updateImageChoice($event, index)"
                  />
                  <div class="image-wrapper mt-3">
                    <img
                      :src="'http://localhost:3000/images/' + choice.source"
                      alt="Image du choix"
                      class="fixed-size-image"
                    />
                  </div>
                </div>
                <div class="form-check">
                  <input
                    type="radio"
                    class="form-check-input"
                    :id="'choice' + index"
                    :name="'questionChoices'"
                    :value="index"
                    v-model="newQuestion.correctChoiceIndex"
                  />
                  <label class="form-check-label" :for="'choice' + index"
                    >Choix correct</label
                  >
                </div>
                <button
                  class="btn btn-outline-info mb-5"
                  @click="removeChoice(index)"
                >
                  Supprimer
                </button>
              </div>
            </div>
            <button class="btn btn-success mb-3 mt-5" @click="submitQuestion">
              Ajouter la question
            </button>
          </form>
        </div>
      </div>
    </BaseBlock>

    <!-- L'affichage des Questions ajouter -->
    <BaseBlock title="Questions ajoutées">
      <div v-for="(question, qIndex) in addedQuestions" :key="qIndex">
        <h3>{{ question.text }}</h3>
        <div v-if="question.type === 'choice'">
          <div v-for="(choice, cIndex) in question.answers" :key="cIndex">
            <div class="form-check">
              <input
                type="radio"
                class="form-check-input"
                :id="'choice' + qIndex + cIndex"
                :name="'question' + qIndex"
                :value="cIndex"
              />
              <label class="form-check-label" :for="'choice' + qIndex + cIndex">
                <span v-if="choice.type === 'text'">{{ choice.value }}</span>
                <img
                  v-else-if="choice.type === 'image'"
                  :src="'http://localhost:3000/images/' + choice.source"
                  alt="Image du choix"
                  class="fixed-size-image"
                />
              </label>
            </div>
          </div>
        </div>
      </div>
    </BaseBlock>
  </div>
</template>

<style>
.fixed-size-image {
  width: 200px;
  height: 150px;
  object-fit: cover;
}
</style>
