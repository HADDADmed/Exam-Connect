import { createToaster } from "@meforma/vue-toaster";
import Swal from "sweetalert2";
import router from "@/router"; // Import your Vue Router instance

class GlobalService {
     constructor() {
          this.toaster = createToaster({});
           this.BACK_END_PORT = 3000;
          this.BACK_END_IP = "localhost";
          this.BACK_END_URL = `http://${this.BACK_END_IP}:${this.BACK_END_PORT}/`;
          this.API_URL = `${this.BACK_END_URL}api/`;
          this.IMAGES_URL = `${this.BACK_END_URL}public/images/`;
     }

     getBackEndPort() {
          return this.BACK_END_PORT;
     }

     getBackEndIp() {
          return this.BACK_END_IP;
     }

     getBackEndUrl() {
          return this.BACK_END_URL;
     }

     getApiUrl() {
          return this.API_URL;
     }

     getImagesUrl() {
          return this.IMAGES_URL;
     }

     getCurrentTime() {
          return new Date().toLocaleTimeString();
     }

     getCurrentUser() {

          return JSON.parse(localStorage.getItem("user"));
     }

     getCurrentAccessToken() {
          return localStorage.getItem("accessToken");
     }
     // add 0 to the number if it is less than 10 especially for the date
     add0(number){
          if(number<10) return `0${number}`
          else return `${number}`
     }
     // formate Date
     getTime(date1) {
          const date = new Date(date1);
          const hours = date.getHours();
          const minutes = date.getMinutes();
          const seconds = date.getSeconds();
          return `${this.add0(hours)}:${this.add0(minutes)}:${this.add0(seconds)}`;
     }
     getTimeWithoutSeconds(date1) {
          const date = new Date(date1);
          const hours = date.getHours();
          const minutes = date.getMinutes();
          return `${this.add0(hours)}:${this.add0(minutes)}`;
     }

     getDate(date1) {
          const date = new Date(date1);
          const year = date.getFullYear();
          const month = date.getMonth();
          const day = date.getDate();
           return `${this.add0(day)}-${this.add0(month)}-${year}`;
     }


     getfullDateTime(date1) {
          const date = new Date(date1);
          const year = date.getFullYear();
          const month = date.getMonth();
          const day = date.getDate();
          const hours = date.getHours();
          const minutes = date.getMinutes();
          const seconds = date.getSeconds();
          return `${this.add0(day)}-${this.add0(month)}-${year} ${this.add0(hours)}:${this.add0(minutes)}:${this.add0(seconds)}`;
     }

     passwordMatch(password, confirmPassword) {
          if (password === confirmPassword) {
               return true;
          } else {
               return false;
          }
     }

     toasterShow(message, type, icon, duration = 5000, position = "top") {
          this.toaster.show(
               `<div><i class="${icon}"></i>&nbsp;&nbsp;&nbsp${message} </div>`,
               {
                    position: position,
                    duration: duration,
                    type: type,
               }
          );
     }

     toasterShowError(message, duration = 6000, position = "top") {
          this.toasterShow(
               message,
               "error",
               "fa-solid fa-triangle-exclamation",
               duration,
               position
          );
     }

     toasterShowSuccess(message, duration = 6000, position = "top") {
          this.toasterShow(
               message,
               "success",
               "fa-regular fa-circle-check",
               duration,
               position
          );
     }

     toasterShowWarning(message, duration = 6000, position = "top") {
          this.toasterShow(
               message,
               "warning",
               "fa-regular fa-circle-xmark",
               duration,
               position
          );
     }

     passwordValidation(password, confirmPassword) {
          if (!this.passwordMatch(password, confirmPassword)) {
               this.toasterShowWarning(`Passwords don't match  !`);
               return false;
          } else if (password.length < 8) {
               this.toasterShowWarning(
                    `Password must be at least 8 characters  !`
               );
               return false;
          } else if (password.search(/[a-z]/) < 0) {
               this.toasterShowWarning(
                    `Password must contain at least one lowercase letter  !`
               );
               return false;
          } else if (password.search(/[A-Z]/) < 0) {
               this.toasterShowWarning(
                    `Password must contain at least one uppercase letter  !`
               );
               return false;
          } else if (password.search(/[0-9]/) < 0) {
               this.toasterShowWarning(
                    `Password must contain at least one number  !`
               );
               return false;
          } else {
               return true;
          }
     }

     // cretae a function that push to the component that name is passed as parameter and also if the parameter contans params and query
     // push the params and query to the component
     routerPush(componentName, params = null, query = null) {
          if (params && query) {
               router.push({
                    name: componentName,
                    params: params,
                    query: query,
               });
          } else if (params) {
               router.push({ name: componentName, params: params });
          } else if (query) {
               router.push({ name: componentName, query: query });
          } else {
               router.push({ name: componentName });
          }
     }
     showConfirmMessage(
          message,
          title = "Are you sure",
          confirmButtonText = "Yes",
          showCancelButton = true,
          cancelButtonText = "No"
     ) {
          let swalConfig = {
               title: title,
               html: message,
               confirmButtonText: confirmButtonText, // Set confirmButtonText once
               confirmButtonColor: "#3085d6",
               backdrop: `
              rgba(0, 0, 123, 0.4)
            `,
          };

          if (showCancelButton) {
               swalConfig = {
                    ...swalConfig,
                    showCancelButton: true,
                    cancelButtonText: cancelButtonText, // Include cancelButtonText conditionally
                    cancelButtonColor: "#d33",
               };
          }

          return Swal.fire(swalConfig);
     }

     minutesToHours(miniutes) {
          if (Math.floor(miniutes / 60) === 0)
               return `${miniutes % 60} minutes`;
          else if (miniutes % 60 === 0)
               return `${Math.floor(miniutes / 60)} hours`;
          else
               return `${Math.floor(miniutes / 60)} hours and ${
                    miniutes % 60
               } minutes`;
     }

     secondsToHours(seconds) {
          return `${Math.floor(seconds / 3600)}:${Math.floor(seconds / 60)}:${
               seconds % 60
          }`;
     }
}

export default new GlobalService();
