<script setup>
import {ref} from "vue"

// 菜单栏部分
const initActiveIndex = ref('1')
const activeIndex = ref('1')
const handleSelect = (key, keyPath) => {
  activeIndex.value = key;
}

// 表格数据-活跃度
const tableDataForActivity = [
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    activity: '2333',
  },
]
// 表格数据-索尼
const tableDataForMoney = [
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
  {
    charName: '九木铃子九木铃子九木铃子九木铃子',
    level: '70',
    race: '龟仙流',
    guildName: '兔神领域',
    money: '2333',
  },
]

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
                style="width: 55%;"
                :cell-style="{textAlign: 'center'}">
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
        <el-table-column prop="race" label="职业" width="140">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="guildName" label="流派" width="260">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
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
                style="width: 55%;"
                :cell-style="{textAlign: 'center'}">
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
        <el-table-column prop="race" label="职业" width="140">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
          </template>
        </el-table-column>
        <el-table-column prop="guildName" label="流派" width="260">
          <template #header="{ column }">
            <div class="my-table-header">{{ column.label }}</div>
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