<script setup>
import {ElConfigProvider} from "element-plus";
import zhCN from "element-plus/dist/locale/zh-cn.mjs";
const local = zhCN
</script>

<template>
  <div class="container">
    <el-config-provider :locale="local">
      <router-view/>
    </el-config-provider>
  </div>
</template>

<style>
.container {
  width: 100%;
  min-width: 512px;
}
</style>