import instance from '@/utils/http'

export function getCategoryHead() {
    return instance({
        method: "get",
        url: "/category/head"
    })
}