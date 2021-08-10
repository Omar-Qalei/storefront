import httpClient from '../configurations/axios.config';
import { ApiConfiguration } from '../configurations/api.config';

export class CompaniesService {
    static async getCompanies() {
        const url = `user/${ApiConfiguration.company.url}`;
        return await httpClient.get(url);
    }
    static async addCompany(data) {
        const url = `user/${ApiConfiguration.company.url}`;
        return await httpClient.post(url, data);
    }
    static async modifyCompany(companyId, data) {
        const url = `user/${ApiConfiguration.company.url}/${companyId}`;
        return await httpClient.post(url, data);
    }
    static async removeCompany(data) {
        const url = `user/${ApiConfiguration.company.url}`;
        return await httpClient.request({ url: url, method: 'DELETE', data: data });
    }
}