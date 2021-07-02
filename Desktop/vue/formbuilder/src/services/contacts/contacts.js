import httpClient from '../configurations/axios.config';
import { ApiConfiguration } from '../configurations/api.config';

export class ContactService {
    static async getContacts() {
        const url = `user/${ApiConfiguration.contacts.url}`;
        return await httpClient.get(url);
    }
    static async addContact(data) {
        const url = `user/${ApiConfiguration.contacts.url}`;
        return await httpClient.post(url, data);
    }
    static async modifyContact(contactId, data) {
        const url = `user/${ApiConfiguration.contacts.url}/${contactId}`;
        return await httpClient.post(url, data);
    }
    static async removeContact(contactId) {
        const url = `user/${ApiConfiguration.contacts.url}/${contactId}`;
        return await httpClient.delete(url);
    }
}