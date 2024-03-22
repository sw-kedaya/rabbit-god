import instance from '@/utils/http'

export function getEventList() {
    return instance({
        method: "get",
        url: "/event/list"
    })
}

export function adminEventSaveApi(data){
    return instance({
        method: "post",
        url: "/event/admin/save",
        data
    })
}

export function adminEventUpdateApi(data){
    return instance({
        method: "put",
        url: "/event/admin/update",
        data
    })
}

export function adminEventDeleteApi(id){
    return instance({
        method: "delete",
        url: "/event/admin/delete",
        params:{id}
    })
}