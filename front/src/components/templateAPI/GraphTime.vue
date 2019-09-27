<script>
import axios from "axios";
import { Bar } from 'vue-chartjs'

export default {
    extends: Bar,
    name: 'GraphTime',
    props: {
        labelsProps: Array,
        datasetsProps: Array,
    },
    data: () => ({
        chartdata: {
            labels: ['day1', 'day2', 'day3', 'day4', 'day5'],
            datasets: [{
                    label: 'Arnaud',
                    backgroundColor: '#f87979',
                    data: []
                },
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false
        },
    }),
    mounted() {
        console.log()
        if (this.labelsProps)
            this.chartdata.labels = this.labelsProps
        if (this.datasetsProps)
            this.chartdata.datasets[0].data = this.datasetsProps
        if (this.labelsProps && this.datasetsProps) {
            this.renderChart(this.chartdata, this.options)
            console.log("test")
        }
    },
    watch: {
        labelsProps: function(newVal, oldVal) { // watch it
            if (this.labelsProps)
                this.chartdata.labels = this.labelsProps
            if (this.datasetsProps)
                this.chartdata.datasets[0].data = this.datasetsProps
            if (this.labelsProps && this.datasetsProps)
                this.renderChart(this.chartdata, this.options)
        },
        datasetsProps: function(newVal, oldVal) {
            if (this.labelsProps)
                this.chartdata.labels = this.labelsProps
            if (this.datasetsProps)
                this.chartdata.datasets[0].data = this.datasetsProps
            if (this.labelsProps && this.datasetsProps) {
                this.renderChart(this.chartdata, this.options)
            }
        }
    },
    methods: {
        getDashboard() {
            axios.get(process.env.ROOT_API + "/api/user/getDashboard", {})
                .then(res => {
                    this.dashboardInfo = res.data
                })
                .catch(err => {
                    this.error = err.response.data
                })
        }
    }
}
</script>