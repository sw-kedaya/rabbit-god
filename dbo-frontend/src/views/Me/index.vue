<script setup>
import {ref, onMounted, watch} from 'vue';
import {checkApi, updateApi} from "@/apis/account";
import {ElMessage} from "element-plus";
import {useRouter} from "vue-router";
import {getDBOCharListApi} from "@/apis/dboChar";
import {getUseCdKeyApi} from "@/apis/cashKey";

// 修改密码的表单校验
const confirmPasswordValidator = (rule, value, callback) => {
  if (value !== passwordForm.value.newPassword) {
    callback(new Error('两次输入的密码不一致'));
  } else {
    callback();
  }
};

const passwordRules = {
  oldPassword: [
    {required: true, message: '请输入原密码'},
    {min: 6, max: 32, message: '密码长度应为6到32位'}
  ],
  newPassword: [
    {required: true, message: '请输入新密码'},
    {min: 6, max: 32, message: '密码长度应为6到32位'}
  ],
  confirmPassword: [
    {required: true, message: '请确认密码'},
    {min: 6, max: 32, message: '密码长度应为6到32位'},
    {validator: confirmPasswordValidator}
  ]
};

// 兑换卡密的表单校验
const cDKeyRules = {
  cdKey: [
    {required: true, message: '请输入卡密'},
    {min: 32, max: 32, message: '请输入正确的卡密'}
  ]
};

// 验证是否登录
const user = ref()
const dialogVisible = ref(false);
const dialogVisibleForCdKey = ref(false);

const router = useRouter()
const checkQuest = async () => {
  if (user.value != null) {
    const res = await checkApi(user.value.token)
    if (!res.data) {
      {
        router.push('/login')
        ElMessage({
          message: '令牌过期，请重新登录',
          type: 'warning'
        });
        localStorage.removeItem("user-token")
      }
    }
  } else {
    router.push('/login')
    ElMessage({
      message: '请先登录',
      type: 'warning'
    });
  }
}

// 获取用户角色信息
const tableData = ref([]);
const getDBOCharListQuest = async (data) => {
  const res = await getDBOCharListApi(data)
  tableData.value = res.data;
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
  console.log(currentPageData.value)
}

// 当tableData有数据，就触发分页
watch(tableData, () => {
  updatePagination();
});

// 钩子
let updateFlag = ref(true)
onMounted(() => {
  // 进入前先判断登录没
  user.value = JSON.parse(localStorage.getItem("user-token"))
  checkQuest()
  getDBOCharListQuest(user.value.accountID)

  // 120秒只能修改一次密码
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

// 修改密码
const passwordForm = ref({
  username: '',
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
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
const updateTime = 120000;
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
    ElMessage.warning('请120秒后再重试');
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
  if (res.success){
    ElMessage.success(res.data)
  }else {
    ElMessage.error(res.errorMsg)
  }
}

// 使用卡密
const cdKeyFormValidate = ref()
const useCdKey = () => {
  cdKeyFormValidate.value.validate((valid) => {
    if (valid){
      dialogVisibleForCdKey.value = false;
      cdKeyExchangeForm.value.accountID = user.value.accountID
      getUseCdKeyQuest()
    }else {
      ElMessage.warning("请填写卡密")
    }
  })
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
              <el-tag class="el-tag--error el-tag--light" style="font-size: 15px;"> 异常</el-tag>
              <div style="height: 5px;"></div>
            </template>
            邮箱：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.email }}</el-tag>
            <div style="height: 5px;"></div>
            余额：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.mallPoints }}</el-tag>
            <div style="height: 5px;"></div>
            现金扭蛋币：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.waguCoins }}</el-tag>
            <div style="height: 5px;"></div>
            活动扭蛋币：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.eventCoins }}</el-tag>
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
                      :page-size="pageSize" :total="tableData.length">
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
              <el-table-column label="职业" prop="dboClass" align="center">
                <template #default="scope">
                  <span v-if="scope.row.dboClass === 0">武道家</span>
                  <span v-else-if="scope.row.dboClass === 1">气功师</span>
                  <span v-else-if="scope.row.dboClass === 2">工程师</span>
                  <span v-else-if="scope.row.dboClass === 3">那美克战士</span>
                  <span v-else-if="scope.row.dboClass === 4">那美克龙族</span>
                  <span v-else-if="scope.row.dboClass === 5">大魔人</span>
                  <span v-else-if="scope.row.dboClass === 6">意魔人</span>
                  <span v-else-if="scope.row.dboClass === 7">格斗</span>
                  <span v-else-if="scope.row.dboClass === 8">剑术</span>
                  <span v-else-if="scope.row.dboClass === 9">鹤仙流</span>
                  <span v-else-if="scope.row.dboClass === 10">龟仙流</span>
                  <span v-else-if="scope.row.dboClass === 13">魔界</span>
                  <span v-else-if="scope.row.dboClass === 14">魔道</span>
                  <span v-else-if="scope.row.dboClass === 15">天天</span>
                  <span v-else-if="scope.row.dboClass === 16">博客</span>
                  <span v-else-if="scope.row.dboClass === 17">奥迪</span>
                  <span v-else-if="scope.row.dboClass === 18">葛兰</span>
                  <span v-else-if="scope.row.dboClass === 19">普利珠</span>
                  <span v-else-if="scope.row.dboClass === 20">卡尔</span>
                  <span v-else>未知</span>
                </template>
              </el-table-column>
              <el-table-column label="性别" prop="gender" align="center">
                <template #default="scope">
                  <span v-if="scope.row.race === 0">男</span>
                  <span v-else-if="scope.row.race === 1">女</span>
                  <span v-else-if="scope.row.race === 2">那美克</span>
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
  margin-bottom: 78px;
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
</style>