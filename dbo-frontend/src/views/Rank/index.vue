<script setup>
import {ref, onMounted} from "vue"
import {ElMessage} from "element-plus";
import {getActivityRankApi, getMoneyRankApi} from "@/apis/dboChar"

onMounted(()=>{
  getActivityRankQuest()
  getMoneyRankQuest()
})

// 菜单栏部分
const initActiveIndex = ref('1')
const activeIndex = ref('1')
const handleSelect = (key, keyPath) => {
  activeIndex.value = key;
}

// 新增加载组件
const loadingForActivity = ref(true)
const loadingForMoney = ref(true)

// 表格数据-活跃度
const tableDataForActivity = ref()
const getActivityRankQuest = async () => {
  const res = await getActivityRankApi()
  if (res.success){
    tableDataForActivity.value = res.data;
    loadingForActivity.value = false;
  }else {
    ElMessage.error(res.errorMsg)
  }
}
// 表格数据-索尼
const tableDataForMoney = ref()
const getMoneyRankQuest = async () => {
  const res = await getMoneyRankApi()
  if (res.success){
    tableDataForMoney.value = res.data;
    loadingForMoney.value = false;
  }else {
    ElMessage.error(res.errorMsg)
  }
}

</script>

<template>
  <div class="my-rank">
    <div class="my-menu">
      <el-menu
          :default-active="initActiveIndex"
          class="el-menu-demo"
          mode="horizontal"
          @select="handleSelect"
          style="background: transparent; height: 37px">
        <div class="flex-grow"/>
        <el-menu-item index="1"><span class="rank-font-size">活跃排行榜</span></el-menu-item>
        <el-menu-item index="2"><span class="rank-font-size">索尼排行榜</span></el-menu-item>
      </el-menu>
    </div>
    <div v-if="activeIndex === '1'" class="my-table">
      <el-table :data="tableDataForActivity" border stripe size="large"
                style="width: 55%;" v-loading="loadingForActivity"
                :cell-style="{textAlign: 'center'}">
        <el-table-column prop="rank" label="排名" width="70">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="charName" label="角色名" width="260">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="level" label="等级" width="120">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="dboClassName" label="职业" width="140">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="guildName" label="流派" width="260">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
          <template #default="{ row }">
            <div>{{ row.guildName || '无' }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="activity" label="活跃度">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div v-else-if="activeIndex === '2'" class="my-table">
      <el-table :data="tableDataForMoney" border stripe size="large"
                style="width: 55%;" v-loading="loadingForMoney"
                :cell-style="{textAlign: 'center'}">
        <el-table-column prop="rank" label="排名" width="70">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="charName" label="角色名" width="260">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="level" label="等级" width="120">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="dboClassName" label="职业" width="140">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="guildName" label="流派" width="260">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
          <template #default="{ row }">
            <div>{{ row.guildName || '无' }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="money" label="索尼">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<style lang="scss">
.my-rank {

}

.my-menu {
  .flex-grow {
    flex-grow: 0.5;
  }

  .rank-font-size {
    font-size: 16px;
  }
}

.el-menu.el-menu--horizontal {
  border: none !important; /** 去除菜单栏的下划线 **/
}

.my-table {
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: transparent;
  margin-top: 10px;
  margin-bottom: 10px;
}

.my-table-header {
  text-align: center;
}
</style>