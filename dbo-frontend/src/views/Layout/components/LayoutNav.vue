<!--<script setup>-->
<!--import {ref, computed, onMounted} from "vue";-->
<!--import {useRouter} from "vue-router";-->
<!--import {ElMessage} from "element-plus";-->

<!--const router = useRouter()-->
<!--const user = ref()-->

<!--// 判断当前路由是否为 /me-->
<!--const isMePage = computed(() => {-->
<!--  return router.currentRoute.value.path === "/me";-->
<!--});-->

<!--// 判断当前路由是否为 /order-->
<!--const isOrderPage = computed(() => {-->
<!--  return router.currentRoute.value.path === "/order";-->
<!--});-->

<!--onMounted(() => {-->
<!--  user.value = JSON.parse(localStorage.getItem("user-token"))-->
<!--})-->

<!--function logoutClick() {-->
<!--  localStorage.removeItem("user-token")-->
<!--  user.value = null;-->
<!--  router.replace('/home')-->
<!--  ElMessage({-->
<!--    message: '退出成功',-->
<!--    type: 'success'-->
<!--  });-->
<!--}-->
<!--</script>-->

<!--<template>-->
<!--  <nav class="app-topnav">-->
<!--    <div class="container">-->
<!--      <ul>-->
<!--        <template v-if="user != null">-->
<!--          <li><a href="javascript:;"><i class="iconfont icon-user"></i>欢迎回来：{{ user.username }}</a></li>-->
<!--          <li :class="{ 'active': isOrderPage }">-->
<!--            <RouterLink :to="`/order`">我的订单</RouterLink>-->
<!--          </li>-->
<!--          <li :class="{ 'active': isMePage }">-->
<!--            <RouterLink :to="`/me`">个人中心</RouterLink>-->
<!--          </li>-->
<!--          <li>-->
<!--            <el-popconfirm title="确认退出吗?" confirm-button-text="确认" cancel-button-text="取消"-->
<!--                           @confirm="logoutClick">-->
<!--              <template #reference>-->
<!--                <a href="javascript:;">退出登录</a>-->
<!--              </template>-->
<!--            </el-popconfirm>-->
<!--          </li>-->
<!--        </template>-->
<!--        <template v-else>-->
<!--          <li>-->
<!--            <RouterLink :to="`/login`">登录/注册</RouterLink>-->
<!--          </li>-->
<!--        </template>-->
<!--      </ul>-->
<!--    </div>-->
<!--  </nav>-->
<!--</template>-->


<!--<style scoped lang="scss">-->
<!--.app-topnav {-->
<!--  background: #ffffff;-->

<!--  ul {-->
<!--    display: flex;-->
<!--    height: 53px;-->
<!--    justify-content: flex-end;-->
<!--    align-items: center;-->

<!--    li {-->
<!--      a {-->
<!--        padding: 0 15px;-->
<!--        color: #000000;-->
<!--        line-height: 1;-->
<!--        display: inline-block;-->

<!--        i {-->
<!--          font-size: 14px;-->
<!--          margin-right: 2px;-->
<!--        }-->

<!--        &:hover {-->
<!--          color: $xtxColor;-->
<!--        }-->
<!--      }-->

<!--      &.active {-->
<!--        a {-->
<!--          color: $xtxColor;-->
<!--        }-->
<!--      }-->

<!--      ~ li {-->
<!--        a {-->
<!--          border-left: 2px solid #000000;-->
<!--        }-->
<!--      }-->
<!--    }-->
<!--  }-->
<!--}-->
<!--</style>-->