<template>
    <div class="Dashboard">
        <h1 class="m-5">Your dashboard</h1>
    
        <div class="container">
            <button v-if="needToClockIn" type="button" class="btn btn-success shadow" v-on:click=clockIn>clockIn</button>
            <button v-if="!needToClockIn" type="button" class="btn btn-warning shadow" v-on:click=clockOut>clockOut</button>
        </div>
        <div class="container d-flex justify-content-center flex-column align-items-center">
    
            <div class="shadow border border-secondary p-2 m-5" v-if="dashboardInfo && dashboardInfo.averagePerDayOf7pastDay && dashboardInfo.averagePerWeekOf28pastDay">
                <div>
                    Average per day over 7 past day : <span class="text-info">{{dashboardInfo.averagePerDayOf7pastDay}} hour(s)</span>
                </div>
                <div>
                    Average per week over 28 past day : <span class="text-info">{{dashboardInfo.averagePerWeekOf28pastDay}} hour(s)</span>
                </div>
            </div>
    
            <select @change="getDashboard()" v-model="periode" class="form-control custom-select w-25 shadow">
                    <option value="1">Week</option>
                    <option value="2">Month</option>
                </select>
    
            <GraphTime class="w-100" v-if="periode == '1'" v-bind:labelsProps="this.labelsWeek" v-bind:datasetsProps="this.datasetsWeek"></GraphTime>
            <GraphTime class="w-100" v-if="periode == '2'" v-bind:labelsProps="this.labelsMonth" v-bind:datasetsProps="this.datasetsMonth"></GraphTime>
        </div>
    </div>
</template>

<script>
import axios from "axios";
import { Bar } from 'vue-chartjs'

import GraphTime from '@/components/templateAPI/GraphTime'

export default {
    extends: Bar,
    components: { GraphTime },
    name: 'Dashboard',
    data() {
        return {
            dashboardInfo: null,
            error: null,
            data: null,
            dataErr: null,
            datasetsWeek: null,
            datasetsMonth: null,
            labelsWeek: [],
            labelsMonth: [],
            periode: "1",
            needToClockIn: true,
        }
    },
    mounted() {
        this.getDashboard()
        this.isClockIn()
    },
    methods: {
        getDashboard() {
            axios.get(process.env.ROOT_API + "/api/user/getDashboard", {})
                .then(res => {
                    this.dashboardInfo = res.data
                    this.dashboardInfo.averagePerDayOf7pastDay = parseInt(this.dashboardInfo.averagePerDayOf7pastDay / 360) / 10
                    this.dashboardInfo.averagePerWeekOf28pastDay = parseInt(this.dashboardInfo.averagePerWeekOf28pastDay / 360) / 10
                    Date.prototype.addDays = function(days) {
                        var date = new Date(this.valueOf());
                        date.setDate(date.getDate() + days);
                        return date;
                    }

                    this.datasetsWeek = []
                    this.labelsWeek = []
                    for (let i = -6; i <= 0; i++) {
                        var date = new Date().addDays(i)
                        this.labelsWeek.push(date.getUTCDate() + "/" + (date.getMonth() + 1))

                        let timeDay = 0
                        this.dashboardInfo.workTimesPast7Days.forEach(wt => {
                            if (wt) {
                                let wtDate = new Date(wt.start)
                                if (wtDate.getUTCDate() == date.getUTCDate() && wtDate.getMonth() == date.getMonth())
                                    timeDay += ((new Date(wt.end) - new Date(wt.start)) / 1000)
                            }
                        })
                        this.datasetsWeek.push(timeDay / 3600)
                    }

                    this.datasetsMonth = []
                    this.labelsMonth = []
                    for (let i = -27; i <= 0; i++) {
                        var date = new Date().addDays(i)
                        this.labelsMonth.push(date.getUTCDate() + "/" + (date.getMonth() + 1))

                        let timeDay = 0
                        this.dashboardInfo.workTimesPast28Days.forEach(wt => {
                            if (wt) {
                                let wtDate = new Date(wt.start)
                                if (wtDate.getUTCDate() == date.getUTCDate() && wtDate.getMonth() == date.getMonth())
                                    timeDay += ((new Date(wt.end) - new Date(wt.start)) / 1000)
                            }
                        })
                        this.datasetsMonth.push(timeDay / 3600)
                    }
                })
                .catch(err => {
                    this.error = err
                    console.log(this.error)
                })
        },
        clockIn() {
            axios.post(process.env.ROOT_API + "/api/user/clockIn", {
                    crossOrigine: true,
                })
                .then(response => {
                    this.data = response.data.data
                    this.dataErr = null
                    this.needToClockIn = false
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
                    this.needToClockIn = true
                })
                .catch(err => {
                    this.data = null
                    this.dataErr = err.response.data
                })
        },
        isClockIn() {
            axios.get(process.env.ROOT_API + "/api/user/getWorkingTime", {})
                .then(res => {
                    let wts = res.data.data
                    wts.forEach(wt => {
                        if (wt.start == wt.end)
                            this.needToClockIn = false
                    });
                })
        }
    }
}
</script>

<style scoped>

</style>
