<template>
    <div id="ManagerTeam">
        <div>
            <input type="text" placeholder="nameTeam" v-model="nameTeam">
            <button v-on:click=createTeam>createTeam</button>
        </div>
        <div>
            <div v-if="this.listTeam">
                <select v-model="selectTeam" @change="getUserListNotInTeam();getUserListInTeam();">
                    <option v-for="team in listTeam" :key="team.id" :value="team">{{team.name}}</option>
                </select>
                <button v-if="this.selectTeam" v-on:click=deleteTeam>Delete {{ selectTeam.name }}</button>
            </div>
        </div>
        <div v-if="this.selectTeam">
            Update Team name selected:
            <input type="text" placeholder="newNameTeam" v-model="newNameTeam">
            <button v-if="this.newNameTeam" v-on:click=updateTeam>Update "{{ selectTeam.name }}" to "{{ newNameTeam }}"</button> {{ updateTeamErr }}
        </div>
    
        <div v-if="usersNotInTeam && selectTeam">
            <select v-model="userToAdd">
                <option v-for="user in usersNotInTeam" :key="user.id" :value="user">{{user.email}}</option>
            </select>
            <button v-if="this.userToAdd" v-on:click=addUserToSelectTeam>Add {{ userToAdd.email }} to team : "{{ selectTeam.name }}"</button>
        </div>

        <div v-if="usersInTeam && selectTeam">
            <select v-model="userToDel">
                <option v-for="user in usersInTeam" :key="user.id" :value="user">{{user.email}}</option>
            </select>
            <button v-if="this.userToDel" v-on:click=delUserFromSelectTeam>Delete {{ userToDel.email }} from team : "{{ selectTeam.name }}"</button>
        </div>

        <div>
            {{ selectTeam }} {{ listTeam }} {{ listTeamErr }}
        </div>
    
    </div>
</template>

<script>
import axios from "axios";

export default {
    name: 'ManagerTeam',
    created() {
        axios.get("http://localhost:4000/api/manager/listTeam", {
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
    methods: {
        getListTeam() {
            axios.get("http://localhost:4000/api/manager/listTeam", {
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
                axios.post("http://localhost:4000/api/manager/createTeam", {
                    team: {
                        name: this.nameTeam
                    }
                })
                .then(response => {
                    this.listTeamErr = null
                    this.getListTeam()
                })
                .catch(err => {
                    this.listTeamErr = err.response.data
                })
        },
        deleteTeam() {
            if (this.selectTeam.id != null) {
                axios.delete("http://localhost:4000/api/manager/deleteTeam", {
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
                axios.put("http://localhost:4000/api/manager/updateNameTeam", {
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
            axios.get("http://localhost:4000/api/manager/user_list_not_in_team", {
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
            axios.post("http://localhost:4000/api/manager/addUserToTeam", {
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
            axios.get("http://localhost:4000/api/manager/user_list_in_team", {
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
            axios.delete("http://localhost:4000/api/manager/removeUserFromTeam", {
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
        }
    }
}
</script>

<style scoped>
.selectTeam {
    width: 10%;
}
</style>