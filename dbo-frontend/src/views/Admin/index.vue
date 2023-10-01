<script setup>
import {useRouter} from "vue-router";
import {ElMessage, ElMessageBox} from "element-plus";
import {computed, onMounted, ref, watch} from "vue";
import {getMallTypeListApi, updateMallTypeByIdApi, deleteByIdApi, saveMallTypeApi} from "@/apis/category"
import {
  getAdminAllMallList,
  saveMallApi,
  updateMallApi,
  deleteMallByIdApi,
  setSignRewardByIdApi,
  cancelSignRewardByIdApi
} from "@/apis/mall"
import {verifyWebAdminApi} from "@/apis/webAdmin"
import {getAdminOrderApi, adminAddCashKeyApi, deleteAllKeyApi} from "@/apis/cashKey"
import {getEventList, adminEventSaveApi, adminEventUpdateApi, adminEventDeleteApi} from "@/apis/event"

// 切换tab时的记录(默认打开第一个tab的第一个子tab)
const activeTab = ref();
const activeSideTab = ref();

const router = useRouter()
const user = ref()
const admin = ref()
onMounted(() => {
  // 进入前先判断是否等于且为管理员
  user.value = JSON.parse(localStorage.getItem("user-token"))
  if (user.value == null) router.push('/login')
  // 然后判断是否输入了管理员密码
  admin.value = localStorage.getItem("admin-token")
  // 其他初始化
  activeTab.value = localStorage.getItem("activeTab");
  activeSideTab.value = localStorage.getItem("activeSideTab");
  getMallTypeListQuest()
  getAdminAllMallListQuest()
  getAdminOrderQuest()
  getEventListQuest()
})
// 用于保存用户当前在哪子标签1还是2...
watch(activeSideTab, () => {
  localStorage.setItem("activeSideTab", activeSideTab.value);
})
watch(activeTab, () => {
  localStorage.setItem("activeTab", activeTab.value)
})

const categoryData = ref([])
const getMallTypeListQuest = async () => {
  const res = await getMallTypeListApi()
  categoryData.value = res.data;
}

const getAdminAllMallListQuest = async () => {
  const res = await getAdminAllMallList()
  goodsData.value = res.data
}

// 新增商品类型部分-新增对话框
const categoryForm = ref({
  userId: 0,
  name: '',
  sort: 0
});
const categoryRules = {
  name: [
    {required: true, message: '请输入商品类型名称'},
  ],
  sort: [
    {required: true, message: '请输入商品类型排序'}
  ]
};
const dialogVisibleForCategoryRules = ref(false)
const showCategoryExchangeForm = () => {
  dialogVisibleForCategoryRules.value = true;
  categoryForm.value.sort = 0
};
const cancelCategoryExchange = () => {
  categoryForm.value = {
    name: '',
  };
  dialogVisibleForCategoryRules.value = false;
}
const categoryFormValidate = ref() // 用于判断用户是否填写了表单

const saveMallTypeQuest = async () => {
  const res = await saveMallTypeApi(categoryForm.value);
  if (res.success) {
    ElMessage.success('添加成功');
    categoryForm.value.name = '';
    getMallTypeListQuest()
  } else {
    ElMessage.error(res.errorMsg);
  }
}

const categorySubmit = () => {
  categoryFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForCategoryRules.value = false;
      categoryForm.value.userId = user.value.accountID
      saveMallTypeQuest()
    } else {
      ElMessage.warning("请输入商品类型名称")
    }
  })
}
// 修改商品类型部分-修改对话框
const updateCategoryForm = ref({
  userId: 0,
  id: 0,
  name: '',
  sort: 0
});
const updateCategoryRules = {
  name: [
    {required: true, message: '请输入商品类型名称'},
  ],
  sort: [
    {required: true, message: '请输入商品类型排序'}
  ]
};
const dialogVisibleForUpdateCategoryRules = ref(false)
const showUpdateCategoryExchangeForm = (id) => {
  updateCategoryForm.value = categoryData.value.find(item => item.id === id);
  dialogVisibleForUpdateCategoryRules.value = true;
};
const cancelUpdateCategoryExchange = () => {
  dialogVisibleForUpdateCategoryRules.value = false;
}
const updateCategoryFormValidate = ref() // 用于判断用户是否填写了表单

const updateMallTypeByIdQuest = async () => {
  const res = await updateMallTypeByIdApi(updateCategoryForm.value)
  if (res.success) {
    ElMessage.success('修改成功');
    getMallTypeListQuest()
  } else {
    ElMessage.error(res.errorMsg);
  }
}

const updateCategorySubmit = () => {
  updateCategoryFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForUpdateCategoryRules.value = false;
      updateCategoryForm.value.userId = user.value.accountID;
      updateMallTypeByIdQuest()
    } else {
      ElMessage.warning("请输入修改内容")
    }
  })
}
// 删除商品类型部分
const deleteByIdQuest = async (id, userId) => {
  const res = await deleteByIdApi(id, userId)
  if (res.success) {
    ElMessage.success('删除成功')
    getMallTypeListQuest()
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const deleteCategory = (id) => {
  ElMessageBox.confirm("确定要删除吗？", "提示", {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    deleteByIdQuest(id, user.value.accountID)
  }).catch(() => {
    ElMessage.info("取消删除")
  })
}

// 刷新按钮
const refreshCategoryList = () => {
  getMallTypeListQuest()
}

// 新增商品部分-新增对话框、查询...
const goodsName = ref('')
const goodsType = ref('')
const goodsStatus = ref('')
const goodsStatusOptions = [
  {value: '0', label: '上架'}, {value: '1', label: '下架'},
  {value: '2', label: '上架(仅管理员可见)'},
]

const goodsData = ref([])

const goodsForm = ref([{
  name: '', description: '', price: '', type: '', del_flag: '0',
  tblidx: '', place: 1, pos: 0, count: 1, rank: 1, durability: 255, grade: 0, needToIdentify: 0,
  battleAttribute: 0, maker: '', optionTblidx: 4294967295, optionTblidx2: 4294967295,
  optionRandomId: 65535, optionRandomVal: 4294967295, optionRandomId2: 65535, optionRandomVal2: 4294967295,
  optionRandomId3: 65535, optionRandomVal3: 4294967295, optionRandomId4: 65535, optionRandomVal4: 4294967295,
  optionRandomId5: 65535, optionRandomVal5: 4294967295, optionRandomId6: 65535, optionRandomVal6: 4294967295,
  optionRandomId7: 65535, optionRandomVal7: 4294967295, optionRandomId8: 65535, optionRandomVal8: 4294967295,
  useStartTime: 0, useEndTime: 0, restrictState: 0, durationType: 0, sign_reward: 0, userId: 0,
}]);
const goodsRules = {
  name: [{required: true, message: '请输入商品名称'},],
  description: [{required: true, message: '请输入商品描述'},],
  price: [{required: true, message: '请输入商品价格'}, {
    validator: (rule, value) => {
      return value >= 0;
    }, message: '价格不能为负数'
  },],
  type: [{required: true, message: '请选择商品类型'},],
  del_flag: [{required: true, message: '请选择状态'},],
  tblidx: [{required: true, message: '请输入tblidx(纯数字)'},],
};
const dialogVisibleForGoodsRules = ref(false)
const showGoodsExchangeForm = () => {
  dialogVisibleForGoodsRules.value = true;
  // 打开前初始化
  goodsForm.value = {
    id: 0, name: '', description: '', price: '', type: '', del_flag: '0',
    tblidx: '', place: 1, pos: 0, count: 1, rank: 1, durability: 255, grade: 0, needToIdentify: 0,
    battleAttribute: 0, maker: '', optionTblidx: 4294967295, optionTblidx2: 4294967295,
    optionRandomId: 65535, optionRandomVal: 4294967295, optionRandomId2: 65535, optionRandomVal2: 4294967295,
    optionRandomId3: 65535, optionRandomVal3: 4294967295, optionRandomId4: 65535, optionRandomVal4: 4294967295,
    optionRandomId5: 65535, optionRandomVal5: 4294967295, optionRandomId6: 65535, optionRandomVal6: 4294967295,
    optionRandomId7: 65535, optionRandomVal7: 4294967295, optionRandomId8: 65535, optionRandomVal8: 4294967295,
    useStartTime: 0, useEndTime: 0, restrictState: 0, durationType: 0, sign_reward: 0, userId: 0,
  }
};
const cancelGoodsExchange = () => {
  goodsForm.value = {
    name: '', description: '', price: '', type: '', del_flag: '0', tblidx: '', userId: 0,
  };
  dialogVisibleForGoodsRules.value = false;
}
const goodsFormValidate = ref() // 用于判断用户是否填写了表单

const saveMallQuest = async () => {
  const res = await saveMallApi(goodsForm.value)
  if (res.success) {
    getAdminAllMallListQuest()
    goodsForm.value = {
      name: '', description: '', price: '', type: '', del_flag: '0', tblidx: '', userId: 0,
    };
    ElMessage.success('添加成功')
    // 添加成功后初始化六个必须数据
  } else {
    ElMessage.error(res.errorMsg)
  }
}

const goodsSubmit = () => {
  goodsFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForGoodsRules.value = false;
      goodsForm.value.userId = user.value.accountID // 判断是否为管理员
      saveMallQuest()
    } else {
      ElMessage.warning("请输入商品信息")
    }
  })
}

// 商品分页
// 分页基本属性
const currentPage = ref(1);
const pageSize = ref(10);
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


const totalGoodsData = computed(() => filteredGoodsData.value.length);
// 根据分类名、类型和状态筛选商品(计算完后更新数据)
const filteredGoodsData = computed(() => {
  if (goodsName.value !== '') { // 如果商品名不为空则过滤
    const res = currentPageData.value.filter(item => item.name.includes(goodsName.value));
    currentPageData.value = res;
  }
  if (goodsType.value !== '') { // 如果商品类型不为空则过滤
    const res = currentPageData.value.filter(item => item.type === goodsType.value);
    currentPageData.value = res;
  }
  if (goodsStatus.value !== '') { // 如果商品状态不为空则过滤
    const res = currentPageData.value.filter(item => item.del_flag === goodsStatus.value);
    currentPageData.value = res;
  }
  updatePaginationBySelf() // 分页后渲染
  return currentPageData.value;
});

// 搜索商品时自动变成第一页
function search() {
  currentPage.value = 1; // 重置当前页码
}

// 当goodsForm有数据，就触发分页
watch(goodsData, () => {
  updatePagination();
});

// 把数据分页-根据所有数据分
function updatePagination() {
  startIndex.value = (currentPage.value - 1) * pageSize.value;
  endIndex.value = Math.min(startIndex.value + pageSize.value - 1, goodsData.value.length - 1);
  currentPageData.value = goodsData.value.slice(startIndex.value, endIndex.value + 1);
}

// 把数据分页-根据自己分
function updatePaginationBySelf() {
  startIndex.value = (currentPage.value - 1) * pageSize.value;
  endIndex.value = Math.min(startIndex.value + pageSize.value - 1, currentPageData.value.length - 1);
  currentPageData.value = currentPageData.value.slice(startIndex.value, endIndex.value + 1);
}

// 修改商品表单
const updateGoodsForm = ref([])
const updateGoodsRules = {
  name: [{required: true, message: '请输入商品名称'},],
  description: [{required: true, message: '请输入商品描述'},],
  price: [{required: true, message: '请输入商品价格'}, {
    validator: (rule, value) => {
      return value >= 0;
    }, message: '价格不能为负数'
  },],
  type: [{required: true, message: '请选择商品类型'},],
  del_flag: [{required: true, message: '请选择状态'},],
  tblidx: [{required: true, message: '请输入tblidx(纯数字)'},],
};
const dialogVisibleForUpdateGoodsRules = ref(false)
const showUpdateGoodsExchangeForm = (id) => {
  dialogVisibleForUpdateGoodsRules.value = true;
  // 打开前回显数据
  updateGoodsForm.value = goodsData.value.find(item => item.id === id);
};
const cancelUpdateGoodsExchange = () => {
  dialogVisibleForUpdateGoodsRules.value = false;
}
const updateGoodsFormValidate = ref() // 用于判断用户是否填写了表单

const updateMallQuest = async () => {
  const res = await updateMallApi(updateGoodsForm.value)
  if (res.success) {
    getAdminAllMallListQuest()
    ElMessage.success('修改成功')
  } else {
    ElMessage.error(res.errorMsg);
  }
}
const updateGoodsSubmit = () => {
  updateGoodsFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForUpdateGoodsRules.value = false;
      updateGoodsForm.value.userId = user.value.accountID // 判断是否为管理员
      updateMallQuest()
    } else {
      ElMessage.warning("请输入商品信息")
    }
  })
}

// 删除商品
const deleteMallByIdQuest = async (id, userId) => {
  const res = await deleteMallByIdApi(id, userId);
  if (res.success) {
    getAdminAllMallListQuest()
    ElMessage.success('删除成功')
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const deleteGoods = (id) => {
  ElMessageBox.confirm("确定要删除吗？", "提示", {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    deleteMallByIdQuest(id, user.value.accountID)
  }).catch(() => {
    ElMessage.info("取消删除")
  })
}

// 签到奖励设置表单
const dialogVisibleForSign = ref(false);
const signForm = ref({id: '', sign: '',});
const signRules = {
  sign: [
    {required: true, message: '请输入日期数字(例如2月6号：206)'},
  ]
};
const showSignForm = (row) => {
  signForm.value.sign = row.sign_reward;
  signForm.value.id = row.id;
  console.log(signForm.value)
  dialogVisibleForSign.value = true;
};
const cancelSign = () => {
  dialogVisibleForSign.value = false;
}
const signFormValidate = ref()
// 设置为签到奖励
const setSignRewardByIdQuest = async (data, userId) => {
  const res = await setSignRewardByIdApi(data, userId)
  if (res.success) {
    getAdminAllMallListQuest()
    ElMessage.success('设置成功')
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const signSubmit = () => {
  signFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForSign.value = false;
      setSignRewardByIdQuest(signForm.value, user.value.accountID)
    } else {
      ElMessage.warning("请输入日期数字(例如10月3号：1003)")
    }
  })
}
// 取消该签到奖励
const cancelSignRewardByIdQuest = async (id, userId) => {
  const res = await cancelSignRewardByIdApi(id, userId)
  if (res.success) {
    getAdminAllMallListQuest()
    ElMessage.success('设置成功')
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const cancelSignRewardGoods = (id) => {
  ElMessageBox.confirm("您确定将此商品设置为非签到奖励？", "提示", {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    cancelSignRewardByIdQuest(id, user.value.accountID)
  }).catch(() => {
    ElMessage.info("取消设置")
  })
}

// 进入前的密码验证
const adminInfo = ref({
  username: '',
  password: ''
})
const rules = {
  password: [
    {required: true, message: '请输入管理平台密码'}
  ]
}
const verifyWebAdminQuest = async () => {
  const res = await verifyWebAdminApi(adminInfo.value)
  if (res.success) {
    admin.value = "admin"
    localStorage.setItem("admin-token", "admin")
    ElMessage.success("欢迎进入管理平台")
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const adminInfoForm = ref()

function onAdminSubmitClick() {
  adminInfoForm.value.validate((valid) => {
    if (valid) {
      adminInfo.value.username = user.value.username;
      verifyWebAdminQuest()
    } else {
      ElMessage.warning('请输入管理平台密码')
    }
  })
}

// 卡密管理部分
const cdKeyNum = ref(1)
const cashNum = ref(1)
const handleCdKeyNumChange = (value) => {
}
const handleCashNumChange = (value) => {
}
const ordersForKey = ref([])
const currentPageForKey = ref(1);
const pageSizeForKey = ref(10);
const totalPageForKey = ref(1);
const startIndexForKey = ref(0);
const endIndexForKey = ref(0);
const currentPageDataForKey = ref([]);
const totalDataForKey = ref(0)
const getAdminOrderQuest = async () => {
  const res = await getAdminOrderApi(user.value.accountID)
  ordersForKey.value = res.data;
  currentPageDataForKey.value = ordersForKey.value
  totalDataForKey.value = currentPageDataForKey.value.length
  updatePaginationForKey()
}

// 切换每页显示多少数据时刷新
function handleSizeChangeForKey(newSize) {
  pageSizeForKey.value = newSize;
  updatePaginationForKey()
}

// 切换页时刷新
function handleClickForKey(newCurrentPage) {
  currentPageForKey.value = newCurrentPage;
  // 如果是查看所有未使用来切换页数，则根据过滤好的数据分页
  if (localStorage.getItem("allKeyUnused")) {
    const res = ordersForKey.value.filter(item => item.accountID === '0')
    currentPageDataForKey.value = res;
    updatePaginationForKeyBySelf()
  } else {
    updatePaginationForKey()
  }
}

function updatePaginationForKey() {
  totalDataForKey.value = ordersForKey.value.length
  totalPageForKey.value = Math.ceil(ordersForKey.value.length / pageSizeForKey.value);
  startIndexForKey.value = (currentPageForKey.value - 1) * pageSizeForKey.value;
  endIndexForKey.value = Math.min(startIndexForKey.value + pageSizeForKey.value - 1, ordersForKey.value.length - 1);
  currentPageDataForKey.value = ordersForKey.value.slice(startIndexForKey.value, endIndexForKey.value + 1);
}

function updatePaginationForKeyBySelf() {
  totalDataForKey.value = currentPageDataForKey.value.length
  totalPageForKey.value = Math.ceil(currentPageDataForKey.value.length / pageSizeForKey.value);
  startIndexForKey.value = (currentPageForKey.value - 1) * pageSizeForKey.value;
  endIndexForKey.value = Math.min(startIndexForKey.value + pageSizeForKey.value - 1, currentPageDataForKey.value.length - 1);
  currentPageDataForKey.value = currentPageDataForKey.value.slice(startIndexForKey.value, endIndexForKey.value + 1);
}

// 当ordersForKey有数据，就触发分页
watch(ordersForKey, () => {
  updatePagination();
});
// 生成卡密
const adminAddCashKeyQuest = async (cash, num, userId) => {
  const res = await adminAddCashKeyApi(cash, num, userId)
  if (res.success) {
    getAdminOrderQuest()
    ElMessage.success('生成卡密成功')
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const generateKey = () => {
  ElMessageBox.confirm("确认生成？", "提示", {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    adminAddCashKeyQuest(cashNum.value, cdKeyNum.value, user.value.accountID)
  }).catch(() => {
    ElMessage.info("取消生成")
  })
}
// 删除所有卡密
const deleteAllKeyQuest = async () => {
  const res = await deleteAllKeyApi()
  if (res.success) {
    getAdminOrderQuest()
    ElMessage.success('删除所有卡密成功')
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const deleteAllKey = () => {
  ElMessageBox.confirm("确认删除所有卡密？", "警告", {
    confirmButtonText: '确定删除',
    cancelButtonText: '取消',
    type: 'error',
  }).then(() => {
    deleteAllKeyQuest()
  }).catch(() => {
    ElMessage.info("取消生成")
  })
}
// 查看所有未使用
const allKeyUnused = () => {
  localStorage.setItem("allKeyUnused", 1);
  currentPageForKey.value = 1
  const res = ordersForKey.value.filter(item => item.accountID === '0')
  currentPageDataForKey.value = res;
  updatePaginationForKeyBySelf()
}
// 恢复查看所有数据
const allKey = () => {
  localStorage.removeItem("allKeyUnused")
  currentPageForKey.value = 1
  currentPageDataForKey.value = ordersForKey.value;
  updatePaginationForKey()
}

// 活动管理部分
const eventData = ref([])
const getEventListQuest = async () => {
  const res = await getEventList()
  eventData.value = res.data
}
// 新增活动
const eventSaveForm = ref({
  event_name: '', monday: '', tuesday: '', wednesday: '', thursday: '', friday: '',
  saturday: '', sunday: '',
})
const eventSaveRules = {
  event_name: [{required: true, message: '请输入活动名称'}],
};
const dialogVisibleForEventSaveRules = ref(false)
const showEventSaveExchangeForm = () => {
  dialogVisibleForEventSaveRules.value = true;
};
const cancelEventSaveExchange = () => {
  dialogVisibleForEventSaveRules.value = false;
}
const eventSaveFormValidate = ref() // 用于判断用户是否填写了表单
const adminEventSaveQuest = async () => {
  const res = await adminEventSaveApi(eventSaveForm.value, user.value.accountID)
  if (res.success) {
    getEventListQuest()
    eventSaveForm.value = {
      event_name: '', monday: '', tuesday: '', wednesday: '', thursday: '', friday: '',
      saturday: '', sunday: '',
    };
    ElMessage.success('新增活动成功')
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const eventSaveSubmit = () => {
  eventSaveFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForEventSaveRules.value = false;
      adminEventSaveQuest()
    } else {
      ElMessage.warning("请输入活动名称")
    }
  })
}
// 修改活动-回显
const eventUpdateForm = ref({})
const eventUpdateRules = {
  event_name: [{required: true, message: '请输入活动名称'}],
};
const dialogVisibleForEventUpdateRules = ref(false)
const showEventUpdateExchangeForm = (id) => {
  dialogVisibleForEventUpdateRules.value = true;
  eventUpdateForm.value = eventData.value.find(item => item.id === id);
};
const cancelEventUpdateExchange = () => {
  dialogVisibleForEventUpdateRules.value = false;
}
const eventUpdateFormValidate = ref() // 用于判断用户是否填写了表单
const adminEventUpdateQuest = async () => {
  const res = await adminEventUpdateApi(eventUpdateForm.value, user.value.accountID)
  if (res.success) {
    getEventListQuest()
    ElMessage.success('修改活动成功')
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const eventUpdateSubmit = () => {
  eventUpdateFormValidate.value.validate((valid) => {
    if (valid) {
      dialogVisibleForEventUpdateRules.value = false;
      adminEventUpdateQuest()
    } else {
      ElMessage.warning("请输入活动名称")
    }
  })
}
// 删除活动
const adminEventDeleteQuest = async (id) => {
  const res = await adminEventDeleteApi(id, user.value.accountID)
  if (res.success) {
    getEventListQuest()
    ElMessage.success('删除活动成功')
  } else {
    ElMessage.error(res.errorMsg)
  }
}
const deleteEvent = (id) => {
  ElMessageBox.confirm("确认删除该活动？", "警告", {
    confirmButtonText: '删除',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    adminEventDeleteQuest(id)
  }).catch(() => {
    ElMessage.info("取消删除")
  })
}

// 复制卡密按钮
const onCopyCashKeyClick = (cdKey) => {
  navigator.clipboard.writeText(cdKey).then(() => {
    ElMessage.success("已复制卡密")
  })
}
</script>

<template>
  <template v-if="admin === null">
    <div class="login-container">
      <div class="login-wrapper">
        <div style="font-size: large; margin-bottom: 10px">七龙珠Online管理平台</div>
        <br>
        <div class="form">
          <el-form ref="adminInfoForm" :model="adminInfo" :rules="rules" status-icon label-width="80px" size="large"
                   @submit.prevent>
            <el-form-item prop="password" style="width:320px" label="密码">
              <el-input placeholder="请输入管理平台密码" v-model="adminInfo.password" type="password"/>
            </el-form-item>
            <div class="button-container">
              <el-button size="large" class="subBtn" type="primary" @click="onAdminSubmitClick">进入管理平台</el-button>
            </div>
          </el-form>
        </div>
      </div>
    </div>
  </template>
  <template v-else>
    <div class="my-tab">
      <el-tabs type="border-card" v-model="activeTab">
        <el-tab-pane label="胶囊商城管理" name="tab1">
          <el-tabs tab-position="left" v-model="activeSideTab">
            <el-tab-pane label="商品类型管理" name="sideTab1" class="my-tab-pane">
              <div>
                <el-button type="primary" size="large" @click="showCategoryExchangeForm">新增商品类型</el-button>
                <el-button type="default" size="large" @click="refreshCategoryList">刷新</el-button>
              </div>
              <el-table :data="categoryData" border style="width: 100%;" max-height="650" size="large">
                <el-table-column prop="name" label="商品类型名称" width="280"/>
                <el-table-column prop="sort" label="商品类型排序" width="750"/>
                <el-table-column fixed="right" label="操作" width="740">
                  <template #default="scope">
                    <el-button type="primary" size="default"
                               @click="showUpdateCategoryExchangeForm(scope.row.id)">修改
                    </el-button>
                    <el-button type="danger" size="default" @click="deleteCategory(scope.row.id)">删除</el-button>
                  </template>
                </el-table-column>
              </el-table>
            </el-tab-pane>
            <el-tab-pane label="商品管理" name="sideTab2" class="my-tab-pane">
              <div>
                <el-button type="primary" size="large" @click="showGoodsExchangeForm" style="margin-right: 5px">
                  新增商品
                </el-button>
                <el-input v-model="goodsName" size="large" placeholder="商品名称"
                          style="width: 222px; margin-right: 5px"/>
                <el-select v-model="goodsType" size="large" class="m-2" placeholder="商品类型" clearable
                           style="margin-right: 5px">
                  <el-option
                      v-for="item in categoryData"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id"
                  />
                </el-select>
                <el-select v-model="goodsStatus" size="large" class="m-2" placeholder="商品状态" clearable
                           style="margin-right:5px">
                  <el-option
                      v-for="item in goodsStatusOptions"
                      :key="item.value"
                      :label="item.label"
                      :value="item.value"
                  />
                </el-select>
                <el-button type="default" size="large" @click="search">查询</el-button>
              </div>
              <el-table :data="currentPageData" border style="width: 100%;" max-height="618" size="large">
                <el-table-column prop="name" label="商品名称" width="300"/>
                <el-table-column prop="price" label="商品价格" width="120"/>
                <el-table-column prop="type" label="商品类型" width="180">
                  <template #default="{ row }">
                  <span v-if="categoryData && categoryData.length > 0">
                    {{ categoryData.find(item => item.id === row.type)?.name || '无' }}</span>
                    <span v-else>-</span>
                  </template>
                </el-table-column>
                <el-table-column prop="del_flag" label="商品状态" width="180">
                  <template #default="{ row }">
                    <span v-if="row.del_flag === '0'">上架</span>
                    <span v-else-if="row.del_flag === '1'">下架</span>
                    <span v-else-if="row.del_flag === '2'">仅管理员可见</span>
                  </template>
                </el-table-column>
                <el-table-column prop="sign_reward" label="签到日期" width="180">
                  <template #default="{ row }">
                    <span v-if="row.sign_reward === '0'">未设置</span>
                    <span v-if="row.sign_reward !== '0'">{{ row.sign_reward }}</span>
                  </template>
                </el-table-column>
                <el-table-column fixed="right" label="操作" width="740">
                  <template #default="scope">
                    <el-button type="primary" size="default"
                               @click="showUpdateGoodsExchangeForm(scope.row.id)">修改
                    </el-button>
                    <el-button type="danger" size="default" @click="deleteGoods(scope.row.id)">删除</el-button>
                    <template v-if="scope.row.sign_reward === '0'">
                      <el-button type="default" size="default" @click="showSignForm(scope.row)">设置签到奖励
                      </el-button>
                    </template>
                    <template v-else-if="scope.row.sign_reward !== '0'">
                      <el-button type="info" size="default" @click="cancelSignRewardGoods(scope.row.id)">
                        取消该签到奖励
                      </el-button>
                    </template>
                  </template>
                </el-table-column>
              </el-table>
              <!--  分页  -->
              <div class="pagination-row">
                <el-pagination v-model="currentPage" :page-sizes="[10]" :page-size="pageSize"
                               :total="totalGoodsData" layout="prev, pager, next,total"
                               @size-change="handleSizeChange" @update:current-page="handleClick"
                               @prev-click="handleClick" @next-click="handleClick">
                </el-pagination>
              </div>
            </el-tab-pane>
          </el-tabs>
        </el-tab-pane>
        <el-tab-pane label="卡密管理" name="tab2" class="my-tab-pane2">
          <div class="my-cashKey-el">
            <span>
              生成数量：
              <el-input-number v-model="cdKeyNum" :min="1" :max="100" size="large" @change="handleCdKeyNumChange"/>
            </span>
            <span style="margin-left: 10px">
              C点：
              <el-input-number v-model="cashNum" :min="1" :max="1000000" @change="handleCashNumChange" size="large"/>
            </span>
            <span style="margin-left: 5px">
              <el-button type="success" size="large" style="background-color: #67c23a" @click="generateKey">
                生成卡密
              </el-button>
            </span>
            <span style="margin-left: 15px">
              <el-button type="danger" size="large" @click="deleteAllKey">
                删除所有卡密
              </el-button>
            </span>
            <span style="margin-left: 15px">
              <el-button type="info" size="large" @click="allKeyUnused">
                查看所有未使用
              </el-button>
            </span>
            <span style="margin-left: 15px">
              <el-button type="default" size="large" @click="allKey">
                查看所有
              </el-button>
            </span>
          </div>
          <div>
            <el-table :data="currentPageDataForKey" border stripe style="width: 100%;" height="624px" size="large">
              <el-table-column prop="id" label="卡密ID" width="180" header-align="center" align="center"/>
              <el-table-column prop="cdKey" label="卡密" width="360" header-align="center" align="center"/>
              <el-table-column prop="cash" label="C点" width="180" sortable header-align="center" align="center"/>
              <el-table-column prop="createTime" label="创建时间" width="200" sortable header-align="center"
                               align="center"/>
              <el-table-column prop="useTime" label="使用时间" width="200" sortable header-align="center"
                               align="center">
                <template #default="{ row }">
                  <span v-if="row.useTime != null">{{ row.useTime }}</span>
                  <span v-else>未使用</span>
                </template>
              </el-table-column>
              <el-table-column prop="roleName" label="使用角色" width="300" sortable header-align="center"
                               align="center">
                <template #default="{ row }">
                  <span v-if="row.roleName != null">{{ row.roleName }}</span>
                  <span v-else>-</span>
                </template>
              </el-table-column>
              <el-table-column label="点击复制卡密">
                <template #default="scope">
                  <el-button size="default" @click="onCopyCashKeyClick(scope.row.cdKey)" type="info">
                    复制卡密
                  </el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>
          <div>
            <el-pagination v-model="currentPageForKey" :page-sizes="[10]" :page-size="pageSizeForKey"
                           :total="totalDataForKey" layout="prev, pager, next, jumper, total"
                           @size-change="handleSizeChangeForKey" @update:current-page="handleClickForKey"
                           @prev-click="handleClickForKey" @next-click="handleClickForKey">
            </el-pagination>
          </div>
        </el-tab-pane>
        <el-tab-pane label="活动时间表管理" name="tab3" class="my-tab-pane3">
          <div>
            <el-button type="primary" size="large" @click="showEventSaveExchangeForm">
              新增活动时间
            </el-button>
          </div>
          <div>
            <el-table :data="eventData" border stripe style="width: 100%;" height="661px">
              <el-table-column prop="event_name" label="活动名称" width="200" header-align="center" align="center"/>
              <el-table-column prop="monday" label="星期一" width="120" header-align="center" align="center"/>
              <el-table-column prop="tuesday" label="星期二" width="120" header-align="center" align="center"/>
              <el-table-column prop="wednesday" label="星期三" width="120" header-align="center" align="center"/>
              <el-table-column prop="thursday" label="星期四" width="120" header-align="center" align="center"/>
              <el-table-column prop="friday" label="星期五" width="120" header-align="center" align="center"/>
              <el-table-column prop="saturday" label="星期六" width="120" header-align="center" align="center"/>
              <el-table-column prop="sunday" label="星期日" width="120" header-align="center" align="center"/>
              <el-table-column label="操作">
                <template #default="scope">
                  <el-button size="default" type="primary" @click="showEventUpdateExchangeForm(scope.row.id)">修改
                  </el-button>
                  <el-button size="default" type="danger" @click="deleteEvent(scope.row.id)">删除</el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>

    <!-- 新增商品类型对话框 -->
    <el-dialog v-model="dialogVisibleForCategoryRules" title="新增商品类型" width="320px">
      <el-form ref="categoryFormValidate" :model="categoryForm" label-position="top" :rules="categoryRules">
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品类型名称</span>
          <el-form-item class="mall-myInput" prop="name">
            <el-input style="height: 38px; width: 160px;" type="text" placeholder="请输入商品类型名称"
                      v-model="categoryForm.name"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品类型排序</span>
          <el-form-item class="mall-myInput" prop="sort">
            <el-input style="height: 38px; width: 160px;" type="text" placeholder="请输入商品类型排序"
                      v-model="categoryForm.sort"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row" style="justify-content: flex-end; margin-top: 40px;">
          <el-button type="default" style="width: 70px; height: 40px" @click="cancelCategoryExchange">取消</el-button>
          <el-button type="primary" style="height: 40px;"
                     @click="categorySubmit">
            保存
          </el-button>
        </div>
      </el-form>
    </el-dialog>
    <!-- 修改商品类型对话框 -->
    <el-dialog v-model="dialogVisibleForUpdateCategoryRules" title="修改商品类型" width="320px">
      <el-form ref="updateCategoryFormValidate" :model="updateCategoryForm" label-position="top"
               :rules="updateCategoryRules">
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品类型名称</span>
          <el-form-item class="mall-myInput" prop="name">
            <el-input style="height: 38px; width: 160px;" type="text" placeholder="请输入商品类型名称"
                      v-model="updateCategoryForm.name"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品类型排序</span>
          <el-form-item class="mall-myInput" prop="sort">
            <el-input style="height: 38px; width: 160px;" type="text" placeholder="请输入商品类型排序"
                      v-model="updateCategoryForm.sort"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row" style="justify-content: flex-end; margin-top: 40px;">
          <el-button type="default" style="width: 70px; height: 40px" @click="cancelUpdateCategoryExchange">取消
          </el-button>
          <el-button type="primary" style="height: 40px;"
                     @click="updateCategorySubmit">
            保存
          </el-button>
        </div>
      </el-form>
    </el-dialog>

    <!-- 新增商品对话框 -->
    <el-dialog v-model="dialogVisibleForGoodsRules" title="新增商品" width="955px">
      <el-form ref="goodsFormValidate" :model="goodsForm" label-position="top" :rules="goodsRules">
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品名称</span>
          <el-form-item class="mall-myInput" prop="name">
            <el-input style="height: 38px; width: 760px;" type="text" placeholder="请输入商品名称"
                      v-model="goodsForm.name"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品描述</span>
          <el-form-item class="mall-myInput" prop="description">
            <el-input style="height: 38px; width: 760px;" type="text" placeholder="请输入商品描述"
                      v-model="goodsForm.description"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品价格</span>
          <el-form-item class="mall-myInput" prop="price">
            <el-input style="height: 38px; width: 760px;" type="text" placeholder="请输入商品价格，最小为0"
                      v-model="goodsForm.price"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品类型</span>
          <el-form-item class="mall-myInput" prop="type">
            <el-select v-model="goodsForm.type" class="m-2" placeholder="商品类型" size="large">
              <el-option
                  v-for="item in categoryData"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id"
              />
            </el-select>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品状态</span>
          <el-form-item class="mall-myInput" prop="del_flag">
            <div class="mb-2 flex items-center text-sm">
              <el-radio-group v-model="goodsForm.del_flag" class="ml-4">
                <el-radio label='0' size="large">上架</el-radio>
                <el-radio label='1' size="large">下架</el-radio>
                <el-radio label='2' size="large">上架(仅管理员可见)</el-radio>
              </el-radio-group>
            </div>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">tblidx</span>
          <el-form-item class="mall-myInput" prop="tblidx">
            <el-input style="height: 38px; width: 760px;" type="text" placeholder="请输入tblidx(纯数字)"
                      v-model="goodsForm.tblidx"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">place</span>
          <el-form-item class="mall-myInput" prop="place">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.place"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">pos</span>
          <el-form-item class="mall-myInput" prop="pos">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.pos"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">count</span>
          <el-form-item class="mall-myInput" prop="count">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.count"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">rank</span>
          <el-form-item class="mall-myInput" prop="rank">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.rank"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">durability</span>
          <el-form-item class="mall-myInput" prop="durability">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.durability"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">grade</span>
          <el-form-item class="mall-myInput" prop="grade">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.grade"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">needToIdentify</span>
          <el-form-item class="mall-myInput" prop="needToIdentify">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.needToIdentify"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">battleAttribute</span>
          <el-form-item class="mall-myInput" prop="battleAttribute">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.battleAttribute"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">maker</span>
          <el-form-item class="mall-myInput" prop="maker">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.maker"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionTblidx</span>
          <el-form-item class="mall-myInput" prop="optionTblidx">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionTblidx"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionTblidx2</span>
          <el-form-item class="mall-myInput" prop="optionTblidx2">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionTblidx2"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId</span>
          <el-form-item class="mall-myInput" prop="optionRandomId">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomId"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomVal"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId2</span>
          <el-form-item class="mall-myInput" prop="optionRandomId2">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomId2"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal2</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal2">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomVal2"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId3</span>
          <el-form-item class="mall-myInput" prop="optionRandomId3">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomId3"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal3</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal3">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomVal3"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId4</span>
          <el-form-item class="mall-myInput" prop="optionRandomId4">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomId4"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal4</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal4">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomVal4"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId5</span>
          <el-form-item class="mall-myInput" prop="optionRandomId5">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomId5"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal5</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal5">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomVal5"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId6</span>
          <el-form-item class="mall-myInput" prop="optionRandomId6">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomId6"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal6</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal6">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomVal6"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId7</span>
          <el-form-item class="mall-myInput" prop="optionRandomId7">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomId7"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal7</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal7">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomVal7"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId8</span>
          <el-form-item class="mall-myInput" prop="optionRandomId8">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomId8"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal8</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal8">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.optionRandomVal8"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">useStartTime</span>
          <el-form-item class="mall-myInput" prop="useStartTime">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.useStartTime"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">useEndTime</span>
          <el-form-item class="mall-myInput" prop="useEndTime">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.useEndTime"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">restrictState</span>
          <el-form-item class="mall-myInput" prop="restrictState">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.restrictState"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">durationType</span>
          <el-form-item class="mall-myInput" prop="durationType">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="goodsForm.durationType"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row" style="justify-content: flex-end; margin-top: 40px;">
          <el-button type="default" style="width: 70px; height: 40px" @click="cancelGoodsExchange">取消</el-button>
          <el-button type="primary" style="height: 40px;"
                     @click="goodsSubmit">
            保存
          </el-button>
        </div>
      </el-form>
    </el-dialog>
    <!-- 修改商品对话框 ------------------------------修改--------------------------------->
    <el-dialog v-model="dialogVisibleForUpdateGoodsRules" title="新增商品" width="955px">
      <el-form ref="updateGoodsFormValidate" :model="updateGoodsForm" label-position="top" :rules="updateGoodsRules">
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品名称</span>
          <el-form-item class="mall-myInput" prop="name">
            <el-input style="height: 38px; width: 760px;" type="text" placeholder="请输入商品名称"
                      v-model="updateGoodsForm.name"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品描述</span>
          <el-form-item class="mall-myInput" prop="description">
            <el-input style="height: 38px; width: 760px;" type="text" placeholder="请输入商品描述"
                      v-model="updateGoodsForm.description"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品价格</span>
          <el-form-item class="mall-myInput" prop="price">
            <el-input style="height: 38px; width: 760px;" type="text" placeholder="请输入商品价格，最小为0"
                      v-model="updateGoodsForm.price"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品类型</span>
          <el-form-item class="mall-myInput" prop="type">
            <el-select v-model="updateGoodsForm.type" class="m-2" placeholder="商品类型" size="large">
              <el-option
                  v-for="item in categoryData"
                  :key="item.id"
                  :label="item.name"
                  :value="item.id"
              />
            </el-select>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">商品状态</span>
          <el-form-item class="mall-myInput" prop="del_flag">
            <div class="mb-2 flex items-center text-sm">
              <el-radio-group v-model="updateGoodsForm.del_flag" class="ml-4">
                <el-radio label='0' size="large">上架</el-radio>
                <el-radio label='1' size="large">下架</el-radio>
                <el-radio label='2' size="large">上架(仅管理员可见)</el-radio>
              </el-radio-group>
            </div>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">tblidx</span>
          <el-form-item class="mall-myInput" prop="tblidx">
            <el-input style="height: 38px; width: 760px;" type="text" placeholder="请输入tblidx(纯数字)"
                      v-model="updateGoodsForm.tblidx"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">place</span>
          <el-form-item class="mall-myInput" prop="place">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.place"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">pos</span>
          <el-form-item class="mall-myInput" prop="pos">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.pos"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">count</span>
          <el-form-item class="mall-myInput" prop="count">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.count"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">rank</span>
          <el-form-item class="mall-myInput" prop="rank">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.rank"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">durability</span>
          <el-form-item class="mall-myInput" prop="durability">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.durability"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">grade</span>
          <el-form-item class="mall-myInput" prop="grade">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.grade"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">needToIdentify</span>
          <el-form-item class="mall-myInput" prop="needToIdentify">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.needToIdentify"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">battleAttribute</span>
          <el-form-item class="mall-myInput" prop="battleAttribute">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.battleAttribute"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">maker</span>
          <el-form-item class="mall-myInput" prop="maker">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.maker"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionTblidx</span>
          <el-form-item class="mall-myInput" prop="optionTblidx">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionTblidx"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionTblidx2</span>
          <el-form-item class="mall-myInput" prop="optionTblidx2">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionTblidx2"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId</span>
          <el-form-item class="mall-myInput" prop="optionRandomId">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomId"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomVal"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId2</span>
          <el-form-item class="mall-myInput" prop="optionRandomId2">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomId2"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal2</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal2">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomVal2"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId3</span>
          <el-form-item class="mall-myInput" prop="optionRandomId3">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomId3"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal3</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal3">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomVal3"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId4</span>
          <el-form-item class="mall-myInput" prop="optionRandomId4">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomId4"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal4</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal4">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomVal4"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId5</span>
          <el-form-item class="mall-myInput" prop="optionRandomId5">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomId5"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal5</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal5">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomVal5"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId6</span>
          <el-form-item class="mall-myInput" prop="optionRandomId6">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomId6"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal6</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal6">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomVal6"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId7</span>
          <el-form-item class="mall-myInput" prop="optionRandomId7">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomId7"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal7</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal7">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomVal7"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomId8</span>
          <el-form-item class="mall-myInput" prop="optionRandomId8">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomId8"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">optionRandomVal8</span>
          <el-form-item class="mall-myInput" prop="optionRandomVal8">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.optionRandomVal8"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">useStartTime</span>
          <el-form-item class="mall-myInput" prop="useStartTime">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.useStartTime"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">useEndTime</span>
          <el-form-item class="mall-myInput" prop="useEndTime">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.useEndTime"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">restrictState</span>
          <el-form-item class="mall-myInput" prop="restrictState">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.restrictState"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row">
          <span class="mall-dialogLabel">durationType</span>
          <el-form-item class="mall-myInput" prop="durationType">
            <el-input style="height: 38px; width: 760px;" type="text"
                      v-model="updateGoodsForm.durationType"></el-input>
          </el-form-item>
        </div>
        <div class="mall-form-row" style="justify-content: flex-end; margin-top: 40px;">
          <el-button type="default" style="width: 70px; height: 40px" @click="cancelUpdateGoodsExchange">取消
          </el-button>
          <el-button type="primary" style="height: 40px;"
                     @click="updateGoodsSubmit">
            保存
          </el-button>
        </div>
      </el-form>
    </el-dialog>

    <!--  活动表部分的表单  -->
    <!--  新增表单  -->
    <el-dialog v-model="dialogVisibleForEventSaveRules" title="新增活动时间" width="320px">
      <el-form ref="eventSaveFormValidate" :model="eventSaveForm" label-position="top" :rules="eventSaveRules">
        <div class="event-form-row">
          <span class="event-dialogLabel">活动名称</span>
          <el-form-item class="event-myInput" prop="event_name">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入活动名称"
                      v-model="eventSaveForm.event_name"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期一</span>
          <el-form-item class="event-myInput" prop="monday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventSaveForm.monday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期二</span>
          <el-form-item class="event-myInput" prop="tuesday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventSaveForm.tuesday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期三</span>
          <el-form-item class="event-myInput" prop="wednesday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventSaveForm.wednesday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期四</span>
          <el-form-item class="event-myInput" prop="thursday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventSaveForm.thursday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期五</span>
          <el-form-item class="event-myInput" prop="friday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventSaveForm.friday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期六</span>
          <el-form-item class="event-myInput" prop="saturday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventSaveForm.saturday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期日</span>
          <el-form-item class="event-myInput" prop="sunday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventSaveForm.sunday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row" style="justify-content: flex-end; margin-top: 40px;">
          <el-button type="default" style="width: 70px; height: 40px" size="large"
                     @click="cancelEventSaveExchange">取消
          </el-button>
          <el-button type="primary" style="height: 40px;" size="large"
                     @click="eventSaveSubmit">
            保存
          </el-button>
        </div>
      </el-form>
    </el-dialog>
    <!--  修改表单  -->
    <el-dialog v-model="dialogVisibleForEventUpdateRules" title="新增活动时间" width="320px">
      <el-form ref="eventUpdateFormValidate" :model="eventUpdateForm" label-position="top" :rules="eventUpdateRules">
        <div class="event-form-row">
          <span class="event-dialogLabel">活动名称</span>
          <el-form-item class="event-myInput" prop="event_name">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入活动名称"
                      v-model="eventUpdateForm.event_name"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期一</span>
          <el-form-item class="event-myInput" prop="monday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventUpdateForm.monday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期二</span>
          <el-form-item class="event-myInput" prop="tuesday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventUpdateForm.tuesday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期三</span>
          <el-form-item class="event-myInput" prop="wednesday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventUpdateForm.wednesday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期四</span>
          <el-form-item class="event-myInput" prop="thursday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventUpdateForm.thursday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期五</span>
          <el-form-item class="event-myInput" prop="friday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventUpdateForm.friday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期六</span>
          <el-form-item class="event-myInput" prop="saturday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventUpdateForm.saturday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row">
          <span class="event-dialogLabel">星期日</span>
          <el-form-item class="event-myInput" prop="sunday">
            <el-input style="height: 38px; width: 190px;" type="text" placeholder="请输入时间段"
                      v-model="eventUpdateForm.sunday"></el-input>
          </el-form-item>
        </div>
        <div class="event-form-row" style="justify-content: flex-end; margin-top: 40px;">
          <el-button type="default" style="width: 70px; height: 40px" size="large"
                     @click="cancelEventUpdateExchange">取消
          </el-button>
          <el-button type="primary" style="height: 40px;" size="large"
                     @click="eventUpdateSubmit">
            保存
          </el-button>
        </div>
      </el-form>
    </el-dialog>

    <!-- 签到奖励 -->
    <el-dialog v-model="dialogVisibleForSign" title="设置签到奖励" width="300px">
      <el-form ref="signFormValidate" :model="signForm" label-position="top" :rules="signRules">
        <div style="text-align: center; background-color: #cccccc">月日各2位数字，例如：5月8日</div>
        <div style="text-align: center; background-color: #cccccc">则写：508（填0表示取消该签到礼物）</div>
        <br>
        <div class="form-row">
          <span class="signLabel">日期时间</span>
          <el-form-item class="myInput" prop="sign">
            <el-input style="height: 40px; width: 175px" type="text" placeholder="请输入日期时间"
                      v-model="signForm.sign"></el-input>
          </el-form-item>
        </div>
        <div class="form-row" style="justify-content: flex-end; margin-top: 20px;">
          <el-button type="default" style="width: 70px; height: 40px" @click="cancelSign">取消</el-button>
          <el-button type="primary" style="background-color: #3388FF; color: #FFFFFF;height: 40px;"
                     @click="signSubmit">保存
          </el-button>
        </div>
      </el-form>
    </el-dialog>
  </template>
</template>

<style>
.my-cashKey-el {
  font-size: 17px;
}

.login-link {
  text-align: right;
}

.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 360px;
  margin-bottom: 376px;
}

.login-wrapper {
  width: 400px;
  padding: 20px;
  border-radius: 4px;
  background-color: #fff;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15); /* 添加阴影效果 */
}

.form {
  margin-bottom: 20px;
}

.links-container {
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
}

.link-wrapper {
  display: flex;
}

.forget-link {
  margin-top: 20px;
  margin-left: 80px;
}

.button-container {
  display: flex;
  justify-content: space-between;
  margin-top: 10px;
}

.subBtn {
  width: 35%;
  margin-left: 80px;
}

.login-btn {
  background-color: #fff;
  color: #000;
  width: 35%;
  margin-right: 40px;
}

.my-tab {
  background-image: url("@/assets/images/bg.png"); /* 设置背景图片的 URL */
  background-repeat: repeat; /* 将背景图片设置为平铺 */
}

.my-tab-pane {
  height: 690px;
}

.my-tab-pane2 {
  height: 699px;
}

.my-tab-pane3 {
  height: 699px;
}

.el-tabs__content {
  margin-top: 5px;
  padding: 2px !important; /* 移除padding样式 */
}

.mall-form-row {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
  margin-right: 15px;
}

.mall-myInput {
  margin-left: 18px;
}

.mall-dialogLabel {
  width: 85px;
  text-align: right;
  margin-bottom: 15px;
  font-size: 14px;
}


.event-form-row {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
  margin-right: 15px;
}

.event-myInput {
  margin-left: 18px;
}

.event-dialogLabel {
  width: 60px;
  text-align: right;
  margin-bottom: 15px;
  font-size: 14px;
}

.signLabel {
  width: 60px;
  text-align: right;
  margin-bottom: 15px;
  font-size: 15px;
}
</style>