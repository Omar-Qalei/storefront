import httpClient from '../configurations/axios.config';
import { ApiConfiguration } from '../configurations/api.config';

export class SiteService {
    static async getSites() {
        const url = `user/${ApiConfiguration.sites.url}`;
        return await httpClient.get(url);
    }
    static async getSitePages(siteId) {
        const url = `user/${ApiConfiguration.sites.url}/${siteId}/${ApiConfiguration.page.url}`;
        return await httpClient.get(url);
    }
    static async getSitePageResources(siteId, pageId) {
        const url = `user/${ApiConfiguration.sites.url}/${siteId}/${ApiConfiguration.page.url}/${pageId}/${ApiConfiguration.resources.url}`;
        return await httpClient.get(url);
    }
    static async getSiteById(siteId) {
        const url = `user/${ApiConfiguration.sites.url}/${siteId}`;
        return await httpClient.get(url);
    }
    static async addSite(data) {
        const url = `user/${ApiConfiguration.sites.store}`;
        return await httpClient.post(url, data);
    }
    static async addPage(siteId, data) {
        const url = `user/${ApiConfiguration.sites.url}/${siteId}/${ApiConfiguration.page.store}`;
        return await httpClient.post(url, data);
    }
    static async addSitePageResourceWeb(siteId, pageId, data) {
        const url = `user/${ApiConfiguration.sites.url}/${siteId}/${ApiConfiguration.page.url}/${pageId}/${ApiConfiguration.resources.store}/web`;
        return await httpClient.post(url, data);
    }
    static async addSitePageResourceMobile(siteId, pageId, data) {
        const url = `user/${ApiConfiguration.sites.url}/${siteId}/${ApiConfiguration.page.url}/${pageId}/${ApiConfiguration.resources.store}/mobile`;
        return await httpClient.post(url, data);
    }
    static async removeSite(siteId) {
        const url = `user/${ApiConfiguration.sites.url}/${siteId}`;
        return await httpClient.delete(url);
    }
}