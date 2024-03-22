import instance from "@/utils/http"

export function adminGetAllWpShopListApi(){
    return instance({
        method: "get",
        url: "/wpShop/admin/list"
    })
}

export function adminSaveWpShopApi(data){
    return instance({
        method: "post",
        url: "/wpShop/admin/save",
        data
    })
}

export function adminUpdateWpShopApi(data){
    return instance({
        method: "put",
        url: "/wpShop/admin/update",
        data
    })
}

export function adminDeleteWpShopByIdApi(id){
    return instance({
        method: "delete",
        url: "/wpShop/admin/delete",
        params: {id}
    })
}