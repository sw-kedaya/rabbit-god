<script setup>
import {useRouter} from "vue-router";
import {ElMessage} from "element-plus";
import {onMounted, ref, computed, watch} from "vue";
import {getMallTypeListApi} from "@/apis/category"
import {getMallList, getAdminEnableMallList, buyOrGiveMallPresentApi} from "@/apis/mall"
import {getDBOCharListApi} from "@/apis/dboChar"
import {getLatestMallPointsApi} from "@/apis/account";

const router = useRouter()
const user = ref()
onMounted(() => {
  // 进入前先判断登录没
  user.value = JSON.parse(localStorage.getItem("user-token"))
  updatePagination()
  // 数据渲染放在这-categories/products
  getMallTypeListQuest()
  // 如果是管理员则找管理员可见的商品
  if (user.value != null && user.value.admin === 10) {
    getAdminEnableMallQuest()
  } else {
    getMallListQuest()
  }
  if (user.value != null) getDBOCharListQuest()
})

// 后台获取分类数据
const categories = ref([])
const getMallTypeListQuest = async () => {
  const res = await getMallTypeListApi()
  categories.value = res.data
}

// products用来存过滤后的数据，currentPageData就是最后分页的数据(当过滤后分页根据自己分，查看updatePaginationBySelf可知)
const products = ref([]);
const getMallListQuest = async () => {
  const res = await getMallList()
  products.value = res.data
}
const getAdminEnableMallQuest = async () => {
  const res = await getAdminEnableMallList()
  products.value = res.data
}
// 选择框的参数，value和label的值一致即可
const dboCharOptions = ref([])
const getDBOCharListQuest = async () => {
  const res = await getDBOCharListApi(user.value.accountID)
  dboCharOptions.value = res.data;
}

// 分页基本属性
const currentPage = ref(1);
const pageSize = ref(16);
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

// 一个是全部数据，一个是关键字搜索的，一个是计算当前数据总条数
const selectedCategory = ref('all');
const searchKeyword = ref('');
const totalProducts = computed(() => filteredProducts.value.length);
// 根据分类和关键字筛选商品(计算完后更新数据)
const filteredProducts = computed(() => {
  if (selectedCategory.value === 'all') {
    const res = products.value.filter(item => item.name.includes(searchKeyword.value));
    currentPageData.value = res;
    updatePaginationBySelf()
    return res;
  } else {
    const res = products.value.filter(item => item.name.includes(searchKeyword.value)
        && item.type === selectedCategory.value);
    currentPageData.value = res;
    updatePaginationBySelf()
    return res;
  }
});

// 判断选择了哪个分类
function selectCategory(categoryId) {
  searchKeyword.value = ''
  selectedCategory.value = categoryId;
}

// 搜索商品时自动变成第一页
function search() {
  currentPage.value = 1; // 重置当前页码
}

// 当products有数据，就触发分页
watch(products, () => {
  updatePagination();
});

// 把数据分页-根据所有数据分
function updatePagination() {
  startIndex.value = (currentPage.value - 1) * pageSize.value;
  endIndex.value = Math.min(startIndex.value + pageSize.value - 1, products.value.length - 1);
  currentPageData.value = products.value.slice(startIndex.value, endIndex.value + 1);
}

// 把数据分页-根据自己分
function updatePaginationBySelf() {
  startIndex.value = (currentPage.value - 1) * pageSize.value;
  endIndex.value = Math.min(startIndex.value + pageSize.value - 1, currentPageData.value.length - 1);
  currentPageData.value = currentPageData.value.slice(startIndex.value, endIndex.value + 1);
}

// 赠送/购买后刷新c点
const getLatestMallPointsQuest = async () => {
  const res = await getLatestMallPointsApi(user.value.accountID)
  user.value.mallPoints = res.data
  localStorage.setItem("user-token", JSON.stringify(user.value))
}

// 赠送/购买API
const mall = ref()
const buyOrGiveMallPresentQuest = async (mall, purchaser, msg) => {
  const requestData = {mall, purchaser}
  const res = await buyOrGiveMallPresentApi(requestData)
  if (res.success) {
    getLatestMallPointsQuest()
    ElMessage.success(msg + "成功")
  } else {
    ElMessage.error(res.errorMsg)
  }
}

// 赠送对话框
const givePresentForm = ref({
  accountID: '',
  roleName: ''
});
const givePresentRules = {
  roleName: [
    {required: true, message: '请输入角色名'},
    {min: 2, max: 16, message: '角色名长度为2-16位'}
  ]
};
const dialogVisibleForGivePresent = ref(false)
const showGivePresentExchangeForm = (product) => {
  mall.value = product
  dialogVisibleForGivePresent.value = true;
};
const cancelGivePresentExchange = () => {
  givePresentForm.value = {
    roleName: '',
  };
  dialogVisibleForGivePresent.value = false;
}
const givePresentFormValidate = ref() // 用于判断用户是否填写了表单

const givePresent = () => {
  if (user.value == null) return ElMessage.warning('请先登录')
  givePresentFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForGivePresent.value = false;
      givePresentForm.value.accountID = user.value.accountID
      buyOrGiveMallPresentQuest(mall.value, givePresentForm.value, "赠送")
    } else {
      ElMessage.warning("请输入角色名称")
    }
  })
}

// 购买对话框
const buyForm = ref({
  accountID: '',
  roleName: ''
});
const buyRules = {
  roleName: [
    {required: true, message: '请选择角色名称'},
  ]
};
const dialogVisibleForBuy = ref(false)
const showBuyExchangeForm = (product) => {
  mall.value = product
  dialogVisibleForBuy.value = true;
};
const cancelBuyExchange = () => {
  buyForm.value.roleName = '';
  dialogVisibleForBuy.value = false;
}
const buyFormValidate = ref() // 用于判断用户是否填写了表单

const buy = () => {
  if (user.value == null) return ElMessage.warning('请先登录')
  buyFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForBuy.value = false;
      buyForm.value.accountID = user.value.accountID
      buyOrGiveMallPresentQuest(mall.value, buyForm.value, "购买")
    } else {
      ElMessage.warning("请选择角色名称")
    }
  })
}
</script>

<template>
  <div class="shop-container">
    <div class="category-row">
      <el-button :style="{ 'background-color': selectedCategory === 'all' ? '#3388ff' : '#fff',
                            'color': selectedCategory === 'all' ? '#fff' : '#000000'}" class="my-custom-button"
                 @click="selectCategory('all')">全部
      </el-button>
      <el-button v-for="category in categories" :key="category.id"
                 :style="{ 'background-color': selectedCategory === category.id ? '#3388ff' : '#fff' ,
                            'color': selectedCategory === category.id ? '#fff' : '#000000'}" class="my-custom-button"
                 @click="selectCategory(category.id)">{{ category.name }}
      </el-button>
    </div>
    <div class="search-row">
      <el-input placeholder="请输入关键字" v-model="searchKeyword"></el-input>
      <el-button type="primary" @click="search" style="margin-left: 10px; height: 40px;
                  background-color: white; color: black; border: 1px solid #dcdfe6;">搜索
      </el-button>
    </div>
    <div class="product-row">
      <div class="product-item" v-for="product in currentPageData" :key="product.id">
        <div class="product-content">
          <!-- 商品展示内容 -->
          <div class="product-name">{{ product.name }}</div>
          <div class="product-price">价格：{{ product.price }}C</div>
          <div class="product-actions">
            <el-tooltip placement="top" popper-class="tooltip-width" effect="light">
              <button class="white-button">商品详情</button>
              <template #content>
                <div class="tooltip-content">
                  {{ product.description }}
                </div>
              </template>
            </el-tooltip>
            <button class="action-button orange-button" @click="showGivePresentExchangeForm(product)">赠送</button>
            <button class="action-button green-button" @click="showBuyExchangeForm(product)">购买</button>
          </div>
        </div>
      </div>
    </div>
    <!--  分页  -->
    <div class="pagination-row">
      <el-pagination v-model="currentPage" :page-sizes="[16]" :page-size="pageSize"
                     :total="totalProducts" layout="prev, pager, next,total"
                     @size-change="handleSizeChange" @update:current-page="handleClick"
                     @prev-click="handleClick" @next-click="handleClick">
      </el-pagination>
    </div>
  </div>
  <!-- 赠送对话表单 -->
  <el-dialog v-model="dialogVisibleForGivePresent" title="请填写要赠送的角色" width="320px">
    <el-form ref="givePresentFormValidate" :model="givePresentForm" label-position="top" :rules="givePresentRules">
      <div class="myWarning ">
        <span class="el-alert__title">赠送前请确保对方信箱位置足够，否则商品会发送失败</span>
      </div>
      <div class="form-row">
        <span class="dialogLabel">角色</span>
        <el-form-item class="myInput" prop="roleName">
          <el-input style="height: 38px; width: 220px" type="text" placeholder="请输入角色名称"
                    v-model="givePresentForm.roleName"></el-input>
        </el-form-item>
      </div>
      <div class="form-row" style="justify-content: flex-end; margin-top: 40px;">
        <el-button type="default" style="width: 70px; height: 40px" @click="cancelGivePresentExchange">取消</el-button>
        <el-button type="primary" style="background-color: #e6a23c; color: #FFFFFF;height: 40px; border-color: #e6a23c;"
                   @click="givePresent">
          确认赠送
        </el-button>
      </div>
    </el-form>
  </el-dialog>
  <!-- 购买对话表单 -->
  <el-dialog v-model="dialogVisibleForBuy" title="购买胶囊" width="320px">
    <el-form ref="buyFormValidate" :model="buyForm" label-position="top" :rules="buyRules">
      <div class="myWarning ">
        <span class="el-alert__title">购买前请确保您的信箱位置足够，否则商品会发送失败</span>
      </div>
      <div class="form-row">
        <span class="dialogLabel">角色</span>
        <el-form-item class="myInput" prop="roleName">
          <el-select v-model="buyForm.roleName" class="m-2" placeholder="请选择角色名称" size="large">
            <el-option
                v-for="item in dboCharOptions"
                :key="item.charName"
                :label="item.charName"
                :value="item.charName"
            />
          </el-select>
        </el-form-item>
      </div>
      <div class="form-row" style="justify-content: flex-end; margin-top: 20px;">
        <el-button type="default" style="width: 70px; height: 40px" @click="cancelBuyExchange">取消</el-button>
        <el-button type="primary"
                   style="background-color: #67c23a; color: #FFFFFF; height: 40px; border-color: #67c23a;"
                   @click="buy">确认购买
        </el-button>
      </div>
    </el-form>
  </el-dialog>
  <div style="margin-bottom: 125px;"/>
</template>

<style lang="scss">
.myWarning {
  background-color: #fdf6ec; /* 橙色背景 */
  color: #E6A23C; /* 白色文字 */
  display: table;
  font-size: 13px;
  width: 88%;
  padding: 8px;
  margin-left: 15px;
  margin-bottom: 8px;
}

.form-row {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
  margin-right: 15px;
}

.dialogLabel {
  width: 40px;
  text-align: right;
  margin-bottom: 15px;
  font-size: 14px;
}

.myInput {
  margin-left: 10px;
  margin-bottom: 16px;
}

.category-row .my-custom-button {
  margin-right: 0; /* 右侧间距为 0 */
}

.category-row .my-custom-button:not(:first-child) {
  margin-left: 0; /* 左侧间距为 0 */
}

.tooltip-width {
  max-width: 300px;
  max-height: 200px;
  min-width: 80px;
}

.tooltip-content {
  font-size: 15px; /* 调整字体大小为16px */
}

.shop-container {
  height: 650px;
  width: 1000px;
  margin: 50px auto;
}

.category-row {
  display: flex;
  margin-bottom: 15px;
}

.my-custom-button {
  padding: 20px 20px;
}

.category-item {
  cursor: pointer;
  margin-right: 10px;
}

.category-item.active {
  font-weight: bold;
}

.search-row {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 20px;
  width: 25%;
  height: 40px;
}

.product-row {
  display: flex;
  flex-wrap: wrap;
}

.product-item {
  width: 245px;
  height: 115px;
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
  border-radius: 4px;
  padding: 10px;

  flex-basis: calc(25% - 10px); /* 每个项目的宽度为20%，减去间距 */
  max-width: calc(25% - 10px); /* 每个项目的最大宽度为20%，减去间距 */
  margin-right: 10px; /* 右侧间距为10px */
  margin-bottom: 20px; /* 下方间距为20px */
}

.product-item:nth-child(4n) {
  margin-right: 0; /* 每行最后一个项目的右侧间距为0 */
}

.product-content {
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.product-name {
  font-size: 16px;
}

.product-description {
  font-size: 14px;
  color: #888;
}

.product-actions {
  display: flex;
  align-items: center;
  margin-top: 10px;
}

.action-button {
  border: none;
  padding: 8px 15px;
  border-radius: 4px;
  cursor: pointer;
}

.white-button {
  border: 1px solid #dcdfe6;
  padding: 8px 15px;
  border-radius: 4px;
  cursor: pointer;
  background-color: #fff;
  color: #000;
  margin-right: 8px;
}

.orange-button {
  background-color: #e6a23c;
  color: #fff;
}

.green-button {
  background-color: #67c23a;
  color: #fff;
}

.product-price {
  font-size: 15px;
  color: orange;
}
</style>