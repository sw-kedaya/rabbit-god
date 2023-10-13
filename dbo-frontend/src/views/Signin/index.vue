<script setup>
import {useRouter} from "vue-router";
import {ElMessage} from "element-plus";
import {onMounted, ref, watch} from "vue";
import {getDBOCharListApi, setSignApi, checkIsSignApi, getSignMessageApi} from "@/apis/dboChar";

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
  if (user.value == null) return ElMessage.warning('请先登录')
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
    checkIsSignQuest(user.value.accountID)
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

// 历史签到表部分
const onSignInCard = ref(false)
const showSignInCard = () => {
  if (user.value == null) return ElMessage.warning('请先登录')
  onSignInCard.value = !onSignInCard.value;
}
// 获取当前日期
const currentDateTime = new Date(Date.now());
const year = currentDateTime.getFullYear();
const month = (currentDateTime.getMonth() + 1).toString().padStart(2, "0"); // 不足两位则补0
const day = (currentDateTime.getDate()).toString().padStart(2, "0"); // 不足两位则补0
const formattedDate = `${year}年${month}月${day}日`;

// 定义顶部星期
const weekTitle = ref(["一", "二", "三", "四", "五", "六", "日"])

// 获取当月的天数
const getDaysInMonth = (year, month) => {
  // 这里month是加过1的，放入后是下个月，然后date写0就可以获取到上个月的最后一个日期
  return new Date(year, month, 0).getDate();
};

// 补签表单部分
const replacementForm = ref({
  roleName: '',
  replaceNum: ''
});

watch(() => replacementForm.value.roleName, () => {
  getSignMessageQuest()
})
watch(() => replacementForm.value.replaceNum, () => {
  notSignedGiftShow.value = [];
  notSignedGift.value.filter(item => {
    if (item.sign_reward === replacementForm.value.replaceNum.toString()) {
      notSignedGiftShow.value.push(item.name)
    }
  });
})

const replacementRules = {
  roleName: [
    {required: true, message: '请选择补签角色'},
  ],
  replaceNum: [
    {required: true, message: '请选择补签日期'},
  ]
};

// 构造一个日期数组
// 已签到、未签到的日期和对应的未签到的签到礼物
const signedDates = ref([]); // 已签到的日期
const notSignedDates = ref([]); // 未签到的日期
const notSignedGift = ref([]); // 未签到的当天礼物信息
const calendar = ref([]); // 日期列表
const notSignedGiftShow = ref([]) // 展示补签表单选择后的当天礼物内容

const getSignMessageQuest = async () => {
  if (replacementForm.value.roleName === '') return;
  const res = await getSignMessageApi(replacementForm.value.roleName)
  signedDates.value = res.data.signed;
  notSignedDates.value = res.data.notSigned;
  notSignedGift.value = res.data.mallList;
  calendar.value = generateCalendar(year, month);
}

const generateCalendar = (year, month) => {
  const daysInMonth = getDaysInMonth(year, month);

  const calendar = [];
  for (let i = 1; i <= daysInMonth; i++) {
    const day = {
      date: i,
      isSigned: signedDates.value.find(item => item === i) === i, // 判断该日期是否已签到
      isNotSigned: notSignedDates.value.find(item => item === i) === i, // 判断该日期是否未签到
    };
    calendar.push(day);
  }

  return calendar;
};
calendar.value = generateCalendar(year, month);

const dialogVisibleForReplacement = ref(false)
const showReplacementExchangeForm = () => {
  if (replacementSignCount.value <= 0) {
    ElMessage.warning("补签次数不足");
    return;
  }
  dialogVisibleForReplacement.value = true;
};
const cancelReplacementExchange = () => {
  replacementForm.value.replaceNum = '';
  dialogVisibleForReplacement.value = false;
}
const replacementFormValidate = ref() // 用于判断用户是否填写了表单

// 获取剩余补签次数
const replacementSignCount = ref(1)
const onReplacementClick = () => {
  if (replacementForm.value.roleName === '') return ElMessage.warning("请选择补签角色")
  replacementFormValidate.value.validate(valid => {
    if (valid) {
      dialogVisibleForReplacement.value = false;
      replacementForm.value.replaceNum = '';
      // getSignMessageQuest()
      // ElMessage.success("补签成功")
    } else {
      ElMessage.warning("请选择补签日期")
    }
  })
}

</script>

<template>
  <div class="sign-in-container">
    <div>
      <el-button class="myButton" type="success" round size="large" @click="showSignExchangeForm" v-if="isCanSign">
        立即签到
      </el-button>
      <el-button class="myButton2" type="info" round size="large" disabled="true" v-else>
        已完成签到
      </el-button>
      <div class="check-sign-in-button">
        <el-button type="text" round @click="showSignInCard">查看历史签到</el-button>
      </div>
      <div v-if="onSignInCard">
        <el-card class="box-card" shadow="always" style="width: 400px;">
          <div style="display: flex">
            <el-select v-model="replacementForm.roleName" class="m-2"
                       style="margin-bottom: 10px; width: 160px;"
                       placeholder="请选择查看的角色" size="default">
              <el-option
                  v-for="item in dboCharOptions"
                  :key="item.charName"
                  :label="item.charName"
                  :value="item.charName"
              />
            </el-select>
          </div>
          <div class="myDateTitle">{{ formattedDate }}</div>
          <div class="calendar">
            <div v-for="week in weekTitle" :key="week" class="week">
              {{ week }}
            </div>
            <div v-for="day in calendar" :key="day.date" class="day"
                 :class="{ 'is-signed': day.isSigned, 'is-not-signed': day.isNotSigned}">
              {{ day.date }}
            </div>
          </div>
          <div style="margin-top: 10px">
            <span class="myTip"><span class="my-signed-box"></span>已签到</span>
            <span class="myTip"><span class="my-not-signed-box"></span>未签到</span>
          </div>
          <div class="my-replacement-sign-button">
            <el-button round class="my-replacement-button" @click="showReplacementExchangeForm">补签</el-button>
            <span style="margin-top: 5px; margin-left: 5px">剩余补签次数：{{ replacementSignCount }}次</span>
          </div>
        </el-card>
      </div>
    </div>
  </div>
  <el-dialog v-model="dialogVisibleForSign" title="每日签到" width="320px">
    <el-form ref="signFormValidate" :model="signForm" label-position="top" :rules="signRules">
      <div class="myWarning">
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
                   @click="sign">确认签到
        </el-button>
      </div>
    </el-form>
  </el-dialog>
  <el-dialog v-model="dialogVisibleForReplacement" title="补签" width="320px">
    <el-form ref="replacementFormValidate" :model="replacementForm" label-position="top" :rules="replacementRules">
      <div class="myWarning">
        <span class="el-alert__title">补签前请确保您的信箱位置足够，否则奖励会发送失败</span>
      </div>
      <div class="form-row">
        <span class="dialogLabel">日期</span>
        <el-form-item class="myInput" prop="replaceNum">
          <el-select v-model="replacementForm.replaceNum" class="m-2" placeholder="请选择补签日期" size="large">
            <el-option
                v-for="item in notSignedDates"
                :key="item"
                :label="item"
                :value="item"
            />
          </el-select>
        </el-form-item>
      </div>
      <div class="my-replace-sign-tip">
        <span class="el-alert__title">该日签到礼物为：{{ notSignedGiftShow }}</span>
      </div>
      <div></div>
      <div class="form-row" style="justify-content: flex-end; margin-top: 20px;">
        <el-button type="default" style="width: 70px; height: 40px" @click="cancelReplacementExchange">取消</el-button>
        <el-button type="primary"
                   style="background-color: #de7f38; color: #FFFFFF; height: 40px; border-color: #de7f38;"
                   @click="onReplacementClick">确认补签
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
  text-align: center;

  .myButton {
    margin-top: 100px;
    font-size: 24px; /* 增加按钮文本的字体大小 */
    padding: 34px 101px; /* 增加按钮的内边距 */
    background-color: #67C23A; /* 设置按钮的背景颜色为红色 */
    color: #ffffff; /* 设置按钮的文本颜色为白色 */
    border-radius: 50px; /* 增加按钮的边框半径 */
  }

  .myButton2 {
    margin-top: 100px;
    font-size: 24px; /* 增加按钮文本的字体大小 */
    padding: 34px 101px; /* 增加按钮的内边距 */
    border-radius: 50px; /* 增加按钮的边框半径 */
  }
}

.check-sign-in-button {
  margin-top: 10px;
  text-align: center;
}

.myDateTitle {
  margin-bottom: 15px;
  font-size: 17px;
}

.calendar {
  margin-left: 10px;
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  grid-gap: 8px;
}

.week {
  width: 70%;
  padding: 4px;
  text-align: center;
}

.day {
  width: 70%;
  padding: 4px;
  text-align: center;
}

.is-signed {
  width: 70%;
  border-radius: 50%;
  background-color: #67C23A;
}

.is-not-signed {
  width: 70%;
  border-radius: 50%;
  background-color: #888888;
}

.myTip {
  display: flex;
  justify-content: right;
}

.my-signed-box {
  display: inline-block;
  margin-top: 5px;
  width: 10px;
  height: 10px;
  background-color: #67C23A;
}

.my-not-signed-box {
  display: inline-block;
  margin-top: 5px;
  width: 10px;
  height: 10px;
  background-color: #888888;
}

.my-replacement-sign-button {
  display: flex;
  justify-content: left;

  .my-replacement-button {
    background-color: #de7f38; /* 设置按钮的背景颜色为红色 */
    color: #ffffff; /* 设置按钮的文本颜色为白色 */
  }
}

.my-replace-sign-tip {
  color: #ba4e27; /* 文字 */
  display: table;
  font-size: 13px;
  margin-left: 15px;
  margin-bottom: 8px;
}
</style>