import instance from '@/utils/http'

export function getEventList() {
    return instance({
        method: "get",
        url: "/event/list"
    })
}

export function adminEventSaveApi(data, userId){
    return instance({
        method: "post",
        url: "/event/admin/save",
        data,
        params:{userId}
    })
}

export function adminEventUpdateApi(data, userId){
    return instance({
        method: "put",
        url: "/event/admin/update",
        data,
        params:{userId}
    })
}

export function adminEventDeleteApi(id, userId){
    return instance({
        method: "delete",
        url: "/event/admin/delete",
        params:{id, userId}
    })
}