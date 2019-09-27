<template>
    <div class="Dashboard">
    
        <div class="container d-flex justify-content-center flex-column align-items-center">
    
            <h1> Your dashboard</h1>
    
            <select v-model="periode" class="form-control custom-select w-25">
                        <option value="1" selected="selected">Week</option>
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
            datasetsWeek: null,
            datasetsMonth: null,
            labelsWeek: [],
            labelsMonth: [],
            periode: "1",
        }
    },
    mounted() {
        this.getDashboard()
    },
    methods: {
        getDashboard() {
            axios.get(process.env.ROOT_API + "/api/user/getDashboard", {})
                .then(res => {
                    this.dashboardInfo = res.data
                    Date.prototype.addDays = function(days) {
                        var date = new Date(this.valueOf());
                        date.setDate(date.getDate() + days);
                        return date;
                    }

                    this.datasetsWeek = []
                    for (let i = -6; i <= 0; i++) {
                        var date = new Date().addDays(i)
                        this.labelsWeek.push(date.getUTCDate() + "/" + (date.getMonth() + 1))

                        let timeDay = 0
                        this.dashboardInfo.workTimesPast7Days.forEach(wt => {
                            let wtDate = new Date(wt.start)
                            if (wtDate.getUTCDate() == date.getUTCDate() && wtDate.getMonth() == date.getMonth())
                                timeDay += ((new Date(wt.end) - new Date(wt.start)) / 1000)
                        })
                        this.datasetsWeek.push(parseInt(timeDay / 3600))
                    }

                    this.datasetsMonth = []
                    for (let i = -27; i <= 0; i++) {
                        var date = new Date().addDays(i)
                        this.labelsMonth.push(date.getUTCDate() + "/" + (date.getMonth() + 1))

                        let timeDay = 0
                        this.dashboardInfo.workTimesPast7Days.forEach(wt => {
                            let wtDate = new Date(wt.start)
                            if (wtDate.getUTCDate() == date.getUTCDate() && wtDate.getMonth() == date.getMonth())
                                timeDay += ((new Date(wt.end) - new Date(wt.start)) / 1000)
                        })
                        this.datasetsMonth.push(parseInt(timeDay / 3600))
                    }
                })
                .catch(err => {
                    this.error = err
                    // if (err.response != null)
                    //     this.error = err.response.data
                    console.log(this.error)
                })
        }
    }
}
</script>

<style scoped>

</style>
