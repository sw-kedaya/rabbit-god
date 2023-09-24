import instance from '@/utils/http'

export function getActivityList() {
    return instance({
        method: "get",
        url: "/activity/list"
    })
}