import httpClient from '../configurations/axios.config';
import { ApiConfiguration } from '../configurations/api.config';

export class MediaService {
    static async getImages() {
        const url = `user/${ApiConfiguration.media.images}`;
        return await httpClient.get(url);
    }
    static async addImages(data) {
        const url = `user/${ApiConfiguration.media.images}`;
        const formData = new FormData();
        for (let index = 0; index < data.length; index++) {
            formData.append('files[' + index + ']', data[index]);
        }
        return await httpClient.post(url, formData, {
            headers: {
                'Content-Type': 'multipart/form-data'
            },
        });
    }
}