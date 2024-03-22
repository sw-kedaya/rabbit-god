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

export function deleteMallByIdApi(id) {
    return instance({
        method: "delete",
        url: "/mall/admin/delete",
        params: {id}
    })
}

export function setSignRewardByIdApi(data) {
    return instance({
        method: "put",
        url: "/mall/admin/set",
        data
    })
}

export function cancelSignRewardByIdApi(id) {
    return instance({
        method: "put",
        url: "/mall/admin/cancel",
        params: {id}
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

export function getCurrentSignRewardMessageApi() {
    return instance({
        method: "get",
        url: "/mall/sign/message"
    })
}