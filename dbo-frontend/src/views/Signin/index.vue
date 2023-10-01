<script setup>
import {useRouter} from "vue-router";
import {ElMessage} from "element-plus";
import {onMounted, ref} from "vue";
import {getDBOCharListApi, setSignApi, checkIsSignApi} from "@/apis/dboChar";

const router = useRouter()
const user = ref()
onMounted(() => {
  // 进入前先判断登录没
  user.value = JSON.parse(localStorage.getItem("user-token"))
  if (user.value !== null) {
    getDBOCharListQuest(user.value.accountID)
    checkIsSignQuest(user.value.accountID)
  }
})

// 判断该账号是否签到
const isCanSign = ref(true)
const checkIsSignQuest = async (accountID) => {
  const res = await checkIsSignApi(accountID)
  if (!res.success) isCanSign.value = false;
}

// 表单
const dboCharOptions = ref([])
const getDBOCharListQuest = async (accountID) => {
  const res = await getDBOCharListApi(accountID)
  dboCharOptions.value = res.data;
}
const signForm = ref({
  roleName: ''
});
const signRules = {
  roleName: [
    {required: true, message: '请选择角色名称'},
  ]
};
const dialogVisibleForSign = ref(false)
const showSignExchangeForm = () => {
  dialogVisibleForSign.value = true;
};
const cancelSignExchange = () => {
  signForm.value.roleName = '';
  dialogVisibleForSign.value = false;
}
const signFormValidate = ref() // 用于判断用户是否填写了表单
const setSignQuest = async (charName, accountID) => {
  const res = await setSignApi(charName, accountID)
  if (res.success) {
    ElMessage.success("签到成功")
  } else {
    ElMessage.warning(res.errorMsg)
  }
}
const sign = () => {
  if (user.value == null) return ElMessage.warning('请先登录')
  if (!isCanSign.value) return ElMessage.warning('一个账号只能签到一次')
  signFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForSign.value = false;
      setSignQuest(signForm.value.roleName, user.value.accountID)
    } else {
      ElMessage.warning("请选择角色名称")
    }
  })
}
</script>

<template>
  <template v-if="isCanSign">
    <div class="sign-in-container">
      <div>
        <el-button class="myButton" type="success" round size="large" @click="showSignExchangeForm">
          立即签到
        </el-button>
      </div>
    </div>
  </template>
  <template v-else>
    <div class="sign-in-container2">
      <div>
        <el-button class="myButton" type="info" round size="large" disabled="true">
          已完成签到
        </el-button>
      </div>
    </div>
  </template>
  <el-dialog v-model="dialogVisibleForSign" title="购买胶囊" width="320px">
    <el-form ref="signFormValidate" :model="signForm" label-position="top" :rules="signRules">
      <div class="myWarning ">
        <span class="el-alert__title">签到前请确保您的信箱位置足够，否则奖励会发送失败</span>
      </div>
      <div class="form-row">
        <span class="dialogLabel">角色</span>
        <el-form-item class="myInput" prop="roleName">
          <el-select v-model="signForm.roleName" class="m-2" placeholder="请选择角色名称" size="large">
            <el-option
                v-for="item in dboCharOptions"
                :key="item.charName"
                :label="item.charName"
                :value="item.charName"
            />
          </el-select>
        </el-form-item>
      </div>
      <div class="form-row" style="justify-content: flex-end; margin-top: 20px;">
        <el-button type="default" style="width: 70px; height: 40px" @click="cancelSignExchange">取消</el-button>
        <el-button type="primary"
                   style="background-color: #67c23a; color: #FFFFFF; height: 40px; border-color: #67c23a;"
                   @click="sign">确认购买
        </el-button>
      </div>
    </el-form>
  </el-dialog>
</template>

<style>
.sign-in-container {
  display: flex;
  justify-content: center;
  height: 738px;
  background-image: url("@/assets/images/bg.png"); /* 设置背景图片的 URL */
  background-repeat: repeat; /* 将背景图片设置为平铺 */

  .myButton {
    margin-top: 100px;
    font-size: 24px; /* 增加按钮文本的字体大小 */
    padding: 34px 101px; /* 增加按钮的内边距 */
    background-color: #67C23A; /* 设置按钮的背景颜色为红色 */
    color: #ffffff; /* 设置按钮的文本颜色为白色 */
    border-radius: 50px; /* 增加按钮的边框半径 */
  }
}
.sign-in-container2 {
  display: flex;
  justify-content: center;
  height: 738px;
  background-image: url("@/assets/images/bg.png"); /* 设置背景图片的 URL */
  background-repeat: repeat; /* 将背景图片设置为平铺 */

  .myButton {
    margin-top: 100px;
    font-size: 24px; /* 增加按钮文本的字体大小 */
    padding: 34px 101px; /* 增加按钮的内边距 */
    border-radius: 50px; /* 增加按钮的边框半径 */
  }
}

h2 {
  font-size: 24px;
  margin-bottom: 10px;
}

p {
  font-size: 16px;
  margin-bottom: 20px;
}
</style>