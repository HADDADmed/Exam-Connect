<script>
import axios from "axios";

export default {
  data() {
    return {
      nom: "",
      prenom: "",
      email: "",
      mot_de_passe: "",
      level: "3",
    };
  },
  methods: {
    async registerUser() {
      try {
        const response = await axios.post("http://localhost:3000/register", {
          nom: this.nom,
          prenom: this.prenom,
          email: this.email,
          mot_de_passe: this.mot_de_passe,
          level: this.level,
        });

        console.log("Utilisateur enregistré avec succès", response.data);
      } catch (error) {
        console.error(
          "Erreur lors de l'enregistrement de l'utilisateur:",
          error
        );
      }
    },
  },
};
</script>

<template>
  <!-- Hero Content -->
  <BaseBackground
    image="/assets/media/various/promo-code.png"
    inner-class="bg-primary-dark-op"
  >
    <div class="content content-full text-center py-7 pb-5">
      <h1 class="h2 text-white mb-2">Page d'Authentification</h1>
    </div>
  </BaseBackground>
  <!-- END Hero Content -->
  <!-- Page Content -->
  <div class="content">
    <!-- Labels on top -->
    <BaseBlock title="Authentifier">
      <div class="row">
        <div class="col-lg-4 me-5">
          <p class="fs-sm text-muted">
            ajouter les champs suivants pour authentifier
          </p>
        </div>
        <div class="col-lg-8 space-y-5">
          <!-- Form Labels on top - Default Style -->
          <form @submit.prevent="registerUser">
            <div class="mb-4">
              <label class="form-label" for="example-ltf-email">NOM</label>
              <input
                type="text"
                class="form-control"
                id="example-ltf-email"
                name="example-ltf-email"
                placeholder="Your Nom.."
                v-model="nom"
              />
            </div>
            <div class="mb-4">
              <label class="form-label" for="example-ltf-email">PRENOM</label>
              <input
                type="text"
                class="form-control"
                id="example-ltf-email"
                name="example-ltf-email"
                placeholder="Your Prénom.."
                v-model="prenom"
              />
            </div>
            <div class="mb-4">
              <label class="form-label" for="example-ltf-email">Email</label>
              <input
                type="email"
                class="form-control"
                id="example-ltf-email"
                name="example-ltf-email"
                placeholder="Your Email.."
                v-model="email"
              />
            </div>
            <div class="mb-4">
              <label class="form-label" for="example-ltf-password"
                >Password</label
              >
              <input
                type="password"
                class="form-control"
                id="example-ltf-password"
                name="example-ltf-password"
                placeholder="Your Password.."
                v-model="mot_de_passe"
              />
            </div>
            <div class="mb-4">
              <button type="submit" class="btn btn-success">Register</button>
            </div>
          </form>
          <!-- END Form Labels on top - Default Style -->
        </div>
      </div>
    </BaseBlock>
    <!-- END Labels on top -->
  </div>
  <!-- END Page Content -->
</template>
