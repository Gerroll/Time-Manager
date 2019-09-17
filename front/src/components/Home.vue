<template>
  <div class="home">
    {{ msg }}
    <router-link :to="{ name: 'Users' }">Users</router-link>
    <router-link :to="{ name: 'ChartManager' }">Chart Manager</router-link>
    <router-link :to="{ name: 'ClockManager' }">Clock Manager</router-link>
    <router-link :to="{ name: 'WorkingTime' }">Working Time</router-link>
    <router-link :to="{ name: 'WorkingTimes' }">Working Times</router-link>
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'Home',
  data () {
    return {
      msg: 'Welcome to the second mini project'
    }
  }
}
</script>