import instance from '@/utils/http'

export function registerApi(data) {
    return instance({
        method: "post",
        url: "/user/open/register",
        data
    })
}

export function loginApi(data) {
    return instance({
        method: "post",
        url: "/user/open/login",
        data
    })
}

export function logoutApi(token) {
    return instance({
        method: "get",
        url: "/user/open/logout",
        params: {token}
    })
}

export function checkApi(token) {
    return instance({
        method: "get",
        url: "/user/open/check",
        params: {
            token
        }
    })
}

export function forgetApi(username) {
    return instance({
        method: "get",
        url: "/user/open/forget",
        params: {
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

export function getLatestMallPointsApi(id) {
    return instance({
        method: "get",
        url: "/user/latest",
        params: {id}
    })
}

export function getCardCountApi(id) {
    return instance({
        method: "get",
        url: "/user/cardCount",
        params: {id}
    })
}