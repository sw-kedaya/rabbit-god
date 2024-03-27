import instance from "@/utils/http";

export function getListForUser(){
    return instance({
        method: "get",
        url: "/auctions/user/list"
    })
}

export function userAttendAuction(auctionId, price){
    return instance({
        method: "get",
        url: "/auctions/user/attend",
        params: {auctionId, price}
    })
}

export function userGetAuctionOrder(){
    return instance({
        method: "get",
        url: "/auctions/user/order"
    })
}