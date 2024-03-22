<script setup>
import {useRouter} from "vue-router";
import {ElMessage, ElMessageBox} from "element-plus";
import {computed, onMounted, ref, watch} from "vue";
import {adminGetListApi, adminUpdateBalance, blockedAccount, unblockedAccount} from "@/apis/accountManagement";

const router = useRouter()
const user = ref()
const admin = ref()
onMounted(() => {
  // 进入前先判断是否等于且为管理员
  user.value = JSON.parse(localStorage.getItem("user-token"))
  if (user.value == null) {
    router.push('/login')
    return;
  }
  if (user.value.admin !== 10) {
    router.push('/home')
    return;
  }
  admin.value = localStorage.getItem("admin-token")
  if (admin.value === 'admin') {
    // 其他初始化
    adminGetListQuest();
  }
})

// ---------------用户管理部分js----------------------------------------------------------------------------------
// 用户信息搜索框基本属性
const accountIDForFind = ref('')
const accountName = ref('')
const accountEmail = ref('')
const accountAccStatus = ref('')
const accountAccStatusOptions = ref([
  {id: 1, label: '正常', value: 'active'},
  {id: 2, label: '封禁', value: 'block'},
])
// 用户信息分页基本属性
const currentPageForAccount = ref(1);
const pageSizeForAccount = ref(10);
const startIndexForAccount = ref(0);
const endIndexForAccount = ref(0);
const currentPageDataForAccount = ref([]);

// 用户信息分页信息基本函数
function handleSizeChangeForAccount(newSize) {
  pageSizeForAccount.value = newSize;
  updatePaginationForAccount();
}

function handleClickForAccount(newCurrentPage) {
  currentPageForAccount.value = newCurrentPage;
  updatePaginationForAccount();
}

const accountData = ref([])
const adminGetListQuest = async () => {
  const res = await adminGetListApi()
  accountData.value = res.data
  currentPageDataForAccount.value = accountData.value
  totalDataForAccount.value = currentPageDataForAccount.value.length
  updatePaginationForAccount()
}

const totalDataForAccount = computed(() => filteredDataForAccount.value);
const filteredDataForAccount = computed(() => {
  let filteredData = [...accountData.value]; // 初始为完整的用户数据（[...]是浅拷贝，不会影响原数据）

  if (accountIDForFind.value !== '') {
    filteredData = filteredData.filter(item => item.accountID.includes(accountIDForFind.value));
  }
  if (accountName.value !== '') {
    filteredData = filteredData.filter(item => item.username.includes(accountName.value));
  }
  if (accountEmail.value !== '') {
    filteredData = filteredData.filter(item => item.email.includes(accountEmail.value));
  }
  if (accountAccStatus.value !== '') {
    filteredData = filteredData.filter(item => item.accStatus === accountAccStatus.value);
  }

  if (accountIDForFind.value === '' && accountName.value === '' && accountEmail.value === '' &&
      accountAccStatus.value === '') {
    filteredData = accountData.value; // 如果没有任何筛选条件，则显示所有数据
  }

  currentPageDataForAccount.value = filteredData;
  const total = currentPageDataForAccount.value.length;
  updatePaginationBySelfForAccount(); // 分页后渲染
  return total;
});
// 当accountData有数据，就触发分页
watch(accountData, () => {
  updatePaginationForAccount();
});

function updatePaginationForAccount() {
  startIndexForAccount.value = (currentPageForAccount.value - 1) * pageSizeForAccount.value;
  endIndexForAccount.value = Math.min(startIndexForAccount.value + pageSizeForAccount.value - 1, accountData.value.length - 1);
  currentPageDataForAccount.value = accountData.value.slice(startIndexForAccount.value, endIndexForAccount.value + 1);
}

function updatePaginationBySelfForAccount() {
  startIndexForAccount.value = (currentPageForAccount.value - 1) * pageSizeForAccount.value;
  endIndexForAccount.value = Math.min(startIndexForAccount.value + pageSizeForAccount.value - 1, currentPageDataForAccount.value.length - 1);
  currentPageDataForAccount.value = currentPageDataForAccount.value.slice(startIndexForAccount.value, endIndexForAccount.value + 1);
}

// 封禁用户相关
const blockedAccountQuest = async (id) => {
  const res = await blockedAccount(id);
  if (res.success) {
    ElMessage.success("封禁成功");
    adminGetListQuest();
  } else {
    ElMessage.error(res.errorMsg);
  }
}
const submitBlockedAccount = (id) => {
  ElMessageBox.confirm("确定要封禁该用户吗？", "提示", {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    blockedAccountQuest(id);
  }).catch(() => {
    ElMessage.info("取消封禁")
  });
}
// 解封用户相关
const unblockedAccountQuest = async (id) => {
  const res = await unblockedAccount(id);
  if (res.success) {
    ElMessage.success("解封成功");
    adminGetListQuest();
  } else {
    ElMessage.error(res.errorMsg);
  }
}
const showDeBlockedForm = (id) => {
  ElMessageBox.confirm("确定要解封该用户吗？", "提示", {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    unblockedAccountQuest(id);
  }).catch(() => {
    ElMessage.info("取消解封")
  });
}

// 编辑余额窗口
const updateForm = ref({
  mallPoints: '',
  waguCoins: '',
  eventCoins: '',
  accountID: '',
})
const updateRules = {
  mallPoints: [{required: true, message: '请输入C点余额'}, {
    validator: (rule, value) => {
      return value >= 0;
    }, message: '不能为负数'
  },],
  waguCoins: [{required: true, message: '请输入现金扭蛋币数量'}, {
    validator: (rule, value) => {
      return value >= 0;
    }, message: '不能为负数'
  },],
  eventCoins: [{required: true, message: '请输入活动扭蛋币数量'}, {
    validator: (rule, value) => {
      return value >= 0;
    }, message: '不能为负数'
  },],
};

const dialogVisibleForUpdateRules = ref(false)
const showUpdateExchangeForm = (row) => {
  dialogVisibleForUpdateRules.value = true;
  // 打开前回显数据
  updateForm.value.mallPoints = row.mallPoints;
  updateForm.value.waguCoins = row.waguCoins;
  updateForm.value.eventCoins = row.eventCoins;
  updateForm.value.accountID = row.accountID;
};
const cancelUpdateExchange = () => {
  dialogVisibleForUpdateRules.value = false;
  updateForm.value = {};
}
const updateFormValidate = ref() // 用于判断用户是否填写了表单

const adminUpdateBalanceQuest = async () => {
  const res = await adminUpdateBalance(updateForm.value)
  if (res.success) {
    updateForm.value = {};
    adminGetListQuest()
    ElMessage.success('修改成功')
  } else {
    ElMessage.error(res.errorMsg);
  }
}
const updateSubmit = () => {
  updateFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForUpdateRules.value = false;
      adminUpdateBalanceQuest()
    } else {
      ElMessage.warning("请输入信息")
    }
  })
}


</script>

<template>
  <div>
    <el-input v-model="accountIDForFind" size="large" placeholder="用户ID"
              style="width: 100px; margin-right: 5px"/>
    <el-input v-model="accountName" size="large" placeholder="用户账号"
              style="width: 150px; margin-right: 5px"/>
    <el-input v-model="accountEmail" size="large" placeholder="用户邮箱"
              style="width: 170px; margin-right: 5px"/>
    <el-select v-model="accountAccStatus" size="large" class="m-2" placeholder="状态" clearable
               style="margin-right: 5px">
      <el-option v-for="item in accountAccStatusOptions" :key="item.id" :label="item.label"
                 :value="item.value"/>
    </el-select>
  </div>
  <el-table :data="currentPageDataForAccount" border style="width: 100%;" max-height="618" size="large">
    <el-table-column prop="accountID" label="用户ID" width="102"/>
    <el-table-column prop="username" label="用户账号" width="153"/>
    <el-table-column prop="email" label="用户邮箱" width="180"/>
    <el-table-column prop="mallPoints" label="C点" width="105"/>
    <el-table-column prop="waguCoins" label="现金扭蛋币" width="105"/>
    <el-table-column prop="eventCoins" label="活动扭蛋币" width="105"/>
    <el-table-column prop="regDate" label="注册时间" width="180"/>
    <el-table-column prop="regIp" label="注册IP" width="145"/>
    <el-table-column prop="lastLogin" label="游戏最后登录时间" width="180"/>
    <el-table-column prop="lastIp" label="游戏最后登录IP" width="145"/>
    <el-table-column prop="accStatus" label="状态" width="80">
      <template #default="{ row }">
        <span v-if="row.accStatus === 'active'" style="color: #13ce66">正常</span>
        <span v-else style="color: #cf4444">封禁</span>
      </template>
    </el-table-column>
    <el-table-column fixed="right" label="操作">
      <template #default="scope">
        <el-button type="primary" size="default" @click="showUpdateExchangeForm(scope.row)">编辑
        </el-button>
        <el-button type="danger" size="default" @click="submitBlockedAccount(scope.row.accountID)"
                   v-if="scope.row.accStatus !== 'block'">封禁该用户
        </el-button>
        <el-button type="info" size="default" @click="showDeBlockedForm(scope.row.accountID)"
                   v-else>解封
        </el-button>
      </template>
    </el-table-column>
  </el-table>
  <!--  分页  -->
  <div class="pagination-row">
    <el-pagination v-model="currentPageForAccount" :page-sizes="[10]" :page-size="pageSizeForAccount"
                   :total="totalDataForAccount" layout="prev, pager, next,total"
                   @size-change="handleSizeChangeForAccount" @update:current-page="handleClickForAccount"
                   @prev-click="handleClickForAccount" @next-click="handleClickForAccount">
    </el-pagination>
  </div>
  <!--  修改对话框  -->
  <el-dialog v-model="dialogVisibleForUpdateRules" title="编辑信息" width="300">
    <el-form ref="updateFormValidate" :model="updateForm" label-position="top" :rules="updateRules"
             @submit.prevent="">
      <div class="mall-form-row">
        <span class="mall-dialogLabel">C点</span>
        <el-form-item class="mall-myInput" prop="mallPoints">
          <el-input style="height: 38px; width: 150px;" type="text" placeholder="请输入C点余额"
                    v-model="updateForm.mallPoints"></el-input>
        </el-form-item>
      </div>
      <div class="mall-form-row">
        <span class="mall-dialogLabel">现金扭蛋币</span>
        <el-form-item class="mall-myInput" prop="waguCoins">
          <el-input style="height: 38px; width: 150px;" type="text" placeholder="请输入现金扭蛋币数量"
                    v-model="updateForm.waguCoins"></el-input>
        </el-form-item>
      </div>
      <div class="mall-form-row">
        <span class="mall-dialogLabel">活动扭蛋币</span>
        <el-form-item class="mall-myInput" prop="eventCoins">
          <el-input style="height: 38px; width: 150px;" type="text" placeholder="请输入活动扭蛋币数量"
                    v-model="updateForm.eventCoins"></el-input>
        </el-form-item>
      </div>
      <div class="mall-form-row" style="justify-content: flex-end; margin-top: 20px;">
        <el-button type="default" style="width: 70px; height: 40px" @click="cancelUpdateExchange">取消
        </el-button>
        <el-button type="primary" style="height: 40px;"
                   @click="updateSubmit">
          保存
        </el-button>
      </div>
    </el-form>
  </el-dialog>
</template>

<style scoped>

</style>