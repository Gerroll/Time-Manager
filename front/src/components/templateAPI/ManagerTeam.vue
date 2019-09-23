<template>
    <div id="ManagerTeam">
        <div>
            <b-form-select v-model="selectTeam" :options="options"></b-form-select>
            {{ selectTeam }}
            {{ listTeam }} {{ listTeamErr }}
        </div>
        <div>
            <input type="text" placeholder="nameTeam" v-model="nameTeam">
            <button v-on:click=createTeam>createTeam</button>
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
                this.listTeam = response.data.data
                this.listTeamErr = null

                for (var i = 0; i < this.listTeam.length; i++)
                    this.options.push({value: this.listTeam[i].id, text: this.listTeam[i].name})
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
                    this.listTeam = response.data.data
                    this.listTeamErr = null
                })
                .catch(err => {
                    console.log(err)
                    this.listTeam = null
                    this.listTeamErr = err.response.data
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
            options: []
        }
    }
}
</script>