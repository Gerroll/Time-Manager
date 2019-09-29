<template>
    <div class="users">
        <!-- <nav class="navbar navbar-dark bg-dark">
            <a class="navbar-brand" href="/">Time-Manager</a>
            <div class="w3-xlarge">
                <div id="UserHome">
                    <button v-if="this.manager" v-on:click=redirectManageTeam>Manage Teams</button>
                    &nbsp; &nbsp; &nbsp;
                    <a v-on:click="redirectDashboard">Dashboard</a>
                    <i class="fa fa-user"><a v-on:click=redirectProfile>Profile</a></i> &nbsp;
                    <i class="fa fa-refresh"><a v-on:click=getWorkingTime>RefreshWorkingTime</a></i> &nbsp;
                    <i class="fa fa-close"><a v-on:click=logOut>LogOut</a></i> &nbsp;
    
                    <div>{{ data }} {{ dataErr }}</div>
                    <div>{{ workingTime }}{{ workingTimeErr }}</div>
    
                </div>
            </div>
        </nav> -->
        <router-view/>

        <!-- <div class="div_form">
            <form class="container form_user">
                <a class="push_button white" v-on:click=clockIn>clockIn</a>
                <a class="push_button gray" v-on:click=clockOut>clockOut</a>
            </form>
        </div> -->
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
        axios.get(process.env.ROOT_API + "/api/user/getWorkingTime", {
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
        redirectDashboard() {
            this.$router.push('/user/dashboard')
        },
        redirectProfile() {
            this.$router.push('/user/profile')
        },
        redirectManageTeam() {
            this.$router.push('/manager/team')
        },
        clockIn() {
            axios.post(process.env.ROOT_API + "/api/user/clockIn", {
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
            axios.put(process.env.ROOT_API + "/api/user/clockOut", {
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
            axios.get(process.env.ROOT_API + "/api/user/getWorkingTime", {
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

<style scoped>
.users {
    text-align: center;
    font-family: "DejaVu Math TeX Gyre";
}

i {
    color: #eeeeee;
}

.push_button {
    position: relative;
    width: 220px;
    height: 40px;
    text-align: center;
    color: #FFF;
    text-decoration: none;
    line-height: 43px;
    font-family: 'Oswald', Helvetica;
    display: block;
    margin: 30px;
}

.push_button:before {
    background: #f0f0f0;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .5) inset, 0 1px 0 #FFF;
    -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .5) inset, 0 1px 0 #FFF;
    box-shadow: 0 1px 2px rgba(0, 0, 0, .5) inset, 0 1px 0 #FFF;
    position: absolute;
    content: "";
    left: -6px;
    right: -6px;
    top: -6px;
    bottom: -10px;
    z-index: -1;
}

.push_button:active {
    -webkit-box-shadow: 0 1px 0 rgba(255, 255, 255, .5) inset, 0 -1px 0 rgba(255, 255, 255, .1) inset;
    top: 5px;
}

.push_button:active:before {
    top: -11px;
    bottom: -5px;
    content: "";
}

.gray {
    text-shadow: -1px -1px 0 rgb(136, 136, 136);
    background: rgb(136, 136, 136);
    border: 1px solid rgb(136, 136, 136);
    background-image: -webkit-linear-gradient(top, rgb(133, 132, 132), rgb(136, 136, 136));
    background-image: -moz-linear-gradient(top, rgb(133, 132, 132), rgb(136, 136, 136));
    background-image: -ms-linear-gradient(top, rgb(133, 132, 132), rgb(136, 136, 136));
    background-image: -o-linear-gradient(top, rgb(133, 132, 132), rgb(136, 136, 136));
    background-image: linear-gradient(to bottom, rgb(133, 132, 132), rgb(136, 136, 136));
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    -webkit-box-shadow: 0 1px 0 rgba(255, 255, 255, .5) inset, 0 -1px 0 rgba(255, 255, 255, .1) inset, 0 4px 0 rgb(136, 136, 136), 0 4px 2px rgba(0, 0, 0, .5);
    -moz-box-shadow: 0 1px 0 rgba(255, 255, 255, .5) inset, 0 -1px 0 rgba(255, 255, 255, .1) inset, 0 4px 0 rgb(136, 136, 136), 0 4px 2px rgba(0, 0, 0, .5);
    box-shadow: 0 1px 0 rgba(255, 255, 255, .5) inset, 0 -1px 0 rgba(255, 255, 255, .1) inset, 0 4px 0 rgb(136, 136, 136), 0 4px 2px rgba(0, 0, 0, .5);
}

.gray:hover {
    background: rgb(133, 132, 132);
    background-image: -webkit-linear-gradient(top, rgb(136, 136, 136), rgb(133, 132, 132));
    background-image: -moz-linear-gradient(top, rgb(136, 136, 136), rgb(133, 132, 132));
    background-image: -ms-linear-gradient(top, rgb(136, 136, 136), rgb(133, 132, 132));
    background-image: -o-linear-gradient(top, rgb(136, 136, 136), rgb(133, 132, 132));
    background-image: linear-gradient(top, rgb(136, 136, 136), rgb(133, 132, 132));
}

.white {
    text-shadow: -1px -1px 0 rgb(202, 202, 202);
    background: rgb(204, 204, 204);
    border: 1px solid rgb(204, 204, 204);
    background-image: -webkit-linear-gradient(top, rgb(255, 255, 255), rgb(204, 204, 204));
    background-image: -moz-linear-gradient(top, rgb(255, 255, 255), rgb(204, 204, 204));
    background-image: -ms-linear-gradient(top, rgb(255, 255, 255), rgb(204, 204, 204));
    background-image: -o-linear-gradient(top, rgb(255, 255, 255), rgb(204, 204, 204));
    background-image: linear-gradient(top, rgb(255, 255, 255), rgb(204, 204, 204));
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    -webkit-box-shadow: 0 1px 0 rgba(255, 255, 255, .5) inset, 0 -1px 0 rgba(255, 255, 255, .1) inset, 0 4px 0 rgb(204, 204, 204), 0 4px 2px rgba(0, 0, 0, .5);
    -moz-box-shadow: 0 1px 0 rgba(255, 255, 255, .5) inset, 0 -1px 0 rgba(255, 255, 255, .1) inset, 0 4px 0 rgb(204, 204, 204), 0 4px 2px rgba(0, 0, 0, .5);
    box-shadow: 0 1px 0 rgba(255, 255, 255, .5) inset, 0 -1px 0 rgba(255, 255, 255, .1) inset, 0 4px 0 rgb(204, 204, 204), 0 4px 2px rgba(0, 0, 0, .5);
}

.white:hover {
    background: rgb(255, 255, 255);
    background-image: -webkit-linear-gradient(top, rgb(204, 204, 204), rgb(255, 255, 255));
    background-image: -moz-linear-gradient(top, rgb(204, 204, 204), rgb(255, 255, 255));
    background-image: -ms-linear-gradient(top, rgb(204, 204, 204), rgb(255, 255, 255));
    background-image: -o-linear-gradient(top, rgb(204, 204, 204), rgb(255, 255, 255));
    background-image: linear-gradient(top, rgb(204, 204, 204), rgb(255, 255, 255));
}

#logo {
    padding: 2%;
}

.div_form {
    background-color: black;
    color: white;
    padding: 5%;
}

.form_user {
    background-color: #9f9f9f;
    padding: 4%;
}

@media screen and (max-width: 708px) {
    #logo img {
        width: 30%;
    }
}
</style>