import instance from '@/utils/http'

export function getDBOCharListApi(accountID) {
    return instance({
        method: "get",
        url: "/char/list",
        params: {
            accountID
        }
    })
}

export function setSignApi(charName) {
    return instance({
        method: "get",
        url: "/char/sign",
        params: {charName}
    })
}