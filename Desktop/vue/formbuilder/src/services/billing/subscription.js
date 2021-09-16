import httpClient from '../configurations/axios.config';
import { ApiConfiguration } from '../configurations/api.config';

export class SubscriptionService {
    static async createSubscription(customer) {
        const url = `user/${ApiConfiguration.subscriptions.url}`;
        return await httpClient.post(url,customer);
    }
    static async getSubscriptions() {
        const url = `user/${ApiConfiguration.subscriptions.url}`;
        return await httpClient.get(url);
    }
    static async modifySubscription(SubscriptionId, data) {
        const url = `user/${ApiConfiguration.subscriptions.url}/${SubscriptionId}`;
        return await httpClient.post(url, data);
    }
    static async getInvoices() {
        const url = `user/${ApiConfiguration.subscriptions.url}/${ApiConfiguration.invoices.url}`;
        return await httpClient.get(url);
    }
    static async getPaymentMethods() {
        const url = `user/${ApiConfiguration.subscriptions.url}/${ApiConfiguration.paymentMethods.url}`;
        return await httpClient.get(url);
    }
    static async deletePaymentMethod(data) {
        const url = `user/${ApiConfiguration.subscriptions.url}/${ApiConfiguration.paymentMethods.url}`;
        return await httpClient.request({ url: url, method: 'DELETE', data: data });
    }
    static async addPaymentMethod(data) {
        const url = `user/${ApiConfiguration.subscriptions.url}/${ApiConfiguration.paymentMethods.url}`;
        return await httpClient.post(url, data);
    }
    static async setDefaultPaymentMethod(data) {
        const url = `user/${ApiConfiguration.subscriptions.url}/${ApiConfiguration.paymentMethodsDefault.url}`;
        return await httpClient.post(url, data);
    }
}