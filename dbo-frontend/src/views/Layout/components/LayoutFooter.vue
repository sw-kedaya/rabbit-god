<template>
  <footer class="app_footer">
    <div class="extra">
      <div class="container">
        <!-- 版权信息 -->
        <div class="copyright">
          <p>
            <a href="javascript:;">适当游玩</a>
            <a href="javascript:;">版权信息</a>
            <a href="javascript:;">严禁脚本</a>
          </p>
          <p>CopyRight &copy; 兔神 | Q群：927829715</p>
        </div>
      </div>
    </div>
  </footer>
</template>

<style scoped lang='scss'>
.app_footer {
  overflow: visible;
  background-color: #fff;
  padding-top: 20px;

  .contact {
    background: #fff;

    .container {
      padding: 60px 0 40px 25px;
      display: flex;
    }
  }

  .extra {
    background-color: #ffffff;
  }

  .copyright {
    height: 100px;
    padding-top: 40px;
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
<script setup>
</script>