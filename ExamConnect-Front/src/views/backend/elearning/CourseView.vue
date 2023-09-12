<script>
import { ref, computed, onMounted } from "vue";
import { useRoute } from "vue-router";
import axios from "axios";

export default {
  data() {
    return {
      examens: [],
      examenId: null,
      questions: [],
    };
  },
  computed: {
    examen() {
      return this.examens.find((ex) => ex.id === this.examenId);
    },
  },
  mounted() {
    document.addEventListener("DOMContentLoaded", this.onDOMLoaded);
  },
  methods: {
    onDOMLoaded() {
      const route = useRoute();
      this.examenId = route.params.id;
      console.log("Examen ID:", this.examenId);
      try {
        this.loadExamenData(this.examenId)
          .then((examenData) => {
            this.examens = [examenData];
            return this.loadExamenQuestions();
          })
          .catch((error) => {
            console.error(
              "Erreur lors du chargement des données de l'examen:",
              error
            );
          });
      } catch (error) {
        console.error(
          "Erreur lors du chargement des données de l'examen:",
          error
        );
      }
      console.log(this.examenId);
    },

    async loadExamenData(examenId) {
      try {
        const response = await axios.get(
          `http://localhost:3000/exams/${examenId}`
        );
        return response.data;
      } catch (error) {
        console.error(
          "Erreur lors du chargement des données de l'examen:",
          error
        );
        throw error;
      }
    },

    async loadExamenQuestions() {
      try {
        const response = await axios.get(
          `http://localhost:3000/exams/${this.examenId}/questions`
        );
        this.questions = response.data;
      } catch (error) {
        console.error("Erreur lors du chargement des questions:", error);
      }
    },
  },
};
</script>

<template>
  <BaseBackground
    image="/assets/media/various/promo-code.png"
    inner-class="bg-primary-dark-op"
  >
    <div class="content content-full text-center py-7 pb-5">
      <h1 class="h2 text-white mb-2">Les questions de L'Examen</h1>
      <h2 class="h4 fw-normal text-white-75">10 questions &bull; 3 heures</h2>
    </div>
  </BaseBackground>

  <!-- Navigation -->
  <div class="bg-body-extra-light">
    <div class="content content-boxed py-3">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb breadcrumb-alt">
          <li class="breadcrumb-item">
            <RouterLink
              :to="{ name: 'backend-elearning-courses' }"
              class="link-fx"
              >Examens</RouterLink
            >
          </li>
          <li class="breadcrumb-item" aria-current="page">
            les question d'examen (examen.titre)
          </li>
        </ol>
      </nav>
    </div>
  </div>
  <!-- Navigation -->

  <div class="content content-boxed">
    <div class="row">
      <div class="col-xl-8">
        <BaseBlock content-class="fs-sm">
          <div>
            <h1>{{ examen ? examen.titre : "Chargement en cours..." }}</h1>
            <p>{{ examen ? examen.nombre_qsts : "" }} questions</p>
            <p>
              Date de début :
              {{ examen ? formatDate(examen.date_heure_debut) : "" }}
            </p>

            <ul v-if="examen && examen.questions.length > 0">
              <li v-for="(question, qIndex) in examen.questions" :key="qIndex">
                {{ question.texte_question }} - {{ question.type_question }}
              </li>
            </ul>

            <p v-else>Aucun examen trouvé pour cet ID.</p>
          </div>

          <div>
            <h1>Questions de l'examen</h1>
            <ul>
              <li v-for="(question, qIndex) in questions" :key="qIndex">
                {{ question.texte_question }} - {{ question.type_question }}
              </li>
            </ul>
          </div>
        </BaseBlock>
      </div>
    </div>
  </div>

  <div class="bg-body-dark">
    <div class="content content-full text-center py-6">
      <h3 class="h4 mb-4">Ajouter d'autre questions :</h3>
      <a
        class="btn btn-outline-success px-4 py-2"
        href="http://localhost:5173/#/backend/dashboard"
        >créer des questions</a
      >
    </div>
  </div>
</template>

<!-- Hero Content -->
<!-- <BaseBackground
  image="/assets/media/various/promo-code.png"
  inner-class="bg-primary-dark-op"
>
  <div class="content content-full text-center py-7 pb-5">
    <h1 class="h2 text-white mb-2">show the questions of this Examen</h1>
    <h2 class="h4 fw-normal text-white-75">10 questions &bull; 3 hours</h2>
  </div>
</BaseBackground> -->
<!-- END Hero Content -->

<!-- Navigation -->
<!-- <div class="bg-body-extra-light">
  <div class="content content-boxed py-3">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb breadcrumb-alt">
        <li class="breadcrumb-item">
          <RouterLink
            :to="{ name: 'backend-elearning-courses' }"
            class="link-fx"
            >Examens</RouterLink
          >
        </li>
        <li class="breadcrumb-item" aria-current="page">
          les question d'examen (examen.titre)
        </li>
      </ol>
    </nav>
  </div>
</div> -->
<!-- END Navigation -->

<!-- Page Content -->
<!-- <div class="content content-boxed">
  <div class="row">
    <div class="col-xl-8">
      <BaseBlock content-class="fs-sm">
        <table class="table table-borderless table-vcenter">
          <tbody>
            <tr class="table-active">
              <th style="width: 50px"></th>
              <th></th>
            </tr>
            <tr>
              <td class="table-danger text-center">
                <i class="fa fa-fw fa-circle text-danger"></i>
              </td>
              <td>
                <a class="fw-medium" href="javascript:void(0)"
                  >3.1 HTML5 Forms</a
                >
              </td>
            </tr>
          </tbody>
        </table>
      </BaseBlock>
    </div>
    <div class="col-xl-4"> -->
<!-- Course Info -->
<!-- <BaseBlock title="About This examen" header-class="text-center">
        <table class="table table-striped table-borderless fs-sm">
          <tbody>
            <tr>
              <td><i class="fa fa-fw fa-book me-1"></i> 10 questions</td>
            </tr>
            <tr>
              <td><i class="fa fa-fw fa-clock me-1"></i> 3 hours</td>
            </tr>
            <tr>
              <td><i class="fa fa-fw fa-calendar me-1"></i> 3 weeks ago</td>
            </tr>
            <tr>
              <td>
                <i class="fa fa-fw fa-tags me-1"></i>
                <a
                  class="fw-semibold link-fx text-primary"
                  href="javascript:void(0)"
                  >HTML</a
                >
              </td>
            </tr>
          </tbody>
        </table>
      </BaseBlock> -->
<!-- END Course Info -->
<!-- </div>
  </div>
</div> -->
<!-- END Page Content -->

<!-- <script setup>
import { ref, computed, onMounted } from "vue";
import { useRoute } from "vue-router";
import axios from "axios";

const route = useRoute();

const examens = ref([]);

const examenId = ref(null);

examenId.value = route.params.id;

const questions = ref([]);

const examen = computed(() => {
  return examens.value.find((ex) => ex.id === examenId.value);
});

async function loadExamenData(examenId) {
  try {
    const response = await axios.get(`http://localhost:3000/exams/${examenId}`);
    return response.data;
  } catch (error) {
    console.error("Erreur lors du chargement des données de l'examen:", error);
    throw error;
  }
}
async function loadExamenQuestions() {
  try {
    const response = await axios.get(
      `http://localhost:3000/exams/${examenId}/questions`
    );
    questions.value = response.data;
  } catch (error) {
    console.error("Erreur lors du chargement des questions:", error);
  }
}

onMounted(async () => {
  const examenId = route.params.id;
  try {
    const examenData = await loadExamenData(examenId.value);
    examen.value = examenData;
  } catch (error) {
    console.error("Erreur lors du chargement des données de l'examen:", error);
  }
});
onMounted(loadExamenQuestions);
onMounted(loadExamenQuestions);

console.log(examenId.value);
</script> -->
