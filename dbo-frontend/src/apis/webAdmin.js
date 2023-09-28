import instance from '@/utils/http'

export function verifyWebAdminApi(data){
    return instance({
        method: "post",
        url: "/web/admin/verify",
        data
    })
}