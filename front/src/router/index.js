import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Users from '@/components/Users'
import General_Manager from "../components/General_Manager";
import Manager from "../components/Manager";
import CreateUser from '@/components/templateAPI/CreateUser'
import Login from '@/components/templateAPI/Login'
import UserInfo from '@/components/templateAPI/UserInfo'
import UserHome from '@/components/templateAPI/UserHome'
import UserUpdate from '@/components/templateAPI/UserUpdate'
import ManagerTeam from '@/components/templateAPI/ManagerTeam'
import ReportTIme from "../components/ReportTIme";
import AccountSettings from "../components/AccountSettings";
import TimeTeam from "../components/TimeTeam";
import TimeUser from "../components/TimeUser";

import axios from "axios";

Vue.use(Router);

const UserGuard = (to, from, next) => {
    const token = localStorage.getItem('token');
    axios.defaults.headers.common['x-xsrf-token'] = token
    axios.get(process.env.ROOT_API + "/api/verifyToken", {
            crossOrigine: true,
        })
        .then(response => {
            next()
        })
        .catch(err => {
            console.log("log first")
            next('/login')
        })
}

const ManagerGuard = (to, from, next) => {
    const token = localStorage.getItem('token');
    const rank = localStorage.getItem('rank');
    axios.defaults.headers.common['x-xsrf-token'] = token
    axios.get(process.env.ROOT_API + "/api/verifyToken", {
            crossOrigine: true,
        })
        .then(response => {
            if (rank == 'manager' || rank == 'general')
                next()
            else if (rank == 'employee')
                next('/user/home')
            else
                next('/login')
        })
        .catch(err => {
            console.log("log first")
            next('/login')
        })
}

const GeneralGuard = (to, from, next) => {
    const token = localStorage.getItem('token');
    const rank = localStorage.getItem('rank');
    axios.defaults.headers.common['x-xsrf-token'] = token
    axios.get(process.env.ROOT_API + "/api/verifyToken", {
            crossOrigine: true,
        })
        .then(response => {
            if (rank == 'general')
                next()
            else if (rank == 'manager' || rank == 'employee')
                next('/user/home')
            else
                next('/login')
        })
        .catch(err => {
            console.log("log first")
            next('/login')
        })
}

export default new Router({
    mode: 'history',
    routes: [{
            path: '*',
            redirect: '/login'
        },
        {
            path: '/login',
            component: Login
        },
        {
            beforeEnter: UserGuard,
            path: '/user/profile',
            component: UserInfo
        },
        {
            beforeEnter: UserGuard,
            path: '/user/update',
            component: UserUpdate
        },
        {
            beforeEnter: UserGuard,
            path: '/user/home',
            component: UserHome
        },
        {
            beforeEnter: ManagerGuard,
            path: '/manager/team',
            component: ManagerTeam
        },
        // {
        //   beforeEnter: UserGuard,
        //   path: '/template',
        //   component: CreateUser
        // },
        // {
        //   beforeEnter: UserGuard,
        //   path: '/',
        //   name: 'Home',
        //   component: Home
        // },
        {
            beforeEnter: UserGuard,
            path: '/users',
            name: 'Users',
            component: Users
        },
        {
            beforeEnter: UserGuard,
            path: '/general-manager',
            name: 'GeneralManager',
            component: General_Manager
        },
        {
            beforeEnter: UserGuard,
            path: '/manager',
            name: 'Manager',
            component: Manager
        },
        {
            path: '/users/report-time',
            name: 'report-time',
            component: ReportTIme
        },
        {
            path: '/users/account-settings',
            name: 'account-settings',
            component: AccountSettings
        },

        {
            path: '/manager',
            name: 'Manager',
            component: Manager
        },
        {
            path: '/manager/time-team',
            name: 'TimeTeam',
            component: TimeTeam
        },
        {
            path: '/manager/time-user',
            name: 'TimeUser',
            component: TimeUser
        },
    ]
})