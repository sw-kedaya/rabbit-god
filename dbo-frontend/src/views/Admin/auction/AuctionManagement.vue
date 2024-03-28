<script setup>
import {useRouter} from "vue-router";
import {ElMessage, ElMessageBox} from "element-plus";
import {computed, onMounted, ref, watch} from "vue";
import {adminDeleteAuction, adminGetAuctionList, adminSaveAuction, adminUpdateAuction} from "@/apis/auction";

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
    adminGetAuctionListQuest()
  }
})

// 接收父组件传递的商品数据
const {goodsData} = defineProps(['goodsData']);

// 日期组件参数
const shortcuts = [
  {
    text: '今天',
    value: new Date(),
  },
  {
    text: '明天',
    value: () => {
      const date = new Date()
      date.setTime(date.getTime() + 3600 * 1000 * 24)
      return date
    },
  },
  {
    text: '一周后',
    value: () => {
      const date = new Date()
      date.setTime(date.getTime() + 3600 * 1000 * 24 * 7)
      return date
    },
  },
]

// ---------------拍卖商品管理部分js----------------------------------------------------------------------------------
// 拍卖商品信息搜索框基本属性
const auctionName = ref('')
const auctionStatus = ref('')
const auctionStatusOptions = ref([
  {id: 1, label: '未开始', value: 'unstarted'},
  {id: 2, label: '进行中', value: 'ongoing'},
  {id: 3, label: '已结束', value: 'ending'},
])
const auctionGrant = ref('')
const auctionGrantOptions = ref([
  {id: 1, label: '未发放', value: 0},
  {id: 2, label: '已发放', value: 1},
])
// 拍卖商品信息分页基本属性
const currentPageForAuction = ref(1);
const pageSizeForAuction = ref(10);
const startIndexForAuction = ref(0);
const endIndexForAuction = ref(0);
const currentPageDataForAuction = ref([]);

// 拍卖商品信息分页信息基本函数
function handleSizeChangeForAuction(newSize) {
  pageSizeForAuction.value = newSize;
  updatePaginationForAuction();
}

function handleClickForAuction(newCurrentPage) {
  currentPageForAuction.value = newCurrentPage;
  updatePaginationForAuction();
}

const auctionData = ref([])
const adminGetAuctionListQuest = async () => {
  const res = await adminGetAuctionList()
  auctionData.value = res.data;
  auctionData.value.map(i => i.mallIcon = "data:image/gif;base64," + i.image);
  currentPageDataForAuction.value = auctionData.value
  totalDataForAuction.value = currentPageDataForAuction.value.length
  updatePaginationForAuction()
}

const totalDataForAuction = computed(() => filteredDataForAuction.value);
const filteredDataForAuction = computed(() => {
  let filteredData = [...auctionData.value]; // 初始为完整的拍卖商品数据（[...]是浅拷贝，不会影响原数据）

  if (auctionName.value !== '') {
    filteredData = filteredData.filter(item => item.mallName.includes(auctionName.value));
  }
  if (auctionStatus.value !== '') {
    filteredData = filteredData.filter(item => item.status === auctionStatus.value);
  }

  if (auctionGrant.value !== '') {
    filteredData = filteredData.filter(item => item.isGrant === auctionGrant.value);
  }

  if (auctionName.value === '' && auctionStatus.value === '' && auctionGrant.value === '') {
    filteredData = auctionData.value; // 如果没有任何筛选条件，则显示所有数据
  }

  currentPageDataForAuction.value = filteredData;
  const total = currentPageDataForAuction.value.length;
  updatePaginationBySelfForAuction(); // 分页后渲染
  return total;
});
// 当auctionData有数据，就触发分页
watch(auctionData, () => {
  updatePaginationForAuction();
});

function updatePaginationForAuction() {
  startIndexForAuction.value = (currentPageForAuction.value - 1) * pageSizeForAuction.value;
  endIndexForAuction.value = Math.min(startIndexForAuction.value + pageSizeForAuction.value - 1, auctionData.value.length - 1);
  currentPageDataForAuction.value = auctionData.value.slice(startIndexForAuction.value, endIndexForAuction.value + 1);
}

function updatePaginationBySelfForAuction() {
  startIndexForAuction.value = (currentPageForAuction.value - 1) * pageSizeForAuction.value;
  endIndexForAuction.value = Math.min(startIndexForAuction.value + pageSizeForAuction.value - 1, currentPageDataForAuction.value.length - 1);
  currentPageDataForAuction.value = currentPageDataForAuction.value.slice(startIndexForAuction.value, endIndexForAuction.value + 1);
}

// 新增
const saveForm = ref({
  auction: {
    mallId: '',
    mallName: '',
    mallIcon: '',
    startingPrice: '',
    currentPrice: '',
    lowestMakeup: '',
    shelfTime: '',
    endTime: '',
  },
  file: {},
})
const saveRules = {
  auction: {
    startingPrice: [{required: true, message: '请输入起拍价'}, {
      validator: (rule, value) => {
        return value >= 0;
      }, message: '不能为负数'
    },],
    lowestMakeup: [{required: true, message: '请输入最低加价'}, {
      validator: (rule, value) => {
        return value >= 0;
      }, message: '不能为负数'
    },],
    shelfTime: [{required: true, message: '请选择上架时间'}],
    endTime: [{required: true, message: '请选择结束时间'}],
  },
};
const dialogVisibleForSaveRules = ref(false)
const showSave = () => {
  dialogVisibleForSaveRules.value = true;
}
const cancelSaveExchange = () => {
  dialogVisibleForSaveRules.value = false;
  saveForm.value.auction = {};
  saveForm.value.file = {};
}
const saveFormValidate = ref();
const adminSaveAuctionQuest = async (data) => {
  const res = await adminSaveAuction(data);
  if (res.success) {
    saveForm.value.auction = {};
    saveForm.value.file = {};
    dialogVisibleForSaveRules.value = false;
    adminGetAuctionListQuest();
    ElMessage.success("新增成功");
  } else {
    ElMessage.error(res.errorMsg);
  }
}
const saveSubmit = () => {
  saveFormValidate.value.validate((valid) => {
    if (valid) {
      if (Object.keys(saveForm.value.file).length === 0) return ElMessage.warning("请选择商品图标");
      // 设置mallId和currentPrice
      const data = ref();
      data.value = goodsData;
      saveForm.value.auction.mallId = data.value.find(i => i.name === saveForm.value.auction.mallName).id;
      saveForm.value.auction.currentPrice = saveForm.value.auction.startingPrice;
      let formData = new FormData();
      formData.append("file", saveForm.value.file);
      formData.append("auctionJson", JSON.stringify(saveForm.value.auction));
      adminSaveAuctionQuest(formData)
    } else {
      ElMessage.warning("请输入拍卖信息")
    }
  });
}

const hanchange = (file) => { // 回响图片选择后的显示
  saveForm.value.auction.mallIcon = URL.createObjectURL(file.raw)
  saveForm.value.file = file.raw;
}

// 编辑余额窗口
const updateForm = ref({
  auction: {
    id: '',
    mallId: '',
    mallName: '',
    mallIcon: '',
    startingPrice: '',
    currentPrice: '',
    lowestMakeup: '',
    shelfTime: '',
    endTime: '',
  },
  file: {},
})
const updateRules = {
  auction: {
    startingPrice: [{required: true, message: '请输入起拍价'}, {
      validator: (rule, value) => {
        return value >= 0;
      }, message: '不能为负数'
    },],
    lowestMakeup: [{required: true, message: '请输入最低加价'}, {
      validator: (rule, value) => {
        return value >= 0;
      }, message: '不能为负数'
    },],
    shelfTime: [{required: true, message: '请选择上架时间'}],
    endTime: [{required: true, message: '请选择结束时间'}],
  }
};

const dialogVisibleForUpdateRules = ref(false)
const showUpdateExchangeForm = (row) => {
  dialogVisibleForUpdateRules.value = true;
  // 打开前回显数据
  updateForm.value.auction = row;
};
const cancelUpdateExchange = () => {
  dialogVisibleForUpdateRules.value = false;
  updateForm.value.auction = {};
}
const updateFormValidate = ref() // 用于判断拍卖商品是否填写了表单

const adminUpdateAuctionQuest = async (data) => {
  const res = await adminUpdateAuction(data)
  if (res.success) {
    updateForm.value.auction = {};
    updateForm.value.file = {};
    dialogVisibleForUpdateRules.value = false;
    adminGetAuctionListQuest();
    ElMessage.success('修改成功')
  } else {
    ElMessage.error(res.errorMsg);
  }
}
const updateSubmit = () => {
  updateFormValidate.value.validate((valid) => {
    if (valid) {
      // 设置mallId
      const data = ref();
      data.value = goodsData;
      updateForm.value.auction.mallId = data.value.find(i => i.name === updateForm.value.auction.mallName).id;
      // 封装formData
      let formData = new FormData();
      formData.append("file", updateForm.value.file);
      formData.append("auctionJson", JSON.stringify(updateForm.value.auction));
      adminUpdateAuctionQuest(formData)
    } else {
      ElMessage.warning("请输入信息")
    }
  })
}

const hanchangeForUpdate = (file) => { // 回响图片选择后的显示
  updateForm.value.auction.mallIcon = URL.createObjectURL(file.raw)
  updateForm.value.file = file.raw;
}

// 删除拍卖商品相关
const adminDeleteAuctionQuest = async (id) => {
  const res = await adminDeleteAuction(id);
  if (res.success) {
    ElMessage.success("删除成功");
    adminGetAuctionListQuest();
  } else {
    ElMessage.error(res.errorMsg);
  }
}
const submitDeleteAuction = (row) => {
  ElMessageBox.confirm("确定要删除该拍卖商品吗？", "提示", {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    if (Date.now() < new Date(row.endTime) || row.isGrant === 0) {
      return ElMessage.error("竞拍未结束或未发放！")
    }
    adminDeleteAuctionQuest(row.id);
  }).catch(() => {
    ElMessage.info("取消")
  });
}
const submitForceDeleteAuction = (row) => {
  ElMessageBox.confirm("确定要强制删除该拍卖商品吗？" +
      "若当前商品有竞拍者将导致其扣除的拍卖点数丢失，但可利用账号管理补发拍卖点数给用户。丢失点数为：" + row.currentPrice,
      "提示", {confirmButtonText: '确定', cancelButtonText: '取消', type: 'error',
  }).then(() => {
    adminDeleteAuctionQuest(row.id);
  }).catch(() => {
    ElMessage.info("取消")
  });
}
</script>

<template>
  <div>
    <el-button type="primary" size="large" @click="showSave()" style="margin-right: 5px">
      新增
    </el-button>
    <el-input v-model="auctionName" size="large" placeholder="拍卖商品名"
              style="width: 150px; margin-right: 5px"/>
    <el-select v-model="auctionStatus" size="large" class="m-2" placeholder="状态" clearable
               style="margin-right: 5px">
      <el-option v-for="item in auctionStatusOptions" :key="item.id" :label="item.label"
                 :value="item.value"/>
    </el-select>
    <el-tooltip content="包含未开始/未结束的拍卖商品">
      <el-select v-model="auctionGrant" size="large" class="m-2" placeholder="是否已发放" clearable
                 style="margin-right: 5px">
        <el-option v-for="item in auctionGrantOptions" :key="item.id" :label="item.label"
                   :value="item.value"/>
      </el-select>
    </el-tooltip>
  </div>
  <el-table :data="currentPageDataForAuction" border style="width: 100%;" max-height="618" size="large">
    <el-table-column prop="mallName" label="商品名" width="150"/>
    <el-table-column prop="mallIcon" label="商品图标" width="90">
      <template #default="{ row }">
        <div style="text-align: center;">
          <img :src="row.mallIcon" alt=""/>
        </div>
      </template>
    </el-table-column>
    >
    <el-table-column prop="startingPrice" label="起拍价格(P点)" width="145"/>
    <el-table-column prop="currentPrice" label="当前价格" width="145"/>
    <el-table-column prop="lowestMakeup" label="最低加价价格" width="145"/>
    <el-table-column prop="shelfTime" label="上架时间" width="180" sortable/>
    <el-table-column prop="endTime" label="结束时间" width="180" sortable/>
    <el-table-column prop="charName" label="当前竞拍者" width="180"/>
    <el-table-column prop="status" label="状态" width="80">
      <template #default="{ row }">
        <span v-if="row.status === 'unstarted'">未开始</span>
        <span v-else-if="row.status === 'ongoing'" style="color: #13ce66">进行中</span>
        <span v-else style="color: #cf4444">已结束</span>
      </template>
    </el-table-column>
    <el-table-column prop="isGrant" label="发放状态" width="90 ">
      <template #default="{ row }">
        <span v-if="row.status === 'ongoing' || row.status === 'unstarted'">未结束</span>
        <span v-else-if="row.isGrant === 0" style="color: #cf4444">未发放</span>
        <span v-else-if="row.isGrant === 1" style="color: #13ce66">已发放</span>
      </template>
    </el-table-column>
    <el-table-column fixed="right" label="操作">
      <template #default="scope">
        <el-button type="primary" size="default" @click="showUpdateExchangeForm(scope.row)">编辑
        </el-button>
        <el-button type="danger" size="default" @click="submitDeleteAuction(scope.row)">删除
        </el-button>
        <el-button type="danger" size="default" @click="submitForceDeleteAuction(scope.row)">强制删除
        </el-button>
      </template>
    </el-table-column>
  </el-table>
  <!--  分页  -->
  <div class="pagination-row">
    <el-pagination v-model="currentPageForAuction" :page-sizes="[10]" :page-size="pageSizeForAuction"
                   :total="totalDataForAuction" layout="prev, pager, next,total"
                   @size-change="handleSizeChangeForAuction" @update:current-page="handleClickForAuction"
                   @prev-click="handleClickForAuction" @next-click="handleClickForAuction">
    </el-pagination>
  </div>
  <!--  新增对话框  -->
  <el-dialog v-model="dialogVisibleForSaveRules" title="新增信息" width="370">
    <el-form ref="saveFormValidate" :model="saveForm" label-position="top" :rules="saveRules"
             @submit.prevent="">
      <div class="auction-form-row">
        <span class="auction-dialogLabel">商品名</span>
        <el-form-item class="auction-myInput" prop="auction.mallName">
          <el-select v-model="saveForm.auction.mallName" clearable size="large" style="width: 200px"
                     placeholder="请选择拍卖商品">
            <el-option v-for="item in goodsData" :key="item.name" :label="item.name" :value="item.name"/>
          </el-select>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">商品图标</span>
        <el-form-item prop="file" style="margin-top: 15px; margin-left: 20px">
          <el-upload
              class="avatar-uploader"
              action="#"
              ref="upload"
              :show-file-list="false"
              :auto-upload="false"
              :on-change="hanchange">
            <img v-if="saveForm.auction.mallIcon" :src="saveForm.auction.mallIcon" alt="" class="my-auction-icon">
            <el-icon v-else class="avatar-uploader-icon"
                     style="width: 35px; height: 35px;box-shadow: 2px 2px 4px #cccccc; margin-bottom: 10px">
              +
            </el-icon>
          </el-upload>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">起拍价格(P点)</span>
        <el-form-item class="auction-myInput" prop="auction.startingPrice">
          <el-input style="height: 38px; width: 200px;" type="text" placeholder="请输入起拍价格(P点)"
                    v-model="saveForm.auction.startingPrice"></el-input>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">最低加价价格</span>
        <el-form-item class="auction-myInput" prop="auction.lowestMakeup">
          <el-input style="height: 38px; width: 200px;" type="text" placeholder="请输入最低加价价格"
                    v-model="saveForm.auction.lowestMakeup"></el-input>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">上架时间</span>
        <el-form-item class="auction-myInput" prop="auction.shelfTime">
          <el-date-picker v-model="saveForm.auction.shelfTime" type="datetime" placeholder="请选择上架时间"
                          style="height: 38px; width: 200px;" value-format="YYYY-MM-DD HH:mm:ss"
                          :shortcuts="shortcuts" size="large"/>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">结束时间</span>
        <el-form-item class="auction-myInput" prop="auction.endTime">
          <el-date-picker v-model="saveForm.auction.endTime" type="datetime" placeholder="请选择结束时间"
                          style="height: 38px; width: 200px;" value-format="YYYY-MM-DD HH:mm:ss"
                          :shortcuts="shortcuts" size="large"/>
        </el-form-item>
      </div>
      <div class="auction-form-row" style="justify-content: flex-end; margin-top: 20px;">
        <el-button type="default" style="width: 70px; height: 40px" @click="cancelSaveExchange">取消
        </el-button>
        <el-button type="primary" style="height: 40px;"
                   @click="saveSubmit">
          保存
        </el-button>
      </div>
    </el-form>
  </el-dialog>
  <!--  修改对话框  -->
  <el-dialog v-model="dialogVisibleForUpdateRules" title="编辑信息" width="370">
    <el-form ref="updateFormValidate" :model="updateForm" label-position="top" :rules="updateRules"
             @submit.prevent="">
      <div class="auction-form-row">
        <span class="auction-dialogLabel">商品名</span>
        <el-form-item class="auction-myInput" prop="auction.mallName">
          <el-select v-model="updateForm.auction.mallName" clearable size="large" style="width: 200px"
                     placeholder="请选择拍卖商品">
            <el-option v-for="item in goodsData" :key="item.name" :label="item.name" :value="item.name"/>
          </el-select>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">商品图标</span>
        <el-form-item prop="file" style="margin-top: 15px; margin-left: 20px">
          <el-upload
              class="avatar-uploader"
              action="#"
              ref="upload"
              :show-file-list="false"
              :auto-upload="false"
              :on-change="hanchangeForUpdate">
            <img v-if="updateForm.auction.mallIcon" :src="updateForm.auction.mallIcon" alt="" class="my-auction-icon">
            <el-icon v-else class="avatar-uploader-icon">+</el-icon>
          </el-upload>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">起拍价格(P点)</span>
        <el-form-item class="auction-myInput" prop="auction.startingPrice">
          <el-input style="height: 38px; width: 200px;" type="text" placeholder="请输入起拍价格(P点)"
                    v-model="updateForm.auction.startingPrice"></el-input>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">当前价格</span>
        <el-form-item class="auction-myInput" prop="auction.currentPrice">
          <el-input style="height: 38px; width: 200px;" type="text" placeholder="请输入当前价格"
                    v-model="updateForm.auction.currentPrice"></el-input>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">最低加价价格</span>
        <el-form-item class="auction-myInput" prop="auction.lowestMakeup">
          <el-input style="height: 38px; width: 200px;" type="text" placeholder="请输入最低加价价格"
                    v-model="updateForm.auction.lowestMakeup"></el-input>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">上架时间</span>
        <el-form-item class="auction-myInput" prop="auction.shelfTime">
          <el-date-picker v-model="updateForm.auction.shelfTime" type="datetime" placeholder="请选择上架时间"
                          style="height: 38px; width: 200px;" value-format="YYYY-MM-DD HH:mm:ss"
                          :shortcuts="shortcuts" size="large"/>
        </el-form-item>
      </div>
      <div class="auction-form-row">
        <span class="auction-dialogLabel">结束时间</span>
        <el-form-item class="auction-myInput" prop="auction.endTime">
          <el-date-picker v-model="updateForm.auction.endTime" type="datetime" placeholder="请选择结束时间"
                          style="height: 38px; width: 200px;" value-format="YYYY-MM-DD HH:mm:ss"
                          :shortcuts="shortcuts" size="large"/>
        </el-form-item>
      </div>
      <div class="auction-form-row" style="justify-content: flex-end; margin-top: 20px;">
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
.auction-form-row {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
  margin-right: 15px;
}

.auction-myInput {
  margin-left: 18px;
}

.auction-dialogLabel {
  width: 100px;
  text-align: right;
  margin-bottom: 15px;
  font-size: 14px;
}

.my-auction-icon {
  width: 32px;
  height: 32px;
}

</style>