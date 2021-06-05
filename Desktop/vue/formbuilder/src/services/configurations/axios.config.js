import axios from 'axios';

const httpClient = axios.create({
    baseURL: '',
    headers: {
        "Content-Type": "application/json"
    },
});

httpClient.interceptors.request.use(req => {
    req.headers.authorization = "Bearer" + "token"
    return req;
});

export default httpClient;

