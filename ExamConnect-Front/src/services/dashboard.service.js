// create a file that contain all dashboard functions


import axios from "axios";

const API_URL = "http://localhost:3000/api/dashboard/";



class DashboardService {

    // fetching statistics

    getExamsStatistics() {
        const accessToken = localStorage.getItem("accessToken");
        if(!accessToken)
            return Promise.reject("No access token set.");
        axios.defaults.headers.common['Authorization'] = 'JWT ' + accessToken;
        return axios.get(API_URL + "exams");
    }

    getQuestionsStatistics() {
        const accessToken = localStorage.getItem("accessToken");
        if(!accessToken)
            return Promise.reject("No access token set.");
        axios.defaults.headers.common['Authorization'] = 'JWT ' + accessToken;
        return axios.get(API_URL + "questions");
    }

    getUsersStatistics() {
            const accessToken = localStorage.getItem("accessToken");
            if(!accessToken)
               return Promise.reject("No access token set.");
            axios.defaults.headers.common['Authorization'] = 'JWT ' + accessToken;
            return axios.get(API_URL + "users");
      }

}

export default new DashboardService();


