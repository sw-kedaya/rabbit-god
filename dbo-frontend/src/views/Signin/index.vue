<script setup>
import {useRouter} from "vue-router";
import {checkApi} from "@/apis/account";
import {ElMessage} from "element-plus";
import {onMounted, ref} from "vue";

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
        localStorage.removeItem("admin-token")
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
  <div class="sign-in-container">
    <div >
      <el-button class="myButton" type="success" round size="large">
        立即签到
      </el-button>
    </div>
  </div>
</template>

<style>
.sign-in-container {
  display: flex;
  justify-content: center;
  height: 738px;
  background-image: url("@/assets/images/bg.png"); /* 设置背景图片的 URL */
  background-repeat: repeat; /* 将背景图片设置为平铺 */
  .myButton{
    margin-top: 100px;
    font-size: 24px; /* 增加按钮文本的字体大小 */
    padding: 34px 101px; /* 增加按钮的内边距 */
    background-color: #67C23A; /* 设置按钮的背景颜色为红色 */
    color: #ffffff; /* 设置按钮的文本颜色为白色 */
    border-radius: 50px; /* 增加按钮的边框半径 */
  }
}
h2 {
  font-size: 24px;
  margin-bottom: 10px;
}
p {
  font-size: 16px;
  margin-bottom: 20px;
}
</style>