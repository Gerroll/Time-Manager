<template>
  <div class="home">
    <div id="logo">
      <img src="../assets/gotham.png" alt="logo" width="15%"/>
    </div>

    <div class="form">
      <h1 class="titre">Bienvenue sur le site de Gotham City hall</h1>

      <form class="container">
        <div class="form-group">
          <label for="exampleInputEmail1">Adresse Email</label>
          <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp"
                 placeholder="Entrez votre Email">
          <small id="emailHelp" class="form-text text-muted">Nous ne partagerons jamais votre adresse mail avec qui que
            ce soit d'autre.</small>
        </div>
        <div class="form-group">
          <label for="exampleInputPassword1">Mot de Passe</label>
          <input type="password" class="form-control" id="exampleInputPassword1"
                 placeholder="Entrez votre mot de passe">
        </div>
        <button type="submit" class="btn btn-dark">Se connecter</button>
      </form>
    </div>

    <div class="infos">
      <p>Pour calmer la tension, la mairie décide de faire ce site web pour faire le point de la situation, et pourquoi
        pas, pour permettre aux employés municipaux d'avoir accès à quelques jours de repos pour récupérer.
        <br>
        <br>
        Pour cela, vous devez vous connecter avec votre email professionnel et votre mot de passe.</p>
    </div>

    <div id="town">
      <img src="../assets/town.jpeg" alt="town"/>
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

  #town {
    margin-top: 5%;
  }

  .link {
    display: flex;
    justify-content: center;
  }

  a {
    color: white;
    margin: 3%;

  }

  a:hover {
    color: darkgrey;
  }

  footer {
    background-color: black;
    color: white;
  }

  footer p {
    margin-bottom: 0;
  }



  @media screen and (max-width: 708px)
  {
    #town img {
      display: none;
    }

    #logo img {
      width: 30%;
    }
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
</style>
