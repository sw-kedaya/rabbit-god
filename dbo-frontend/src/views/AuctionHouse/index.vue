<script setup>
import {useRouter} from "vue-router";
import {ElMessage, ElMessageBox} from "element-plus";
import {computed, onMounted, ref, watch} from "vue";
import {getListForUser} from "@/apis/auctionHouse"

const router = useRouter()
const user = ref()
const admin = ref()
onMounted(() => {
  getListForUserQuest();
});

// 获取拍卖列表
const auctionData = ref([]);
const loading = ref(true)
const getListForUserQuest = async () => {
  const res = await getListForUser();
  res.data.map(i => i.mallIcon = "data:image/gif;base64," + i.image);
  auctionData.value = res.data;
  loading.value = false;
}
</script>

<template>
  <div class="my-table-auction">
    <el-table :data="auctionData" border stripe size="large"
              style="width: 70%;" v-loading="loading"
              :cell-style="{textAlign: 'center'}">
      <el-table-column prop="mallName" label="竞拍物品" width="270">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
        <template #default="{ row }">
          <div style="display: flex; align-items: center;">
            <img :src="row.mallIcon" alt="" style="margin-right: 10px">
            <span style="text-align: center;">{{ row.mallName }}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="shelfTime" label="上架时间" width="180">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
      </el-table-column>
      <el-table-column prop="endTime" label="结束时间" width="180">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
      </el-table-column>
      <el-table-column prop="startingPrice" label="起拍价格" width="150">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
      </el-table-column>
      <el-table-column prop="lowestMakeup" label="最低加价" width="150">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
      </el-table-column>
      <el-table-column prop="currentPrice" label="当前竞价" width="150">
        <template #header="{ column }">
          <div class="my-table-auction-header">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div style="color: #cf4444">
            {{ scope.row.currentPrice }}
          </div>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="参与竞拍">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
        <template #default="scope">
          <el-button type="text" size="default" @click="showUpdateExchangeForm(scope.row)">竞拍
          </el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<style scoped>
.my-table-auction {
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: transparent;
  margin-top: 10px;
  margin-bottom: 10px;
}

.my-table-auction-header {
  text-align: center;
}


.rank-icon-auction {
  display: flex;
  align-items: center;
}
</style>