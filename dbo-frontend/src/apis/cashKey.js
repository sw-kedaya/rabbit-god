import instance from '@/utils/http'

export function getUserOrderList(accountID) {
    return instance({
        method: "get",
        url: "/cash/order",
        params: {
            accountID
        }
    })
}

export function getUseCdKeyApi(data) {
    return instance({
        method: "post",
        url: "/cash/use",
        data
    })
}

export function getAdminOrderApi() {
    return instance({
        method: "get",
        url: "/cash/admin/order"
    })
}

export function adminAddCashKeyApi(cash, num) {
    return instance({
        method: "get",
        url: "/cash/admin/save",
        params: {cash, num}
    })
}

export function deleteAllKeyApi() {
    return instance({
        method:"delete",
        url: "cash/admin/delete"
    })
}