import instance from '@/utils/http'

export function adminGetListApi() {
    return instance({
        method: "get",
        url: "/user/admin/list"
    })
}

export function adminUpdateBalance(data) {
    return instance({
        method: "put",
        url: "/user/admin/update/",
        data,
    })
}

export function blockedAccount(id) {
    return instance({
        method: "get",
        url: "/user/admin/block",
        params: {id}
    })
}

export function unblockedAccount(id) {
    return instance({
        method: "get",
        url: "/user/admin/unblock",
        params: {id}
    })
}
