<script setup>

</script>

<template>
  <div class="home-banner">
    <el-carousel width="1920px" height="871px" :interval="3000">
      <el-carousel-item>
        <img src="/banner/10.jpg" alt="" class="carousel-image">
      </el-carousel-item>
      <el-carousel-item>
        <img src="/banner/11.jpg" alt="" class="carousel-image">
      </el-carousel-item>
      <el-carousel-item>
        <img src="/banner/12.jpg" alt="" class="carousel-image">
      </el-carousel-item>
      <el-carousel-item>
        <img src="/banner/13.jpg" alt="" class="carousel-image">
      </el-carousel-item>
    </el-carousel>
  </div>
</template>

<style scoped lang='scss'>
.home-banner {
  margin-left: -9px;
  width: 1920px;
  height: 550px;
  left: 0;
  z-index: 98;
}

.carousel-image {
  object-fit: cover;
  width: 100%;
  height: 100%;
}
</style>