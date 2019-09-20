<template>
    <div id="CreateUser">
        <div id="axiomGET">
            USER LIST: 
            <button v-on:click=userList>userList</button> {{ data }}
            <li v-for="u in data" :key="u">
                <ul>{{ u.id }}: {{ u.email }}</ul>
            </li>
        </div>

        <div id="axiomPOST">
            <div id="createUser">
                CREATE ACCOUNT:
                <input type="email" placeholder="email" v-model="email">
                <input type="text" placeholder="username" v-model="username">
                <input type="text" placeholder="password" v-model="password">
                <input type="text" placeholder="password2" v-model="password2">

                <button v-on:click=createUser>CreateUser</button>

                <li v-for="(key, value) in resCreate" :key="value">
                    <ul>{{ key }}{{ value }}</ul>
                </li>
                <!-- <ul>{{ item.id }}: {{ item.name }}</ul> -->
                {{ errmsgCreateuser }}
            </div>

            <div id="login">
                LOGIN:
                <input type="email" placeholder="email" v-model="loginEmail">
                <input type="text" placeholder="password" v-model="loginPass">

                <button v-on:click=login>Login</button> {{ loginErrMsg }}
            </div>
        </div>
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'CreateUser',
    methods: {
        userList() { // Basic get request
            axios.get("http://localhost:4000/user_list", {
                    crossOrigine: true,
                })
                .then(response => (this.data = response.data.data))
        },
        createUser() { // Basic post request
            if (this.password == this.password2) {
                axios.post("http://localhost:4000/api/createUser", {
                        user: {
                            email: this.email,
                            username: this.username,
                            password: this.password,
                            rank: 'employee' // employee, manager, general
                        }
                    })
                    .then(response => {
                        this.resCreate = response.data.data
                    })
                    .catch(err => { this.errmsgCreateuser = err })
                    .finally(console.log("this message allways get console.log succes/fail"))
            }
        },
        // login() {
        //     axios.post("http://localhost:4000/api/sign_in", {
        //             email: this.loginEmail,
        //             password: this.loginPass,
        //         })
        //         .then(response => {
        //             this.loginRes = response.data
        //             // console.log(response.data.token)
        //             axios.defaults.headers.common['x-xsrf-token'] = response.data.token
        //             window.location.pathname = "/"
        //         })
        //         .catch(err => { this.loginErrMsg = err })
        // }
    },
    data() {
        return {
            resCreate: null,
            data: null,
            email: null,
            username: null,
            password: null,
            password2: null,
            errmsgCreateuser: null
        }
    }
}
</script>