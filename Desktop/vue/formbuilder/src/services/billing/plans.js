import httpClient from '../configurations/axios.config';
import { ApiConfiguration } from '../configurations/api.config';

export class PlanService {
static async getPlans() {
    const url = `user/${ApiConfiguration.plans.url}`;
    return await httpClient.get(url);
}
}