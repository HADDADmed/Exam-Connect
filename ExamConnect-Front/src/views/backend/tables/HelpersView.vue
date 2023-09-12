<script setup>
import { reactive, computed, ref, onMounted } from "vue";

// Vue Dataset, for more info and examples you can check out https://github.com/kouts/vue-dataset/tree/next
import {
  Dataset,
  DatasetItem,
  DatasetInfo,
  DatasetPager,
  DatasetSearch,
  DatasetShow,
} from "vue-dataset";

// Get example data
// import users from "@/data/usersDataset.json";
const users = ref([]);

// Appel à l'API pour récupérer les utilisateurs
async function fetchUsers() {
  try {
    const response = await fetch("http://localhost:3000/users");
    const data = await response.json();
    users.value = data;
  } catch (error) {
    console.error("Erreur lors de la récupération des utilisateurs:", error);
  }
}

// Helper variables
const cols = reactive([
  {
    name: "ID",
    field: "id",
    sort: "",
  },
  {
    name: "NOM",
    field: "nom",
    sort: "",
  },
  {
    name: "PRENOM",
    field: "prenom",
    sort: "",
  },
  {
    name: "EMAIL",
    field: "email",
    sort: "",
  },
  {
    name: "MOT_DE_PASSE",
    field: "mot_de_passe",
    sort: "",
  },
]);

// Sort by functionality
const sortBy = computed(() => {
  return cols.reduce((acc, o) => {
    if (o.sort) {
      o.sort === "asc" ? acc.push(o.field) : acc.push("-" + o.field);
    }
    return acc;
  }, []);
});

// On sort th click
function onSort(event, i) {
  let toset;
  const sortEl = cols[i];

  if (!event.shiftKey) {
    cols.forEach((o) => {
      if (o.field !== sortEl.field) {
        o.sort = "";
      }
    });
  }

  if (!sortEl.sort) {
    toset = "asc";
  }

  if (sortEl.sort === "desc") {
    toset = event.shiftKey ? "" : "asc";
  }

  if (sortEl.sort === "asc") {
    toset = "desc";
  }

  sortEl.sort = toset;
}

// Apply a few Bootstrap 5 optimizations
onMounted(() => {
  // Remove labels from
  document.querySelectorAll("#datasetLength label").forEach((el) => {
    el.remove();
  });

  // Replace select classes
  let selectLength = document.querySelector("#datasetLength select");

  selectLength.classList = "";
  selectLength.classList.add("form-select");
  selectLength.style.width = "80px";
});
onMounted(fetchUsers);
</script>

<style lang="scss" scoped>
.gg-select {
  box-sizing: border-box;
  position: relative;
  display: block;
  transform: scale(1);
  width: 22px;
  height: 22px;
}
.gg-select::after,
.gg-select::before {
  content: "";
  display: block;
  box-sizing: border-box;
  position: absolute;
  width: 8px;
  height: 8px;
  left: 7px;
  transform: rotate(-45deg);
}
.gg-select::before {
  border-left: 2px solid;
  border-bottom: 2px solid;
  bottom: 4px;
  opacity: 0.3;
}
.gg-select::after {
  border-right: 2px solid;
  border-top: 2px solid;
  top: 4px;
  opacity: 0.3;
}
th.sort {
  cursor: pointer;
  user-select: none;
  &.asc {
    .gg-select::after {
      opacity: 1;
    }
  }
  &.desc {
    .gg-select::before {
      opacity: 1;
    }
  }
}
</style>

<template>
  <!-- Hero Content -->
  <BaseBackground
    image="/assets/media/various/promo-code.png"
    inner-class="bg-primary-dark-op"
  >
    <div class="content content-full text-center py-7 pb-5">
      <h1 class="h2 text-white mb-2">La liste d'utilisateur</h1>
    </div>
  </BaseBackground>
  <!-- END Hero Content -->

  <!-- Page Content -->
  <div class="content">
    <BaseBlock title=" La liste des utilisateurs" content-full>
      <Dataset
        v-slot="{ ds }"
        :ds-data="users"
        :ds-sortby="sortBy"
        :ds-search-in="['nom', 'prenom', 'email', 'mot_de_passe']"
      >
        <div class="row" :data-page-count="ds.dsPagecount">
          <div id="datasetLength" class="col-md-8 py-2">
            <DatasetShow />
          </div>
          <div class="col-md-4 py-2">
            <DatasetSearch ds-search-placeholder="Search..." />
          </div>
        </div>
        <hr />
        <div class="row">
          <div class="col-md-12">
            <div class="table-responsive">
              <table class="table table-striped mb-0">
                <thead>
                  <tr>
                    <th
                      v-for="(th, index) in cols"
                      :key="th.field"
                      :class="['sort', th.sort]"
                      @click="onSort($event, index)"
                    >
                      {{ th.name }} <i class="gg-select float-end"></i>
                    </th>
                  </tr>
                </thead>
                <DatasetItem tag="tbody" class="fs-sm">
                  <template #default="{ row, rowIndex }">
                    <tr>
                      <th scope="row">{{ row.id }}</th>
                      <td style="min-width: 150px">{{ row.nom }}</td>
                      <td>{{ row.prenom }}</td>
                      <td style="min-width: 150px">{{ row.email }}</td>
                      <td style="min-width: 150px">{{ row.mot_de_passe }}</td>
                    </tr>
                  </template>
                </DatasetItem>
              </table>
            </div>
          </div>
        </div>
        <div
          class="d-flex flex-md-row flex-column justify-content-between align-items-center"
        >
          <DatasetInfo class="py-3 fs-sm" />
          <DatasetPager class="flex-wrap py-3 fs-sm" />
        </div>
      </Dataset>
    </BaseBlock>
  </div>
  <!-- END Page Content -->
</template>

<!-- 
<template>
  <div>
    <h2>Liste des Utilisateurs</h2>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Nom</th>
          <th>Prénom</th>
          <th>Email</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="user in users" :key="user.id">
          <td>{{ user.id }}</td>
          <td>{{ user.nom }}</td>
          <td>{{ user.prenom }}</td>
          <td>{{ user.email }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      users: [],
    };
  },
  mounted() {
    this.fetchUsers();
  },
  methods: {
    async fetchUsers() {
      try {
        const response = await axios.get("http://localhost:3000/users");
        this.users = response.data;
      } catch (error) {
        console.error("Erreur lors de la récupération des utilisateurs:", error);
      }
    },
  },
};
</script> -->
