import { createRouter, createWebHistory } from 'vue-router'
import Login from '@/views/Login/index.vue'
import Layout from '@/views/Layout/index.vue'
import Home from '@/views/Home/index.vue'
import Skill from '@/views/Skill/index.vue'
import Event from '@/views/Event/index.vue'
import Register from '@/views/Register/index.vue'
import Forget from '@/views/Forget/index.vue'
import Me from '@/views/Me/index.vue'
import OrderKey from '@/views/OrderKey/index.vue'
import OrderMall from '@/views/OrderMall/index.vue'
import OrderAuction from '@/views/OrderAuction/index.vue'
import Signin from '@/views/Signin/index.vue'
import Mall from '@/views/Mall/index.vue'
import Admin from '@/views/Admin/index.vue'
import Rank from '@/views/Rank/index.vue'
import AuctionHouse from '@/views/AuctionHouse/index.vue'

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
          component: Event
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
          path: "orderKey",
          component: OrderKey
        },
        {
          path: "orderMall",
          component: OrderMall
        },
        {
          path: "orderAuction",
          component: OrderAuction
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
        },
        {
          path: 'admin',
          component: Admin
        },
        {
          path: 'rank',
          component: Rank
        },
        {
          path: 'auctionHouse',
          component: AuctionHouse
        }
      ]
    },

  ]
})

export default router
