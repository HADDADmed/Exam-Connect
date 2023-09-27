import { createApp } from "vue";
import { createPinia } from "pinia";
import App from "./App.vue";
import Toaster from '@meforma/vue-toaster';
import mitt from 'mitt'
 
// You can use the following starter router instead of the default one as a clean starting point
// import router from "./router/starter";
import router from "./router";
 
 // Template components
 import BaseBlock from "@/components/BaseBlock.vue";
 import BaseBackground from "@/components/BaseBackground.vue";
 import BasePageHeading from "@/components/BasePageHeading.vue";
 import GlobalService from "@/services/global.service";
 
 // Template directives
 import clickRipple from "@/directives/clickRipple";
 

 // Bootstrap framework
 import * as bootstrap from "bootstrap";
import axios from "axios";
 window.bootstrap = bootstrap;
 
 // Craft new application
 const app = createApp(App);
 

// Register global components
app.component("BaseBlock", BaseBlock);
app.component("BaseBackground", BaseBackground);
app.component("BasePageHeading", BasePageHeading);

// Register global directives
app.directive("click-ripple", clickRipple);

// Use Pinia and Vue Router
app.use(createPinia());
app.use(router);
app.use(Toaster);

app.config.globalProperties.globalService = GlobalService

const emitter = mitt()

app.config.globalProperties.emitter = emitter


import { useUserStore } from "./stores/user";
const userStore = useUserStore();
const accessToken = GlobalService.getCurrentAccessToken();
const user = userStore.user;
axios.defaults.headers.common['Authorization'] = 'JWT '+ accessToken;
const isAdmin = user.isAdmin;
// Set up Axios interceptor to handle 401 responses
axios.interceptors.response.use(
    (response) => {
      return response;
    },
    (error) => {
      if (error.response && error.response.status === 401) {
        if(!isAdmin) router.push({ name: 'user-error-401' }); // Redirect to the 401 error page
        else router.push({ name: 'user-error-401' }); // Redirect to the 401 error page
      }else if(error.response && error.response.status === 404){
        if(!isAdmin) router.push({ name: 'user-error-404' }); // Redirect to the 401 error page
        else router.push({ name: 'user-error-403' }); // Redirect to the 401 error page
     }
      return Promise.reject(error);
    }
  );


// ..and finally mount it!
app.mount("#app");
