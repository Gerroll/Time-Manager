import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Users from '@/components/Users'
import WorkingTime from '@/components/WorkingTime.vue'
import WorkingTimes from '@/components/WorkingTimes.vue'
import ClockManager from '@/components/ClockManager.vue'
import ChartManager from '@/components/ChartManager.vue'

Vue.use(Router)

export default new Router({
  routes: [
    { path: '/', name:'Home', component: Home },
    { path: '/users', name:'Users', component: Users },
    { path: '/worktime', name: 'WorkingTime', component: WorkingTime },
    { path: '/worktimes', name: 'WorkingTimes', component: WorkingTimes },
    { path: '/clock', name: 'ClockManager', component: ClockManager },
    { path: '/chart', name: 'ChartManager', component: ChartManager }
  ]
})
