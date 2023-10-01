import '@/styles/common.scss'
import "element-plus/theme-chalk/el-message.css";
import "element-plus/theme-chalk/el-message-box.css";
import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'

import VueSmoothScroll from "vue2-smooth-scroll";


const app = createApp(App)

// 隐藏 右侧浏览器 滚动条
app.directive('smooth-scroll', VueSmoothScroll); // 注册指令

app.use(createPinia())
app.use(router)

app.mount('#app')
