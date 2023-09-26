<script setup>
import {useRouter} from "vue-router";
import {checkApi} from "@/apis/account";
import {ElMessage} from "element-plus";
import {onMounted, ref} from "vue";

// 进入前先判断登录
const router = useRouter()
const checkQuest = async () => {
  if (user.value != null) {
    const res = await checkApi(user.value.token)
    if (!res.data) {
      {
        router.push('/login')
        ElMessage({
          message: '令牌过期，请重新登录',
          type: 'warning'
        });
        localStorage.removeItem("user-token")
      }
    }
  }else {
    router.push('/login')
    ElMessage({
      message: '请先登录',
      type: 'warning'
    });
  }
}
const user = ref()
onMounted(() => {
  // 进入前先判断登录没
  user.value = JSON.parse(localStorage.getItem("user-token"))
  checkQuest()
})
</script>

<template>

</template>

<style scoped lang="scss">

</style>