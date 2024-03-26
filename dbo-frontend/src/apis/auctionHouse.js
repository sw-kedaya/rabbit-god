import instance from "@/utils/http";

export function getListForUser(){
    return instance({
        method: "get",
        url: "/auctions/user/list"
    })
}
