

import axios from 'axios';
 
const API_URL = 'http://localhost:3000/api/auth/';



class  AuthService {

    async login(username, password) {
        return await axios
            .post(API_URL + 'login', {
                email: username,
                password: password
            })
    }
    
    logout() {
        localStorage.removeItem('user');
    }
}

export default new AuthService();