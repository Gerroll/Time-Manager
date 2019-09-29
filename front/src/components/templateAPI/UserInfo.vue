<template>
    <div id="UserInfo" class="pt-5">
        <h2>Profile</h2>
        <h6>You can directly edit your information</h6>
    
        <form @submit.prevent="updateInfoUser" v-if="userInfo" class="container w-25 mt-5 p-5 shadow border border-secondary">
            <div class="form-group">
                <label for="exampleInputEmail1">Email address</label>
                <input v-model="userInfo.email" type="email" class="form-control" placeholder="Enter email">
            </div>
            <div class="form-group">
                <label for="exampleInputUsername">Username</label>
                <input v-model="userInfo.username" type="text" class="form-control" placeholder="Enter username">
            </div>
            <div class="form-group">
                <label for="exampleInputEmail1">New password</label>
                <input v-model="pass1" type="password" class="form-control" placeholder="Enter new password">
            </div>
            <div class="form-group">
                <label for="exampleInputEmail1">Confirmation new password</label>
                <input v-model="pass2" type="password" class="form-control" placeholder="Enter new password again">
            </div>
            <button type="submit" class="btn btn-primary">Update User informations</button>
        </form>
    </div>
</template>

<script>
import Vue from 'vue'
import axios from "axios";

export default {
    name: 'UserInfo',
    data() {
        return {
            userInfo: null,
            firstEmail: null,
            pass1: null,
            pass2: null,
            dataErr: null,
        }
    },
    mounted() {
        this.getInfoUser()
    },
    methods: {
        redirectUpdate() {
            this.$router.push('/update')
        },
        getInfoUser() {
            axios.get(process.env.ROOT_API + "/api/user/info", {
                    crossOrigine: true,
                })
                .then(response => {
                    this.userInfo = response.data.data
                    this.firstEmail = this.userInfo.email
                })
                .catch(err => this.dataErr = err.response.data)
        },
        updateInfoUser() {
            let mail = null
            if (this.firstEmail != this.userInfo.email)
                mail = this.userInfo.email
            if (this.pass1 == this.pass2)
                axios.put(process.env.ROOT_API + "/api/user/update", {
                    crossOrigine: true,
                    user: {
                        username: this.userInfo.username,
                        email: mail,
                        password: this.pass1
                    }
                })
                .then(response => {
                    this.data = response.data.data
                    this.dataErr = null
                    this.getInfoUser()
                    Vue.notify({
                        group: 'app',
                        title: 'Information message',
                        text: 'Accont updated'
                    })
                })
                .catch(err => {
                    // this.dataErr = err.response.data
                    console.log(err)
                })
        }
    }
}
</script>