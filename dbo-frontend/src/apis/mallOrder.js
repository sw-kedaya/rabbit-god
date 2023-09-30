import instance from "@/utils/http"

export function getMallOrderByUserId(id) {
    return instance({
        method: "get",
        url: "/mallOrder/list",
        params: {id}
    })
}