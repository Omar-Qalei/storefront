import httpClient from '../configurations/axios.config';

// export const login = async (data) => await httpClient.post(data);

export class LoginService {
    static async login(data) {
        const url = 'auth/login';
        return await httpClient.post(url, data);
    }
}