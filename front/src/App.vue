<template>
  <div id="app">
    <router-view/>
<notifications group="auth"/>
<notifications group="app"/>
  </div>
</template>

<script>
    export default {
        name: 'App'
    }
</script>

<style scoped>
  

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
