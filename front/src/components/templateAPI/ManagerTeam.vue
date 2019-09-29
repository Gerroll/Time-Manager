<template>
    <div id="ManagerTeam">
        <div id="logo">
            <img src="../../assets/gotham.png" alt="logo" width="15%"/>
        </div>

        <div>
            <h1 style="margin-bottom: 3%">On this page, you can Create a team, but also delete or modify them.</h1>
        </div>

        <div class="createTeam">
            <div class="container">
                <h2 style="margin-bottom: 4%; color: white">Create a team here </h2>
                <input type="text" placeholder="Name of the team" class="form-control" v-model="nameTeam">
                <button id="btnTeam" class="btn btn-outline-light btn-lg" v-on:click=createTeam>Create Team</button>
                <div v-if="alert" style="margin-top: 3%" class="alert alert-success" role="alert">
                    You have created the "{{ nameTeam }}" team well
                </div>
            </div>
        </div>


        <div class="colEdit">
            <div class="row">
                <div class="col-sm editTeam1">
                    <div class="container">
                        <div v-if="this.listTeam">
                            <h2 style="margin-bottom: 5%">Select the team you want to edit</h2>
                            <select style="margin-bottom: 3%" class="form-control form-control-lg" v-model="selectTeam" @change="getUserListNotInTeam();getUserListInTeam();">
                                <option v-for="team in listTeam" :key="team.id" :value="team">{{team.name}}</option>
                            </select>
                        </div>
                    </div>
                </div>


                <div class="col-sm editTeam2">
                    <div v-if="this.selectTeam">
                        <div><button style="margin-bottom: 5%" class="btn btn-outline-dark btn-lg" v-if="this.selectTeam" v-on:click=deleteTeam>Delete {{ selectTeam.name }}</button></div>
                        Update Team name selected:
                        <input type="text" placeholder="New name of the team" v-model="newNameTeam">
                        <button style="margin-top: 2%" class="btn btn-outline-dark btn-lg" v-if="this.newNameTeam" v-on:click=updateTeam>Update "{{ selectTeam.name }}" to "{{ newNameTeam }}"</button> {{ updateTeamErr }}
                    </div>
                </div>
            </div>
        </div>

    
        <div v-if="usersNotInTeam && selectTeam" class="container mt-5">
            Add user to "{{ selectTeam.name }}":
            <select class="form-control" v-model="userToAdd">
                <option v-for="user in usersNotInTeam" :key="user.id" :value="user">{{user.email}}</option>
            </select>
            <button class="btn btn-outline-dark btn-lg" v-if="this.userToAdd" v-on:click=addUserToSelectTeam>Add {{ userToAdd.email }} to team : "{{ selectTeam.name }}"</button>
        </div>

        <div v-if="usersInTeam && selectTeam" class="container mt-5">
            Delete user of "{{ selectTeam.name }}":
            <select class="form-control" v-model="userToDel">
                <option v-for="user in usersInTeam" :key="user.id" :value="user">{{user.email}}</option>
            </select>
            <button class="btn btn-outline-dark btn-lg" v-if="this.userToDel" v-on:click=delUserFromSelectTeam>Delete {{ userToDel.email }} of team : "{{ selectTeam.name }}"</button>
        </div>

        <div style="display: none;">
            {{ selectTeam }} {{ listTeam }} {{ listTeamErr }}
        </div>
    
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'ManagerTeam',
    created() {
        axios.get(process.env.ROOT_API + "/api/manager/listTeam", {
                crossOrigine: true,
            })
            .then(response => {
                this.listTeam = null
                if (response.data.data != null && response.data.data.length != 0)
                    this.listTeam = response.data.data;
                this.listTeamErr = null;
            })
            .catch(err => {
                this.listTeam = null
                this.listTeamErr = err.response.data
            })
    },
    methods: {
        getListTeam() {
            axios.get(process.env.ROOT_API + "/api/manager/listTeam", {
                    crossOrigine: true,
                })
                .then(response => {
                    this.listTeam = null
                    if (response.data.data != null && response.data.data.length != 0)
                        this.listTeam = response.data.data
                    this.listTeamErr = null
                })
                .catch(err => {
                    this.listTeam = null
                    this.listTeamErr = err.response.data
                })
        },
        createTeam() {
            if (this.nameTeam != null)
                axios.post(process.env.ROOT_API + "/api/manager/createTeam", {
                    team: {
                        name: this.nameTeam
                    }
                })
                .then(response => {
                    this.listTeamErr = null;
                    this.getListTeam();
                    this.alert = true;
                })
                .catch(err => {
                    this.listTeamErr = err.response.data
                })

        },
        deleteTeam() {
            if (this.selectTeam.id != null) {
                axios.delete(process.env.ROOT_API + "/api/manager/deleteTeam", {
                        data: {
                            team_id: this.selectTeam.id
                        }
                    })
                    .then(response => {
                        this.listTeamErr = null
                        this.selectTeam = null
                        this.getListTeam()
                    })
                    .catch(err => {
                        this.listTeamErr = err.response.data
                    })
            }
        },
        updateTeam() {
            if (this.selectTeam.id != null && this.newNameTeam != null) {
                axios.put(process.env.ROOT_API + "/api/manager/updateNameTeam", {
                        team_id: this.selectTeam.id,
                        team: {
                            name: this.newNameTeam
                        }
                    })
                    .then(response => {
                        this.selectTeam = null
                        this.newNameTeam = null
                        this.getListTeam()
                    })
                    .catch(err => {
                        this.updateTeamErr = err.response.data
                    })
            }
        },
        getUserListNotInTeam() {
            axios.get(process.env.ROOT_API + "/api/manager/user_list_not_in_team", {
                    params: {
                        team_id: this.selectTeam.id
                    }
                })
                .then(response => {
                    this.usersNotInTeam = null
                    if (response.data.data != null && response.data.data.length != 0)
                        this.usersNotInTeam = response.data.data
                })
                .catch(err => {
                    this.updateTeamErr = err.response.data
                })
        },
        addUserToSelectTeam() {
            axios.post(process.env.ROOT_API + "/api/manager/addUserToTeam", {
                    team_id: this.selectTeam.id,
                    user_id: this.userToAdd.id
                })
                .then(response => {
                    this.userToAdd = null
                    this.userToDel = null
                    this.getUserListInTeam()
                    this.getUserListNotInTeam()
                })
                .catch(err => {
                    this.updateTeamErr = err.response.data
                })
        },
        getUserListInTeam() {
            axios.get(process.env.ROOT_API + "/api/manager/user_list_in_team", {
                    params: {
                        team_id: this.selectTeam.id
                    }
                })
                .then(response => {
                    this.usersInTeam = null
                    if (response.data.data != null && response.data.data.length != 0)
                        this.usersInTeam = response.data.data
                })
                .catch(err => {
                    this.updateTeamErr = err.response.data
                })
        },
        delUserFromSelectTeam() {
            axios.delete(process.env.ROOT_API + "/api/manager/removeUserFromTeam", {
                    data: {
                        team_id: this.selectTeam.id,
                        user_id: this.userToDel.id
                    }
                })
                .then(response => {
                    this.userToAdd = null
                    this.userToDel = null
                    this.getUserListInTeam()
                    this.getUserListNotInTeam()
                })
                .catch(err => {
                    this.updateTeamErr = err.response.data
                })
        }
    },
    data() {
        return {
            data: null,
            dataErr: null,
            listTeam: null,
            listTeamErr: null,
            nameTeam: null,
            selectTeam: null,
            nameTeam: null,
            newNameTeam: null,
            updateTeamErr: null,
            usersNotInTeam: null,
            userToAdd: null,
            usersInTeam: null,
            userToDel: null,
            alert: false,
        }
    }
}
</script>

<style scoped>
#ManagerTeam {
    text-align: center;
    font-family: "DejaVu Math TeX Gyre";
}

#logo {
    padding: 2%;
    text-align: center;
}

.createTeam {
    background-color: black;
    padding: 5%;
}

.editTeam1 {
    background-color: #9f9f9f;
    padding: 5%;
}

.editTeam2 {
    background-color: darkgrey;
    padding: 5%;
}

.editTeam {
    margin-top: 4%;
}

#btnTeam {
    margin-top: 3%;
}



@media screen and (max-width: 708px)
{
    #logo img {
        width: 30%;
    }
}
</style>