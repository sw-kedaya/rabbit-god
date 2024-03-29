<script setup>
import {ref, onMounted} from 'vue'
import {loginApi, checkApi} from '@/apis/account'
import {ElMessage} from "element-plus";
import {useRouter} from "vue-router";
import {getCodeImgApi} from "@/apis/code"

const router = useRouter()
// 进入该页面前检测是否登录，若登录跳转到首页
const checkQuest = async () => {
  if (user.value != null) {
    const res = await checkApi(user.value.token)
    if (res.data && router.currentRoute.value.fullPath === "/login") {
      router.push("/home");
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

const user = ref()
onMounted(() => {
  user.value = JSON.parse(localStorage.getItem("user-token"))
  checkQuest()
  getCodeImg()
})


// 表单数据对象
const userInfo = ref({
  username: '',
  password: '',
  uuid: '',
  code: '',
})

// 规则数据对象
const rules = {
  username: [
    {required: true, message: '账号不能为空'},
    {min: 3, max: 14, message: '账号长度要求3-14个字符'},
    {validator: validateUser, message: '账号只能由英文和数字组成'}
  ],
  password: [
    {required: true, message: '密码不能为空'},
    {min: 6, max: 14, message: '密码长度要求6-14个字符'}
  ],
  code: [
    {required: true, message: '验证码不能为空'},
    {min: 1, max: 14, message: '验证码不能为空'}
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
const loginForm = ref(null);

const loginQuest = async () => {
  const res = await loginApi(userInfo.value);
  if (res.success) {
    localStorage.setItem("user-token", JSON.stringify(res.data))
    ElMessage({
      message: '登录成功',
      type: "success"
    });
    setTimeout(() => {
      router.push({ path: '/me', query: { key: 'isMe' }});
    }, 1000);
  } else {
    // 如果登录失败，继续开放登录按钮
    disabledLoginButton = ref(true)
    ElMessage({
      message: res.errorMsg,
      type: "error"
    });
  }
}

// 防止一直按登录
let disabledLoginButton = ref(true)

function onLoginClick() {
  loginForm.value.validate((valid) => {
    if (valid) {
      if (disabledLoginButton.value) {
        disabledLoginButton = ref(false)
        loginQuest()
      }
    } else {
      // 表单验证不通过，处理错误信息
      ElMessage({
        message: '请填写正确的登录信息',
        type: "warning"
      })
    }
  });
}

// 跳转到注册页面的按钮
function onRegisterPageClick() {
  router.push('/register')
}

// 跳转到忘记密码页面的按钮
function onForgetPageClick() {
  router.push('/forget')
}

// 获取验证码图片
const isEnabled = ref(true)
const codeURL = ref()
const loading = ref(true)
const getCodeImg = async () => {
  const res = await getCodeImgApi();
  if (res.success) {
    loading.value = false;
    isEnabled.value = res.data.captchaEnabled;
    codeURL.value = "data:image/gif;base64," + res.data.image;
    userInfo.value.uuid = res.data.uuid;
  }
}

</script>

<template>
  <div class="login-container">
    <div class="login-wrapper">
      <div style="font-size: large; margin-bottom: 10px">七龙珠Online账号登录</div>
      <br><br>
      <div class="form">
        <el-form ref="loginForm" :model="userInfo" :rules="rules"
                 status-icon label-width="80px" size="large"
                 @submit.prevent>
          <el-form-item prop="username" style="width:360px;margin-left:-10px;" label="账号">
            <el-input placeholder="请输入账号" v-model="userInfo.username"/>
          </el-form-item>
          <el-form-item prop="password" style="width:360px;margin-left:-10px;" label="密码">
            <el-input type="password" placeholder="请输入密码" v-model="userInfo.password"/>
          </el-form-item>
          <el-row v-if="isEnabled">
            <el-col :span="16">
              <el-form-item prop="code" style="width:230px; margin-left:-10px;" label="验证码">
                <el-input placeholder="请输入验证码" v-model="userInfo.code"/>
              </el-form-item>
            </el-col>
            <el-col :span="7" style="" v-loading="loading">
              <img :src="codeURL" @click="getCodeImg" alt=""/>
            </el-col>
          </el-row>
          <div class="button-container">
            <el-button size="large" class="subBtn" @click="onLoginClick" native-type="submit">登录</el-button>
            <el-button size="large" class="register-btn" @click="onRegisterPageClick">
              注册账号
            </el-button>
          </div>
          <div class="forget-link">
            <button class="el-button el-button--default el-button--mini" @click="onForgetPageClick">
              密码忘了？点击找回密码
            </button>
          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>

<style scoped lang='scss'>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 80vh;
}

.login-wrapper {
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
  margin-left: 70px;
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
  margin-left: 70px;
}

.register-btn {
  background-color: #fff;
  color: #000;
  width: 35%;
  margin-right: 40px;
}
</style>