<script setup>
import {ref, onMounted} from 'vue'
import {getEventList} from "@/apis/event";

const tableData = ref([])
const loading = ref(true);

const getEvent = async () => {
  const res = await getEventList()
  tableData.value = res.data;
  loading.value = false;
}

onMounted(()=> getEvent())
</script>

<template>
  <div class="event-contain">
    <el-table :data="tableData" stripe style="width: 80%; font-size: 15px;" align="center" :border="true" v-loading="loading">
      <el-table-column prop="event_name" label="活动名称" width="180">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.event_name }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="monday" label="星期一" width="180">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.monday }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="tuesday" label="星期二" width="180">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.tuesday }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="wednesday" label="星期三" width="180">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.wednesday }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="thursday" label="星期四" width="180">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.thursday }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="friday" label="星期五" width="180">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.friday }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="saturday" label="星期六" width="180">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.saturday }}
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="sunday" label="星期日" width="180">
        <template #header="{ column }">
          <div class="header-wrapper">
            {{ column.label }}
          </div>
        </template>
        <template #default="scope">
          <div class="cell-wrapper">
            {{ scope.row.sunday }}
          </div>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<style>
.event-contain{
  margin-top: 35px;
  margin-bottom: 90px;
  display: flex;
  justify-content: center;
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