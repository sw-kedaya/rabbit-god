<script setup>
import {getActivityVal} from '@/views/composables/activity'
const tableData = getActivityVal().activityList
</script>

<template>
  <el-table :data="tableData" stripe style="width: 100%" align="center">
    <el-table-column prop="name" label="活动名称" width="180"/>
    <el-table-column prop="monday" label="星期一" width="180"/>
    <el-table-column prop="tuesday" label="星期二" width="180"/>
    <el-table-column prop="wednesday" label="星期三" width="180"/>
    <el-table-column prop="thursday" label="星期四" width="180"/>
    <el-table-column prop="friday" label="星期五" width="180"/>
    <el-table-column prop="saturday" label="星期六" width="180"/>
    <el-table-column prop="sunday" label="星期七" width="180"/>
  </el-table>
</template>


