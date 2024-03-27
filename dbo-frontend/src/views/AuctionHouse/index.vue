<script setup>
import {useRouter} from "vue-router";
import {ElMessage, ElMessageBox} from "element-plus";
import {onMounted, ref} from "vue";
import {getListForUser, userAttendAuction} from "@/apis/auctionHouse"
import {getLatestMallPointsApi} from "@/apis/account";

const router = useRouter()
const user = ref()
const admin = ref()
onMounted(() => {
  user.value = JSON.parse(localStorage.getItem("user-token"));
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
// 获取用户已有的拍卖订单
const userAuctionOrder = ref([]);

// 参与竞拍
const auctionForm = ref({
  auction: {},
  price: ''
})
const auctionRules = {
  price: [{required: true, message: '请输入竞拍价格'}, {
    validator: (rule, value) => {
      return value >= 0;
    }, message: '不能为负数'
  },],
}
const dialogVisibleForAttendAuction = ref(false)

const showAttendAuction = (row) => {
  if (user.value === null) return ElMessage.warning("请先登录");
  dialogVisibleForAttendAuction.value = true;
  auctionForm.value.auction = row;
}
const cancelAttendAuction = () => {
  dialogVisibleForAttendAuction.value = false;
  auctionForm.value = {};
}
const auctionFormValidate = ref();
const userAttendAuctionQuest = async (auctionId, price) => {
  const res = await userAttendAuction(auctionId, price);
  if (res.success) {
    auctionForm.value = {};
    ElMessage.success("竞拍成功");
    getLatestMallPointsQuest(); //刷新拍卖点余额
    loading.value = true;
    getListForUserQuest();
  } else {
    ElMessage.error(res.errorMsg);
  }
}
const submitAttendAuction = () => {
  auctionFormValidate.value.validate((valid) => {
    if (valid) {
      if (parseInt(auctionForm.value.price) < parseInt(auctionForm.value.auction.currentPrice) +
          parseInt(auctionForm.value.auction.lowestMakeup)) {
        return ElMessage.warning("出价不能低于最低加价");
      }
      if (parseInt(auctionForm.value.price) > parseInt(user.value.auctionPoint)) {
        return ElMessage.warning("拍卖点数不足");
      }
      dialogVisibleForAttendAuction.value = false;
      userAttendAuctionQuest(auctionForm.value.auction.id, auctionForm.value.price);
    }
  });
}
// 竞拍后刷新拍卖点
const getLatestMallPointsQuest = async () => {
  const res = await getLatestMallPointsApi(user.value.accountID)
  user.value.auctionPoint = res.data.auctionPoint
  localStorage.setItem("user-token", JSON.stringify(user.value))
}

</script>

<template>
  <div class="my-table-auction">
    <el-table :data="auctionData" border stripe size="large"
              style="width: 80%; height: 780px" v-loading="loading"
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
      <el-table-column prop="charName" label="当前竞拍者" width="160">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="参与竞拍" v-if="user == null">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
        <template #default="scope">
          <el-button type="text" size="default" @click="showAttendAuction(scope.row)">竞拍
          </el-button>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="参与竞拍" v-if="user != null">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
        <template #default="scope">
          <el-button type="text" size="default" disabled v-if="scope.row.accountID === user.accountID">
            竞拍中
          </el-button>
          <el-button type="text" size="default" @click="showAttendAuction(scope.row)" v-else>
            竞拍
          </el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
  <!-- 参与竞拍窗口 -->
  <!--  修改对话框  -->
  <el-dialog v-model="dialogVisibleForAttendAuction" title="参与竞拍" width="370">
    <el-form ref="auctionFormValidate" :model="auctionForm" label-position="top" :rules="auctionRules"
             @submit.prevent="">
      <div class="auction-house-form-row">
        <span class="auction-house-dialogLabel">竞拍价格</span>
        <el-form-item class="auction-house-myInput" prop="price">
          <el-input style="height: 38px; width: 200px;" type="text" placeholder="请输入竞拍价格"
                    v-model="auctionForm.price"></el-input>
        </el-form-item>
      </div>
      <div class="auction-house-form-row" style="justify-content: flex-end; margin-top: 20px;">
        <el-button type="default" style="width: 70px; height: 40px" @click="cancelAttendAuction">取消
        </el-button>
        <el-button type="primary" style="height: 40px;"
                   @click="submitAttendAuction">
          保存
        </el-button>
      </div>
    </el-form>
  </el-dialog>
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

.auction-house-form-row {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
  margin-right: 15px;
}

.auction-house-myInput {
  margin-left: 18px;
}

.auction-house-dialogLabel {
  width: 100px;
  text-align: right;
  margin-bottom: 15px;
  font-size: 14px;
}
</style>