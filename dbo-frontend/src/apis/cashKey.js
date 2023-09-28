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

export function getAdminOrderApi(userId) {
    return instance({
        method: "get",
        url: "/cash/admin/order",
        params: {userId}
    })
}

export function adminAddCashKeyApi(cash, num, userId) {
    return instance({
        method: "get",
        url: "/cash/admin/save",
        params: {cash, num, userId}
    })
}

export function deleteAllKeyApi() {
    return instance({
        method:"delete",
        url: "cash/admin/delete"
    })
}