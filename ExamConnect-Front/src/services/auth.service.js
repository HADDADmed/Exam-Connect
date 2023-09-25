

import axios from 'axios';
import GlobalService from './global.service';
const API_URL = GlobalService.getApiUrl() + 'auth/';


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