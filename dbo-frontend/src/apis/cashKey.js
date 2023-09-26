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