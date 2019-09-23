<template>
    <div id="login">
        LOGIN:
        <input type="email" placeholder="email" v-model="loginEmail">
        <input type="text" placeholder="password" v-model="loginPass">
    
        <button v-on:click=login>Login</button> {{ loginErrMsg }}
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'Login',
    methods: {
        login() {
            axios.post("http://localhost:4000/api/sign_in", {
                    email: this.loginEmail,
                    password: this.loginPass,
                })
                .then(response => {
                    localStorage.setItem('token', response.data.token)
                    axios.defaults.headers.common['x-xsrf-token'] = response.data.token
                    this.$router.push('/userInfo')
                })
                .catch(err => { this.loginErrMsg = err.response.data })
        }
    },
    data() {
        return {
            loginEmail: null,
            loginPass: null,
            loginErrMsg: null
        }
    }
}
</script>