import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Users from '@/components/Users'
import General_Manager from "../components/General_Manager";
import Manager from "../components/Manager";
import CreateUser from '@/components/templateAPI/CreateUser'
import UserHome from '@/components/templateAPI/UserHome'
import Login from '@/components/templateAPI/Login'

Vue.use(Router)

const UserGuard = (to, from, next) => {
  // localStorage.getItem('token');
  // requete axios checktoken
  // next('/login') // if token pas bon
  // else
  next();
}

export default new Router({
  mode:'history',
  routes: [
    { path: '*', redirect: '/notfound' },
    { path: '/login', component: Login},
    { 
      beforeEnter: UserGuard,
      path:'/user/', children: [
        { path:'home', component: UserHome },
    ]},
    { 
      beforeEnter: UserGuard,
      path:'/template', component: CreateUser
    },

    // { path:'/employee/', children: [
    //   { path:'clock', component: clock},
    //   { path:'clock', component: clock},
    //   { path:'clock', component: clock},
    // ]},
    { 
      beforeEnter: UserGuard,
      path: '/', name:'Home', component: Home },
    { 
      beforeEnter: UserGuard,
      path: '/users', name:'Users', component: Users },
    { 
      beforeEnter: UserGuard,
      path: '/general-manager', name: 'GeneralManager', component: General_Manager },
    { 
      beforeEnter: UserGuard,
      path: '/manager', name: 'Manager', component: Manager },
    { 
      beforeEnter: UserGuard,
      path: '/manager/route', name: 'Manager', component: Manager },
    ]
})
