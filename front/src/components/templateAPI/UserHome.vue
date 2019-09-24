<template>
    <div id="UserHome">
        <button v-if="this.manager" v-on:click=redirectManageTeam>Manage Teams</button>
        <button v-on:click=redirectProfile>Profile</button>
        <button v-on:click=clockIn>clockIn</button>
        <button v-on:click=clockOut>clockOut</button>
        <button v-on:click=getWorkingTime>refreshWorkingTime</button>
        <button v-on:click=logOut>logOut</button>
        <div>{{ data }} {{ dataErr }}</div>
        <div>{{ workingTime }}{{ workingTimeErr }}</div>

    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'UserHome',
    mounted() {
        const rank = localStorage.getItem('rank');
        if (rank === 'manager')
            this.manager = true
        else if (rank === 'general') {
            this.manager = true
            this.general = true
        }
        axios.get("http://localhost:4000/api/user/getWorkingTime", {
                crossOrigine: true,
            })
            .then(response => {
                this.workingTime = response.data.data
                this.workingTimeErr = null
            })
            .catch(err => {
                this.workingTime = null
                this.workingTimeErr = err.response.data
            })
    },
    methods: {
        redirectProfile() {
            this.$router.push('/user/profile')
        },
        redirectManageTeam() {
            this.$router.push('/manager/team')
        },
        clockIn() {
            axios.post("http://localhost:4000/api/user/clockIn", {
                    crossOrigine: true,
                })
                .then(response => {
                    this.data = response.data.data
                    this.dataErr = null
                })
                .catch(err => {
                    this.data = null
                    this.dataErr = err.response.data
                })
        },
        clockOut() {
            axios.put("http://localhost:4000/api/user/clockOut", {
                    crossOrigine: true,
                })
                .then(response => {
                    this.data = response.data.data
                    this.dataErr = null
                })
                .catch(err => {
                    this.data = null
                    this.dataErr = err.response.data
                })
        },
        getWorkingTime() {
            axios.get("http://localhost:4000/api/user/getWorkingTime", {
                    crossOrigine: true,
                })
                .then(response => {
                    this.workingTime = response.data.data
                    this.workingTimeErr = null
                })
                .catch(err => {
                    this.workingTime = null
                    this.workingTimeErr = err.response.data
                })
        },
        logOut() {
            localStorage.setItem('token', null)
            localStorage.setItem('rank', null)
            this.$router.push('/login')
        }
    },
    data() {
        return {
            data: null,
            dataErr: null,
            workingTime: null,
            workingTimeErr: null,
            manager: null,
            general: null,
        }
    }
}
</script>