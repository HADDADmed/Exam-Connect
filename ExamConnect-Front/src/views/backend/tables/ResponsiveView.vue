<script>
import axios from "axios";
import { RouterLink } from 'vue-router';

export default {
  data() {
    return {
      examTitle: "",
      nombre_qsts: 0,
      date_heure_debut: "",
      date_heure_fin: "",
      addedQuestions: [],
      createdExams: [],
    };
  },
  methods: {
    async fetchQuestions() {
      try {
        const response = await axios.get("http://localhost:3000/questions");
        console.log("Réponse de l'API des questions:", response.data);
        this.addedQuestions = response.data;

        console.log("Questions récupérées avec succès", this.addedQuestions);
      } catch (error) {
        console.error("Erreur lors de la récupération des questions:", error);
      }
    },

    async createExam() {
      if (this.addedQuestions.length === 0) {
        console.error("Aucune question n'a été ajoutée à l'examen.");
        return;
      }

      // Sélectionnez un nombre aléatoire de questions
      const randomQuestions = this.shuffle(this.addedQuestions).slice(
        0,
        this.nombre_qsts
      );

      // Créez un nouvel examen en envoyant les données au backend
      try {
        const response = await axios.post("http://localhost:3000/exams", {
          titre: this.examTitle,
          nombre_qsts: this.nombre_qsts,
          questions: randomQuestions,
          date_heure_debut: this.date_heure_debut,
          date_heure_fin: this.date_heure_fin,
        });

        console.log("Examen créé avec succès", response.data);
      } catch (error) {
        console.error("Erreur lors de la création de l'examen:", error);
      }
    },

    shuffle(array) {
      let currentIndex = array.length,
        randomIndex,
        tempValue;
      while (currentIndex !== 0) {
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex--;
        tempValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = tempValue;
      }
      return array;
    },
    async fetchCreatedExams() {
      try {
        const response = await axios.get("http://localhost:3000/exams");
        this.createdExams = response.data;
        console.log("Examens récupérés avec succès", this.createdExams);
      } catch (error) {
        console.error("Erreur lors de la récupération des examens:", error);
      }
    },
  },
  created() {
    this.fetchQuestions();
    this.fetchCreatedExams();
  },
};
</script>

<template>
  <div>
    <div class="content">
      <BaseBlock title="AJOUTER UN NOUVEAU EXAMEN">
        <div class="row">
          <div class="col-lg-4">
            <p class="fs-sm text-muted">
              Créez une nouvelle examens en remplissant les champs ci-dessous.
            </p>
          </div>
          <div class="col-lg-8 space-y-5">
            <h2 class="mb-4">Créer un nouvel examen</h2>
            <form @submit.prevent="createExam">
              <div class="mb-4">
                <label class="form-label mb-2" for="examTitle"
                  >Titre de l'examen :</label
                >
                <input type="text" v-model="examTitle" class="form-control" />
              </div>
              <div class="mb-4">
                <label class="form-label mb-2" for="nombre_qsts"
                  >Nombre de questions :</label
                >
                <input
                  type="number"
                  v-model="nombre_qsts"
                  class="form-control"
                />
              </div>
              <div class="mb-4">
                <label class="form-label mb-2" for="date_heure_debut"
                  >Date et Heure de début :</label
                >
                <input
                  type="datetime-local"
                  v-model="date_heure_debut"
                  class="form-control"
                />
              </div>
              <div class="mb-4">
                <label class="form-label mb-2" for="date_heure_fin"
                  >Date et Heure de fin :</label
                >
                <input
                  type="datetime-local"
                  v-model="date_heure_fin"
                  class="form-control"
                />
              </div>
              <button type="submit" class="btn btn-success mb-3 mt-5">
                Créer l'examen
              </button>
            </form>
          </div>
        </div>

        <div class="mt-5">
          <h3>Examens créés :</h3>
          <ul>
            <li v-for="(examen, index) in createdExams" :key="index">
              <p>
              {{ examen.titre }} ({{ examen.nombre_qsts }} questions)
              <ul>
                <li
                  v-for="(question, qIndex) in examen.questions"
                  :key="qIndex" 
                >
                  {{ question.texte_question }} 
                  <!-- - {{ question.type_question }} -->
                </li>
              </ul>
            </p>
          <div>
            <!-- <a :href="'/passer-examen/' + examen.examen_id">Passer l'examen</a> -->
            <router-link :to="{ name: 'backend-elearning-course' }">Voir les examens</router-link>
          </div>

            </li>
          </ul>
        </div>
      </BaseBlock>
    </div>
  </div>
</template>
