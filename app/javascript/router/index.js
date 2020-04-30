import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    component: () => import('../pages/DividendsIndexPage.vue')
  },
  {
    path: '/brand_latest_dividends/:id',
    component: () => import('../pages/DividendDetailPage.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  routes
})

export default router
