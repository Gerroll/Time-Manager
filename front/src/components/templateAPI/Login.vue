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
    // mounted() {
    //     const token = localStorage.getItem('token')
    //     axios.defaults.headers.common['x-xsrf-token'] = response.data.token
    // },
    methods: {
        login() {
            axios.post("http://localhost:4000/api/sign_in", {
                    email: this.loginEmail,
                    password: this.loginPass,
                })
                .then(response => {
                    axios.defaults.headers.common['x-xsrf-token'] = response.data.token
                    window.location.pathname = "/"
                })
                .catch(err => { this.loginErrMsg = err })

            // requete axios login
            // recup token
            // localStorage.setItem('token', token)
            // axios.defaults.headers.common['x-xsrf-token'] = response.data.token
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