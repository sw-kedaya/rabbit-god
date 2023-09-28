<script setup>
import {useRouter} from "vue-router";
import {checkApi} from "@/apis/account";
import {ElMessage} from "element-plus";
import {onMounted, ref, watch} from "vue";
import {getUserOrderList} from "@/apis/cashKey";

const router = useRouter()

// 判断是否登录
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
        localStorage.removeItem("admin-token")
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

// 查询订单
const orders = ref([])
const getUserOrderListQuest = async () => {
  const res = await getUserOrderList(user.value.accountID)
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
  checkQuest()
  getUserOrderListQuest()
})

</script>

<template>
  <div class="order-list-container">
    <h2 class="order-list-title">卡密订单</h2>
    <el-table :data="currentPageData" style="width: 70%; font-size: 15px;"
              :cell-style="{textAlign: 'center'}" align="center" :border="true"
              :current-page="currentPage" :page-size="pageSize" :total="orders.length">
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
      <el-table-column prop="cdKey" label="卡密" width="340%">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.cdKey }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="cash" label="C点" width="200%">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.cash }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="useTime" label="购买时间">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.createTime }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="useTime" label="使用时间">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.useTime }}
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
  bottom: 180px;
  right: 287px;
}

.order-list-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  height: 738px;
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