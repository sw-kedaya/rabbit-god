<script setup>
import {ref, onMounted} from 'vue';

const homeUrl = ref({
  downloadUrl: '',
  customButton1: '',
  customButton2: '',
  customUrl1: '',
  customUrl2: '',
});

onMounted(() => {
  fetchPublicFile('myHome.json');
});

async function fetchPublicFile(filename) {
  try {
    // const response = await fetch(filename);
    // 增加时间戳，防止浏览器缓存
    const response = await fetch(filename + '?t=' + Date.now());
    if (response.ok) {
      const content = await response.json();
      homeUrl.value = content.homeUrl;
    } else {
      console.error(`Failed to fetch ${filename}: ${response.status} ${response.statusText}`);
    }
  } catch (error) {
    console.error(`Error while fetching ${filename}:`, error);
  }
}
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
      <div class="home-inner-log"/>
      <div class="home-inner-card">
        <div>
          <a :href="homeUrl.downloadUrl">
            <button class="card-inner-download-button">
              <span class="button-top-bg"></span>
              <span class="button-inner-font">游戏下载</span>
            </button>
          </a>
        </div>
        <div class="card-inner-other-contain">
          <a href="/register">
            <button class="card-inner-other-button-top">
              <span class="button-inner-font">账号注册</span>
            </button>
          </a>
          <a href="/mall">
            <button class="card-inner-other-button-bottom">
              <span class="button-inner-font">游戏商城</span>
            </button>
          </a>
        </div>
        <div class="card-inner-other-contain">
          <a :href="homeUrl.customUrl1">
            <button class="card-inner-other-button-top">
              <span class="button-inner-font">{{ homeUrl.customButton1 }}</span>
            </button>
          </a>
          <a :href="homeUrl.customUrl2">
            <button class="card-inner-other-button-bottom">
              <span class="button-inner-font">{{ homeUrl.customButton2 }}</span>
            </button>
          </a>
        </div>
        <div class="card-inner-link-contain">
          <span class="other-link-bg"></span>
        </div>
      </div>
    </el-carousel>
  </div>
</template>

<style scoped lang='scss'>
.home-banner {
  width: 100%;
  height: 550px;
  left: 0;

  .carousel-image {
    object-fit: cover;
    width: 100%;
    height: 100%;
  }
}

.home-inner-log {
  position: absolute;
  z-index: 100;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 523px; /* 根据实际情况调整宽度 */
  height: 190px; /* 根据实际情况调整高度 */
  background: url('/banner/logo.png') no-repeat center;
  background-size: contain;
}

.home-inner-card {
  position: absolute;
  bottom: 40px;
  left: 50%;
  transform: translateX(-50%);
  width: 405px;
  height: 90px;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 100;

  .card-inner-download-button:hover {
    background-image: url("@/assets/home/download-bg-hover.png");
  }

  .card-inner-download-button {
    position: relative;
    margin: 5px;
    width: 100px;
    height: 80px;
    float: right; /* 向右浮动 */
    background-image: url("@/assets/home/download-bg.png");
    cursor: pointer; /* 设置为手势光标 */
    border: none;

    .button-top-bg {
      position: absolute;
      top: 11px;
      left: 25%;
      width: 50%;
      height: 38%;
      background-image: url('/home/download.png');
      background-size: contain;
      background-position: center top;
    }

    .button-inner-font {
      font-size: 17px;
      font-weight: bold;
      color: #4b3b29;
      display: block;
      margin-top: 30px;
    }
  }

  .card-inner-other-contain {
    position: relative;
    width: 100px;
    height: 80px;
    border: none;
    float: right;
    margin-left: 5px;
    margin-top: 5px;
  }

  .card-inner-other-button-top:hover {
    background-image: url("@/assets/home/other-top-bg-hover.png");
  }

  .card-inner-other-button-top {
    position: relative;
    width: 100px;
    height: 37.5px;
    float: right; /* 向右浮动 */
    background-image: url("@/assets/home/other-top-bg.png");
    cursor: pointer; /* 设置为手势光标 */
    border: none;

    .button-inner-font {
      font-size: 15px;
      font-weight: bold;
      color: #4b3b29;
      display: block;
    }
  }

  .card-inner-other-button-bottom:hover {
    background-image: url("@/assets/home/other-bottom-bg-hover.png");
  }

  .card-inner-other-button-bottom {
    position: relative;
    margin-top: 5px;
    width: 100px;
    height: 37.5px;
    float: right; /* 向右浮动 */
    background-image: url("@/assets/home/other-bottom-bg.png");
    cursor: pointer; /* 设置为手势光标 */
    border: none;

    .button-inner-font {
      font-size: 15px;
      font-weight: bold;
      color: #4b3b29;
      display: block;
    }
  }

  .card-inner-link-contain {
    position: relative;
    width: 80px;
    height: 80px;
    border: none;
    float: right;
    margin-left: 5px;
    margin-top: 5px;
  }

  .other-link-bg {
    position: absolute;
    width: 80px;
    height: 80px;
    background-image: url('/home/QR.jpg');
    background-size: 100% 100%;
    background-position: center top;
  }
}
</style>