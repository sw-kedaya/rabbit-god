<script setup>
import {ref, onMounted, watch} from 'vue';
import {updateApi, getLatestMallPointsApi} from "@/apis/account";
import {ElMessage} from "element-plus";
import {useRouter} from "vue-router";
import {getDBOCharListApi} from "@/apis/dboChar";
import {getUseCdKeyApi} from "@/apis/cashKey";
import {sendCode, checkOpen} from "@/apis/code"

// 修改密码的表单校验
const confirmPasswordValidator = (rule, value, callback) => {
  if (value !== passwordForm.value.newPassword) {
    callback(new Error('两次输入的密码不一致'));
  } else {
    callback();
  }
};
// 判断是否开了邮箱验证
const isOpenEmailCheck = ref()
const checkOpenQuest = async () => {
  const res = await checkOpen()
  isOpenEmailCheck.value = res.data
  passwordRules.code[0].required = isOpenEmailCheck.value
}

// 兑换卡密的表单校验
const cDKeyRules = {
  cdKey: [
    {required: true, message: '请输入卡密'},
    {min: 32, max: 32, message: '请输入正确的卡密'}
  ]
};

const user = ref()
const dialogVisible = ref(false);
const dialogVisibleForCdKey = ref(false);

const router = useRouter()

// 获取用户角色信息
// 新增加载组件
const loading = ref(true)
const tableData = ref([]);
const getDBOCharListQuest = async (data) => {
  const res = await getDBOCharListApi(data)
  tableData.value = res.data;
  loading.value = false;
}
// 给角色信息分表
const currentPage = ref(1);
const pageSize = ref(10);
const totalPage = ref(1);
const startIndex = ref(0);
const endIndex = ref(0);
const currentPageData = ref([]);

// 切换每页显示多少数据时刷新
function handleSizeChange(newSize) {
  pageSize.value = newSize;
  updatePagination();
}

// 切换页时刷新
function handleClick(newCurrentPage) {
  currentPage.value = newCurrentPage;
  updatePagination();
}

function updatePagination() {
  totalPage.value = Math.ceil(tableData.value.length / pageSize.value);
  startIndex.value = (currentPage.value - 1) * pageSize.value;
  endIndex.value = Math.min(startIndex.value + pageSize.value - 1, tableData.value.length - 1);
  currentPageData.value = tableData.value.slice(startIndex.value, endIndex.value + 1);
}

// 当tableData有数据，就触发分页
watch(tableData, () => {
  updatePagination();
});

// 钩子
let updateFlag = ref(true)
onMounted(() => {
  if (router.currentRoute.value.query.key === 'isMe') {
    // 删除网址?isMe再重新加载，否则会无限循环
    window.location.replace(window.location.href.split('?')[0])
  }

  // 判断是否开启了邮箱验证
  checkOpenQuest()
  // 进入前先判断登录没
  user.value = JSON.parse(localStorage.getItem("user-token"))
  if (user.value == null) {
    router.push('/login')
    return;
  }
  getDBOCharListQuest(user.value.accountID)

  // 30秒只能修改一次密码
  const updateTTL = localStorage.getItem("update-ttl");
  // 值不为空且还没过期，就先进入把倒计时走完再开放
  if (updateTTL && Date.now() < Number(updateTTL)) {
    updateFlag = ref(false);
    setTimeout(() => {
      updateFlag = ref(true);
    }, Number(updateTTL) - Date.now());
  }

  // 给兑换卡密的表单设置用户id
  cdKeyExchangeForm.value.accountID = user.value.accountID;
})

const passwordRules = {
  oldPassword: [
    {required: true, message: '请输入原密码'},
    {min: 6, max: 14, message: '密码长度应为6到14位'}
  ],
  newPassword: [
    {required: true, message: '请输入新密码'},
    {min: 6, max: 14, message: '密码长度应为6到14位'}
  ],
  confirmPassword: [
    {required: true, message: '请确认密码'},
    {min: 6, max: 14, message: '密码长度应为6到14位'},
    {validator: confirmPasswordValidator}
  ],
  code: [
    {required: isOpenEmailCheck.value, message: '请输入验证码'}
  ]
};

// 修改密码
const passwordForm = ref({
  username: '',
  oldPassword: '',
  newPassword: '',
  confirmPassword: '',
  code: '',
  uuid: localStorage.getItem("uuid")
});

// 兑换卡密
const cdKeyExchangeForm = ref({
  accountID: '',
  cdKey: ''
});

const showPasswordForm = () => {
  dialogVisible.value = true;
};

const showCdKeyExchangeForm = () => {
  dialogVisibleForCdKey.value = true;
};

const updateQuest = async () => {
  const res = await updateApi(passwordForm.value)
  if (res.success) {
    ElMessage.success('修改成功')
  } else {
    ElMessage.error(res.errorMsg)
  }
}

const passwordFormValidate = ref()
const updateTime = 30000;
const savePassword = () => {
  if (updateFlag.value) {
    passwordFormValidate.value.validate((valid) => {
      if (valid) {
        updateFlag = ref(false);
        passwordForm.value.username = user.value.username;
        updateQuest()
        localStorage.setItem("update-ttl", (Date.now() + updateTime).toString());
        setTimeout(() => {
          updateFlag = ref(true);
          localStorage.removeItem("update-ttl");
        }, updateTime);
        passwordForm.value = {
          username: '',
          oldPassword: '',
          newPassword: '',
          confirmPassword: ''
        };
        dialogVisible.value = false;
      } else {
        ElMessage.warning('请填写正确的信息');
      }
    });
  } else {
    ElMessage.warning('请30秒后再重试');
  }
};

// 修改密码取消按钮
const cancelPassword = () => {
  passwordForm.value = {
    username: '',
    oldPassword: '',
    newPassword: '',
    confirmPassword: ''
  };
  dialogVisible.value = false;
}

// 卡密兑换取消
const cancelCdKeyExchange = () => {
  cdKeyExchangeForm.value = {
    cdKey: '',
  };
  dialogVisibleForCdKey.value = false;
}

// 点击购买卡密提示
function onBuyCardClick() {
  ElMessage.warning("暂未开放购买卡密")
}

// 卡密请求
const getUseCdKeyQuest = async () => {
  const res = await getUseCdKeyApi(cdKeyExchangeForm.value)
  if (res.success) {
    ElMessage.success(res.data)
  } else {
    ElMessage.error(res.errorMsg)
  }
}

// 使用卡密
const cdKeyFormValidate = ref()
const useCdKey = () => {
  cdKeyFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForCdKey.value = false;
      cdKeyExchangeForm.value.accountID = user.value.accountID
      getUseCdKeyQuest()
    } else {
      ElMessage.warning("请填写卡密")
    }
  })
}

// 刷新余额
const isLatest = ref(false)
const getLatestMallPointsQuest = async () => {
  const res = await getLatestMallPointsApi(user.value.accountID)
  if (res.success) {
    isLatest.value = true;
    user.value.mallPoints = res.data.mallPoints
    user.value.auctionPoint = res.data.auctionPoint
    localStorage.setItem("user-token", JSON.stringify(user.value))
    setTimeout(() => {
      isLatest.value = false;
    }, 3000)
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const onGetLatestMallPointsClick = () => {
  if (isLatest.value) return;
  getLatestMallPointsQuest()
}

// 修改密码验证码
const sendCodeQuest = async () => {
  const res = await sendCode(user.value.email)
  passwordForm.value.code = res.data.code;
  // 存入uuid
  passwordForm.value.uuid = res.data.uuid
  localStorage.setItem('uuid', res.data.uuid)
}
const isClickSendCode = ref(true)
const sendCodeText = ref('获取')
const onSendCodeClick = () => {
  if (isClickSendCode.value) {
    isClickSendCode.value = false;
    ElMessage.success("获取成功")
    sendCodeQuest()
    sendCodeText.value = '10s'
    let count = 10;
    const timer = setInterval(() => {
      count--;
      if (count > 0) {
        sendCodeText.value = `${count}s`;
      } else {
        clearInterval(timer);
        sendCodeText.value = '获取';
      }
    }, 1000);
  } else {
    ElMessage.warning("请勿重复获取验证码")
  }
}
</script>

<template>
  <div id="me">
    <el-row v-if="user">
      <el-col :span="8" style="padding-left: 300px; padding-bottom: 250px">
        <el-card class="box-card grid-content bg-purple me is-always-shadow">
          <div class="el-card__body">
            账号：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.username }}</el-tag>
            <div style="height: 5px;"></div>
            状态：
            <template v-if="user.accStatus === 'active'">
              <el-tag class="el-tag--success el-tag--light" style="font-size: 15px;"> 正常</el-tag>
              <div style="height: 5px;"></div>
            </template>
            <template v-else>
              <el-tag class="el-tag--error el-tag--light" style="font-size: 15px;"> 封禁</el-tag>
              <div style="height: 5px;"></div>
            </template>
            邮箱：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.email }}</el-tag>
            <div style="height: 5px;"></div>
            余额<img src="/me/cash.png" alt="" style="margin-left: 3px">：
            <el-tooltip content="若不同步请点击刷新按钮">
              <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.mallPoints }}</el-tag>
            </el-tooltip>
            <el-button size="small" type="info" style="margin-left: 10px"
                       @click="onGetLatestMallPointsClick">刷新
            </el-button>
            <div style="height: 5px;"></div>
            现金扭蛋币<img src="/me/cashcoin.png" alt="" style="margin-left: 3px">：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.waguCoins }}</el-tag>
            <div style="height: 5px;"></div>
            活动扭蛋币<img src="/me/eventcoin.png" alt="" style="margin-left: 3px">：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.eventCoins }}</el-tag>
            <div style="height: 5px;"></div>
            拍卖点数<img src="/me/P币.png" alt="" style="margin-left: 3px; width: 20px; height: 20px">：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.auctionPoint }}</el-tag>
            <div style="height: 15px;"></div>
            <div style="height: 35px;">
              <el-button class="el-button--primary el-button--mini" style="width: 100%;" @click="showPasswordForm">
                修改密码
              </el-button>
            </div>
            <div style="height: 35px;">
              <el-button class="el-button--warning el-button--mini" style="width: 100%;" @click="onBuyCardClick">
                购买卡密
              </el-button>
            </div>
            <div style="height: 35px;">
              <el-button class="el-button--success el-button--mini" style="width: 100%;" @click="showCdKeyExchangeForm">
                卡密兑换
              </el-button>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col v-if="tableData != null" :span="13" style="padding-left: 10px; padding-right: 10px; margin-top: 40px">
        <el-card class="grid-content bg-purple is-always-shadow">
          <div class="el-card__body">
            <el-table :data="currentPageData" style="width: 100%;" stripe fit :current-page="currentPage"
                      :page-size="pageSize" :total="tableData.length" v-loading="loading">
              <el-table-column label="角色" prop="charName" align="center"></el-table-column>
              <el-table-column label="等级" prop="level" align="center"></el-table-column>
              <el-table-column label="种族" prop="race" align="center">
                <template #default="scope">
                  <span v-if="scope.row.race === 0">人类</span>
                  <span v-else-if="scope.row.race === 1">娜美克</span>
                  <span v-else-if="scope.row.race === 2">魔人</span>
                  <span v-else>未知</span>
                </template>
              </el-table-column>
              <el-table-column label="职业" prop="dboClass" align="center" width="130px">
                <template #default="{ row }">
                  <span v-if="row.dboClass === 0" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/1_small.png" alt=""/>
                    <span style="margin-left: 10px">武道家</span>
                  </span>
                  <span v-else-if="row.dboClass === 1" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/2_small.png" alt=""/>
                    <span style="margin-left: 10px">气功师</span>
                  </span>
                  <span v-else-if="row.dboClass === 3" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/3_small.png" alt=""/>
                    <span style="margin-left: 10px">那美克战士</span>
                  </span>
                  <span v-else-if="row.dboClass === 4" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/4_small.png" alt=""/>
                    <span style="margin-left: 10px">那美克龙族</span>
                  </span>
                  <span v-else-if="row.dboClass === 5" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/5_small.png" alt=""/>
                    <span style="margin-left: 10px">大魔人</span>
                  </span>
                  <span v-else-if="row.dboClass === 6" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/6_small.png" alt=""/>
                    <span style="margin-left: 10px">意魔人</span>
                  </span>
                  <span v-else-if="row.dboClass === 7" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/11_small.png" alt=""/>
                    <span style="margin-left: 10px">格斗家</span>
                  </span>
                  <span v-else-if="row.dboClass === 9" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/12_small.png" alt=""/>
                    <span style="margin-left: 10px">鹤仙流</span>
                  </span>
                  <span v-else-if="row.dboClass === 13" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/13_small.png" alt=""/>
                    <span style="margin-left: 10px">魔界战士</span>
                  </span>
                  <span v-else-if="row.dboClass === 15" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/14_small.png" alt=""/>
                    <span style="margin-left: 10px">天天导师</span>
                  </span>
                  <span v-else-if="row.dboClass === 17" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/15_small.png" alt=""/>
                    <span style="margin-left: 10px">奥迪魔</span>
                  </span>
                  <span v-else-if="row.dboClass === 19" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/16_small.png" alt=""/>
                    <span style="margin-left: 10px">普利兹魔</span>
                  </span>
                  <span v-else-if="row.dboClass === 8" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/17_small.png" alt=""/>
                    <span style="margin-left: 10px">剑术家</span>
                    </span>
                  <span v-else-if="row.dboClass === 10" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/18_small.png" alt=""/>
                    <span style="margin-left: 10px">龟仙流</span>
                    </span>
                  <span v-else-if="row.dboClass === 14" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/19_small.png" alt=""/>
                    <span style="margin-left: 10px">魔导战士</span>
                  </span>
                  <span v-else-if="row.dboClass === 16" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/20_small.png" alt=""/>
                    <span style="margin-left: 10px">波可导师</span>
                  </span>
                  <span v-else-if="row.dboClass === 18" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/21_small.png" alt=""/>
                    <span style="margin-left: 10px">格兰魔</span>
                  </span>
                  <span v-else-if="row.dboClass === 20" class="me-icon">
                    <img src="/MyHTML/skill-web/img/skill/22_small.png" alt=""/>
                    <span style="margin-left: 10px">卡尔魔</span>
                  </span>
                  <span v-else>未知</span>
                </template>
              </el-table-column>
              <el-table-column label="性别" prop="gender" align="center">
                <template #default="scope">
                  <span v-if="scope.row.gender === 0">男</span>
                  <span v-else-if="scope.row.gender === 1">女</span>
                  <span v-else-if="scope.row.gender === 2">那美克</span>
                  <span v-else>未知</span>
                </template>
              </el-table-column>
              <el-table-column label="流派" prop="guildName" align="center"></el-table-column>
            </el-table>
          </div>
        </el-card>
        <div style="display: flex; justify-content: flex-end;">
          <el-pagination v-model="currentPage" :page-sizes="[10]" :page-size="pageSize"
                         :total="tableData.length" layout="prev, pager, next, total"
                         @size-change="handleSizeChange" @update:current-page="handleClick"
                         @prev-click="handleClick" @next-click="handleClick">
          </el-pagination>
        </div>
      </el-col>
    </el-row>
  </div>
  <!-- 修改密码对话框 -->
  <el-dialog v-model="dialogVisible" title="修改密码" width="350px">
    <el-form ref="passwordFormValidate" :model="passwordForm" label-position="top" :rules="passwordRules">
      <div class="form-row">
        <span class="label">原密码</span>
        <el-form-item class="myInput" prop="oldPassword">
          <el-input style="height: 40px;" type="password" placeholder="请输入原密码"
                    v-model="passwordForm.oldPassword"></el-input>
        </el-form-item>
      </div>
      <div class="form-row">
        <span class="label">新密码</span>
        <el-form-item class="myInput" prop="newPassword">
          <el-input style="height: 40px;" type="password" placeholder="请输入新密码"
                    v-model="passwordForm.newPassword"></el-input>
        </el-form-item>
      </div>
      <div class="form-row">
        <span class="label">确认密码</span>
        <el-form-item class="myInput" prop="confirmPassword">
          <el-input style="height: 40px;" type="password" placeholder="请确认密码"
                    v-model="passwordForm.confirmPassword"></el-input>
        </el-form-item>
      </div>
      <div class="form-row-code" v-if="isOpenEmailCheck">
        <span class="label">验证码</span>
        <el-form-item class="myInput" prop="code" v-if="isOpenEmailCheck">
          <el-input style="height: 40px; width: 120px" type="text" placeholder="请输入验证码"
                    v-model="passwordForm.code"></el-input>
          <el-button type="default" size="large" style="margin-left: 4px" @click="onSendCodeClick">{{
              sendCodeText
            }}
          </el-button>
        </el-form-item>
      </div>
      <div class="form-row" style="justify-content: flex-end; margin-top: 20px;">
        <el-button type="default" style="width: 70px; height: 40px" @click="cancelPassword">取消</el-button>
        <el-button type="primary" style="background-color: #3388FF; color: #FFFFFF;height: 40px;" @click="savePassword">
          确认修改
        </el-button>
      </div>
    </el-form>
  </el-dialog>
  <!-- 兑换卡密对话框 -->
  <el-dialog v-model="dialogVisibleForCdKey" title="兑换卡密" width="440px">
    <el-form ref="cdKeyFormValidate" :model="cdKeyExchangeForm" label-position="top" :rules="cDKeyRules">
      <div class="form-row">
        <span class="cdKeyLabel">卡密</span>
        <el-form-item class="myInput" prop="cdKey">
          <el-input style="height: 40px; width: 330px" type="text" placeholder="请输入卡密"
                    v-model="cdKeyExchangeForm.cdKey"></el-input>
        </el-form-item>
      </div>
      <div class="form-row" style="justify-content: flex-end; margin-top: 20px;">
        <el-button type="default" style="width: 70px; height: 40px" @click="cancelCdKeyExchange">取消</el-button>
        <el-button type="primary" style="background-color: #3388FF; color: #FFFFFF;height: 40px;" @click="useCdKey">
          确认兑换
        </el-button>
      </div>
    </el-form>
  </el-dialog>
</template>

<style scoped lang="scss">
.me {
  margin-top: 40px;
  margin-bottom: 164px;
}

.el-tag {
  user-select: text; /* 允许选择文本 */
}

.form-row {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
  margin-right: 15px;
}

.form-row-code {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
  margin-right: 15px;
}

.label {
  width: 60px;
  text-align: right;
  margin-bottom: 10px;
  margin-left: 25px;
  font-size: 15px;
}

.myInput {
  margin-left: 18px;
}

.cdKeyLabel {
  width: 50px;
  text-align: right;
  margin-bottom: 15px;
  font-size: 15px;
}

.me-icon{
  display: flex;
  align-items: center;
  margin-left: 5px;
}
</style>