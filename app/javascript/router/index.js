import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/brands',
    component: () => import('../pages/BrandIndexPage.vue')
  },
  {
    path: '/brands/:id',
    component: () => import('../pages/BrandDetailPage.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

export default router
