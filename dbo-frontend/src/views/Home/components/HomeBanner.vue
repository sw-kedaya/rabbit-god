<script setup>
import {ref} from 'vue'

// banner数据对象
const bannerInfo = ref({
  src: [
      "07.jpg",
      "09.jpg",
      "010.jpg",
      "011.jpg"
  ]
})
</script>

<template>
  <div class="home-banner">
    <el-carousel height="720px" width="1280px" :interval="3000">
      <el-carousel-item>
        <img src="@/assets/banner/10.jpg" alt="">
      </el-carousel-item>
      <el-carousel-item>
        <img src="@/assets/banner/11.jpg" alt="">
      </el-carousel-item>
      <el-carousel-item>
        <img src="@/assets/banner/12.jpg" alt="">
      </el-carousel-item>
      <el-carousel-item>
        <img src="@/assets/banner/13.jpg" alt="">
      </el-carousel-item>
    </el-carousel>
  </div>
</template>

<style scoped lang='scss'>
.home-banner {
  width: 1280px;
  height: 450px;
  left: 0;
  z-index: 98;

}
</style>