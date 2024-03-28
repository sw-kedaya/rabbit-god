<script setup>
import {useRouter} from "vue-router";
import {ElMessage} from "element-plus";
import {onMounted, ref, watch} from "vue";
import {userGetAuctionOrder} from "@/apis/auctionHouse";

const router = useRouter()
// 查询订单
const orders = ref([])
// 新增加载组件
const loading = ref(true)
const userGetAuctionOrderQuest = async () => {
  const res = await userGetAuctionOrder()
  if (res.success) {
    orders.value = res.data;
    loading.value = false;
  } else {
    ElMessage.error(res.errorMsg)
  }
}

// 分页
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
  totalPage.value = Math.ceil(orders.value.length / pageSize.value);
  startIndex.value = (currentPage.value - 1) * pageSize.value;
  endIndex.value = Math.min(startIndex.value + pageSize.value - 1, orders.value.length - 1);
  currentPageData.value = orders.value.slice(startIndex.value, endIndex.value + 1);
}

// 当orders有数据，就触发分页
watch(orders, () => {
  updatePagination();
});

const user = ref()
onMounted(() => {
  // 进入前先判断登录没
  user.value = JSON.parse(localStorage.getItem("user-token"))
  if (user.value == null) {
    router.push('/login')
    return;
  }
  userGetAuctionOrderQuest()
})

</script>

<template>
  <div class="order-list-container">
    <h2 class="order-list-title">拍卖订单</h2>
    <el-table :data="currentPageData" style="width: 75%; font-size: 15px;" v-loading="loading"
              :cell-style="{textAlign: 'center'}" align="center" :border="true"
              :current-page="currentPage" :page-size="pageSize" :total="orders.length" stripe>
      <el-table-column prop="id" label="订单编号" width="230px">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="mallName" label="商品名称" width="300px">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="charName" label="竞拍角色" width="170px">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.charName || "无" }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="竞拍时间" width="180px">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="price" label="竞拍价" width="150px">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="successPrice" label="成功竞价" width="150px">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="status" label="拍卖状态">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            <span v-if="scope.row.status === 'ongoing'">进行中</span>
            <span v-else-if="scope.row.status === 'failed'" style="color: red">失败</span>
            <span v-else-if="scope.row.status === 'success'" style="color: #13ce66;">成功</span>
          </div>
        </template>
      </el-table-column>
    </el-table>
  </div>
  <div class="pagination-container">
    <el-pagination v-model="currentPage" :page-sizes="[10]" :page-size="pageSize"
                   :total="orders.length" layout="prev, pager, next,total"
                   @size-change="handleSizeChange" @update:current-page="handleClick"
                   @prev-click="handleClick" @next-click="handleClick">
    </el-pagination>
  </div>
</template>

<style scoped>
.pagination-container {
  display: flex;
  justify-content: flex-end;
  position: absolute;
  bottom: 190px;
  right: 258px;
}

.order-list-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  height: 825px;
}

.order-list-title {
  margin-top: 40px;
  margin-bottom: 20px;
  font-size: 24px;
  text-align: center;
}

.cell-wrapper {
  padding: 5px;
  text-align: center;
}

.header-wrapper {
  padding: 5px;
  text-align: center;
}
</style>