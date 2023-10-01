<script setup>
import {sendCode, checkOpen} from "@/apis/code";
import {registerApi, checkApi} from "@/apis/account";
import {ref, onMounted} from 'vue'
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
        message: '注册请先退出登录',
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

const user = ref()
onMounted(() => {
  user.value = JSON.parse(localStorage.getItem("user-token"))
  checkQuest()
})

// 表单数据对象
const userInfo = ref({
  username: '',
  password: '',
  rePassword: '',
  email: '',
  verification: '',
  uuid: localStorage.getItem("uuid")
})

// 查看是否开启邮箱验证
const isOpenEmailCheck = ref()
const checkOpenQuest = async () => {
  const res = await checkOpen()
  isOpenEmailCheck.value = res.data
}

let registerFlag = ref(true)
onMounted(() => {
  checkOpenQuest()
  const registerTTL = localStorage.getItem("register-ttl");
  if (registerTTL && Date.now() < Number(registerTTL)) {
    registerFlag = false;
    setTimeout(() => {
      registerFlag = true;
    }, Number(registerTTL) - Date.now());
  }
})

// 规则数据对象
const rules = {
  username: [
    {required: true, message: '账号不能为空'},
    {min: 6, max: 16, message: '密码长度要求6-16个字符'},
    {validator: validateUser, message: '账号只能由英文和数字组成'}
  ],
  password: [
    {required: true, message: '密码不能为空'},
    {min: 6, max: 32, message: '密码长度要求6-32个字符'}
  ],
  rePassword: [
    {required: true, message: '密码不能为空'}
  ],
  email: [
    {required: isOpenEmailCheck.value, message: '邮箱不能为空'},
    {validator: validateEmail, message: '邮箱格式不正确(仅支持qq邮箱)'} // 添加邮箱格式验证规则
  ],
  verification: [
    {required: isOpenEmailCheck.value, message: '验证码不能为空'}
  ]
}

// 获取验证码
const verificationBtnText = ref('获取');
const verificationBtnDisabled = ref(false);
const codeMessage = ref()
const sendCodeQuest = async () => {
  const res = await sendCode(userInfo.value.email)
  codeMessage.value = res.data;
  // 存入uuid
  userInfo.value.uuid = codeMessage.value.uuid
  localStorage.setItem('uuid', codeMessage.value.uuid)
}

const registerTime = 120000;

const onVerificationBtnClick = () => {
  if (!registerFlag.value) {
    // 120秒内只能发送一次
    ElMessage({
      message: '请120秒后再重试',
      type: "warning"
    });
  }
  if (verificationBtnDisabled.value) return;
  let flag = 0;
  const emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
  if (emailRegex.test(userInfo.value.email)) {
    // 格式正确才发送
    if (userInfo.value.password !== userInfo.value.rePassword) {
      ElMessage({
        message: '密码不一致,请检查密码',
        type: 'warning'
      });
      flag = 1;
    } else {
      sendCodeQuest()
      registerFlag = false;
      localStorage.setItem("register-ttl", (Date.now() + registerTime).toString());
      setTimeout(() => {
        registerFlag = true;
      }, registerTime);
    }
  } else {
    // 错误则提示
    ElMessage({
      message: '邮箱为空或格式错误',
      type: 'warning'
    });
  }

  verificationBtnDisabled.value = true;
  verificationBtnText.value = '120s';
  let count;
  if (flag === 1) count = 5;
  else count = 120;

  const timer = setInterval(() => {
    count--;

    if (count > 0) {
      verificationBtnText.value = `${count}s`;
    } else {
      clearInterval(timer);
      verificationBtnText.value = '获取';
      verificationBtnDisabled.value = false;
    }
  }, 1000);
};

function validateEmail(rule, value, callback) {
  if (!value) {
    return callback(new Error('邮箱不能为空'));
  }
  const emailRegex = /^[A-Za-z0-9._%+-]+@qq\.com$/;
  if (!emailRegex.test(value)) {
    return callback(new Error('邮箱格式不正确(仅支持qq邮箱)'));
  }
  callback();
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

// 注册
const registerForm = ref(null);
const registerQuest = async () => {
  const res = await registerApi(userInfo.value);
  if (res.success) {
    ElMessage({
      message: '注册成功,3秒后跳到登录界面',
      type: 'success'
    });
    setTimeout(() => {
      router.push('/login')
    }, 3000);
  } else {
    ElMessage({
      message: res.errorMsg,
      type: 'error'
    });
  }
}

function onRegisterClick() {
  registerForm.value.validate((valid) => {
    if (valid) {
      registerQuest()
    } else {
      // 表单验证不通过，处理错误信息
      ElMessage({
        message: '请填写正确的注册信息',
        type: 'error'
      });
    }
  });
}

// 跳转到登录界面的按钮
function onLoginPageClick(){
  router.push('/login')
}

</script>

<template>
  <div class="login-container">
    <div class="login-wrapper">
      <div style="font-size: large; margin-bottom: 10px">七龙珠Online账号注册</div>
      <br><br>
      <div class="form">
        <el-form ref="registerForm" :model="userInfo" :rules="rules" status-icon label-width="80px" size="large"
                 @submit.prevent>
          <el-form-item prop="username" style="width:345px" label="账号">
            <el-input placeholder="请输入账号" v-model="userInfo.username"/>
          </el-form-item>
          <el-form-item prop="password" style="width:345px" label="密码">
            <el-input type="password" placeholder="请输入密码" v-model="userInfo.password"/>
          </el-form-item>
          <el-form-item prop="rePassword" style="width:345px" label="确认密码">
            <el-input type="password" placeholder="请确认密码" v-model="userInfo.rePassword"/>
          </el-form-item>
          <el-form-item prop="email" style="width:345px" label="邮箱" v-if="isOpenEmailCheck">
            <el-input placeholder="请输入邮箱" v-model="userInfo.email"/>
          </el-form-item>
          <el-row v-if="isOpenEmailCheck">
            <el-col :span="16">
              <el-form-item prop="verification" style="width:270px" label="验证码">
                <el-input placeholder="请输入验证码" v-model="userInfo.verification"/>
              </el-form-item>
            </el-col>
            <el-col :span="8">
              <el-button @click="onVerificationBtnClick" style="margin-left: 36px">
                {{ verificationBtnText }}
              </el-button>
            </el-col>
          </el-row>
          <div class="button-container">
            <el-button size="large" class="subBtn" @click="onRegisterClick">
              注册
            </el-button>
            <el-button size="large" class="register-btn" @click="onLoginPageClick">
              已有帐号？登录
            </el-button>
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
  height: 620px;
  margin-bottom: 115px;
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

.register-btn {
  background-color: #fff;
  color: #000;
  width: 35%;
  margin-right: 40px;
}
</style>