import httpClient from '../configurations/axios.config';
import { ApiConfiguration } from '../configurations/api.config';

export default class AccountService {
    static async getAccountDetails() {
        const url = `${ApiConfiguration.account.url}`;
        return await httpClient.get(url);
    }
    static async modifyAccountDetails(data) {
        const url = `${ApiConfiguration.account.url}/update`;
        return await httpClient.post(url, data);
    }
}