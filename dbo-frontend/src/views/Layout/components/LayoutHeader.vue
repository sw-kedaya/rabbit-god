<script setup>
import {ref, computed, onMounted} from "vue";
import {watch} from "vue";
import {useRouter} from "vue-router";
import {ElMessage} from "element-plus";

const router = useRouter()
const user = ref()

// 判断当前路由是否为login或者register
const isLoginOrRegister = computed(() => {
  if (router.currentRoute.value.path === "/login") {
    return 'login';
  } else if (router.currentRoute.value.path === "/register") {
    return 'register'
  }
});

// 判断当前路由是否为 /me
const isMePage = computed(() => {
  return router.currentRoute.value.path === "/me";
});

// 判断当前路由是否为 /orderXXX
const isOrderPage = computed(() => {
  return router.currentRoute.value.path === "/orderKey" ||
      router.currentRoute.value.path === "/orderMall";
});

// 判断当前路由是否为 /orderXXX
const isAdminPage = computed(() => {
  return router.currentRoute.value.path === "/admin"
});

onMounted(() => {
  user.value = JSON.parse(localStorage.getItem("user-token"))
})

function logoutClick() {
  localStorage.removeItem("user-token")
  user.value = null;
  router.replace('/home')
  ElMessage({
    message: '退出成功',
    type: 'success'
  });
}

const showDropdown = ref(false);
const dropdownRef = ref(null)

watch(showDropdown, (newValue) => {
  if (newValue) {
    // 显示下拉菜单
    dropdownRef.value.style.display = 'block'
  } else {
    // 隐藏下拉菜单
    dropdownRef.value.style.display = 'none'
  }
})
</script>

<template>
  <header class="app-header">
    <div class="container">
      <h1 class="logo">
        <RouterLink to="/home">七龙珠Online</RouterLink>
      </h1>
      <ul class="app-header-nav">
        <li>
          <RouterLink active-class="active" :to="`/home`">首页</RouterLink>
        </li>
        <li>
          <RouterLink active-class="active" :to="`/activity`">活动列表</RouterLink>
        </li>
        <li>
          <RouterLink active-class="active" :to="`/skill`">加点模拟器</RouterLink>
        </li>
        <li>
          <RouterLink active-class="active" :to="`/signin`">每日签到</RouterLink>
        </li>
        <li>
          <RouterLink active-class="active" :to="`/mall`">胶囊商城</RouterLink>
        </li>
      </ul>
      <ul class="app-nav-nav">
        <template v-if="user != null">
          <template v-if="user.admin === 10">
            <li :class="{ 'active': isAdminPage }" class="enlarge-hover">
              <RouterLink active-class="active" :to="`/admin`">管理界面</RouterLink>
            </li>
          </template>
          <template v-else>
            <li class="enlarge-hover" @mouseenter="showDropdown = true" @mouseleave="showDropdown = false">
              <a href="javascript:;" :class="{ 'active': isOrderPage }">我的订单</a>
              <ul ref="dropdownRef" class="dropdown" v-show="showDropdown">
                <li><RouterLink active-class="active" :to="`/orderKey`">卡密订单</RouterLink></li>
                <li><RouterLink active-class="active" :to="`/orderMall`">商城订单</RouterLink></li>
              </ul>
            </li>
          </template>
          <li :class="{ 'active': isMePage }" class="enlarge-hover">
            <RouterLink active-class="active" :to="`/me`">个人中心</RouterLink>
          </li>
          <li class="enlarge-hover">
            <el-popconfirm title="确认退出吗?" confirm-button-text="确认" cancel-button-text="取消"
                           @confirm="logoutClick">
              <template #reference>
                <a href="javascript:;">退出登录</a>
              </template>
            </el-popconfirm>
          </li>
        </template>
        <template v-else>
          <template v-if="isLoginOrRegister === 'login'">
            <li class="enlarge-hover">
              <RouterLink active-class="active" :to="`/login`">登录/注册</RouterLink>
            </li>
          </template>
          <template v-else-if="isLoginOrRegister === 'register'">
            <li class="enlarge-hover">
              <RouterLink active-class="active" :to="`/register`">登录/注册</RouterLink>
            </li>
          </template>
          <template v-else>
            <li class="enlarge-hover">
              <RouterLink active-class="active" :to="`/login`">登录/注册</RouterLink>
            </li>
          </template>
        </template>
      </ul>
    </div>
  </header>
</template>


<style scoped lang='scss'>
.dropdown {
  position: absolute;
  top: 100%;
  left: 490px;
  z-index: 999;
  padding: 8px;
  background-color: #fff;
  border: 1px solid #ccc;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.15);
  width: 100px; /* 设置下拉菜单的宽度 */
  height: 90px; /* 设置下拉菜单的高度 */
  li {
    margin-bottom: 8px;

    &:last-child {
      margin-bottom: 0;
    }

    a {
      display: block;
      height: 32px;
      line-height: 30px;
      font-size: 14px;
      color: #666;

      &:hover {
        color: $xtxColor;
      }
    }
  }
}

.app-header {
  background: #fff;
  height: 60px;

  .container {
    display: flex;
    align-items: center;
    height: 60px;
  }

  .logo {
    width: 158px;

    a {
      display: block;
      height: 80px;
      width: 100%;
      text-indent: -9999px;
      background: url('@/assets/images/logo.png') no-repeat center 18px / contain;
    }
  }

  .app-header-nav {
    width: 820px;
    display: flex;
    padding-left: 40px;
    position: relative;
    z-index: 998;

    li {
      margin-right: 30px;
      width: 85px;
      text-align: center;

      a {
        font-size: 16px;
        line-height: 32px;
        height: 32px;
        display: inline-block;

        &:hover {
          color: $xtxColor;
          border-bottom: 2px solid $xtxColor;
        }
      }

      .active {
        color: $xtxColor;
        border-bottom: 2px solid $xtxColor;
      }
    }
  }

  .app-nav-nav {
    width: 900px;
    display: flex;
    padding-left: 500px;
    position: relative;
    z-index: 998;

    li {
      margin-right: 30px;
      width: 80px;
      text-align: center;

      a {
        font-size: 16px;
        line-height: 32px;
        height: 32px;
        display: inline-block;

        &:hover {
          color: $xtxColor;
          border-bottom: 2px solid $xtxColor;
        }
      }

      .active {
        color: $xtxColor;
        border-bottom: 2px solid $xtxColor;
      }
    }
  }
}
</style>