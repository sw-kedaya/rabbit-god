<script setup>
import { ref, onMounted } from 'vue';

const message = ref({
  text1: "",
  text2: "",
  text3: "",
  CopyRight: "",
});

onMounted(() => {
  fetchPublicFile('footer.json');
});

async function fetchPublicFile(filename) {
  try {
    const response = await fetch(filename);
    if (response.ok) {
      const content = await response.json();
      message.value = content.message;
    } else {
      console.error(`Failed to fetch ${filename}: ${response.status} ${response.statusText}`);
    }
  } catch (error) {
    console.error(`Error while fetching ${filename}:`, error);
  }
}
</script>

<template>
  <footer class="app_footer">
    <div class="extra">
      <div class="container">
        <!-- 版权信息 -->
        <div class="copyright">
          <p>
            <a href="javascript:;">{{ message.text1 }}</a>
            <a href="javascript:;">{{ message.text2 }}</a>
            <a href="javascript:;">{{ message.text3 }}</a>
          </p>
          <p>{{ message.CopyRight }}</p>
        </div>
      </div>
    </div>
  </footer>
</template>

<style scoped lang='scss'>
.app_footer {
  overflow: visible;
  background-color: #fff;
  padding-top: 5px;

  .contact {
    background: #fff;

    .container {
      padding: 60px 0 40px 25px;
      display: flex;
    }
  }

  .extra {
    background-color: transparent;
  }

  .copyright {
    height: 40px;
    text-align: center;
    color: #999;
    font-size: 15px;

    p {
      line-height: 1;
      margin-bottom: 0px;
    }

    a {
      color: #999;
      line-height: 1;
      padding: 0 10px;
      border-right: 1px solid #999;

      &:last-child {
        border-right: none;
      }
    }
  }
}
</style>