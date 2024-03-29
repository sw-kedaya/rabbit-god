<script setup>
import {ref, onMounted} from 'vue'
import {checkApi, forgetApi} from '@/apis/account'
import {ElMessage} from "element-plus";
import {useRouter} from "vue-router";

const router = useRouter()
// 进入该页面前检测是否登录，若登录跳转到首页
const checkQuest = async () => {
  if (user.value != null) {
    const res = await checkApi(user.value.token)
    if (res.data) {
      router.push('/home')
      ElMessage({
        message: '请先退出登录',
        type: 'warning'
      });
    } else {
      ElMessage({
        message: '令牌过期，请重新登录',
        type: 'warning'
      });
      localStorage.removeItem("user-token")
      localStorage.removeItem("admin-token")
    }
  }
}

const user = ref();
let forgetFlag = ref(true)
onMounted(() => {
  const forgetTTL = localStorage.getItem("forget-ttl");
  // 值不为空且还没过期，就先进入把倒计时走完再开放
  if (forgetTTL && Date.now() < Number(forgetTTL)) {
    forgetFlag = ref(false);
    setTimeout(() => {
      forgetFlag = ref(true);
    }, Number(forgetTTL) - Date.now());
  }

  user.value = JSON.parse(localStorage.getItem("user-token"))
  checkQuest()
})

// 表单数据对象
const userInfo = ref({
  username: ''
})

// 规则数据对象
const rules = {
  username: [
    {required: true, message: '账号不能为空'},
    {min: 3, max: 14, message: '账号长度要求3-14个字符'},
    {validator: validateUser, message: '账号只能由英文和数字组成'}
  ]
}

function validateUser(rule, value, callback) {
  if (!value) {
    return callback(new Error('账号不能为空'));
  }
  const userRegex = /^[a-zA-Z0-9]+$/;
  if (!userRegex.test(value)) {
    return callback(new Error('账号只能由英文和数字组成'));
  }
  callback();
}

// 登录
const forgetForm = ref(null);

const forgetQuest = async () => {
  const res = await forgetApi(userInfo.value.username);
  if (res.success) {
    ElMessage({
      message: '密码已发至您的注册邮箱，请注意查收',
      type: "success"
    });
  } else {
    ElMessage({
      message: res.errorMsg,
      type: "error"
    });
  }
}

const forgetTime = 120000;

function onForgetClick() {
  if (forgetFlag.value) {
    forgetForm.value.validate((valid) => {
      if (valid) {
        forgetFlag = ref(false);
        forgetQuest()
        localStorage.setItem("forget-ttl", (Date.now() + forgetTime).toString());
        setTimeout(() => {
          forgetFlag = ref(true);
          localStorage.removeItem("forget-ttl");
        }, forgetTime);
      } else {
        // 表单验证不通过，处理错误信息
        ElMessage({
          message: '请填写正确的信息',
          type: "warning"
        });
      }
    });
  } else {
    // 120秒内只能发送一次
    ElMessage({
      message: '请120秒后再重试',
      type: "warning"
    });
  }
}

// 跳转到登录界面的按钮
function onLoginPageClick(){
  router.push('/login')
}

</script>

<template>
  <div class="forget-container">
    <div class="forget-wrapper">
      <div style="font-size: large; margin-bottom: 10px">忘记密码</div>
      <br>
      <div class="form">
        <el-form ref="forgetForm" :model="userInfo" :rules="rules" status-icon label-width="80px" size="large"
                 @submit.prevent>
          <el-form-item prop="username" style="width:320px" label="账号">
            <el-input placeholder="请输入账号" v-model="userInfo.username"/>
          </el-form-item>
          <div class="button-container">
            <el-tooltip content="密码将发送到注册邮箱">
              <el-button size="large" class="subBtn" @click="onForgetClick">找回密码</el-button>
            </el-tooltip>
            <el-button size="large" class="login-btn" @click="onLoginPageClick">
              马上登录
            </el-button>
          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>

<style scoped lang='scss'>
.forget-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 80vh;
}

.forget-wrapper {
  width: 400px;
  padding: 20px;
  border-radius: 4px;
  background-color: #fff;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15); /* 添加阴影效果 */
}

.form {
  margin-bottom: 20px;
}

.links-container {
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
}

.link-wrapper {
  display: flex;
}

.forget-link {
  margin-top: 20px;
  margin-left: 80px;
}

.button-container {
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
}

.subBtn {
  background-color: #409eff;
  color: #fff;
  width: 35%;
  margin-left: 80px;
}

.forget-btn {
  background-color: #fff;
  color: #000;
  width: 35%;
  margin-right: 40px;
}
</style>