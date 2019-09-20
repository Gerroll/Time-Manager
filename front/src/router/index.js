import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Users from '@/components/Users'
import General_Manager from "../components/General_Manager";
import Manager from "../components/Manager";
import ReportTIme from "../components/ReportTIme";
import AccountSettings from "../components/AccountSettings";
import TimeTeam from "../components/TimeTeam";
import TimeUser from "../components/TimeUser";

Vue.use(Router);

export default new Router({
  mode:'history',
  routes: [
    { path: '/', name:'Home', component: Home },

    { path: '/users', name:'Users', component: Users },
    { path: '/users/report-time', name: 'report-time', component: ReportTIme },
    { path: '/users/account-settings', name: 'account-settings', component: AccountSettings },

    { path: '/manager', name: 'Manager', component: Manager },
    { path: '/manager/time-team', name: 'TimeTeam', component: TimeTeam },
    { path: '/manager/time-user', name: 'TimeUser', component: TimeUser },

    { path: '/general-manager', name: 'GeneralManager', component: General_Manager },
  ]
})
