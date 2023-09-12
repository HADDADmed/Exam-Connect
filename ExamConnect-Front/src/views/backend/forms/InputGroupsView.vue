<template>
  <!-- Hero Content -->
  <BaseBackground
    image="/assets/media/various/promo-code.png"
    inner-class="bg-primary-dark-op"
  >
    <div class="content content-full text-center py-7 pb-5">
      <h1 class="h2 text-white mb-2">Page de connexion</h1>
    </div>
  </BaseBackground>
  <!-- END Hero Content -->
  <div class="content">
    <BaseBlock title="Connexion">
      <div class="row">
        <div class="col-lg-4 me-5">
          <p class="fs-sm text-muted">Connectez-vous à votre compte</p>
        </div>
        <div class="col-lg-8 space-y-5">
          <form @submit.prevent="loginUser">
            <div class="mb-4">
              <label class="form-label" for="login-email">Email</label>
              <input
                type="email"
                class="form-control"
                id="login-email"
                name="login-email"
                placeholder="Votre Email.."
                v-model="email"
              />
            </div>
            <div class="mb-4">
              <label class="form-label" for="login-password"
                >Mot de passe</label
              >
              <input
                type="password"
                class="form-control"
                id="login-password"
                name="login-password"
                placeholder="Votre Mot de passe.."
                v-model="mot_de_passe"
              />
            </div>
            <div class="mb-4">
              <button type="submit" class="btn btn-success">
                Se connecter
              </button>
            </div>
            <div class="mb-4">
              <a href="http://localhost:5173/#/backend/forms/layouts">
                S'authentifier
              </a>
            </div>
          </form>
        </div>
      </div>
    </BaseBlock>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      email: "",
      mot_de_passe: "",
    };
  },
  methods: {
    async loginUser() {
      try {
        console.log("Email envoyé au serveur:", this.email);
        console.log("Mot de passe envoyé au serveur:", this.mot_de_passe);

        const response = await axios.post("http://localhost:3000/login", {
          email: this.email,
          mot_de_passe: this.mot_de_passe,
        });

        console.log("Réponse du serveur:", response.data);

        if (response.data.message === "Connexion réussie") {
          // this.$router.push("/");
          console.log("Connexion réussie");
        } else {
          console.error("L'authentification a échoué.");
        }
      } catch (error) {
        console.error("Erreur lors de la connexion:", error);
      }
    },
  },
};
</script>
