<script setup>
import { ref, onMounted } from "vue";
import { RouterLink } from "vue-router";
import axios from "axios";

// Mock data for testing
const examens = ref([
  {
    id: 1,
    titre: "Examen 1",
    nombre_qsts: 4,
    date_heure_debut: "2023-09-01 10:00:00",
    date_heure_fin: "2023-09-01 12:00:00",
  },
  // Add more examens here
]);

function calculateDuration(start, end) {
  const startDate = new Date(start);
  const endDate = new Date(end);

  const timeDiff = endDate - startDate;

  const hours = Math.floor(timeDiff / (60 * 60 * 1000));
  const minutes = Math.floor((timeDiff % (60 * 60 * 1000)) / (60 * 1000));

  return `${hours} h ${minutes} min`;
}

function formatDate(date) {
  const options = { year: "numeric", month: "numeric", day: "numeric" };
  return new Date(date).toLocaleDateString(undefined, options);
}

const createdExams = ref([]);

async function fetchCreatedExams() {
  try {
    const response = await axios.get("http://localhost:3000/exams");
    createdExams.value = response.data;
    console.log("Examens récupérés avec succès", createdExams.value);
  } catch (error) {
    console.error("Erreur lors de la récupération des examens:", error);
  }
}
onMounted(fetchCreatedExams);
</script>

<template>
  <!-- Hero Content -->
  <!-- Hero Content  &bull-->
  <BaseBackground
    image="/assets/media/various/promo-code.png"
    inner-class="bg-primary-dark-op"
  >
    <div class="content content-full text-center py-7 pb-5">
      <h1 class="h2 text-white mb-2">show Examen</h1>
    </div>
  </BaseBackground>
  <!-- END Hero Content -->
  <!-- END Hero Content -->

  <!-- Page Content -->
  <div class="content content-boxed">
    <div class="row items-push py-4">
      <div
        v-for="examen in createdExams"
        :key="examen.id"
        class="col-md-6 col-lg-4 col-xl-3"
      >
        <RouterLink
          :to="{ name: 'backend-elearning-course', params: { id: examen.id } }"
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
                class="block-content block-content-full text-center bg-amethyst"
              >
                <div
                  class="item item-2x item-circle bg-white-10 py-3 my-3 mx-auto"
                >
                  <i class="fa-solid fa-laptop-file"></i>
                </div>
                <div class="fs-sm text-white-75">
                  {{ examen.nombre_qsts }} questions &bull;
                  {{
                    calculateDuration(
                      examen.date_heure_debut,
                      examen.date_heure_fin
                    )
                  }}
                </div>
              </div>
              <div class="block-content block-content-full">
                <h4 class="h5 mb-1">{{ examen.titre }}</h4>

                <div class="fs-sm text-muted">
                  {{ formatDate(examen.date_heure_debut) }}
                </div>
              </div>
            </template>
          </BaseBlock>
        </RouterLink>
      </div>
    </div>
  </div>
  <!-- END Page Content -->

  <!-- Get Started -->
  <div class="bg-body-dark">
    <div class="content content-full">
      <div class="my-5 text-center">
        <h3 class="h4 mb-4">Ajouter des nouveaux examens :</h3>
        <a
          class="btn btn-outline-secondary px-4 py-2"
          href="http://localhost:5173/#/backend/tables/responsive"
          >créer un examen</a
        >
      </div>
    </div>
  </div>
  <!-- END Get Started -->
</template>
