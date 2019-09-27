<template>
  <div class="home">
    <div id="logo">
      <img src="../assets/gotham.png" alt="logo" width="15%"/>
    </div>

    <div class="form">
      <h1 class="titre">Welcome to the Gotham City hall website.</h1>

      <form class="container">
        <div class="form-group">
          <label for="exampleInputEmail1">Email Address</label>
          <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                 placeholder="Enter Email">
        </div>
        <div class="form-group">
          <label for="exampleInputPassword1">Password</label>
          <input type="password" class="form-control" id="exampleInputPassword1"
                 placeholder="Enter Password">
        </div>
        <button type="submit" class="btn btn-dark">Connect</button>
      </form>
    </div>

    <div class="infos">
      <p>To ease the tension, the town hall decided to make this website to review the situation, and why not, to allow municipal employees to have access to a few days of rest to recover.
        <br>
        <br>
        To do this, you must log in with your professional email and password.
      </p>
    </div>

  </div>
</template>

<script>
    export default {
        name: 'Home',
        data() {
            return {}
        }
    }
</script>

<style scoped>
  .home {
    text-align: center;
    font-family: "DejaVu Math TeX Gyre";
  }

  #logo {
    padding: 2%;
  }

  .form {
    background-color: black;
    color: white;
    padding: 5%;
  }

  .infos {
    background-color: #9f9f9f;
    color: white;
    padding: 5%;
    font-size: 26px;
  }




  @media screen and (max-width: 708px)
  {
    #logo img {
      width: 30%;
    }
  }
</style>
