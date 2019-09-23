<template>
    <div id="UserUpdate">
        <input type="email" placeholder="email" v-model="email">
        <input type="text" placeholder="username" v-model="username">
        <input type="password" placeholder="password" v-model="password">
        <input type="password" placeholder="password2" v-model="password2">
    
        <button v-on:click=updateInfoUser>updateInfoUser</button> {{ data }} {{ dataErr }}
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'UserUpdate',
    mounted() {
        axios.get("http://localhost:4000/api/user/info", {
                crossOrigine: true,
            })
            .then(response => (this.data = response.data.data))
            .catch(err => this.dataErr = err.response.data)
    },
    methods: {
        updateInfoUser() {
            if (this.password === this.password2 && this.password != null)
                axios.put("http://localhost:4000/api/user/update", {
                    crossOrigine: true,
                    user: {
                        username: this.username,
                        email: this.email,
                        password: this.password
                    }
                })
                .then(response => {
                    this.data = response.data.data
                    this.dataErr = null
                    getInfoUser()
                })
                .catch(err => this.dataErr = err.response.data)
        },
        getInfoUser() {
            axios.get("http://localhost:4000/api/user/info", {
                    crossOrigine: true,
                })
                .then(response => this.data = response.data.data)
                .catch(err => this.dataErr = err.response.data)
        }
    },
    data() {
        return {
            data: null,
            dataErr: null,
            email: null,
            username: null,
            password: null,
            password2: null,
        }
    }
}
</script>