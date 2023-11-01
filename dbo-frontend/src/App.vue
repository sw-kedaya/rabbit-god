<script setup>
import {ElConfigProvider} from "element-plus";
import zhCN from "element-plus/dist/locale/zh-cn.mjs";
const local = zhCN
</script>

<template>
  <div class="container user-selectable">
    <el-config-provider :locale="local">
      <router-view/>
    </el-config-provider>
  </div>
</template>

<style>
.container {
  width: 100%;
  min-width: 512px;
  background-image: url("@/assets/images/bg.png"); /* 设置背景图片的 URL */
  background-repeat: repeat; /* 将背景图片设置为平铺 */
}

.user-selectable {
  -webkit-user-select: text; /* Chrome, Safari, Opera */
  -moz-user-select: text; /* Firefox */
  -ms-user-select: text; /* Internet Explorer/Edge */
  user-select: text; /* 非前缀版本，目前被大多数浏览器支持 */
}
</style>