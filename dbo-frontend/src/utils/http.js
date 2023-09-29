import axios from "axios"
import {ElMessage} from "element-plus";
import {useRouter} from "vue-router";

const router = useRouter()

const instance = axios.create({
    // baseURL: 'http://localhost:8080',
    baseURL: '/api',
    timeout: 5000
})

instance.interceptors.request.use(config => {
    config.headers['Rg-Msg'] = 'Online';
    config.headers['authorization'] = localStorage.getItem('user-token')
    return config
}, e => Promise.reject(e))

instance.interceptors.response.use(res => {
    return res.data;
}, e => {
    if (e.response.data=== 'Unauthorized' && e.response.status === 401){
        ElMessage.warning("请先登录")
        localStorage.removeItem("user-token")
        localStorage.removeItem("admin-token")
        router.push('/login')
    }
    return Promise.reject(e)
})

export default instance