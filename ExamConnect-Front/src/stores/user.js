import { defineStore } from "pinia";

// Main Pinia Store
export const useUserStore = defineStore({
  id: "user",
  state: () => ({
    
    user : {},
    accessToken: null,
    }),
    
    getters: {
        getUser() {
            return this.user;
        },
        getAccessToken() {
            return this.accessToken;
        }
    },

    actions: {
        setUser(user) {
            this.user = user;
        },
        setAccessToken(accessToken) {
            this.accessToken = accessToken;
        }
    }
});

