// src/store/userAnswers.js
import { defineStore } from 'pinia';

export const useUserAnswersStore = defineStore('userAnswers', {
  state: () => ({
    userAnswers: [], // Initialize as an empty array
  }),

  actions: {
    addUserAnswer(answer) {
      this.userAnswers.push(answer); // Add a new user answer to the array
    },
  },
});