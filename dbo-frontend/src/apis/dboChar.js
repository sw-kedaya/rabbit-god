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

export function checkActivity(accountID) {
    return instance({
        method: "get",
        url: "/char/sign/activity",
        params: {accountID}
    })
}

export function replacementSignApi(accountID, roleName, day, itemId, count) {
    return instance({
        method: "get",
        url: "/char/sign/replacement",
        params: {accountID, roleName, day, itemId, count}
    })
}