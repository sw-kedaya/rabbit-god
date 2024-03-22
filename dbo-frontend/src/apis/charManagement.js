import instance from '@/utils/http'

export function adminGetCharacterList() {
    return instance({
        method: "get",
        url: "/char/admin/list"
    })
}

export function adminUpdateCharacter(data) {
    return instance({
        method: "put",
        url: "/char/admin/update",
        data
    })
}
