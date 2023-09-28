import instance from '@/utils/http'

export function getMallTypeListApi() {
    return instance({
        method: "get",
        url: "/category/list"
    })
}

export function updateMallTypeByIdApi(data) {
    return instance({
        method: "post",
        url: "/category/admin/update",
        data
    })
}

export function deleteByIdApi(id, userId) {
    return instance({
        method: "delete",
        url: "/category/admin/delete",
        params: {id, userId}
    })
}

export function saveMallTypeApi(data) {
    return instance({
        method: "post",
        url: "/category/admin/save",
        data
    })
}