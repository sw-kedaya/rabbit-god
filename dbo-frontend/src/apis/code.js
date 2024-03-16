import instance from '@/utils/http'

export function sendCode(email) {
    return instance({
        method: "get",
        url: "/code/send",
        params:{
            email
        }
    })
}

export function checkOpen(){
    return instance({
        method: "get",
        url: "/code/check"
    })
}

export function getCodeImgApi(){
    return instance({
        method: "get",
        url: "/code/captchaImage"
    })
}