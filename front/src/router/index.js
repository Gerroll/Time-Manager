import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Users from '@/components/Users'
import General_Manager from "../components/General_Manager";
import Manager from "../components/Manager";
import ReportTIme from "../components/ReportTIme";
import AccountSettings from "../components/AccountSettings";

Vue.use(Router)

export default new Router({
  mode:'history',
  routes: [
    { path: '/', name:'Home', component: Home },

    { path: '/users', name:'Users', component: Users },
    { path: '/users/report-time', name: 'report-time', component: ReportTIme },
    { path: '/users/account-settings', name: 'account-settings', component: AccountSettings },

    { path: '/general-manager', name: 'GeneralManager', component: General_Manager },
    { path: '/manager', name: 'Manager', component: Manager },
  ]
})
