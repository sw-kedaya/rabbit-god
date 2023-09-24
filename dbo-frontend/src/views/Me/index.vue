<script setup>
import {ref, onMounted} from 'vue';
import {checkApi, updateApi} from "@/apis/account";
import {ElMessage} from "element-plus";
import {useRouter} from "vue-router";

// 表单校验
const confirmPasswordValidator = (rule, value, callback) => {
  if (value !== passwordForm.value.newPassword) {
    callback(new Error('两次输入的密码不一致'));
  } else {
    callback();
  }
};

const passwordRules = {
  oldPassword: [
    {required: true, message: '请输入原密码'},
    {min: 6, max: 32, message: '密码长度应为6到32位'}
  ],
  newPassword: [
    {required: true, message: '请输入新密码'},
    {min: 6, max: 32, message: '密码长度应为6到32位'}
  ],
  confirmPassword: [
    {required: true, message: '请确认密码'},
    {min: 6, max: 32, message: '密码长度应为6到32位'},
    {validator: confirmPasswordValidator}
  ]
};

// 验证是否登录
const user = ref()
const dialogVisible = ref(false);

const tableData = ref([]);
const router = useRouter()
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

let updateFlag = ref(true)
onMounted(() => {
  // 进入前先判断登录没
  user.value = JSON.parse(localStorage.getItem("user-token"))
  checkQuest()

  // 120秒只能修改一次密码
  const updateTTL = localStorage.getItem("update-ttl");
  // 值不为空且还没过期，就先进入把倒计时走完再开放
  if (updateTTL && Date.now() < Number(updateTTL)) {
    updateFlag = ref(false);
    setTimeout(() => {
      updateFlag = ref(true);
    }, Number(updateTTL) - Date.now());
  }
})

// TODO 获取数据库中的数据，并将其赋值给 tableData
// 示例数据对象
const dataFromDatabase = [
  {
    name: "九木鈴子",
    level: 70,
    race: "人类",
    job: "鹤仙流",
    gender: "男",
    genre: "无",
  },
];
// TODO 将从数据库中获取的数据赋值给 tableData
tableData.value = dataFromDatabase;

// 修改密码
// const dialogVisible = ref(false);
const passwordForm = ref({
  username: '',
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
});

const showPasswordForm = () => {
  dialogVisible.value = true;
};

const updateQuest = async () => {
  const res = await updateApi(passwordForm.value)
  if (res.success){
    ElMessage.success('修改成功')
  }else {
    ElMessage.error(res.errorMsg)
  }
}

const passwordFormValidate = ref()
const updateTime = 120000;
const savePassword = () => {
  if (updateFlag.value) {
    passwordFormValidate.value.validate((valid) => {
      if (valid) {
        updateFlag = ref(false);
        passwordForm.value.username = user.value.username;
        updateQuest()
        localStorage.setItem("update-ttl", (Date.now() + updateTime).toString());
        setTimeout(() => {
          updateFlag = ref(true);
          localStorage.removeItem("update-ttl");
        }, updateTime);
        passwordForm.value = {
          username: '',
          oldPassword: '',
          newPassword: '',
          confirmPassword: ''
        };
        dialogVisible.value = false;
      } else {
        ElMessage.warning('请填写正确的信息');
      }
    });
  }else {
    ElMessage.warning('请120秒后再重试');
  }
};

// 修改密码取消按钮
const cancelPassword = () => {
  passwordForm.value = {
    username: '',
    oldPassword: '',
    newPassword: '',
    confirmPassword: ''
  };
  dialogVisible.value = false;
}
</script>

<template>
  <div id="me">
    <el-row v-if="user">
      <el-col :span="8" style="padding-left: 300px; padding-bottom: 250px">
        <el-card class="box-card grid-content bg-purple me is-always-shadow">
          <div class="el-card__body">
            账号：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.username }}</el-tag>
            <div style="height: 5px;"></div>
            状态：
            <el-tag class="el-tag--success el-tag--light" style="font-size: 15px;">正常</el-tag>
            <div style="height: 5px;"></div>
            邮箱：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.email }}</el-tag>
            <div style="height: 5px;"></div>
            余额：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.mallPoints }}</el-tag>
            <div style="height: 5px;"></div>
            现金扭蛋币：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.waguCoins }}</el-tag>
            <div style="height: 5px;"></div>
            活动扭蛋币：
            <el-tag class="el-tag--light" style="font-size: 15px;">{{ user.eventCoins }}</el-tag>
            <div style="height: 15px;"></div>
            <div style="height: 35px;">
              <el-button class="el-button--primary el-button--mini" style="width: 100%;" @click="showPasswordForm">
                修改密码
              </el-button>
            </div>
            <div style="height: 35px;">
              <el-button class="el-button--warning el-button--mini" style="width: 100%;">购买卡密</el-button>
            </div>
            <div style="height: 35px;">
              <el-button class="el-button--success el-button--mini" style="width: 100%;">卡密兑换</el-button>
            </div>
          </div>
        </el-card>
      </el-col>
      <el-col :span="13" style="padding-left: 10px; padding-right: 10px;">
        <el-card class="grid-content bg-purple is-always-shadow">
          <div class="el-card__body">
            <el-table :data="tableData" style="width: 100%;" stripe fit>
              <el-table-column label="角色" prop="name" align="center"></el-table-column>
              <el-table-column label="等级" prop="level" align="center"></el-table-column>
              <el-table-column label="种族" prop="race" align="center"></el-table-column>
              <el-table-column label="职业" prop="job" align="center"></el-table-column>
              <el-table-column label="性别" prop="gender" align="center"></el-table-column>
              <el-table-column label="流派" prop="genre" align="center"></el-table-column>
            </el-table>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
  <!-- 修改密码对话框 -->
  <el-dialog v-model="dialogVisible" title="修改密码" width="350px">
    <el-form ref="passwordFormValidate" :model="passwordForm" label-position="top" :rules="passwordRules">
      <div class="form-row">
        <span class="label">原密码</span>
        <el-form-item class="myInput" prop="oldPassword">
          <el-input style="height: 40px;" type="password" placeholder="请输入原密码"
                    v-model="passwordForm.oldPassword"></el-input>
        </el-form-item>
      </div>
      <div class="form-row">
        <span class="label">新密码</span>
        <el-form-item class="myInput" prop="newPassword">
          <el-input style="height: 40px;" type="password" placeholder="请输入新密码"
                    v-model="passwordForm.newPassword"></el-input>
        </el-form-item>
      </div>
      <div class="form-row">
        <span class="label">确认密码</span>
        <el-form-item class="myInput" prop="confirmPassword">
          <el-input style="height: 40px;" type="password" placeholder="请确认密码"
                    v-model="passwordForm.confirmPassword"></el-input>
        </el-form-item>
      </div>
      <div class="form-row" style="justify-content: flex-end; margin-top: 20px;">
        <el-button type="default" style="width: 70px; height: 40px" @click="cancelPassword">取消</el-button>
        <el-button type="primary" style="background-color: #3388FF; color: #FFFFFF;height: 40px;" @click="savePassword">
          确认修改
        </el-button>
      </div>
    </el-form>
  </el-dialog>
</template>

<style scoped lang="scss">
.el-tag {
  user-select: text; /* 允许选择文本 */
}

.form-row {
  display: flex;
  align-items: center;
  margin-bottom: 5px;
  margin-right: 15px;
}

.label {
  width: 60px;
  text-align: right;
  margin-bottom: 10px;
  margin-left: 25px;
  font-size: 15px;
}

.myInput {
  margin-left: 18px;
}
</style>