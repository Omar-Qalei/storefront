import axios from 'axios';

const httpClient = axios.create({
    baseURL: 'https://wimmly.com/api/v1/',
    headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
    },
});

export default httpClient;