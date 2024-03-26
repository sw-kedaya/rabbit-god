import instance from "@/utils/http";

export function adminSaveAuction(data){
    return instance({
        method: "post",
        url: "/auctions/admin/save",
        data
    })
}

export function adminGetAuctionList(){
    return instance({
        method: "get",
        url: "/auctions/admin/list"
    })
}

export function adminUpdateAuction(data){
    return instance({
        method: "put",
        url: "/auctions/admin/update",
        data
    })
}

export function adminDeleteAuction(id){
    return instance({
        method: "delete",
        url: "/auctions/admin/delete",
        params: {id}
    })
}