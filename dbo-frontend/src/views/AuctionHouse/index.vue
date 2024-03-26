<script setup>

</script>

<template>
  <div class="my-table-auction">
    <el-table :data="tableDataForActivity" border stripe size="large"
              style="width: 55%;" v-loading="loadingForActivity"
              :cell-style="{textAlign: 'center'}">
      <el-table-column prop="charName" label="商品名" width="260">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
      </el-table-column>
      <el-table-column prop="level" label="等级" width="120">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
      </el-table-column>
      <el-table-column prop="dboClassName" label="职业" width="140">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
        <template #default="{ row }">
            <span v-if="row.dboClassName === '武道家'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/1_small.png" alt=""/>
              <span style="margin-left: 10px">武道家</span>
            </span>
          <span v-else-if="row.dboClassName === '气功师'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/2_small.png" alt=""/>
              <span style="margin-left: 10px">气功师</span>
            </span>
          <span v-else-if="row.dboClassName === '那美克战士'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/3_small.png" alt=""/>
              <span style="margin-left: 10px">那美克战士</span>
            </span>
          <span v-else-if="row.dboClassName === '那美克龙族'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/4_small.png" alt=""/>
              <span style="margin-left: 10px">那美克龙族</span>
            </span>
          <span v-else-if="row.dboClassName === '大魔人'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/5_small.png" alt=""/>
              <span style="margin-left: 10px">大魔人</span>
            </span>
          <span v-else-if="row.dboClassName === '意魔人'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/6_small.png" alt=""/>
              <span style="margin-left: 10px">意魔人</span>
            </span>
          <span v-else-if="row.dboClassName === '格斗家'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/11_small.png" alt=""/>
              <span style="margin-left: 10px">格斗家</span>
            </span>
          <span v-else-if="row.dboClassName === '鹤仙流'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/12_small.png" alt=""/>
              <span style="margin-left: 10px">鹤仙流</span>
            </span>
          <span v-else-if="row.dboClassName === '魔界战士'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/13_small.png" alt=""/>
              <span style="margin-left: 10px">魔界战士</span>
            </span>
          <span v-else-if="row.dboClassName === '天天导师'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/14_small.png" alt=""/>
              <span style="margin-left: 10px">天天导师</span>
            </span>
          <span v-else-if="row.dboClassName === '奥迪魔'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/15_small.png" alt=""/>
              <span style="margin-left: 10px">奥迪魔</span>
            </span>
          <span v-else-if="row.dboClassName === '普利兹魔'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/16_small.png" alt=""/>
              <span style="margin-left: 10px">普利兹魔</span>
            </span>
          <span v-else-if="row.dboClassName === '剑术家'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/17_small.png" alt=""/>
              <span style="margin-left: 10px">剑术家</span>
            </span>
          <span v-else-if="row.dboClassName === '龟仙流'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/18_small.png" alt=""/>
              <span style="margin-left: 10px">龟仙流</span>
            </span>
          <span v-else-if="row.dboClassName === '魔导战士'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/19_small.png" alt=""/>
              <span style="margin-left: 10px">魔导战士</span>
            </span>
          <span v-else-if="row.dboClassName === '波可导师'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/20_small.png" alt=""/>
              <span style="margin-left: 10px">波可导师</span>
            </span>
          <span v-else-if="row.dboClassName === '格兰魔'" class="rank-icon-auction">
              <img src="/MyHTML/skill-web/img/skill/21_small.png" alt=""/>
              <span style="margin-left: 10px">格兰魔</span>
            </span>
          <span v-else-if="row.dboClassName === '卡尔魔'">
              <img src="/MyHTML/skill-web/img/skill/22_small.png" alt=""/>
              <span style="margin-left: 10px">卡尔魔</span>
            </span>
          <span v-else>未知</span>
        </template>
      </el-table-column>
      <el-table-column prop="guildName" label="流派" width="260">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
        </template>
        <template #default="{ row }">
          <div>{{ row.guildName || '无' }}</div>
        </template>
      </el-table-column>
      <el-table-column prop="activity" label="活跃度">
        <template #header="{ column }">
          <div class="my-table-auction-header">{{ column.label }}</div>
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