import httpClient from '../../services/configurations/axios.config';

export const setCheckUser = (state, payload) => {
    const data = payload.data.data;
    const token = `${data.token_type} ${data.access_token}`;
    httpClient.interceptors.request.use(req => {
        req.headers.authorization = token
        return req;
    });
    localStorage.setItem('user', JSON.stringify(data));
    state.user = data;
}

export const setAutoLogin = (state) => {
    if (localStorage.getItem('user')) {
        const data = JSON.parse(localStorage.getItem('user'));
        //     const token = `${data.token_type} ${data.access_token}`;
        //     httpClient.interceptors.request.use(req => {
        //         req.headers.authorization = token
        //         return req;
        //     });
        state.user = data;
    }
}
// export const updateUser