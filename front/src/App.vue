<template>
  <div id="app">
    <div class="home">
      <nav class="navbar navbar-dark bg-dark">
        <a class="navbar-brand" href="/">Time-Manager</a>
        <div class="link">
          <a class="nav-link" href="/users">Users</a>
          <a class="nav-link" href="/general-manager">General Manager</a>
          <a class="nav-link" href="/manager">Manager</a>
        </div>
      </nav>
    </div>


    <router-view/>

    <div id="town">
      <img src="./assets/bulding.jpeg" alt="town"/>
    </div>

    <footer>
      <div class="link">
        <a class="nav-link" href="/users">Users</a>
        <a class="nav-link" href="/chart">Chart Manager</a>
        <a class="nav-link" href="/clock">Clock Manager</a>
        <a class="nav-link" href="/worktime">Working Time</a>
        <a class="nav-link" href="/worktimes">Working Times</a>
      </div>

      <p>© 2019 | Tous droits réservés. The Gotham town hall</p>
    </footer>
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

  #town {
    margin-top: 5%;
    text-align: center;
  }

  .link {
    display: flex;
    justify-content: center;
  }

  footer .link a {
    margin: 3%;
  }

  footer {
    background-color: black;
    color: white;
  }

  footer p {
    margin-bottom: 0;
    text-align: center;
  }



  @media screen and (max-width: 650px)
  {
    footer a {
      display: contents;
    }

    footer .link {
      margin-bottom: 5%;
    }
  }


  @media screen and (max-width: 708px) {
    #town img {
      display: none;
    }
  }
</style>
