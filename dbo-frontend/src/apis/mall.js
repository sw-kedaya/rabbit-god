import instance from '@/utils/http'

export function getMallList() {
    return instance({
        method: "get",
        url: "/mall/list"
    })
}

export function saveMallApi(data) {
    return instance({
        method: "post",
        url: "/mall/admin/save",
        data
    })
}

export function updateMallApi(data) {
    return instance({
        method: "put",
        url: "/mall/admin/update",
        data
    })
}

export function deleteMallByIdApi(id, userId) {
    return instance({
        method: "delete",
        url: "/mall/admin/delete",
        params: {id, userId}
    })
}

export function setSignRewardByIdApi(data, userId) {
    return instance({
        method: "put",
        url: "/mall/admin/set",
        data,
        params: {userId}
    })
}

export function cancelSignRewardByIdApi(id, userId) {
    return instance({
        method: "put",
        url: "/mall/admin/cancel",
        params: {id, userId}
    })
}

export function getAdminEnableMallList() {
    return instance({
        method: "get",
        url: "/mall/admin/list"
    })
}

export function getAdminAllMallList() {
    return instance({
        method: "get",
        url: "/mall/admin/all/list"
    })
}

export function buyOrGiveMallPresentApi(data) {
    return instance({
        method: "post",
        url: "/mall/buyOrGive",
        data
    })
}