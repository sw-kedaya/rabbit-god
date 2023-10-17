import instance from "@/utils/http"

export function adminGetAllWpShopListApi(){
    return instance({
        method: "get",
        url: "/wpShop/list"
    })
}

export function adminSaveWpShopApi(data){
    return instance({
        method: "post",
        url: "/wpShop/save",
        data
    })
}

export function adminUpdateWpShopApi(data){
    return instance({
        method: "put",
        url: "/wpShop/update",
        data
    })
}

export function adminDeleteWpShopByIdApi(id){
    return instance({
        method: "delete",
        url: "/wpShop/delete",
        params: {id}
    })
}