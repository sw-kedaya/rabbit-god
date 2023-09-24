import axios from "axios"

const instance = axios.create({
    // baseURL: 'http://localhost:8080',
    baseURL: '/api',
    timeout: 5000
})

instance.interceptors.request.use(config => {
    config.headers['Rg-Msg'] = 'Online';

    return config
}, e => Promise.reject(e))

instance.interceptors.response.use(res => res.data,e => {
    return Promise.reject(e)
})

export default instance