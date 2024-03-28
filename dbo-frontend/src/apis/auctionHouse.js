import instance from "@/utils/http";

export function getListForUser(){
    return instance({
        method: "get",
        url: "/auctions/user/list"
    })
}

export function userAttendAuction(auctionId, price, charName){
    return instance({
        method: "get",
        url: "/auctions/user/attend",
        params: {auctionId, price, charName}
    })
}

export function userGetAuctionOrder(){
    return instance({
        method: "get",
        url: "/auctions/user/order"
    })
}