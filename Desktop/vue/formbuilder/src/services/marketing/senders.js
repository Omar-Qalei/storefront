import httpClient from '../configurations/axios.config';
import { ApiConfiguration } from '../configurations/api.config';

export class SendersService {
    static async getSenders() {
        const url = `user/${ApiConfiguration.marketing.senders}`;
        return await httpClient.get(url);
    }
    static async addSender(data) {
        const url = `user/${ApiConfiguration.marketing.storeSenders}`;
        return await httpClient.post(url, data);
    }
}