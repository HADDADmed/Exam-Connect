import axios from "axios";
 
const API_URL = "http://localhost:3000/api/users/";




class UserService {

    getAllUsers() {
        return axios.get(API_URL );
    }
    getUserById(id) {
        return axios.get(API_URL + id);
    }
    deleteUserById(id) {
        return axios.delete(API_URL + id);
    }
    createUser(user) {
        console.log(user);
        return axios.post(API_URL, user);
    }

}


export default new UserService();