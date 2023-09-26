import instance from '@/utils/http'

export function getEventList() {
    return instance({
        method: "get",
        url: "/event/list"
    })
}