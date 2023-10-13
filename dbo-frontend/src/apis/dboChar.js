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

export function setSignApi(charName, accountID) {
    return instance({
        method: "get",
        url: "/char/sign",
        params: {charName, accountID}
    })
}

export function checkIsSignApi(accountID) {
    return instance({
        method: "get",
        url: "/char/sign/check",
        params: {accountID}
    })
}

export function getSignMessageApi(roleName) {
    return instance({
        method: "get",
        url: "/char/sign/message",
        params: {roleName}
    })
}