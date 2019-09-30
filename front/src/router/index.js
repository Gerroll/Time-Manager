import Vue from 'vue'
import Router from 'vue-router'
import General_Manager from "../components/General_Manager";
import Login from '@/components/templateAPI/Login'
import UserInfo from '@/components/templateAPI/UserInfo'
import UserHome from '@/components/templateAPI/UserHome'
import UserUpdate from '@/components/templateAPI/UserUpdate'
import Dashboard from '@/components/templateAPI/Dashboard'
import ManagerTeam from '@/components/templateAPI/ManagerTeam'
import AccountSettings from "../components/AccountSettings";
import TemplateIn from "../components/templateAPI/TemplateIn";

import axios from "axios";

Vue.use(Router);

const UserGuard = (to, from, next) => {
  const token = localStorage.getItem('token');
  axios.defaults.headers.common['x-xsrf-token'] = token
  axios.get(process.env.ROOT_API + "/api/user/verifyToken", {
      crossOrigine: true,
    })
    .then(response => {
      next()
    })
    .catch(err => {
      next('/login')
    })
}

const ManagerGuard = (to, from, next) => {
  const token = localStorage.getItem('token');
  const rank = localStorage.getItem('rank');
  axios.defaults.headers.common['x-xsrf-token'] = token
  axios.get(process.env.ROOT_API + "/api/manager/verifyToken", {
      crossOrigine: true,
    })
    .then(response => {
      next()
    })
    .catch(err => {
      next('/login')
    })
}

const GeneralGuard = (to, from, next) => {
  const token = localStorage.getItem('token');
  const rank = localStorage.getItem('rank');
  axios.defaults.headers.common['x-xsrf-token'] = token
  axios.get(process.env.ROOT_API + "/api/general/verifyToken", {
      crossOrigine: true,
    })
    .then(response => {
      next()
    })
    .catch(err => {
      next('/login')
    })
}

export default new Router({
  mode: 'history',
  routes: [
    // {
    //   path: '*',
    //   redirect: '/login'
    // },
    // {
    //   path: '/login',
    //   component: Login
    // },
    // {
    //   beforeEnter: UserGuard,
    //   path: '/user/profile',
    //   component: UserInfo
    // },
    // {
    //   beforeEnter: UserGuard,
    //   path: '/user/update',
    //   component: UserUpdate
    // },
    // {
    //   beforeEnter: UserGuard,
    //   path: '/user/home',
    //   component: UserHome
    // },
    // {
    //   beforeEnter: ManagerGuard,
    //   path: '/manager/team',
    //   component: ManagerTeam
    // },
    // {
    //   beforeEnter: UserGuard,
    //   path: '/users',
    //   name: 'Users',
    //   component: Users
    // },
    // {
    //   beforeEnter: GeneralGuard,
    //   path: '/general-manager',
    //   name: 'GeneralManager',
    //   component: General_Manager
    // },
    // {
    //   beforeEnter: UserGuard,
    //   path: '/manager',
    //   name: 'Manager',
    //   component: Manager
    // },
    // {
    //   path: '/users/report-time',
    //   name: 'report-time',
    //   component: ReportTIme
    // },
    // {
    //   path: '/users/account-settings',
    //   name: 'account-settings',
    //   component: AccountSettings
    // },
    // {
    //   path: '/manager',
    //   name: 'Manager',
    //   component: Manager
    // },
    // {
    //   path: '/manager/time-team',
    //   name: 'TimeTeam',
    //   component: TimeTeam
    // },
    // {
    //   path: '/manager/time-user',
    //   name: 'TimeUser',
    //   component: TimeUser
    // },
    // {
    //   beforeEnter: UserGuard,
    //   path: '/user/dashboard',
    //   name: 'Dashboard',
    //   component: Dashboard
    // },
    {
      path: '/',
      component: TemplateIn,
      children: [
        {
          beforeEnter: UserGuard,
          path: '',
          component: UserHome,
          children: [
            {
              path: '',
              component: UserHome
            },
            {
              path: 'dashboard',
              component: Dashboard
            },
            {
              path: 'profile',
              component: UserInfo
            },
            {
              path: 'update',
              component: UserUpdate
            },
          ]
        },
        {
          beforeEnter: ManagerGuard,
          path: '',
          component: UserHome,
          children: [
            {
              path: 'team',
              component: ManagerTeam
            },
          ]
        },
        {
          beforeEnter: GeneralGuard,
          path: '',
          component: UserHome,
          children: [
            {
              path: 'accountSetting',
              component: General_Manager
            },
          ]
        }
      ]
    },
    {
      path: '*',
      redirect: '/login'
    },
    {
      path: '/login',
      component: Login
    },

        // {
    //   beforeEnter: ManagerGuard,
    //   path: '/manager/team',
    //   component: ManagerTeam
    // },
  ]
})
