<script setup>
import {useRouter} from "vue-router";
import {ElMessage} from "element-plus";
import {onMounted, ref, watch} from "vue";
import {getMallOrderByUserId} from "@/apis/mallOrder";

const router = useRouter()
// 查询订单
const orders = ref([])
const getMallOrderByUserIdQuest = async () => {
  const res = await getMallOrderByUserId(user.value.accountID)
  if (res.success) {
    orders.value = res.data
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
  getMallOrderByUserIdQuest()
})

</script>

<template>
  <div class="order-list-container">
    <h2 class="order-list-title">商城订单</h2>
    <el-table :data="currentPageData" style="width: 75%; font-size: 15px;"
              :cell-style="{textAlign: 'center'}" align="center" :border="true"
              :current-page="currentPage" :page-size="pageSize" :total="orders.length" stripe>
      <el-table-column prop="id" label="订单编号" width="230%">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.id }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="mallName" label="商品名称" width="200%">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.mallName }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="mallDesc" label="商品描述" width="300%">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.mallDesc }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="price" label="价格">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.price }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="charName" label="角色名" width="350%">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.charName }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="buyTime" label="购买时间" width="200%">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.buyTime }}
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