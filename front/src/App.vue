<template>
  <div id="app">
    <div class="home">
      <nav class="navbar navbar-dark bg-dark">
        <a class="navbar-brand" href="/">Time-Manager</a>
        <div class="link">
          <a class="nav-link" href="/users">Users</a>
          <a class="nav-link" href="/chart">Chart Manager</a>
          <a class="nav-link" href="/clock">Clock Manager</a>
          <a class="nav-link" href="/worktime">Working Time</a>
          <a class="nav-link" href="/worktimes">Working Times</a>
        </div>
      </nav>
    </div>

    <router-view/>
  </div>
</template>

<script>
    export default {
        name: 'App'
    }
</script>

<style scoped>
  .link {
    display: flex;
  }

  a {
    color: white;
  }

  a:hover {
    color: darkgrey;
  }
</style>
