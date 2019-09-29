<template>
    <div class="users">
        <div id="logo">
            <img src="../assets/gotham.png" alt="logo" width="15%" />
        </div>
        <div class="div_form">
            <h1 class="titre">The General Manager</h1>

            <div class="container form_user">
                <h3>Account Settings</h3>
                <div class="row mb-3">
                    <select v-model="selectUser" class="form-control custom-select">
                        <option :value="null" selected="selected">Select User to edit</option>
                        <option v-for="user in users_list" :key="user.id" :value="user">{{user.email}}</option>
                    </select>
                </div>
                <div class="row mb-3">
                    <div class="input-group" id="inputGroupSelect04" v-if="selectUser">
                        <select v-model="selectRank" class="form-control custom-select">
                            <option :value="null" selected="selected">Select a rank to update "{{selectUser.email}}"</option>
                            <option v-for="rank in rank_list" :key="rank.id" :value="rank">{{rank}}</option>
                        </select>
                        <div class="input-group-append" v-if="selectUser && selectRank">
                            <button class="btn btn-info" type="button" v-on:click="updateRankUser()">Set user "{{ selectUser.email}}" to {{ selectRank }}</button>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-center">
                    <button v-if="selectUser" class="btn btn-danger center" v-on:click="deleteUser()">Delete user "{{ selectUser.email }}" from the app</button>
                </div>
            </div>
        </div>
    

    <!-- create part -->
        <div class="container w-25 mt-5">
            <h3 class="mb-2" style="text-align: center">Créer un utilisateur</h3>
            <form v-on:submit.prevent="createUser()">
                <div class="form-group">
                    <input type="email" class="form-control" placeholder="Enter email" v-model="userToCreate.email">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Enter username" v-model="userToCreate.username">
                </div>
                <div class="form-group">
                    <select v-model="userToCreate.rank" class="form-control custom-select">
                        <option value="" selected="selected">Select a rank</option>
                        <option v-for="rank in rank_list" :key="rank.id" :value="rank">{{rank}}</option>
                    </select>
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="Password" v-model="userToCreate.password">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="Confirme Password" v-model="userToCreate.verifPass">
                </div>
                <small id="emailHelp" class="form-text text-muted">{{errCreateUser}}</small>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </div>
</template>

<script>
import axios from "axios";

export default {

    name: 'General_Manager',

    data() {
        return {
            rank_list: null,
            errGetRankList: null,
            users_list: null,
            errGetUserList: null,
            resCreate: null,
            errCreateUser: null,
            resUpdate: null,
            errUpdateUser: null,
            userToDel: null,
            errDeleteUser: null,
            selectUser: null,
            selectRank: null,
            userToCreate: { username: "", email: "", rank: "", password: "" }
        }
    },
    mounted() {
        axios.get(process.env.ROOT_API + "/api/general/getListRank", {})
            .then(res => {
                this.rank_list = res.data.data;
            })
            .catch(err => {
                this.errGetRankList = err.response.data
            })
        axios.get(process.env.ROOT_API + "/api/general/user_list", {
                crossOrigin: true
            })
            .then(res => {
                this.users_list = res.data.data;
            })
            .catch(err => {
                this.errGetUserList = err.response.data
            })
    },
    methods: {
        getListRank() {
            axios.get(process.env.ROOT_API + "/api/general/getListRank", {})
                .then(res => {
                    this.rank_list = res.data.data;
                })
                .catch(err => {
                    this.errGetRankList = err.response.data
                })
        },
        getUserList() {
            axios.get(process.env.ROOT_API + "/api/general/user_list", {
                    crossOrigin: true
                })
                .then(res => {
                    this.users_list = res.data.data;
                })
                .catch(err => {
                    this.errGetUserList = err.response.data
                })
        },
        createUser() {
            if (this.userToCreate.password != this.userToCreate.verifPass)
                this.errCreateUser = "KO : passwords don't match"
            else if (this.userToCreate.rank == null)
                this.errCreateUser = "KO : please select rank"
            else
                axios.post(process.env.ROOT_API + "/api/general/createUser", {
                    user: {
                        email: this.userToCreate.email,
                        username: this.userToCreate.username,
                        rank: this.userToCreate.rank,
                        password: this.userToCreate.password,
                    }
                })
                .then(res => {
                    this.resCreate = res.data.data;
                    this.errCreateUser = "Accont created"
                    this.userToCreate = { username: "", email: "", rank: "", password: "" }
                })
                .catch(err => {
                    this.errCreateUser = err.response.data;
                });
        },
        updateRankUser() {
            axios.put(process.env.ROOT_API + "/api/general/updateRankUser", {
                    user_id: this.selectUser.id,
                    rank: this.selectRank
                })
                .then(result => {
                    this.resUpdate = result.data.data
                    this.errUpdateUser = "user updated"
                    this.selectUser = null
                    this.selectRank = null
                })
                .catch(err => {
                    this.errUpdateUser = err.response.data;
                });
        },
        deleteUser() {
            axios.delete(process.env.ROOT_API + "/api/general/deleteUser", {
                    data: {
                        user_id: this.selectUser.id
                    }
                })
                .then(res => {
                    this.deleteUser = res.data.data;
                    this.getUserList()
                    this.selectUser = null
                    this.selectRank = null
                })
                .catch(err => {
                    this.errDeleteUser = err.response.data
                })
        }
    }
}
</script>

<style scoped>
.users {
    text-align: center;
    font-family: "DejaVu Math TeX Gyre";
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

#buttons {
    margin: 4%;
}

#btn_view {
    margin-left: 10%;
    margin-right: 10%;
}

@media screen and (max-width: 708px) {
    #buttons {
        display: grid;
        margin-top: 10%;
    }
    #btn_view {
        margin-top: 5%;
        margin-bottom: 5%;
    }
    #logo img {
        width: 30%;
    }
}
</style>
