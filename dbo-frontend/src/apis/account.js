import instance from '@/utils/http'

export function registerApi(data) {
    return instance({
        method: "post",
        url: "/user/register",
        data
    })
}

export function loginApi(data) {
    return instance({
        method: "post",
        url: "/user/login",
        data
    })
}

export function checkApi(token) {
    return instance({
        method: "get",
        url: "/user/check",
        params:{
            token
        }
    })
}

export function forgetApi(username) {
    return instance({
        method: "get",
        url: "/user/forget",
        params:{
            username
        }
    })
}

export function updateApi(data) {
    return instance({
        method: "post",
        url: "/user/update",
        data
    })
}