<template>
    <div id="login">
        <button v-on:click=getInfoUser>getInfoUser</button> {{ data }} {{ dataErr }}
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'UserInfo',
    mounted() {
        axios.get("http://localhost:4000/api/user/info", {
                crossOrigine: true,
            })
            .then(response => (this.data = response.data.data))
            .catch(err => this.dataErr = err.response.data)
    },
    methods: {
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
            dataErr: null
        }
    }
}
</script>