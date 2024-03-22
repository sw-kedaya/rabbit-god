<script setup>
import {useRouter} from "vue-router";
import {ElMessage, ElMessageBox} from "element-plus";
import {computed, onMounted, ref, watch} from "vue";
import {adminGetCharacterList, adminUpdateCharacter} from "@/apis/charManagement";

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
    adminGetCharacterListQuest();
  }
})

// ---------------角色管理部分js----------------------------------------------------------------------------------
// 角色信息搜索框基本属性
const characterName = ref('')
const characterGuildName = ref('')
const characterIsOnline = ref('')
const characterIsOnlineOptions = ref([
  {id: 1, label: '在线', value: 1},
  {id: 2, label: '离线', value: 0},
])
// 角色信息分页基本属性
const currentPageForCharacter = ref(1);
const pageSizeForCharacter = ref(10);
const startIndexForCharacter = ref(0);
const endIndexForCharacter = ref(0);
const currentPageDataForCharacter = ref([]);

// 角色信息分页信息基本函数
function handleSizeChangeForCharacter(newSize) {
  pageSizeForCharacter.value = newSize;
  updatePaginationForCharacter();
}

function handleClickForCharacter(newCurrentPage) {
  currentPageForCharacter.value = newCurrentPage;
  updatePaginationForCharacter();
}

const characterData = ref([])
const adminGetCharacterListQuest = async () => {
  const res = await adminGetCharacterList()
  characterData.value = res.data
  currentPageDataForCharacter.value = characterData.value
  totalDataForCharacter.value = currentPageDataForCharacter.value.length
  updatePaginationForCharacter()
}

const totalDataForCharacter = computed(() => filteredDataForCharacter.value);
const filteredDataForCharacter = computed(() => {
  let filteredData = [...characterData.value]; // 初始为完整的角色数据（[...]是浅拷贝，不会影响原数据）

  if (characterName.value !== '') {
    filteredData = filteredData.filter(item => item.charName.includes(characterName.value));
  }
  if (characterGuildName.value !== '') {
    filteredData = filteredData.filter(item => item.guildName.includes(characterGuildName.value));
  }
  if (characterIsOnline.value !== '') {
    filteredData = filteredData.filter(item => item.isOnline === characterIsOnline.value);
  }

  if (characterName.value === '' && characterGuildName.value === '' && characterIsOnline.value === '') {
    filteredData = characterData.value; // 如果没有任何筛选条件，则显示所有数据
  }

  currentPageDataForCharacter.value = filteredData;
  const total = currentPageDataForCharacter.value.length;
  updatePaginationBySelfForCharacter(); // 分页后渲染
  return total;
});
// 当characterData有数据，就触发分页
watch(characterData, () => {
  updatePaginationForCharacter();
});

function updatePaginationForCharacter() {
  startIndexForCharacter.value = (currentPageForCharacter.value - 1) * pageSizeForCharacter.value;
  endIndexForCharacter.value = Math.min(startIndexForCharacter.value + pageSizeForCharacter.value - 1, characterData.value.length - 1);
  currentPageDataForCharacter.value = characterData.value.slice(startIndexForCharacter.value, endIndexForCharacter.value + 1);
}

function updatePaginationBySelfForCharacter() {
  startIndexForCharacter.value = (currentPageForCharacter.value - 1) * pageSizeForCharacter.value;
  endIndexForCharacter.value = Math.min(startIndexForCharacter.value + pageSizeForCharacter.value - 1, currentPageDataForCharacter.value.length - 1);
  currentPageDataForCharacter.value = currentPageDataForCharacter.value.slice(startIndexForCharacter.value, endIndexForCharacter.value + 1);
}

// 编辑角色（姓名、等级、索尼）
const updateForm = ref({
  charID: '',
  charName: '',
  level: '',
  money: '',
})
const updateRules = {
  charName: [{required: true, message: '请输入角色名'}],
  level: [{required: true, message: '请输入等级'}, {
    validator: (rule, value) => {
      return value >= 0;
    }, message: '不能为负数'
  },],
  money: [{required: true, message: '请输入索尼'}, {
    validator: (rule, value) => {
      return value >= 0;
    }, message: '不能为负数'
  },],
};
const dialogVisibleForUpdateRules = ref(false)
const showUpdate = (row) => {
  dialogVisibleForUpdateRules.value = true;
  updateForm.value.charID = row.charID; // 把角色主键存起来
  updateForm.value.charName = row.charName;
  updateForm.value.level = row.level;
  updateForm.value.money = row.money;
}
const cancelUpdateExchange = () => {
  dialogVisibleForUpdateRules.value = false;
  updateForm.value = {};
}
const updateFormValidate = ref();
const adminUpdateCharacterQuest = async () => {
  const res = await adminUpdateCharacter(updateForm.value);
  if (res.success) {
    ElMessage.success("编辑成功");
    updateForm.value = {};
    adminGetCharacterListQuest();
  } else {
    ElMessage.error(res.errorMsg);
  }
}
const updateSubmit = () => {
  updateFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForUpdateRules.value = false;
      adminUpdateCharacterQuest()
    } else {
      ElMessage.warning("请编辑信息")
    }
  })
}

</script>

<template>
  <div>
    <el-input v-model="characterName" size="large" placeholder="角色名"
              style="width: 222px; margin-right: 5px"/>
    <el-input v-model="characterGuildName" size="large" placeholder="流派名"
              style="width: 222px; margin-right: 5px"/>
    <el-select v-model="characterIsOnline" size="large" class="m-2" placeholder="状态" clearable
               style="margin-right: 5px">
      <el-option v-for="item in characterIsOnlineOptions" :key="item.id" :label="item.label"
                 :value="item.value"/>
    </el-select>
  </div>
  <el-table :data="currentPageDataForCharacter" border style="width: 100%;" max-height="618" size="large">
    <el-table-column prop="charName" label="角色名" width="160"/>
    <el-table-column prop="accountID" label="所属用户ID" width="105"/>
    <el-table-column prop="level" label="等级" width="70"/>
    <el-table-column prop="dboClassName" label="职业" width="110"/>
    <el-table-column prop="guildName" label="流派名" width="160">
      <template #default="{ row }">
        {{ row.guildName || '无' }}
      </template>
    </el-table-column>
    <el-table-column prop="createTime" label="创建时间" width="180"/>
    <el-table-column prop="ip" label="最后游玩IP" width="145"/>
    <el-table-column prop="money" label="索尼余额" width="150"/>
    <el-table-column prop="playTime" label="游玩时长(小时)" width="150"/>
    <el-table-column prop="isOnline" label="是否在线" width="90">
      <template #default="{ row }">
        <span v-if="row.isOnline === 1" style="color: #13ce66">在线</span>
        <span v-else style="color: #8c8181">离线</span>
      </template>
    </el-table-column>
    <el-table-column fixed="right" label="操作">
      <template #default="scope">
        <el-button type="primary" size="default" @click="showUpdate(scope.row)">编辑
        </el-button>
      </template>
    </el-table-column>
  </el-table>
  <!--  分页  -->
  <div class="pagination-row">
    <el-pagination v-model="currentPageForCharacter" :page-sizes="[10]" :page-size="pageSizeForCharacter"
                   :total="totalDataForCharacter" layout="prev, pager, next,total"
                   @size-change="handleSizeChangeForCharacter" @update:current-page="handleClickForCharacter"
                   @prev-click="handleClickForCharacter" @next-click="handleClickForCharacter">
    </el-pagination>
  </div>
  <!--  修改对话框  -->
  <el-dialog v-model="dialogVisibleForUpdateRules" title="编辑信息" width="320">
    <el-form ref="updateFormValidate" :model="updateForm" label-position="top" :rules="updateRules"
             @submit.prevent="">
      <div class="mall-form-row">
        <span class="mall-dialogLabel">角色名</span>
        <el-form-item class="mall-myInput" prop="charName">
          <el-input style="height: 38px; width: 180px;" type="text" placeholder="请输入角色名"
                    v-model="updateForm.charName"></el-input>
        </el-form-item>
      </div>
      <div class="mall-form-row">
        <span class="mall-dialogLabel">等级</span>
        <el-form-item class="mall-myInput" prop="level">
          <el-input style="height: 38px; width: 180px;" type="text" placeholder="请输入等级"
                    v-model="updateForm.level"></el-input>
        </el-form-item>
      </div>
      <div class="mall-form-row">
        <span class="mall-dialogLabel">索尼</span>
        <el-form-item class="mall-myInput" prop="money">
          <el-input style="height: 38px; width: 180px;" type="text" placeholder="请输入索尼"
                    v-model="updateForm.money"></el-input>
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