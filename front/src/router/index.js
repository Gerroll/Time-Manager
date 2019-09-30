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
  ]
})
