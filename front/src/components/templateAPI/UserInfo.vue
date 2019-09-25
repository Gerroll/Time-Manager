<template>
    <div id="UserInfo">
        <button v-on:click=redirectUpdate>Udpate Profile</button>
        <button v-on:click=getInfoUser>getInfoUser</button>
        <button v-on:click=deleteUser>Delete User Profile</button> {{ data }} {{ dataErr }}
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'UserInfo',
    mounted() {
        axios.get(process.env.ROOT_API + "/api/user/info", {
                crossOrigine: true,
            })
            .then(response => (this.data = response.data.data))
            .catch(err => this.dataErr = err.response.data)
    },
    methods: {
        redirectUpdate() {
            this.$router.push('/user/update')
        },
        getInfoUser() {
            axios.get(process.env.ROOT_API + "/api/user/info", {
                    crossOrigine: true,
                })
                .then(response => this.data = response.data.data)
                .catch(err => this.dataErr = err.response.data)
        },
        deleteUser() {
            axios.delete(process.env.ROOT_API + "/api/user/delete", {})
                .then(response => {
                    this.data = response.data.data
                    this.dataErr = null
                    this.$router.push('/login')
                })
                .catch(err => {
                    this.data = null
                    this.dataErr = err.response.data
                })
        }
    },
    data() {
        return {
            data: null,
            dataErr: null,
        }
    }
}
</script>