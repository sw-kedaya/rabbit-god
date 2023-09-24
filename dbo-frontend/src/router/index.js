import { createRouter, createWebHistory } from 'vue-router'
import Login from '@/views/Login/index.vue'
import Layout from '@/views/Layout/index.vue'
import Home from '@/views/Home/index.vue'
import Skill from '@/views/Skill/index.vue'
import Activity from '@/views/Activity/index.vue'
import Register from '@/views/Register/index.vue'
import Forget from '@/views/Forget/index.vue'
import Me from '@/views/Me/index.vue'
import Order from '@/views/Order/index.vue'
import Signin from '@/views/Signin/index.vue'
import Mall from '@/views/Mall/index.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '',
      component: Layout,
      redirect: 'home',
      children: [
        {
          path: 'home',
          component: Home
        },
        {
          path: "activity",
          component: Activity
        },
        {
          path: "skill",
          component: Skill
        },
        {
          path: "signin",
          component: Signin
        },
        {
          path: "mall",
          component: Mall
        },
        {
          path: "me",
          component: Me
        },
        {
          path: "order",
          component: Order
        },
        {
          path: '/login',
          component: Login
        },
        {
          path: '/register',
          component: Register
        },
        {
          path: '/forget',
          component: Forget
        }
      ]
    },

  ]
})

export default router
