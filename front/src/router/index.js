import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Users from '@/components/Users'
import General_Manager from "../components/General_Manager";
import Manager from "../components/Manager";

Vue.use(Router)

export default new Router({
  mode:'history',
  routes: [
    { path: '/', name:'Home', component: Home },
    { path: '/users', name:'Users', component: Users },
    { path: '/general-manager', name: 'GeneralManager', component: General_Manager },
    { path: '/manager', name: 'Manager', component: Manager },
    { path: '/manager/route', name: 'Manager', component: Manager }
  ]
})
